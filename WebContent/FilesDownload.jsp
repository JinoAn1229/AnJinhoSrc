<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Dao.BoardDao"%>
 <%@ page import="Dao.FilesDao"%>
 <%@ page import="Vo.BoardVo"%> 
 <%@ page import="Vo.FilesVo"%>
 <%@ page import="java.io.*"%>
 <%@ page import="com.oreilly.servlet.*" %>
 <%@ page import="com.oreilly.servlet.multipart.*" %>
 <%@ page import="java.util.*" %>
 
 <%
	request.setCharacterEncoding("UTF-8");

	FilesVo filesVo= new FilesVo();
	
	if(request.getParameter("filesId")!=null){
		int filesId = Integer.parseInt(request.getParameter("filesId"));
	
		FilesDao filesDao = new FilesDao();
		filesVo = filesDao.getFiles(filesId);	
	}
	
	String filesName = filesVo.getFilesName(); //db에 저장된 게시판에서 보여지는 파일명
	String filesRealname = filesVo.getFilesRealname(); // 서버에 실제 저장된 파일명
	String filesPath = filesVo.getFilesPath();  // 파일 업로드된 경로
	 

	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	String client = "";

	try{
		// 파일을 읽어 스트림에 담기
		try{
			file = new File(filesPath, filesRealname);  //업로드된 경로와 실제 파일명으로 파일객체 생성
			in = new FileInputStream(file); 
		}catch(FileNotFoundException fe){  //파일이 지정된 경로에 없거나 할때 예외처리
			skip = true;
		}
			client = request.getHeader("User-Agent");

			// 파일 다운로드 헤더 지정
			response.reset() ;
			response.setContentType("application/octet-stream");  //response할 형식이 파일이라고 알려줌
			response.setHeader("Content-Description", "JSP Generated Data");

			if(!skip){  //파일이 존재하면
				// IE
				if(client.indexOf("MSIE") != -1){
					response.setHeader ("Content-Disposition", "attachment; filename="+new String(filesName.getBytes("KSC5601"),"ISO8859_1"));

				}else{
					// 한글 파일명 처리
					filesName = new String(filesName.getBytes("utf-8"),"iso-8859-1");

					response.setHeader("Content-Disposition", "attachment; filename=\"" + filesName + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
				}  
				
				response.setHeader ("Content-Length", ""+file.length() ); //파일 받는것까지 완료
  
				os = response.getOutputStream();
				byte b[] = new byte[1024];  //파일을 한번에 얼마나 읽을지 설정. 조절가능 , 한번에 다 읽거나 크게 읽을면 오류날 수 있음
				int leng = 0;
				
				while( (leng = in.read(b)) > 0 ){  //in에 담겨져있는 파일을 os로 읽는다
					os.write(b,0,leng);
				}

			}else{
				response.setContentType("text/html;charset=UTF-8");
				out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다');history.back();</script>");

			}
			
			in.close();
			os.close();

		}catch(Exception e){
		  e.printStackTrace();
		}
	
	
	
  	
	
  %>

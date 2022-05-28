<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Dao.BoardDao"%>
 <%@ page import="Dao.FilesDao"%>
 <%@ page import="Vo.BoardVo"%> 
 <%@ page import="Vo.FilesVo"%>
 <%@ page import="java.io.PrintWriter"%>
 <%@ page import="com.oreilly.servlet.*" %>
 <%@ page import="com.oreilly.servlet.multipart.*" %>
 <%@ page import="java.util.*" %>
 
 <%

   		request.setCharacterEncoding("UTF-8");
     
     
     	String[] filesSplitArray = null;  //확장자를 구하기 위해 파싱한다 (아직 확장자 안해놈) 
     	//파일 업로드 부분
     	final String directory = "C:\\Users\\jino\\Documents\\boardfiles";  //저장될 파일 위치
    	int sizeLimit = 100*1024*1024;		//100MB 제한
    	String encoding = "UTF-8";
    	FilesVo filesVo = new FilesVo();
    	FilesDao filesDao = new FilesDao();
    	BoardDao dao = new BoardDao();
    	BoardVo boardVo = new BoardVo();
    	
    	int boardId = dao.getNextBoardId();  //파일에 저장할 board_id를 가져온다. (다른 방법도 찾아본다 ex>board_list가 생성되고 그 board_id를 가져오는 방법)
    	
    	MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, encoding, new DefaultFileRenamePolicy());
    	
    	
    	Enumeration files = multi.getFileNames();
    	
    	if(files != null){  //파일이 존재하는지 확인
    		while(files.hasMoreElements()) {
    	
    	String File = (String)files.nextElement();
    	
    	if(multi.getFilesystemName(File) == null) continue; //파일 업로드가 안된게 있는지 확인
    	
    	filesSplitArray = multi.getFilesystemName(File).split("[.]"); //파일 확장자명을 제외해서 저장 나중에 확장자도 따로 저장하고 파일 이름도 조금 바꿔줘야지
    	String FilesName = filesSplitArray[0];
    	
    	String FilesRealname = multi.getOriginalFileName(File);
    	
    		
    	//files db에 저장한다.
    	filesVo = new FilesVo();	
    	filesVo.setBoardId(boardId);
    	filesVo.setFilesName(FilesName);
    	filesVo.setFilesRealname(FilesRealname);
    	filesVo.setFilesPath(directory);
    	
    	filesDao.addFiles(filesVo);
    		
    		}
    		
    	}//파일처리
    	
     	
     
     	
     	String pwCheck = null;
     	
     	if(multi.getParameter("title")!=null){
     		boardVo.setBoardTitle((String)multi.getParameter("title"));
    	}
     	if(multi.getParameter("content")!=null){
     		boardVo.setBoardContent((String) multi.getParameter("content"));
  		}
  		if(multi.getParameter("writer")!=null){
  			boardVo.setWriter((String) multi.getParameter("writer"));
  		}
  		if(multi.getParameter("pw")!=null){
  			boardVo.setPw((String) multi.getParameter("pw"));  
  		}
  		if(multi.getParameter("pwcheck")!=null){
  			pwCheck = (String) multi.getParameter("pwcheck");
   		}
  		if(multi.getParameter("category")!=null){
  			boardVo.setCategory((String) multi.getParameter("category"));
    	}
      	
      	//값 입력이 누락됬는지 확인 (validation클래스 만들어서 처리할지 고민)
    	if(boardVo.getBoardTitle() == null || boardVo.getBoardContent() == null || boardVo.getWriter() == null || boardVo.getPw() == null || boardVo.getCategory() == null) {
      		PrintWriter script = response.getWriter();
      		script.println("<script>");
       		script.println("alert('값없음');");
       		script.println("history.back();");
          	script.println("</script>");
          	script.close();
         	return;
       	}
    	
     	if(!boardVo.getPw().equals(pwCheck))
    	{
     		PrintWriter script = response.getWriter();
    		script.println("<script>");
       		script.println("alert('비밀번호 확인값이 다릅니다.');");
          	script.println("history.back();");
          	script.println("</script>");
          	script.close();
         	return;
       	}
           	
    	//값이 정상이면 게시물을 추가하고 목록화면으로 이동
     	int result = dao.addBoardList(boardVo);
    	if(result == 1) {
      		PrintWriter script = response.getWriter();
        	script.println("<script>");
         	script.println("alert('추가완료');");
         	script.println("location.href = 'BoardList.jsp';");
          	script.println("</script>");
        	script.close();
        	return;
     	}
  %>

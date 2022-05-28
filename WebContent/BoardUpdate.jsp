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
     
     
     	String[] filesSplitArray = null;
    	//파일 업로드 부분
    	final String directory = "C:\\Users\\jino\\Documents\\boardfiles";  //고정값
    	int sizeLimit = 100*1024*1024;		//100MB 제한
    	String encoding = "UTF-8";
    	FilesVo filesVo = new FilesVo();
    	FilesDao filesDao = new FilesDao();
    	BoardDao dao = new BoardDao();
    	
    	MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, encoding, new DefaultFileRenamePolicy());
    	
    	String boardTitle = null; 
     	String boardContent = null;
     	String writer = null;
     	String pw = null;
     	String boardId = null;
        int nboardId = 0;
        
     	BoardVo board = new BoardVo();
     	
     	if(multi.getParameter("title")!=null){
     		board.setBoardTitle( multi.getParameter("title")); 
    	}
     	if(multi.getParameter("content")!=null){
     		board.setBoardContent(multi.getParameter("content"));
       	}
       	if(multi.getParameter("writer")!=null){
       		board.setWriter(multi.getParameter("writer"));
       	}
     	if(multi.getParameter("pw")!=null){
     		board.setPw(multi.getParameter("pw"));
      	}
     	if(multi.getParameter("boardId")!=null){
     		boardId = (String)multi.getParameter("boardId");
     		nboardId = Integer.parseInt(boardId);
     		board.setBoardId(nboardId);
      	}
    	
    	
    	
    	
    	Enumeration files = multi.getFileNames();
    	
    	if(files != null){
    		while(files.hasMoreElements()) {
    	
    	String File = (String)files.nextElement();
    	
    	if(multi.getFilesystemName(File) == null) continue; //파일 업로드가 안된게 있는지 확인
    	
    	filesSplitArray = multi.getFilesystemName(File).split("[.]"); //파일 확장자명을 제외해서 저장 나중에 확장자도 따로 저장하고 파일 이름도 조금 바꿔줘야지
    	String FilesName = filesSplitArray[0];
    	
    	String FilesRealname = multi.getOriginalFileName(File);
    	
    	//if(FilesName == null) continue; 
    	
    	
    	filesVo = new FilesVo();	
    	filesVo.setBoardId(nboardId);
    	filesVo.setFilesName(FilesName);
    	filesVo.setFilesRealname(FilesRealname);
    	filesVo.setFilesPath(directory);
    	
    	filesDao.addFiles(filesVo);
    		
    		}
    		
    	}//파일처리 
     	
     
     	int result = dao.updateBoard(board);
    	if(result == 1) {
      		PrintWriter script = response.getWriter();
        	script.println("<script>");
         	script.println("alert('수정완료');");
      		script.println("location.href = 'BoardView.jsp?boardId="+board.getBoardId()+"';");
          	script.println("</script>");
        	script.close();
        	
        	return;
     	}
  %>

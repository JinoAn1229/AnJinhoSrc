<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Dao.FilesDao"%>
 <%@ page import="Vo.FilesVo"%> 
 <%@ page import="java.io.PrintWriter"%>
 <%@ page import="java.io.*"%>
 
 <%
	request.setCharacterEncoding("UTF-8");

 	int filesId = 0;
 	
 	if(request.getParameter("filesId")!=null){
 		filesId = Integer.parseInt(request.getParameter("filesId"));
  	}
       	
 	FilesDao filesDao = new FilesDao();
 	FilesVo filesVo =new FilesVo();
 	filesVo = filesDao.getFiles(filesId);
 	
 	int boardId = filesVo.getBoardId();
 	
 	String fileName = filesVo.getFilesRealname(); //지울 파일명   
 	String fileDir = filesVo.getFilesPath(); //지울 파일이 존재하는 디렉토리   
 
 	File file = new File(fileDir, fileName); // 파일 객체생성   
 	if( file.exists()) file.delete(); // 파일이 존재하면 파일을 삭제한다.
 	
 	int result = filesDao.deleteFiles(filesId);  //db에서도 파일정보를 삭제한다.
	if(result == 1) {
  		PrintWriter script = response.getWriter();
    	script.println("<script>");
     	script.println("alert('삭제완료');");
     	script.println("location.href = 'BoardUpdateForm.jsp?boardId="+boardId+"';");
      	script.println("</script>");
    	script.close();
    	
    	return;
 	}

  %>

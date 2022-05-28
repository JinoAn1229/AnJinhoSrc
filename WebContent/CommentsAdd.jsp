<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Dao.CommentsDao"%>
 <%@ page import="Vo.CommentsVo"%> 
 <%@ page import="java.io.PrintWriter"%>
 
 <%
	request.setCharacterEncoding("UTF-8");
	int boardId = 0; 
 	String commentsContent = null;
 	
 	
 	if(request.getParameter("boardId")!=null){
 		boardId = Integer.parseInt(request.getParameter("boardId"));
  	}
 	if(request.getParameter("commentsContent")!=null){
 		commentsContent = (String) request.getParameter("commentsContent");
   	}
   
  	
	if(boardId == 0 || commentsContent == null) {
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
   		script.println("alert('갑없음');");
   		script.println("history.back();");
      	script.println("</script>");
      	script.close();
     	return;
   	}
	
 	
       	
	CommentsDao dao = new CommentsDao();
 	int result = dao.addComments(boardId, commentsContent);
	if(result == 1) {
  		PrintWriter script = response.getWriter();
    	script.println("<script>");
     	script.println("location.href = 'BoardView.jsp?boardId="+boardId+"';");
      	script.println("</script>");
    	script.close();
    	return;
 	}
  %>

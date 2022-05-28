<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Dao.BoardDao"%>
 <%@ page import="Vo.BoardVo"%> 
 <%@ page import="java.io.PrintWriter"%>
 
 <%
  	request.setCharacterEncoding("UTF-8");

   	String boardId = null;
      int nboardId = 0;
   	
   	if(request.getParameter("boardId")!=null){
   		boardId = (String)request.getParameter("boardId");
   		nboardId = Integer.parseInt(boardId);
    	}
         	
  	BoardDao dao = new BoardDao();
   	int result = dao.deleteBoard(nboardId);
  	if(result == 1) {
    		PrintWriter script = response.getWriter();
      	script.println("<script>");
       	script.println("alert('삭제완료');");
       	script.println("location.href = 'BoardList.jsp';");
        	script.println("</script>");
      	script.close();
      	
      	return;
   	}
  %>

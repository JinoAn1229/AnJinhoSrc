<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="Vo.BoardVo"%> 
 <%@ page import="Dao.BoardDao"%>
 <%@ page import="java.io.PrintWriter"%>
 
 <%
    request.setCharacterEncoding("UTF-8");
     
     	int boardId = 0;
     	String pwCheck = "";
     	String func = "";
     	
     	if(request.getParameter("boardId")!=null){	
     		boardId = Integer.parseInt(request.getParameter("boardId"));
      	}
     	if(request.getParameter("pwCheck")!=null){
     		pwCheck = (String) request.getParameter("pwCheck");
     	}
     	if(request.getParameter("func")!=null){
     		func = (String) request.getParameter("func");
     	}
     	
     	BoardDao dao = new BoardDao();
    	BoardVo board = dao.getBoard(boardId);
     	
     	if(pwCheck != null || func != null) {
     		if(board.getPw().equals(pwCheck)){
     			if(func.equals("update")){
     				PrintWriter script = response.getWriter();
     				script.println("<script>");
     				script.println("location.href = 'BoardUpdateForm.jsp?boardId="+board.getBoardId()+"';");
     				script.println("</script>");
     				script.close();
     				return;
     			}
     			else if(func.equals("delete")){
     				PrintWriter script = response.getWriter();
     				script.println("<script>");
     				script.println("location.href = 'BoardDelete.jsp?boardId="+board.getBoardId()+"';");
     				script.println("</script>");
     				script.close();
     				return;
     			}
     		}
     		else if(!board.getPw().equals(pwCheck)){
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('비밀번호가 일치하지 않습니다.');");
     			script.println("location.href = 'PwCheckForm.jsp?boardId="+board.getBoardId()+"&func=" + func +"';");
     			script.println("</script>");
     			script.close();
     			return;
     		}
     	}
     	else
     	{
     		PrintWriter script = response.getWriter();
     		script.println("<script>");
     		script.println("alert('값을 입력해주세요.');");
     		script.println("history.back();");
     		script.println("</script>");
     		script.close();
     		return;
     	}
  %>
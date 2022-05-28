<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.BoardDao"%>
<%@ page import="Vo.BoardVo"%>
<%@ page import="java.util.*"%>

<%
	int boardId = 0;
	String func = "";
	
	if(request.getParameter("boardId")!=null){
		boardId = Integer.parseInt(request.getParameter("boardId"));
	}
	if(request.getParameter("boardId")!=null){
		func = (String) request.getParameter("func");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<meta charset="UTF-8">

		<title>게시판</title>

		<script>
		
			$(function() {	
			
			});
		
			function goBack(){  //전 화면으로 이동
				window.history.back();
			}
			

		</script>
	</head>
	<body>
	
		<div style="font: bold; font-size: 2.0em;">비밀번호 확인</div>
		<form action="./PwCheck.jsp?boardId=<%= boardId %>&func=<%= func %>" method = "POST">
			<table border="1">
				<tr>
					<th>비밀번호입력</th>
					<td>
						<input type="password" name="pwCheck" placeholder="비밀번호를 입력하시오.">
					</td>
				</tr>
			</table>
			<div style="float: right; width: 90%;">
					<input type="submit" value="확인">
			</div>
		</form>
		<div style="float: left;">
			<button onclick="goBack();">취소</button>
		</div>
	</body>
</html>
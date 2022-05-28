<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.BoardDao"%>
<%@ page import="Vo.BoardVo"%>
<%@ page import="Dao.FilesDao"%>
<%@ page import="Vo.FilesVo"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	int boardId = 0; 
	boolean filesAdd = true;
	BoardVo board = null;
	ArrayList<FilesVo> fileslist = null;

	if(request.getParameter("boardId")!=null){
		boardId = Integer.parseInt(request.getParameter("boardId"));

		BoardDao boarddao = new BoardDao();
		board = boarddao.getBoard(boardId);
	
		FilesDao filesDao = new FilesDao();
		fileslist = filesDao.getFilesList(boardId);

		if(fileslist.size() > 2) filesAdd = false;
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
			
			
			function filesDownload(filesId){
		        location.href='./FilesDownload.jsp?filesId=' + filesId;
		    }
			function filesDelete(filesId){
		        location.href='./FilesDelete.jsp?filesId=' + filesId;
		    }
			
			
			
		</script>        	
	
	</head>
	<body>	
		<div style="font-size: 2.0em;">게시판 - 수정</div>
		
		<form action="./BoardUpdate.jsp" method = "post" enctype="multipart/form-data">
			<input type="hidden" name="boardId" value="<%= board.getBoardId()%>">
			
			<table border="1">
			<tr>
				<th>카테고리</th>
				<td>
					<input type="text" name="category" value="<%= board.getCategory()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>등록 일시</th>
				<td>
					<input type="text" name="regdate" value="<%= board.getRegdate()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>수정 일시</th>
				<td>
					<input type="text" name="rewriteDate" value="<%= board.getRewriteDate()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>
					<input type="text" name="view" value="<%= board.getView()%>" readonly>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="writer"  value="<%= board.getWriter()%>">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<div style="float: left; width: 33%;">
						<input type="password" name="pw" placeholder="비밀번호" value="<%= board.getPw()%>">
					</div>
				</td>	
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" value="<%= board.getBoardTitle()%>">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea cols="70" rows="15" name="content"><%= board.getBoardContent()%></textarea></td>
			</tr>
			
			
			<!--To do 파일 다운로드-->
			<tr>
				<th>파일첨부</th>
				<td>
					<%
						for(int i = 0; i < fileslist.size(); i++){			
					%>
						<div>
							<span><%=fileslist.get(i).getFilesName()%></span>
							<span><input type='button' value='Download' onclick="filesDownload(<%=fileslist.get(i).getFilesId() %>);"></span>
							<span><input type='button' value='삭제' onclick="filesDelete(<%=fileslist.get(i).getFilesId() %>);"></span>							
						</div>
					<%
						}
					%>
					<!--To do 파일 업로드 구현-->
					<%
						if(filesAdd) { //파일이 최대개수로 등록되어있는지 확인 (최대개수 3개)
							int filesListSize = fileslist.size();
							for(int i = filesListSize; i < 3; i++){  //파일을 최대개수로 등록할 수 있게 등록버튼 생성
					%>
						<div>
							<input type="file" name="firstFile<%=i%>">
						</div>
					<%
							}
						}
					%>
				</td>
			</tr>
			
		</table>
		
		<div style="float: right; width: 33%;">
			<input type="submit" value="저장">
		</div>	
	</form>
	<div style="float: left; width: 50%;">
		<button onclick="location.href='./BoardView.jsp?boardId=<%= board.getBoardId()%>'">취소</button>
	</div>
		

	</body>
</html>
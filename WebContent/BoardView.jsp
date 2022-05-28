<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.BoardDao"%>
<%@ page import="Vo.BoardVo"%>
<%@ page import="Dao.CommentsDao"%>
<%@ page import="Vo.CommentsVo"%> 
<%@ page import="Dao.FilesDao"%>
<%@ page import="Vo.FilesVo"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.PrintWriter"%>

<%
	// to-do 목록 검색조건 가져와 목록으로 다시 돌아갔을때 같은 상태되게 searchvo 가져오기
	
	request.setCharacterEncoding("UTF-8");
	int boardId = 0; 
	String commentsContent = null;
	
	BoardVo board = null;
	ArrayList<CommentsVo> commentslist = null;
	ArrayList<FilesVo> fileslist = null;
	
	if(request.getParameter("boardId")!=null){
		boardId = Integer.parseInt(request.getParameter("boardId"));
	
		BoardDao boardDao = new BoardDao();
		board = boardDao.getBoard(boardId);
		boardDao.updateView(boardId); //조회수 증가
		
		CommentsDao commentsDao = new CommentsDao();
		commentslist = commentsDao.getList(boardId);
		
		FilesDao filesDao = new FilesDao();
		fileslist = filesDao.getFilesList(boardId);
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
			
			function boardList(){  
		           location.href='./BoardList.jsp';
		    }
			function updates(boardId){ 
		        location.href='./PwCheckForm.jsp?boardId=' + boardId +'&func=update';
		    }

		    function deletes(boardId){
		        location.href='./PwCheckForm.jsp?boardId=' + boardId +'&func=delete';
		    }
		    
		    /*function addComments(boardId){
		        location.href='./pwCheckForm.jsp?boardId=' + boardId +'&func=delete';
		    }*/
		    function filesDownload(filesId){
		        location.href='./FilesDownload.jsp?filesId=' + filesId;
		    }
		    
		    /*function commentsAdd(){
		        
		        $.ajax({
		            method: 'POST',
		            url : './CommentsAdd.jsp',
		            data : {
		            	var boardId = "";
				        var commentsContent = "";       
		            }
		            success: function(){
		            	getListComments(); //파일을 추가하면 다시 댓글 목록을 가져와 보여준다. 아직 안만듬
		            },
		        })
		    }*/
			
			
			
		</script>        	
	
	</head>
	<body>	
		<div style="font-size: 2.0em;">게시판 - 보기</div>

		<table>
    		<tr>
   				<td width="100"><%= board.getCategory()%></td>
        		<td width="300"><%= board.getBoardTitle() %></td>
       			<td width="100">조회수:<%= board.getView()+1 %></td>
   			</tr>
		</table>
		
		<table>
   			<tr>
        		<td width="300"><textarea name="boardContent" cols="70" rows="15" readonly><%= board.getBoardContent()%></textarea></td>
    		</tr>
		</table>
		
		<!--To do 파일 다운로드-->
		<%
			for(int i = 0; i < fileslist.size(); i++){			
		%>
				<div>
					<span><%=fileslist.get(i).getFilesName()%></span>
					<span><input type='button' value='Download' onclick="filesDownload(<%=fileslist.get(i).getFilesId() %>);"></span>							
				</div>
		<%
			}
		%>
		<br>
		<br>
		<!--To do 게시글-->
		<%
			for(int i = 0; i < commentslist.size(); i++){			
		%>		
				<table>
					<tr>
						<td>
							<div><%= commentslist.get(i).getRegdate()%></div>
							<div><%= commentslist.get(i).getCommentsContent() %></div>	
						</td>		
					</tr>
				</table>
		<%
			}
		%>
		
		<!--댓글 기능 구현-->
		<!--페이지 새로고침 떄문에 ajax로 수정중-->
		<form action="./CommentsAdd.jsp" method = "post">	
			<input type="hidden" name="boardId" value="<%=board.getBoardId()%>">
			<table border="1">
				<tr>
					<th>내용</th>
					<td><textarea cols="50" rows="3" name="commentsContent"></textarea></td>
					<td><input type="submit" value="등록"></td>
				</tr>
			</table>
	
		</form>

		
		
		<button onclick="boardList();">목록</button>
		<button onclick="updates(<%= board.getBoardId() %>);">수정</button>
		<button onclick="deletes(<%= board.getBoardId() %>);">삭제</button>
	
		

	</body>
</html>
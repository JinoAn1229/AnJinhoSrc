<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="Dao.CategorysDao"%>
    
 <% 
 	//db에 저장된 카테고리 목록 불러오기
 	CategorysDao categorysDao = new CategorysDao();
 	ArrayList<String> categorysList = new ArrayList<String>();
 	categorysList = categorysDao.getCategorysList();		
 %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 - 등록</title>
<script type="text/javascript">


	function boardList(){
		location.href='./BoardList.jsp';
	}

</script>
</head>
<body>
<form action="./BoardAdd.jsp" method = "post" enctype="multipart/form-data">
	<div style="font: bold; font-size: 2.0em;">게시판 - 등록</div>
	<table border="1">
		<tr>
			<th>카테고리</th>
			<td>
				<select id="categorys" name="category">
				<option value=""></option>
				<%
					for(int i = 0; i < categorysList.size(); i++){	//디비에 저장된 카테고리 목록으로 셀렉트박스를 생성한다.				
				%>	
						<option value="<%= categorysList.get(i)%>"><%= categorysList.get(i)%></option>
				<%
					}				
				%>
				 </select>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer">
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<div style="float: left; width: 33%;">
					<input type="password" name="pw" placeholder="비밀번호">
				</div>
				<div style="float: left; width: 33%;">
					<input type="password" name="pwcheck" placeholder="비밀번호확인">
				</div>
			</td>	
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea cols="70" rows="15" name="content"></textarea></td>
		</tr>
	</table>
	
	<!-- 파일 업로드 3개-->
	<div>
		<input type="file" name="firstFile">
	</div>
	<div>
		<input type="file" name="secondFile">
	</div>
	<div>
		<input type="file" name="thirdFile">
	<div>
	<br>
	
	<div style="float: right; width: 33%;">
		<input type="submit" value="저장">
	</div>	
</form>

<div style="float: left; width: 50%;">
		<input type='button' value='취소' onclick="boardList();">
</div>
</body>
</html>
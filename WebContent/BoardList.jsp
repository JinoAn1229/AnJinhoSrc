<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dao.BoardDao"%>
<%@ page import="Vo.BoardVo"%>
<%@ page import="Vo.SearchVo"%>
<%@ page import="Vo.PageCreatorVo"%>
<%@ page import="java.util.*"%>


<%

	request.setCharacterEncoding("UTF-8");
	String rewriteDate = "-";
	String startDate = ""; 
	String endDate = "";
	String condition = "";
	String keyword = "";
	int pages = 1;
	int countPerPage = 10;
	int views = 0;
	
	BoardDao dao = new BoardDao(); // 인스턴스 생성
	SearchVo searchVo = new SearchVo();
	PageCreatorVo pc = new PageCreatorVo();
	
	if(request.getParameter("startDate")!=null){
		startDate = (String) request.getParameter("startDate");
	}
	if(request.getParameter("endDate")!=null){
		endDate = (String) request.getParameter("endDate");
	}
	if(request.getParameter("condition")!=null){
		condition = (String) request.getParameter("condition");
	}
	if(request.getParameter("keyword")!=null){
		keyword = (String) request.getParameter("keyword");
	}
	if(request.getParameter("page")!=null){
		pages = Integer.parseInt(request.getParameter("page"));
	}
	if(request.getParameter("countPerPage")!=null){
		countPerPage = Integer.parseInt(request.getParameter("countPerPage"));
	}
		
	searchVo.setStartDate(startDate);
	searchVo.setEndDate(endDate);
	searchVo.setCondition(condition);
	searchVo.setKeyword(keyword);
	searchVo.setPage(pages);
	searchVo.setCountPerPage(countPerPage);
	
	ArrayList<BoardVo> list = dao.searchGetList(searchVo); // 검색조건에 맞는 게시물 목록 가져오기
	
	pc = dao.getPageVo(searchVo); //페이징 작업

	views = dao.getCountBoardList(searchVo);  //총 게시물 수 가져오기
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
				$.datepicker.setDefaults({
					dateFormat: 'yy-mm-dd' //Input Display Format 변경
 					,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
					,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
             		,changeYear: true //콤보박스에서 년 선택 가능
               		,changeMonth: true //콤보박스에서 월 선택 가능
              		,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
             		,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
             		,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
              		,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
             		,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
             		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
             		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
               		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
               		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
              		,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
              		,maxDate: "+1Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    			});
        		
  				//input을 datepicker로 선언
          		$("#startDate").datepicker();
         		$("#endDate").datepicker();

        		//From의 초기값을 오늘 날짜로 설정
        		$('#startDate').datepicker('setDate', '<%=startDate%>'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
         		//To의 초기값을 내일로 설정
      			$('#endDate').datepicker('setDate', '<%=endDate%>'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
      		
			});
			
			function boardList(){  //게시물 등록 페이지로 이동
		           location.href='./BoardAddForm.jsp';
		    }
	       	 
			
		</script>        	
	</head>
	<body>
	
		<form action="./BoardList.jsp" method = "get">
		
    		<table>
				<tr>
					<td>
						<span>등록일</span>
   						<input type="text" id="startDate" name="startDate">~
     					<input type="text" id="endDate" name="endDate">
            		</td>
         			<td>
    					<select id="condition" class="form-control" name="condition">
 							<option value="boardTitle">제목</option>
							<option value="writer">작성자</option>
        					<option value="boardContent">내용</option>
        					<option value="titleWriterContent">제목+작성자+내용</option>
    					</select>
					</td>
            		<td>
   						<input type="text"  name="keyword"  placeholder="검색어" value="<%=keyword%>">
            		</td>
            		<td>
           				 <span>
               				 <input type="submit" value="검색">
            			</span>
            		</td>
        		</tr>
			</table>
			
  

		</form>
		
		<div style="font-size: 1.0em;">총<%=views%>건</div>

		<table style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">카테고리</th>
					<th style="background-color: #eeeeee; text-align: center;">첨부파일</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					<th style="background-color: #eeeeee; text-align: center;">수정일</th>
				</tr>
			</thead>
			
			<tbody>
				
				<%
					for(int i = 0; i < list.size(); i++){					
				%>			
				<tr>
					<td><%= list.get(i).getCategory() %></td>					
					<%
						if(list.get(i).isFilesCheck()){	//게시물에 파일을 하나라도 첨부하면 표시해준다					
					%>
							<td><img src = "./images/files.png" width="20" height="20" alt=""></td>
					<%		
						}
					%>
					<%
						if(!list.get(i).isFilesCheck()){ 
							
					%>
							<td></td>
					<%		
						}
					%>
					
					
					<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
					<td><a href="BoardView.jsp?boardId=<%= list.get(i).getBoardId() %>">
						<%= list.get(i).getBoardTitle() %></a></td>
					<td><%= list.get(i).getWriter() %></td>
					<td><%= list.get(i).getView() %></td>
					<td><%= list.get(i).getRegdate()%></td>
					<td><%= list.get(i).getRewriteDate() %></td>			
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<!--To do 페이징처리 구현-->
		<ul class="paging">
			<%
				if(pc.isPrev()) {  //현재 보여진 페이징보다 전 페이지가 있으면 실행
			%>
 					<a href="./BoardList.jsp?page=1&countePerPage=<%=pc.getPaging().getCountPerPage() %>
 					&keyword=<%=keyword%>&condition=<%=condition%>&startDate=<%=startDate%>&endDate=<%=endDate%>"><<</a>
			<%
				}
			%>
					<a href="./BoardList.jsp?page=<%=pc.getPaging().getPage()-1%>&countePerPage=<%=pc.getPaging().getCountPerPage() %>
					&keyword=<%=keyword%>&condition=<%=condition%>&startDate=<%=startDate%>&endDate=<%=endDate%>"><</a>

			<%
				for(int pageNum = pc.getBeginPage(); pageNum <= pc.getEndPage(); pageNum++){
			%>			
      				<a href="./BoardList.jsp?page=<%=pageNum%>&countePerPage=<%=pc.getPaging().getCountPerPage() %>
      				&keyword=<%=keyword%>&condition=<%=condition%>&startDate=<%=startDate%>&endDate=<%=endDate%>" ><%= pageNum %></a>
			<%
				}
			%>
					<a href="./BoardList.jsp?page=<%=pc.getPaging().getPage()+1%>&countePerPage=<%=pc.getPaging().getCountPerPage() %>
					&keyword=<%=keyword%>&condition=<%=condition%>&startDate=<%=startDate%>&endDate=<%=endDate%>">></a>				
  					
			<%
				if(pc.isNext()) { //현재 보여진 페이징보다 더 페이지가 있으면 실행
			%>		
  					<a href="./BoardList.jsp?page=<%=pc.getLastPage() %>&countePerPage=<%=pc.getPaging().getCountPerPage() %>
  					&keyword=<%=keyword%>&condition=<%=condition%>&startDate=<%=startDate%>&endDate=<%=endDate%>">>></a>
    		<%
				}
			%>
		</ul>
		
		
		<button onclick="boardList();">등록</button>
		
	</body>
</html>
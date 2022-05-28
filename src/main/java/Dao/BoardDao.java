package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Vo.BoardVo;
import Vo.PageCreatorVo;
import Vo.SearchVo;
import util.DatabaseUtil;

public class BoardDao {
	
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	
	
	
	/**
	 * @methodType : boardDao
	 * @methodName : addBoardList
	 * @param : boardVo
	 * @return : int 
	 * @throws SQLException 
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 게시글을 등록하는 쿼리 
	 */
	public int addBoardList(BoardVo boardVo)   {  //게시글 등록 쿼리
		
		String SQL = "INSERT INTO board_list ( board_title, board_content, writer, pw, categorys) VALUES (?,?,?,?,?)";
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, boardVo.getBoardTitle());
			psmt.setString(2, boardVo.getBoardContent());
			psmt.setString(3, boardVo.getWriter());
			psmt.setString(4, boardVo.getPw());
			psmt.setString(5, boardVo.getCategory());
			return psmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		
		return -1;
	}
	
	
	
	/**
	 * @methodType : BoardDao
	 * @methodName : searchGetList
	 * @param :  searchVo
	 * @return : ArrayList<BoardVo>
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 조건에따라 게시판 목록 불러오기
	
	 */
	public ArrayList<BoardVo> searchGetList(SearchVo searchVo) {  
		//값없을때 처리해야할듯
		String SQL = "";
		
		if(searchVo.getStartDate().equals("") || searchVo.getEndDate().equals("")){ //검색조건 없을때
			SQL = "SELECT * FROM board_list AS bl LEFT OUTER JOIN files AS f ON bl.board_id = f.board_id" +
				  " GROUP BY bl.board_id ORDER BY bl.board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		else if(searchVo.getCondition().equals("boardTitle")) {  //제목으로검색
			 SQL = "SELECT * FROM board_list AS bl LEFT OUTER JOIN files AS f ON bl.board_id = f.board_id " + 
				   " WHERE board_title like  '%" + searchVo.getKeyword() + 
				   "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + 
					"' GROUP BY bl.board_id ORDER BY bl.board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		else if(searchVo.getCondition().equals("writer")) {  //작성자로검색
			SQL = "SELECT * FROM board_list AS bl LEFT OUTER JOIN files AS f ON bl.board_id = f.board_id " + 
					   " WHERE writer like  '%" + searchVo.getKeyword() + 
					   "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + 
						"' GROUP BY bl.board_id ORDER BY bl.board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		else if(searchVo.getCondition().equals("boardContent")) {  //글 내용 으로검색
			SQL = "SELECT * FROM board_list AS bl LEFT OUTER JOIN files AS f ON bl.board_id = f.board_id " + 
					   " WHERE board_content like  '%" + searchVo.getKeyword() + 
					   "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + 
						"' GROUP BY bl.board_id ORDER BY bl.board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		else if(searchVo.getCondition().equals("titleWriterContent")) {  //3가지 조건중 아무거나 검색 쿼리문 조금 수정해야함
			 SQL = "SELECT * FROM board_list WHERE board_content like '%" + 
					 searchVo.getKeyword() + "%' OR writer like '%" + searchVo.getKeyword() + "%' OR board_content like '%" + 
					 searchVo.getKeyword() + "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + 
						"' ORDER BY board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		else { //날짜로만 검색
			SQL = "SELECT * FROM board_list AS bl LEFT OUTER JOIN files AS f ON bl.board_id = f.board_id" + 
				  " WHERE reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + 
					"' GROUP BY bl.board_id ORDER BY bl.board_id desc LIMIT " + searchVo.getStartPage() + "," + searchVo.getCountPerPage();
		}
		
		
																
		ArrayList<BoardVo> list = new ArrayList<BoardVo>();
		boolean filesCheck = false;
		
		conn = null;
		rs= null;
		 
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 rs= psmt.executeQuery();
			 
			 
			 while(rs.next()) {
				 filesCheck = false;
				 if(rs.getInt("files_id") != 0) filesCheck = true;  //파일이 존재하는지 확인
				 
				 BoardVo board = new BoardVo();
				 board.setBoardId(rs.getInt("board_id"));
				 board.setBoardTitle(rs.getString("board_title"));
				 board.setBoardContent(rs.getString("board_content"));
				 board.setWriter(rs.getString("writer"));
				 board.setPw(rs.getString("pw"));
				 board.setView(rs.getInt("views"));
				 board.setCategory(rs.getString("categorys"));
				 board.setRegdate(rs.getString("reg_date"));
				 board.setFilesCheck(filesCheck);
				 if(rs.getString("rewrite_date") == null) board.setRewriteDage("-");
				 else board.setRewriteDage(rs.getString("rewrite_date"));		
				 list.add(board);
			 }	
		}
		catch (Exception e) { //DB 끊는것
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return list;
	}
	
	
	/**
	 * @methodType : BoardDao
	 * @methodName : getPageVo
	 * @param : searchVo
	 * @return : PageCreatorVo
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 페이징 작업 처리 
	
	 */
	public PageCreatorVo getPageVo(SearchVo searchVo) throws SQLException {  
		
		PageCreatorVo pc = new PageCreatorVo();
		BoardDao dao = new BoardDao(); 
		
		pc.setPaging(searchVo);
        pc.setTotalArticles(dao.getCountBoardList(searchVo));

		return pc;
	}
	
	/*public Map<String,Object> searchGetMapList(SearchVo vo) throws SQLException {  //맵 형식을 리턴받아 페이지 정보랑 같이 가져오는데 받는법 찾는중
	String SQL = "SELECT * FROM board_list WHERE board_title like  '%" + vo.getKeyword() + "%' AND reg_date BETWEEN ? AND ?  ORDER BY board_id desc LIMIT " + vo.getStartPage() + ",?";
			
	Map<String, Object> result = new HashMap<>();
	ArrayList<boardVo> boardList = new ArrayList<boardVo>();
	PageCreatorVo pc = new PageCreatorVo();
	boardDao dao = new boardDao(); 
	
	pc.setPaging(vo);
    pc.setTotalArticles(dao.getCountBoardList());
	
	
	conn = null;
	psmt = null;
	rs= null;
	 
	try {
		 conn = DatabaseUtil.getConnection();
		 psmt = conn.prepareStatement(SQL);
		 //psmt.setString(1, vo.getKeyword());
		 psmt.setString(1, vo.getStartDate());
		 psmt.setString(2, vo.getEndDate());
		 //psmt.setInt(3, vo.getStartPage());
		 psmt.setInt(3, vo.getCountPerPage());
		 rs= psmt.executeQuery();
		 
		 while(rs.next()) {
			 boardVo board = new boardVo();
			 board.setBoardId(rs.getInt("board_id"));
			 board.setBoardTitle(rs.getString("board_title"));
			 board.setBoardContent(rs.getString("board_content"));
			 board.setWriter(rs.getString("writer"));
			 board.setPw(rs.getString("pw"));
			 board.setView(rs.getInt("views"));
			 board.setCategory(rs.getString("categorys"));
			 board.setRegdate(rs.getString("reg_date"));
			 if(rs.getString("rewrite_date") == null) board.setRewriteDage("-");
			 else board.setRewriteDage(rs.getString("rewrite_date"));		
			 boardList.add(board);
		 }	
	}
	catch (Exception e) { //DB 끊는것
		e.printStackTrace();
	}
	finally
	{
		//if(bNewConnect)
		conn.close();
		rs.close();
		psmt.close();
		
	}	
	result.put("boardList", boardList);
    result.put("pc", pc);
	return result;
}*/
	
	/**
	 * @methodType : BoardDao
	 * @methodName : getBoard
	 * @param : boardId
	 * @return : BoardVo
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 게시글 상세보기
	
	 */
	public BoardVo getBoard(int boardId) {   
		
		//updateView(boardId); //게시글 조회수 1증가 시키고 출력
		
		BoardVo board = null;
		String SQL = "select * from board_list WHERE board_id = ?";
		
		conn = null;
		rs= null;
		
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 psmt.setInt(1, boardId);
			 rs= psmt.executeQuery();
			 
			 if(rs.next()) {
				 board = new BoardVo();
				 board.setBoardId(rs.getInt("board_id"));
				 board.setBoardTitle(rs.getString("board_title"));
				 board.setBoardContent(rs.getString("board_content"));
				 board.setWriter(rs.getString("writer"));
				 board.setPw(rs.getString("pw"));
				 board.setView(rs.getInt("views"));
				 board.setCategory(rs.getString("categorys"));
				 board.setRegdate(rs.getString("reg_date"));
				 if(rs.getString("rewrite_date") == null) board.setRewriteDage("-");
				 else board.setRewriteDage(rs.getString("rewrite_date"));		
			 } 
			 	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return board;
	}
	
	/**
	 * @methodType : BoardDao
	 * @methodName : getCountBoardList
	 * @param : searchVo
	 * @return : int
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 조건에 따라 총 게시글 수 조회
	
	 */
	public int getCountBoardList(SearchVo searchVo)  {  //
		//값없을때 처리해야할듯
		String SQL = "";
		int views = 0;
		
		if(searchVo.getStartDate().equals("") || searchVo.getEndDate().equals("")){
			SQL = "SELECT count(*) FROM board_list";
		}
		else if(searchVo.getCondition().equals("boardTitle")) {  //제목으로검색
			 SQL = "SELECT count(*) FROM board_list WHERE board_title like  '%" + 
					 searchVo.getKeyword() + "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate() + "'"; 
						
		}
		else if(searchVo.getCondition().equals("writer")) {  //작성자로검색
			 SQL = "SELECT count(*) FROM board_list WHERE writer like  '%" + 
					 searchVo.getKeyword() + "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate()+ "'"; 
		}
		else if(searchVo.getCondition().equals("boardContent")) {  //글 내용 으로검색
			 SQL = "SELECT count(*) FROM board_list WHERE board_content like  '%" + 
					 searchVo.getKeyword() + "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate()+ "'"; 
		}
		else if(searchVo.getCondition().equals("titleWriterContent")) {  //3가지 조건중 아무거나 검색 쿼리문 조금 수정해야함
			 SQL = "SELECT count(*) FROM board_list WHERE board_content like '%" + 
					 searchVo.getKeyword() + "%' OR writer like '%" + searchVo.getKeyword() + "%' OR board_content like '%" + 
					 searchVo.getKeyword() + "%' AND reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate()+ "'"; 
		}
		else {
			SQL = "SELECT count(*) FROM board_list WHERE reg_date BETWEEN '" + searchVo.getStartDate() + "' AND '" + searchVo.getEndDate()+ "'"; 
		}   
		
		
		
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 rs= psmt.executeQuery();
 
			 if(rs.next()){
				 views = rs.getInt(1);
			 }			 	
			 
			 	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return views;
	}
	
	/**
	 * @methodType : BoardDao
	 * @methodName : updateView
	 * @param : boardId
	 * @return : int
	 * @throws SQLException 
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 게시글을 확인하면 조회수 증가
	
	 */
	public int updateView(int boardId) {   
		String SQL = "UPDATE board_list SET views = views+1 WHERE board_id = ?";
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, boardId);
			return psmt.executeUpdate();	 		 	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return -1;
	}
	
	/**
	 * @methodType : BoardDao
	 * @methodName : updateBoard
	 * @param : board
	 * @return : int
	 * @throws SQLException 
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 게시글 수정
	
	 */
	public int updateBoard(BoardVo board)  {   
		String SQL = "UPDATE board_list SET board_title = ?, board_content = ?,writer = ?, pw = ?, rewrite_date = NOW()"
					+ "WHERE board_id = ?";
		
		conn = null;
		psmt = null;
		
		
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setString(1, board.getBoardTitle());
			psmt.setString(2, board.getBoardContent());
			psmt.setString(3, board.getWriter());
			psmt.setString(4, board.getPw());
			psmt.setInt(5, board.getBoardId());
			return psmt.executeUpdate();	 		 	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return -1;
	}
	
	/**
	 * @methodType : BoardDao
	 * @methodName : deleteBoard
	 * @param : boardId
	 * @return : int
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 게시글 삭제
	
	 */
	public int deleteBoard(int boardId)   {   
		String SQL = "DELETE FROM board_list  WHERE board_id = ?";
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, boardId);
			return psmt.executeUpdate();	 		 	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		
		return -1;
	}
	
	
	
	public int getNextBoardId() {   //board_id의 다음값을 가져오는 함수 (파일 추가시 board_id저장할때 사용)
		String SQL = "SELECT board_id FROM board_list ORDER BY board_id desc"; //나중에 limit 1걸어보자
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 rs= psmt.executeQuery();
			 
			 if(rs.next()) {
				 return rs.getInt(1)+1;
			 }	
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			try {
				conn.close();
				rs.close();
				psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		return -1;
	}
	
	
	
	
}

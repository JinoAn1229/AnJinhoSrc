package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Vo.CommentsVo;
import util.DatabaseUtil;

public class CommentsDao {
	
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	
	/**
	 * @methodType : CommentsDao
	 * @methodName : addComments
	 * @param : boardId
	 * @param : commentsContent
	 * @return : int
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : 댓글 등록 쿼리
	 * 매개 변수가 적어 따로 객체에 안 담았다
	
	 */
	public int addComments(int boardId, String commentsContent)  {  
		String SQL = "INSERT INTO comments ( board_id,comments_content) VALUES (?,?)";
		
		conn = null;
		psmt = null;
	
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, boardId);
			psmt.setString(2, commentsContent);
			
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
	 * @methodType : CommentsDao
	 * @methodName : getList
	 * @param : boardId
	 * @return : ArrayList<CommentsVo>
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : boardId에 속한 댓글 목록 불러오기
	
	 */
	public ArrayList<CommentsVo> getList(int boardId) {  
		String SQL = "SELECT * FROM comments WHERE board_id = ? ORDER BY reg_date DESC ";
		ArrayList<CommentsVo> list = new ArrayList<CommentsVo>();
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 psmt.setInt(1, boardId);
		
			 rs= psmt.executeQuery();
			 
			 while(rs.next()) {
				 CommentsVo comments = new CommentsVo();
				 comments.setCommentsContent(rs.getString("comments_content"));
				 comments.setRegdate(rs.getString("reg_date"));			
				 list.add(comments);
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
		return list;
	}
	

	
	
}

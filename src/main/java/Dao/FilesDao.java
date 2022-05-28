package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Vo.FilesVo;
import util.DatabaseUtil;

public class FilesDao {
	
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	
	
	
	
	
	
	
	/**
	 * @methodType : FilesDao
	 * @methodName : addFiles
	 * @param : filesVo 파일 객체
	 * @return : int
	 * @lastUpdate : 2022. 5. 27.
	 * @methodInfo : 파일 정보 등록
	
	 */
	public int addFiles(FilesVo filesVo) throws SQLException {  
		String SQL = "INSERT INTO files ( board_id, files_name, files_realname, files_path) VALUES (?, ?, ?, ?)";
		
		conn = null;
		psmt = null;
	
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, filesVo.getBoardId());
			psmt.setString(2, filesVo.getFilesName());
			psmt.setString(3, filesVo.getFilesRealname());
			psmt.setString(4, filesVo.getFilesPath());
			
			return psmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			//if(bNewConnect)
			conn.close();
			psmt.close();
			
		}	
		return -1;
	}
	
	/**
	 * @methodType : FilesDao
	 * @methodName : getFilesList
	 * @param : boardId
	 * @return : ArrayList<FilesVo>
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : boardId에 속한 파일 목록 가져오기
	
	 */
	public ArrayList<FilesVo> getFilesList(int boardId) {   
		String SQL = "SELECT * FROM files where board_id = ? ORDER BY files_id  ";
		ArrayList<FilesVo> list = new ArrayList<FilesVo>();
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 psmt.setInt(1, boardId);
		
			 rs= psmt.executeQuery();
			 
			 while(rs.next()) {
				 FilesVo filesVo = new FilesVo();
				 filesVo.setFilesName(rs.getString("files_name"));
				 filesVo.setFilesRealname(rs.getString("files_realname"));
				 filesVo.setFilesPath(rs.getString("files_path"));
				 filesVo.setFilesId(rs.getInt("files_id"));
				 list.add(filesVo);
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
	
	
	/**
	 * @methodType : FilesDao
	 * @methodName : getFiles
	 * @param : filesId
	 * @return : FilesVo
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : filesId로 파일정보 가져오기
	
	 */
	public FilesVo getFiles(int filesId) {  
		String SQL = "SELECT * FROM files where files_id = ?";
		 FilesVo filesVo = new FilesVo();
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);
			 psmt.setInt(1, filesId);
		
			 rs= psmt.executeQuery();
			 
			 if(rs.next()) {				
				 filesVo.setFilesName(rs.getString("files_name"));
				 filesVo.setFilesRealname(rs.getString("files_realname"));
				 filesVo.setFilesPath(rs.getString("files_path"));
				 filesVo.setBoardId(rs.getInt("board_id"));	
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
		return filesVo;
	}
	
	
	/**
	 * @methodType : FilesDao
	 * @methodName : deleteFiles
	 * @param : filesId
	 * @return : int
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : filesId와 일치한 파일 목록 삭제
	
	 */
	public int deleteFiles(int filesId)  {  
		
		
		String SQL = "DELETE FROM files WHERE files_id = ?";
		try {
			conn = DatabaseUtil.getConnection();
			psmt = conn.prepareStatement(SQL);
			psmt.setInt(1, filesId);

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
	

	
}

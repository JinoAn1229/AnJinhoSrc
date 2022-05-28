package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class CategorysDao {
	
	private Connection conn;
	private PreparedStatement psmt;
	private ResultSet rs;
	
	
	
	/**
	 * @methodType : CategorysDao
	 * @methodName : getCategorysList
	 * @param : 
	 * @return : ArrayList<String>
	 * @lastUpdate : 2022. 5. 28.
	 * @methodInfo : 카테고리 목록 불러오기
	
	 */
	public ArrayList<String> getCategorysList() {   
		String SQL = "SELECT * FROM category";
		ArrayList<String> categorysList = new ArrayList<String>();
		try {
			 conn = DatabaseUtil.getConnection();
			 psmt = conn.prepareStatement(SQL);

			 rs= psmt.executeQuery();
			 
			 while(rs.next()) {			
				 categorysList.add(rs.getString("category_name"));
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
		return categorysList;
	}
	

	
	
}

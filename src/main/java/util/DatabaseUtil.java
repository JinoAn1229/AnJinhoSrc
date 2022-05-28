package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board";
			String dbID = "root";
			String dbPW = "7700";
			Class.forName("org.mariadb.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}

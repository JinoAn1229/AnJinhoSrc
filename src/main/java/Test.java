
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class Test {
    public static void main(String[] args) throws SQLException {
        String driver="org.mariadb.jdbc.Driver";
        String dbUrl="jdbc:mysql://localhost:3306/board";
        try {
            //1.데이터베이스 드라이버 로딩
            Class.forName(driver);
            System.out.println("DB Driver Loading");
             
            //2.데이터베이스 서버와 연결
            Connection con=DriverManager.getConnection(dbUrl,"user","user");
            System.out.println("DB Connection:"+con);
 
            con.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
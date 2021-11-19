package utill;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {

	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection("jdbc:oracle:thin:@db.llrayall.com:1521:xe", "JSPUSER", "JSPUSER");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	
}

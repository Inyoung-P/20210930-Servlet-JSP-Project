package utill;

public class DBConnTests {
	
	public static void main(String[] args) {
		testGetConnection();
	}
	
	// DB 연결
	public static void testGetConnection() {
		System.out.println(DBConn.getConnection());
	}
}

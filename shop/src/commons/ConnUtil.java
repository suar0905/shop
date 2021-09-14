package commons;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnUtil {
	
	// maira db 환경 설정 메소드
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		// maria db 사용
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("[debug] mariadb 등록 확인!");
		
		// maria db 접속
		String url = "jdbc:mariadb://127.0.01:3306/shop";
		String id = "root";
		String pw = "java1004";
		Connection conn = DriverManager.getConnection(url, id, pw);
				
		return conn;
	}
}

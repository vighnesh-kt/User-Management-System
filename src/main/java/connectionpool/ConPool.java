package connectionpool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConPool {


	private static String url = "jdbc:postgresql://localhost:5432/user_management_system?user=postgres&password=root";
	private static String driver ="org.postgresql.Driver";
	private static final int poolSize = 4;
	private static List<Connection> connPool = new ArrayList<>();
	static {
		for (int i = 0; i < poolSize; i++) {
			connPool.add(createConn());
		}
	}

	private static Connection createConn() {
		Connection con = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return con;
	}

	public static Connection giveConn() {
		if (!connPool.isEmpty())
			return connPool.remove(0);

		else
			return createConn();
	}

	public static void submitConn(Connection con) {
		if (connPool.size() < poolSize) {
			connPool.add(con);
		} else {

			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}

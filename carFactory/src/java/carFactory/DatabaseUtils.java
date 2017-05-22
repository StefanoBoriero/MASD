package carFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.sql.ResultSet;

public class DatabaseUtils {
	
	private Logger logger;
	
	public DatabaseUtils(Logger logger) {
		this.logger = logger;
	}

	public List<Integer> GetCars() {
		List<Integer> list = new ArrayList<Integer>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet res = null;
		try {
		    conn = DriverManager.getConnection(Constants.CONNECTION_URL,
		    		Constants.USERNAME, Constants.PASSWORD);
		    stmt = conn.createStatement();
		    res = stmt.executeQuery("SELECT * FROM sql11175794.cars;");
		    while (res.next()) {
		    	list.add(res.getInt("id"));
		    }
		    	
		} catch (SQLException ex) {
			logger.info("SQLException: " + ex.getMessage());
			logger.info("SQLState: " + ex.getSQLState());
			logger.info("VendorError: " + ex.getErrorCode());
		}
		return list;
	}

}

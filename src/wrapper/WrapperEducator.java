package wrapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import model.Educator;
import utils.ConnectionPool;

public class WrapperEducator {

	private static final String GET_ALL = "select * FROM show_educators";
	private static final String FIND_LOGED = "select * FROM educator WHERE username = ? AND password = ?";
	private static final String FIND_NAME = "select * FROM find_educator_name WHERE username = ? AND password = ?";

	public static boolean isEducator(String username, String password) {
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			ps = c.prepareStatement(FIND_LOGED);
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();

			if (rs.isBeforeFirst()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(ps, rs, c);
		}
		return false;
	}

	public static ObservableList<Educator> getAll() {
		ObservableList<Educator> educators = FXCollections.observableArrayList();
		Connection c = null;
		Statement s = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			s = c.createStatement();
			rs = s.executeQuery(GET_ALL);
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
			while (rs.next()) {
				educators.add(new Educator(rs.getString(2), rs.getString(3), rs.getString(1), dt.format(rs.getDate(4)),
						rs.getString(5) + "," + rs.getString(6) + "," + String.valueOf(rs.getInt(7))));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(s, rs, c);
		}
		return educators;
	}

	public static String getName(String username, String password) {
		String name = "";
		Connection c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			ps = c.prepareStatement(FIND_NAME);
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			rs.next();
			name = rs.getString(1) + " " + rs.getString(2);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(ps, rs, c);
		}
		return name;
	}

	private static void close(Statement s, ResultSet rs, Connection c) {
		if (s != null) {
			try {
				s.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		ConnectionPool.getInstance().checkIn(c);
	}

}

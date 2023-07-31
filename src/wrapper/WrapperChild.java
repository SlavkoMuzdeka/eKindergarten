package wrapper;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.sql.Date;
import java.sql.ResultSet;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import model.Child;
import utils.ConnectionPool;

public class WrapperChild {

	private static final String CREATE = "{call create_child(?,?,?,?,?,?,?,?,?,?)}";
	private static final String GET_ALL = "select * FROM show_children";

	public static boolean create(String firstName, String lastName, String imbd, Integer streetNumber, String streetName,
			String city, Integer height, Integer weight, LocalDate dateOfBirth) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(CREATE);

			cs.setString(1, firstName);
			cs.setString(2, lastName);
			cs.setString(3, imbd);
			cs.setInt(4, streetNumber);
			cs.setString(5, streetName);
			cs.setString(6, city);
			cs.setInt(7, height);
			cs.setInt(8, weight);
			cs.setDate(9, Date.valueOf(dateOfBirth));
			cs.registerOutParameter(10, Types.BOOLEAN);

			cs.executeUpdate();

			return cs.getBoolean(10);
		} catch (Exception ex) {
			return false;
		} finally {
			close(c, cs, null);
		}
	}

	public static ObservableList<Child> getAll() {
		ObservableList<Child> children = FXCollections.observableArrayList();
		Connection c = null;
		Statement s = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			;
			s = c.createStatement();
			rs = s.executeQuery(GET_ALL);
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
			while (rs.next()) {
				children.add(new Child(rs.getString(2), rs.getString(3), rs.getString(1), dt.format(rs.getDate(4)),
						rs.getString(5) + "," + rs.getString(6) + "," + String.valueOf(rs.getInt(7)),
						String.valueOf(rs.getInt(8)), String.valueOf(rs.getInt(9))));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(c, s, rs);
		}
		return children;
	}

	private static void close(Connection c, Statement s, ResultSet rs) {
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

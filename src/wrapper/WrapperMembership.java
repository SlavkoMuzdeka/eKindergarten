package wrapper;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import model.Membership;
import utils.ConnectionPool;

public class WrapperMembership {

	private static String GET_ALL = "{call show_membership_fees(?)}";
	private static String PAY_MEMBERSHIP = "{call pay_membership_fee(?)}";
	private static String CREATE_MEMBERSHIP = "{call create_membership_fee(?,?,?,?)}";

	public static ObservableList<Membership> getAll(String imbd) {
		ObservableList<Membership> memberships = FXCollections.observableArrayList();
		Connection c = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(GET_ALL);
			cs.setString(1, imbd);
			rs = cs.executeQuery();
			SimpleDateFormat dt = new SimpleDateFormat("MM/yyyy");
			while (rs.next()) {
				Boolean isPaid = false;
				if (rs.getInt(4) == 0) {
					isPaid = false;
				} else {
					isPaid = true;
				}
				memberships.add(new Membership(rs.getInt(1), rs.getString(2),
						String.valueOf(rs.getInt(3)) + " KM", isPaid, dt.format(rs.getDate(5))));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(c, cs, rs);
		}
		return memberships;
	}

	public static boolean pay(Integer id) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(PAY_MEMBERSHIP);
			cs.setInt(1, id);
			cs.executeQuery();
			return true;
		} catch (Exception ex) {
			return false;
		} finally {
			close(c, cs, null);
		}
	}

	public static boolean create(String imbd, String type, Integer amount, LocalDate month) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(CREATE_MEMBERSHIP);
			cs.setString(1, imbd);
			cs.setString(2, type);
			cs.setInt(3, amount);
			cs.setDate(4, Date.valueOf(month));
			cs.executeQuery();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		} finally {
			close(c, cs, null);
		}
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

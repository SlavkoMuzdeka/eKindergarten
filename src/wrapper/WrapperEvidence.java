package wrapper;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import model.Evidence;
import utils.ConnectionPool;

public class WrapperEvidence {

	private static final String GET_ALL = "call prikaz_evidencija(?)";
	private static final String SET_ARRIVAL = "{call evidentiraj_dolazak(?,?,?)}";
	private static final String SET_DEPARTURE = "{call evidentiraj_odlazak(?,?)}";
	public static boolean isMembershipPaid;

	public static ObservableList<Evidence> getAll(String imbd) {
		ObservableList<Evidence> evidences = FXCollections.observableArrayList();
		Connection c = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(GET_ALL);
			cs.setString(1, imbd);
			rs = cs.executeQuery();
			while (rs.next()) {
				evidences.add(new Evidence(rs.getDate(1).toString(), rs.getTime(1).toString()));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(c, cs, rs);
		}
		return evidences;
	}

	public static boolean setArrival(String imbd) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(SET_ARRIVAL);
			cs.setString(1, imbd);
			cs.registerOutParameter(2, Types.BOOLEAN);
			cs.registerOutParameter(3, Types.BOOLEAN);
			cs.executeUpdate();

			isMembershipPaid = cs.getBoolean(2);
			return cs.getBoolean(3);
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		} finally {
			close(c, cs, null);
		}
	}

	public static boolean setDeparture(String imbd) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(SET_DEPARTURE);
			cs.setString(1, imbd);
			cs.registerOutParameter(2, Types.BOOLEAN);
			cs.executeUpdate();
			return cs.getBoolean(2);
		} catch (Exception ex) {
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

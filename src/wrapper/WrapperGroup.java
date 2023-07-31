package wrapper;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import model.Child;
import model.Group;
import utils.ConnectionPool;
import model.Educator;

public class WrapperGroup {

	private static final String GET_ALL = "select * FROM ekindergarten.group WHERE isActive = 1";
	private static final String DELETE = "update ekindergarten.group set isActive = 0 WHERE name = ?";
	private static final String CREATE = "insert into ekindergarten.group(name, numberOfMembers, isActive) values (?, 0, 1)";
	private static final String GET_EDUCATORS = "{call get_educators_from_group(?)}";
	private static final String GET_CHILDREN = "{call get_children_from_group(?)}";
	private static final String DELETE_FROM_GROUP = "{call delete_from_group(?,?,?)}";
	public static final String ADD_IN_GROUP = "{call add_in_group(?,?,?,?)}";

	public static ObservableList<Group> getAll() {
		ObservableList<Group> groups = FXCollections.observableArrayList();
		Connection c = null;
		Statement s = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			s = c.createStatement();
			rs = s.executeQuery(GET_ALL);
			while (rs.next()) {
				groups.add(new Group(rs.getString(2), rs.getInt(3)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(c, s, rs);
		}
		return groups;
	}

	public static ObservableList<Educator> getEducators(String groupName) {
		ObservableList<Educator> educators = FXCollections.observableArrayList();
		Connection c = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(GET_EDUCATORS);
			cs.setString(1, groupName);
			rs = cs.executeQuery();
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
			while (rs.next()) {
				educators.add(new Educator(rs.getString(2), rs.getString(3), rs.getString(1), dt.format(rs.getDate(4)),
						rs.getString(5) + "," + rs.getString(6) + "," + String.valueOf(rs.getInt(7))));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(c, cs, rs);
		}
		return educators;
	}

	public static ObservableList<Child> getChildren(String groupName) {
		ObservableList<Child> children = FXCollections.observableArrayList();
		Connection c = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(GET_CHILDREN);
			cs.setString(1, groupName);
			rs = cs.executeQuery();
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
			while (rs.next()) {
				children.add(new Child(rs.getString(2), rs.getString(3), rs.getString(1), dt.format(rs.getDate(4)),
						rs.getString(5) + "," + rs.getString(6) + "," + String.valueOf(rs.getInt(7)),
						String.valueOf(rs.getInt(8)), String.valueOf(rs.getInt(9))));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(c, cs, rs);
		}
		return children;
	}

	public static boolean deleteFromGroup(String imbd, String groupName) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(DELETE_FROM_GROUP);
			cs.setString(1, imbd);
			cs.setString(2, groupName);
			cs.registerOutParameter(3, Types.BOOLEAN);

			cs.executeUpdate();

			return cs.getBoolean(3);

		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		} finally {
			close(c, cs, null);
		}
	}

	public static boolean addInGroup(String imbd, String groupName, boolean t) {
		Connection c = null;
		CallableStatement cs = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			cs = c.prepareCall(ADD_IN_GROUP);
			cs.setString(1, imbd);
			cs.setString(2, groupName);
			cs.setBoolean(3, t);
			cs.registerOutParameter(4, Types.BOOLEAN);

			cs.executeUpdate();

			return cs.getBoolean(4);
		} catch (Exception ex) {
			return false;
		} finally {
			close(c, cs, null);
		}
	}

	public static boolean delete(String groupName) {
		Connection c = null;
		PreparedStatement ps = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			c = ConnectionPool.getInstance().checkOut();
			;
			ps = c.prepareStatement(DELETE);
			ps.setString(1, groupName);
			ps.executeUpdate();
		} catch (SQLException e) {
			return false;
		} finally {
			close(c, ps, null);
		}
		return true;
	}

	public static boolean create(String groupName) {
		Connection c = null;
		PreparedStatement ps = null;
		try {
			c = ConnectionPool.getInstance().checkOut();
			;
			ps = c.prepareStatement(CREATE);
			ps.setString(1, groupName);
			int pom = ps.executeUpdate();
			if (pom == 1) {
				return true;
			} else {
				return false;
			}
		} catch (Exception ex) {
			return false;
		} finally {
			close(c, ps, null);
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

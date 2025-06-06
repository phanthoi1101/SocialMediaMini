package RoomModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class RoomDao {
	public int GetRoomID(int SenderID , int ReceiverId) {
		try {
			int roomId = 0;
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT r.RoomID\r\n"
					+ "FROM Rooms r\r\n"
					+ "JOIN RoomDetail rd1 ON r.RoomID = rd1.RoomID AND rd1.UserID = ?\r\n"
					+ "JOIN RoomDetail rd2 ON r.RoomID = rd2.RoomID AND rd2.UserID = ?\r\n"
					+ "WHERE r.IsGroup = 0;";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, SenderID);
			cmd.setInt(2, ReceiverId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				roomId =rs.getInt("RoomID");
			}
			kn.cn.close();
			rs.close();
			return roomId;
		} catch (Exception e) {
			System.out.println("Get RoomId by User  "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public Room getRoomByRoomID ( int roomId) {
		try {
			Room room = new Room();
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Rooms where RoomID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, roomId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int roomid = rs.getInt("RoomID");
				String roomname = rs.getString("RoomName");
				boolean isgroup = rs.getBoolean("IsGroup");
				Date CreatedAt = rs.getDate("CreatedAt");
				boolean Status = rs.getBoolean("Status");
				room = new Room(roomid, roomname, isgroup, CreatedAt, Status);
			}
			kn.cn.close();
			rs.close();
			return room;
		} catch (Exception e) {
			System.out.println("Get RoomId by roomId  "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Integer> GetRoomIDByUserId(int userId) {
		try {
			ArrayList<Integer> ds = new ArrayList<Integer>();
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT rd.RoomId\r\n"
					+ "FROM RoomDetail rd\r\n"
					+ "LEFT JOIN Messages m ON rd.RoomId = m.RoomId\r\n"
					+ "WHERE rd.UserID = ?\r\n"
					+ "GROUP BY rd.RoomId\r\n"
					+ "ORDER BY MAX(m.SentAt) DESC";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int roomId = rs.getInt("RoomId");
				ds.add(roomId);
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Get RoomId by User  "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public int CreateRoom(String RoomName,boolean IsGroup) {
		try {
			KetNoi kn = new KetNoi();
			int idMoi = 0 ;
			kn.KetNoi();
			String sql = "insert into Rooms(RoomName,IsGroup,Status)\r\n"
					+ "values(?,?,1)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
			cmd.setString(1, RoomName);
			cmd.setBoolean(2, IsGroup);
			cmd.executeUpdate();

			ResultSet rs = cmd.getGeneratedKeys();
			if (rs.next()) {
			    idMoi = rs.getInt(1);
			}
			kn.cn.close();
			rs.close();
			return idMoi;
		} catch (Exception e) {
			System.out.println("Tạo Room Chat   "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public boolean checkIsRoom(int userid1, int userid2) {
		try {
			int x=0;
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT RoomDetail.RoomID\r\n"
					+ "FROM RoomDetail\r\n"
					+ "JOIN Rooms ON Rooms.RoomID = RoomDetail.RoomID\r\n"
					+ "WHERE RoomDetail.UserID IN (?,?) AND Rooms.IsGroup = 0\r\n"
					+ "GROUP BY RoomDetail.RoomID\r\n"
					+ "HAVING COUNT(DISTINCT RoomDetail.UserID) = 2;";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userid2);
			cmd.setInt(2, userid1);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				x=rs.getInt("RoomID");
			}
			if(x!=0) {
				kn.cn.close();
				rs.close();
				return true;
			}
			kn.cn.close();
			rs.close();
			return false;
		} catch (Exception e) {
			System.out.println("Kiểm tra đã có room hay chưa "+e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	public int UpdateStatus (int status , int roomid) {
		try {
			int x=0;
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "update Rooms set Status = ? where RoomID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, status);
			cmd.setInt(2, roomid);
			x = cmd.executeUpdate();
			kn.cn.close();
			return x;
		} catch (Exception e) {
			System.out.println("Update Status Room By roomId "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public int selectRoomIdOf2User(int userid1, int userid2) {
		try {
			int x=0;
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT RoomDetail.RoomID\r\n"
					+ "FROM RoomDetail\r\n"
					+ "JOIN Rooms ON Rooms.RoomID = RoomDetail.RoomID\r\n"
					+ "WHERE RoomDetail.UserID IN (?,?) AND Rooms.IsGroup = 0\r\n"
					+ "GROUP BY RoomDetail.RoomID\r\n"
					+ "HAVING COUNT(DISTINCT RoomDetail.UserID) = 2;";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userid2);
			cmd.setInt(2, userid1);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				x=rs.getInt("RoomID");
			}
			kn.cn.close();
			rs.close();
			return x;
		} catch (Exception e) {
			System.out.println("Kiểm tra đã có room hay chưa "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
}

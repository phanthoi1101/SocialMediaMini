package RoomModal;

import java.beans.Statement;
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
				room = new Room(roomid, roomname, isgroup, CreatedAt);
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
			String sql = "insert into Rooms(RoomName,IsGroup)\r\n"
					+ "values(?,?)";
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
}

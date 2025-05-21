package RoomModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}

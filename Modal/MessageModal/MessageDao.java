package MessageModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class MessageDao {
	
	public int CreateMessage(int SenderId, String content,int RoomId) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "insert into Messages (SenderID,Content,RoomId)\r\n"
					+ "values(?,?,?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, SenderId);
			cmd.setString(2, content);
			cmd.setInt(3, RoomId);
			int x = cmd.executeUpdate();
			kn.cn.close();
			return x;
		} catch (Exception e) {
			System.out.println("Create Message  "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public ArrayList<Message> GetMessageByRoomId(int roomId){
		ArrayList<Message> ds = new ArrayList<Message>();
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Messages where RoomId = ?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, roomId);
			ResultSet rs =cmd.executeQuery();
			while(rs.next()) {
				int MessageId = rs.getInt("MessageID");
				int senderId = rs.getInt("SenderID");
				String content = rs.getString("Content");
				Timestamp SenAt = rs.getTimestamp("SentAt");
				ds.add(new Message(MessageId, senderId, roomId, content, SenAt));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Get Message by RoomId  "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}

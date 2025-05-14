package FriendshipModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import KetNoiModal.KetNoi;

public class FriendshipDao {
	ArrayList<Friendship> ds = new ArrayList<Friendship>();
	public ArrayList<Friendship> getFriendshipByStatus(int senderID,int status){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Friendships where Status = ? and UserID1=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, status);
			cmd.setInt(2, senderID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int FriendshipID = rs.getInt("FriendshipID");
				int receiverID = rs.getInt("UserID2");
				Date CreatedAt = rs.getDate("CreatedAt");
				ds.add(new Friendship(FriendshipID, senderID, receiverID, status, CreatedAt));		
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong get Friendship by Status and Sender ID	"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Friendship> getFriendshipByStatusAndReceiveID(int ReceiverID,int status){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Friendships where Status = ? and UserID2=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, status);
			cmd.setInt(2, ReceiverID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int FriendshipID = rs.getInt("FriendshipID");
				int senderId = rs.getInt("UserID1");
				Date CreatedAt = rs.getDate("CreatedAt");
				ds.add(new Friendship(FriendshipID, senderId,ReceiverID , status, CreatedAt));		
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong get Friendship by Status and ReceiverID	"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Friendship> getFriendshipByUserId(int UserId){
		try {
			System.out.println(UserId);
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Friendships where UserID1=? and Status=1 or UserID2= ? and Status=1";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, UserId);
			cmd.setInt(2, UserId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int FriendshipID = rs.getInt("FriendshipID");
				int senderId = rs.getInt("UserID1");
				int ReceiverID = rs.getInt("UserID2");
				int status = 1;
				Date CreatedAt = rs.getDate("CreatedAt");
				ds.add(new Friendship(FriendshipID, senderId,ReceiverID , status, CreatedAt));		
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong get Friendship by UserId	"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}

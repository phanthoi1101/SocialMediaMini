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
			ArrayList<Friendship> list = new ArrayList<Friendship>();
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
				list.add(new Friendship(FriendshipID, senderId,ReceiverID , status, CreatedAt));		
			}
			kn.cn.close();
			rs.close();
			return list;
		} catch (Exception e) {
			System.out.println("Wrong get Friendship by Status and ReceiverID	"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	
	public ArrayList<Friendship> getFriendshipByUserId(int UserId){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Friendships where (UserID1=? and Status=1) or (UserID2= ? and Status=1)";
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
	public ArrayList<Friendship> getFriendshipByUserId_Search(int UserId,String Search){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT F.*\r\n"
					+ "FROM Friendships F\r\n"
					+ "JOIN Users U ON \r\n"
					+ "    (U.UserID = F.UserID1 AND F.UserID2 = ?)\r\n"
					+ "    OR (U.UserID = F.UserID2 AND F.UserID1 = ?)\r\n"
					+ "WHERE F.Status = 1 and FullName like ?;";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, UserId);
			cmd.setInt(2, UserId);
			cmd.setString(3, "%" + Search + "%");
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
			System.out.println("Wrong get Friendship by UserId	Search"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public int UpdateFriendshipBySender_Receiver(int userId1,int userId2 , int status) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "update Friendships \r\n"
					+ "set Status=?\r\n"
					+ "where (UserID1 = ? and UserID2=?) or (UserID1 = ? and UserID2=?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, status);
			cmd.setInt(2, userId1);
			cmd.setInt(3, userId2);
			cmd.setInt(4, userId2);
			cmd.setInt(5, userId1);
			int kq = cmd.executeUpdate();
			kn.cn.close();
			return kq;
		} catch (Exception e) {
			System.out.println("Wrong update Friendship by Sender and Receiver" + e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public int DeleteFriendshipBySender_Receiver(int userId1,int userId2) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "delete Friendships\r\n"
					+ "where (UserID1 = ? and UserID2=?) or (UserID1 = ? and UserID2=?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userId1);
			cmd.setInt(2, userId2);
			cmd.setInt(3, userId2);
			cmd.setInt(4, userId1);
			int kq = cmd.executeUpdate();
			kn.cn.close();
			return kq;
		} catch (Exception e) {
			System.out.println("Wrong delete Friendship by Sender and Receiver" + e.getMessage());
			e.printStackTrace();
			return 0;
		}
		}
	public int CreateFriendshipBySender_Receiver(int sender,int receiver, int status) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "insert into Friendships(UserID1,UserID2,Status)\r\n"
					+ "values(?,?,?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, sender);
			cmd.setInt(2, receiver);
			cmd.setInt(3, status);
			int kq = cmd.executeUpdate();
			kn.cn.close();
			return kq;
		} catch (Exception e) {
			System.out.println("Wrong Create Friendship by Sender and Receiver" + e.getMessage());
			e.printStackTrace();
			return 0;
		}
		}
}

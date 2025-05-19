package UserModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;
import PostsModal.Posts;

public class UserDao {
	ArrayList<User> ds = new ArrayList<User>();
	public ArrayList<User> getAllUser(){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Users";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int userid = rs.getInt("UserID");
				String username = rs.getString("Username");
				String Email = rs.getString("Email");
				String password = rs.getString("PasswordHash");
				String fullname = rs.getString("FullName");
				String avater = rs.getString("Avatar");
				java.util.Date createdat = rs.getDate("CreatedAt");
				String photoCover = rs.getString("PhotoCover");
				ds.add(new User(userid, username, Email, password, fullname, avater, photoCover, createdat));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get Users"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	
	public User getUserById(int userId){
		try {
			User user = new User();
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Users where UserID = ?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int userid = rs.getInt("UserID");
				String username = rs.getString("Username");
				String Email = rs.getString("Email");
				String password = rs.getString("PasswordHash");
				String fullname = rs.getString("FullName");
				String avater = rs.getString("Avatar");
				java.util.Date createdat = rs.getDate("CreatedAt");
				String photoCover = rs.getString("PhotoCover");
				user = new User(userid, username, Email, password, fullname, avater, photoCover, createdat);
			}
			kn.cn.close();
			rs.close();
			return user;
		} catch (Exception e) {
			System.out.println("Wrong Get User By Id"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public User getUserByDangNhap(String username, String password){
		try {
			User user = new User();
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Users where Username = ? and PasswordHash = ?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setString(1, username);
			cmd.setString(2, password);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int userid = rs.getInt("UserID");
				String Email = rs.getString("Email");
				String fullname = rs.getString("FullName");
				String avater = rs.getString("Avatar");
				java.util.Date createdat = rs.getDate("CreatedAt");
				String photoCover = rs.getString("PhotoCover");
				user = new User(userid, username, Email, password, fullname, avater, photoCover, createdat);
			}
			kn.cn.close();
			rs.close();
			return user;
		} catch (Exception e) {
			System.out.println("Wrong Get User By Id"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	
	public int addUser(String Fullname, String username, String email, String password) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "insert into Users(FullName,Username,Email,PasswordHash)\r\n"
					+ "values(?,?,?,?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setString(1, Fullname);
			cmd.setString(2, username);
			cmd.setString(3, email);
			cmd.setString(4, password);
			int x = cmd.executeUpdate();
			return x;
		} catch (Exception e) {
			System.out.println("Wrong add User "+e.getMessage());
			e.printStackTrace();
			return 0;
			
		}
	}
	public int updateAvatar(int UserID, String avatar) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "update Users\r\n"
					+ "set Avatar = ?\r\n"
					+ "where UserID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(2, UserID);
			cmd.setString(1, avatar);
			int x = cmd.executeUpdate();
			return x;
		} catch (Exception e) {
			System.out.println("Update avatar is error   "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public int updatePhotoCover(int UserID, String photoCover) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "update Users\r\n"
					+ "set PhotoCover = ?\r\n"
					+ "where UserID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(2, UserID);
			cmd.setString(1, photoCover);
			int x = cmd.executeUpdate();
			return x;
		} catch (Exception e) {
			System.out.println("Update photoCover is error   "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public ArrayList<User> getUserIsNotFriend(int UserId){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Users\r\n"
					+ "		where UserID not in (select UserID1 from Friendships \r\n"
					+ "		where (UserID2 = ? and Status = 1) or (UserID2=? and status=0)\r\n"
					+ "		union \r\n"
					+ "		select UserID2 from Friendships where UserID1=? and status=1\r\n"
					+ "		) and UserID !=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, UserId);
			cmd.setInt(2, UserId);
			cmd.setInt(3, UserId);
			cmd.setInt(4, UserId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int userid = rs.getInt("UserID");
				String username = rs.getString("Username");
				String Email = rs.getString("Email");
				String password = rs.getString("PasswordHash");
				String fullname = rs.getString("FullName");
				String avater = rs.getString("Avatar");
				java.util.Date createdat = rs.getDate("CreatedAt");
				String photoCover = rs.getString("PhotoCover");
				ds.add(new User(userid, username, Email, password, fullname, avater, photoCover, createdat));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get User Is not Friend"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}

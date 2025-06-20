package Post_UserModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;
import UtilModal.TimeAgoUtil;

public class Post_UserDao {
	TimeAgoUtil timeago = new TimeAgoUtil();
	ArrayList<Post_User> ds = new ArrayList<Post_User>();
	Post_User post_user = new Post_User();
	public ArrayList<Post_User> getPost_User(){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "					from User_Post left join Likes on Likes.PostID=User_Post.PostID \r\n"
					+ "					group by Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,Content,Image,User_Post.CreatedAt\r\n"
					+ "					order by CreatedAt desc\r\n";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				String username = rs.getString("Username");
				String fullname = rs.getString("FullName");
				String avatar = rs.getString("Avatar");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				Date createdat = rs.getDate("CreatedAt");
				int likeCount = rs.getInt("LikeCount");
				java.sql.Timestamp date = rs.getTimestamp("CreatedAt");
				String timepost = timeago.getTimeAgoUtil(date);
				ds.add(new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount, timepost));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get post-user "+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Post_User> getAllPost_UserIsFriendByUserId(int userId){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT u.Username,u.FullName,u.Avatar,p.PostID,p.UserID,p.Content,p.Image,p.CreatedAt,COUNT(l.LikeID) AS LikeCount\r\n"
					+ "FROM posts p\r\n"
					+ "JOIN users u ON p.UserID = u.UserID\r\n"
					+ "LEFT JOIN likes l ON l.PostID = p.PostID\r\n"
					+ "WHERE p.UserID = ?\r\n"
					+ "   OR p.UserID IN (\r\n"
					+ "       SELECT \r\n"
					+ "           CASE \r\n"
					+ "               WHEN f.UserID1 = ? THEN f.UserID2\r\n"
					+ "               WHEN f.UserID2 = ? THEN f.UserID1\r\n"
					+ "           END\r\n"
					+ "       FROM friendships f\r\n"
					+ "       WHERE (f.UserID1 = ? OR f.UserID2 = ?) AND f.Status = 1\r\n"
					+ "   )\r\n"
					+ "GROUP BY u.Username,u.FullName,u.Avatar,p.PostID,p.UserID,p.Content,p.Image,p.CreatedAt\r\n"
					+ "ORDER BY p.CreatedAt DESC;\r\n";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userId);
			cmd.setInt(2, userId);
			cmd.setInt(3, userId);
			cmd.setInt(4, userId);
			cmd.setInt(5, userId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				String username = rs.getString("Username");
				String fullname = rs.getString("FullName");
				String avatar = rs.getString("Avatar");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				Date createdat = rs.getDate("CreatedAt");
				int likeCount = rs.getInt("LikeCount");
				java.sql.Timestamp date = rs.getTimestamp("CreatedAt");
				String timepost = timeago.getTimeAgoUtil(date);
				ds.add(new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount, timepost));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get post-user "+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	
	
	public Post_User get1Post_User(int postID) {
		Post_User post_user = null;
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "					from User_Post left join Likes on Likes.PostID=User_Post.PostID\r\n"
					+ "					where User_Post.PostID = ?\r\n"
					+ "					group by Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,Content,Image,User_Post.CreatedAt";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, postID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				String username = rs.getString("Username");
				String fullname = rs.getString("FullName");
				String avatar = rs.getString("Avatar");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				Date createdat = rs.getDate("CreatedAt");
				int likeCount = rs.getInt("LikeCount");
				java.sql.Timestamp date = rs.getTimestamp("CreatedAt");
				String timepost = timeago.getTimeAgoUtil(date);
				post_user = new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount, timepost);
			}
			kn.cn.close();
			rs.close();
			return post_user;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Wrong in get one post_user "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Post_User> getPost_UserByUserID(int userID){
		try {
			Post_User post_User = null;
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "					from User_Post left join Likes on Likes.PostID=User_Post.PostID\r\n"
					+ "					where User_Post.UserID = ?\r\n"
					+ "					group by Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,Content,Image,User_Post.CreatedAt"
					+ "					order by CreatedAt desc";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				String username = rs.getString("Username");
				String fullname = rs.getString("FullName");
				String avatar = rs.getString("Avatar");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				Date createdat = rs.getDate("CreatedAt");
				int likeCount = rs.getInt("LikeCount");
				java.sql.Timestamp date = rs.getTimestamp("CreatedAt");
				String timepost = timeago.getTimeAgoUtil(date);
				ds.add(new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount, timepost));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get post-user by userID"+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}

package Post_UserModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class Post_UserDao {
	ArrayList<Post_User> ds = new ArrayList<Post_User>();
	Post_User post_user = new Post_User();
	public ArrayList<Post_User> getPost_User(){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "from User_Post inner join Likes on Likes.PostID=User_Post.PostID \r\n"
					+ "group by Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,Content,Image,User_Post.CreatedAt";
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
				ds.add(new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount));
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
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "					from User_Post inner join Likes on Likes.PostID=User_Post.PostID\r\n"
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
				post_user = new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount);
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
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,User_Post.Content,Image,User_Post.CreatedAt,COUNT(LikeID) as LikeCount\r\n"
					+ "					from User_Post inner join Likes on Likes.PostID=User_Post.PostID\r\n"
					+ "					where User_Post.UserID = ?\r\n"
					+ "					group by Username,FullName,Avatar,User_Post.PostID,User_Post.UserID,Content,Image,User_Post.CreatedAt";
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
				ds.add(new Post_User(userid, postid, username, fullname, avatar, content, image, createdat, likeCount));
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

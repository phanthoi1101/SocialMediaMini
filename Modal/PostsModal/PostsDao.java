package PostsModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class PostsDao {
	ArrayList<Posts> ds = new ArrayList<Posts>();
	public ArrayList<Posts> getPost(){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Posts";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				Date createdAt = rs.getDate("CreatedAt");
				ds.add(new Posts(postid, userid, content, image, createdAt));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get Posts"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public ArrayList<Posts> getPostByUserID(int userId){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Posts where UserID = ? order by CreatedAt desc";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, userId);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int postid = rs.getInt("PostID");
				int userid = rs.getInt("UserID");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				Date createdAt = rs.getDate("CreatedAt");
				ds.add(new Posts(postid, userid, content, image, createdAt));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong Get Posts by UserID"+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public int CreatePost(String content, String image, int userId) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql;
			if(!content.isEmpty() && image.isEmpty()) {
				sql = "insert into Posts(UserID,Content)\r\n"
						+ "values(?,?)";
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, userId);
				cmd.setString(2, content);
				int x = cmd.executeUpdate();
				kn.cn.close();
				return x;
			}else if(!image.isEmpty() && content.isEmpty()) {
				sql = "insert into Posts(UserID,Image)\r\n"
						+ "values(?,?)";
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, userId);
				cmd.setString(2, image);
				int x = cmd.executeUpdate();
				kn.cn.close();
				return x;
			}else {
				sql = "insert into Posts(UserID,Content,Image)\r\n"
						+ "values(?,?,?)";
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, userId);
				cmd.setString(2, content);
				cmd.setString(3, image);
				int x = cmd.executeUpdate();
				kn.cn.close();
				return x;
			}
		} catch (Exception e) {
			System.out.println("Tao Bài Post : "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
}

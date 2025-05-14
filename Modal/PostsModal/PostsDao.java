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
}

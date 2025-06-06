package LikeModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class LikeDao {
	ArrayList<Like> ds = new ArrayList<Like>();
	public ArrayList<Like> getLike(){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select * from Likes";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int likeid = rs.getInt("LikeID");
				int userid = rs.getInt("UserID");
				int postid = rs.getInt("PostID");
				Date CreatedAt = rs.getDate("CreatedAt");
				ds.add(new Like(likeid, postid, userid, CreatedAt));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Get list Like "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public boolean CheckLike(int userid , int postid) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "SELECT * FROM Likes WHERE PostID=? AND UserID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, postid);
            cmd.setInt(2, userid);
            ResultSet rs = cmd.executeQuery();
            boolean liked = false;
            if(rs.next()) {
            	String sql1 = "DELETE FROM Likes WHERE UserID = ? AND PostID = ?";
            	PreparedStatement ps = kn.cn.prepareStatement(sql1);
            	ps.setInt(1, userid);
                ps.setInt(2, postid);
                int rows = ps.executeUpdate();
                kn.cn.close();
                liked = false;
            	//xoá ở cơ sở dữ liệu và gán cho nó bằng 0
            }else {
            	String sql2 = "INSERT INTO likes (UserID, PostID) VALUES (?, ?)";
                PreparedStatement ps = kn.cn.prepareStatement(sql2);
                ps.setInt(1, userid);
                ps.setInt(2, postid);
                int rows = ps.executeUpdate();
                kn.cn.close();
                liked=true;
            }
			return liked;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Lỗi check like "+e.getMessage());
			e.printStackTrace();
			return false;
		}
		}
	
	public int deleteLike(int postId) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "delete Likes where PostID = ?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, postId);
			int x = cmd.executeUpdate();
			return x;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		}
	}
	public int LikeCount(int postID) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			PreparedStatement countStmt = kn.cn.prepareStatement("SELECT COUNT(*) FROM Likes WHERE PostID=?");
            countStmt.setInt(1, postID);
            ResultSet countRs = countStmt.executeQuery();
            int likeCount = countRs.next() ? countRs.getInt(1) : 0;
            return likeCount;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Đếm số like "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
}

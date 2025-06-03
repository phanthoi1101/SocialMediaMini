package CommentModal;

import java.sql.PreparedStatement;
import java.util.ArrayList;

import KetNoiModal.KetNoi;

public class CommentDao {
	ArrayList<Comment> ds = new ArrayList<Comment>();
	public int AddComment(int PostId, int UserID, String content,int parentId) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql;
			if(parentId==0) {
				sql = "insert into Comments(PostID,UserID,Content)\r\n"
						+ "values(?,?,?)";		
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, PostId);
				cmd.setInt(2, UserID);
				cmd.setString(3, content);
				int x = cmd.executeUpdate();
				kn.cn.close();
				return x;
			}else {
				sql = "insert into Comments(PostID,UserID,Content,ParentID)\r\n"
						+ "values(?,?,?,?)";		
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, PostId);
				cmd.setInt(2, UserID);
				cmd.setString(3, content);		
				cmd.setInt(4, parentId);
				int x = cmd.executeUpdate();
				kn.cn.close();
				return x;
			}

		} catch (Exception e) {
			System.out.println("Wrong add comment "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	
	}
}

package CommentContainModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import KetNoiModal.KetNoi;

public class CommentContainDao {
	ArrayList<CommentContain> ds = new ArrayList<CommentContain>();
	public ArrayList<CommentContain> getComment_PostId(int PostID){
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "select Comments.*,Users.Username,Users.Avatar\r\n"
					+ "from Comments inner join Users on Comments.UserID=Users.UserID\r\n"
					+ "where PostID = ?\r\n"
					+ "order by CreatedAt desc";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, PostID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int commentId = rs.getInt("CommentID");
				int postId = rs.getInt("PostID");
				int userId = rs.getInt("UserID");
				int parentId = rs.getInt("ParentID");
				String content = rs.getString("Content");
				String username = rs.getString("Username");
				String avatar = rs.getString("Avatar");
				java.sql.Date createdAt = rs.getDate("CreatedAt");
				ds.add(new CommentContain(commentId, postId, userId, content, createdAt, parentId, username, avatar));
			}
			kn.cn.close();
			rs.close();
			return ds;
		} catch (Exception e) {
			System.out.println("Wrong get comment contain "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}

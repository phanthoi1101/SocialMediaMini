	package SearchUserModal;
	
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.util.ArrayList;
	
	import KetNoiModal.KetNoi;
	
	public class SearchUserDao {
		ArrayList<SearchUser> ds = new ArrayList<SearchUser>();
		public ArrayList<SearchUser> getUserBySearch(int userId , String search){
			try {
				KetNoi kn = new KetNoi();
				kn.KetNoi();
				String sql = "SELECT u.*, 1 AS IsFriend\r\n"
						+ "FROM Users u\r\n"
						+ "JOIN Friendships f ON (\r\n"
						+ "    (f.UserID1 = ? AND f.UserID2 = u.UserID)\r\n"
						+ "    OR\r\n"
						+ "    (f.UserID2 = ? AND f.UserID1 = u.UserID)\r\n"
						+ ")\r\n"
						+ "WHERE f.Status = 1\r\n"
						+ "  AND u.FullName LIKE CONCAT('%', ?, '%')\r\n"
						+ "  AND u.UserID != ?\r\n"
						+ "\r\n"
						+ "UNION\r\n"
						+ "\r\n"
						+ "SELECT *, 0 AS IsFriend\r\n"
						+ "FROM Users u\r\n"
						+ "WHERE u.FullName LIKE CONCAT('%', ?, '%')\r\n"
						+ "  AND u.UserID != ?\r\n"
						+ "  AND u.UserID NOT IN (\r\n"
						+ "      SELECT f.UserID2 FROM Friendships f\r\n"
						+ "      WHERE f.UserID1 = ? AND f.Status = 1\r\n"
						+ "      UNION\r\n"
						+ "      SELECT f.UserID1 FROM Friendships f\r\n"
						+ "      WHERE f.UserID2 = ? AND f.Status = 1\r\n"
						+ "  );\r\n"
						+ "";
				PreparedStatement cmd = kn.cn.prepareStatement(sql);
				cmd.setInt(1, userId);
				cmd.setInt(2, userId);
				cmd.setString(3, search);
				cmd.setInt(4, userId);
				cmd.setString(5, search);
				cmd.setInt(6, userId);
				cmd.setInt(7, userId);	
				cmd.setInt(8, userId);
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
					boolean isFriend = rs.getBoolean("IsFriend");
					ds.add(new SearchUser(userid, username, Email, password, fullname, avater, photoCover, isFriend));
				}
				kn.cn.close();
				rs.close();
				return ds;
			} catch (Exception e) {
				System.out.println("Wrong Get Search Users"+e.getMessage());
				e.printStackTrace();
				return null;
			}
		}
	}

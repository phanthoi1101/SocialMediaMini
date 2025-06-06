package RoomDetailModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import KetNoiModal.KetNoi;

public class RoomDetailDao {
	public RoomDetail getRoomDetailByUserID_RoomID(int roomId,int userID) {
		try {
			KetNoi kn = new KetNoi();
			RoomDetail rDetail = new RoomDetail();
			kn.KetNoi();
			String sql="select * from RoomDetail where RoomID=? and UserID!=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, roomId);
			cmd.setInt(2, userID);
			ResultSet rs = cmd.executeQuery();
			while(rs.next()) {
				int rDetailId = rs.getInt("RoomDetailID");
				int rId = rs.getInt("RoomID");
				int uId = rs.getInt("UserID");
				rDetail = new RoomDetail(rDetailId, rId, uId);
			}
			kn.cn.close();
			rs.close();
			return rDetail;
		} catch (Exception e) {
			System.out.println("Get roomDetail by userId and RoomID  "+e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
	public int CreateRoomDetail(int RoomId,int userId) {
		try {
			KetNoi kn = new KetNoi();
			int idMoi = 0 ;
			kn.KetNoi();
			String sql = "insert into RoomDetail(RoomID,UserID)\r\n"
					+ "values(?,?)";
			PreparedStatement cmd = kn.cn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
			cmd.setInt(1, RoomId);
			cmd.setInt(2, userId);
			cmd.executeUpdate();

			ResultSet rs = cmd.getGeneratedKeys();
			if (rs.next()) {
			    idMoi = rs.getInt(1);
			}
			kn.cn.close();
			rs.close();
			return idMoi;
		} catch (Exception e) {
			System.out.println("Tạo Room Detail Chat   "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
	public int DeleteRoomDetail(int RoomId,int userId) {
		try {
			KetNoi kn = new KetNoi();
			kn.KetNoi();
			String sql = "delete RoomDetail\r\n"
					+ "where RoomID = ? and UserID=?";
			PreparedStatement cmd = kn.cn.prepareStatement(sql);
			cmd.setInt(1, RoomId);
			cmd.setInt(2, userId);
			int x = cmd.executeUpdate();
			kn.cn.close();
			return x;
		} catch (Exception e) {
			System.out.println("Tạo Room Detail Chat   "+e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}
}

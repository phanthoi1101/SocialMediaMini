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
}

package RoomDetailModal;

public class RoomDetailBo {
	RoomDetailDao rdDao = new RoomDetailDao();
	public RoomDetail getRoomDetailByUserID_RoomID(int roomId,int userId) {
		return rdDao.getRoomDetailByUserID_RoomID(roomId, userId);
	}
	public int CreateRoomDetail(int roomId, int userId) {
		return rdDao.CreateRoomDetail(roomId, userId);
	}
	public int DeleteRoomDetail(int roomid , int userid) {
		return rdDao.DeleteRoomDetail(roomid, userid);
	}
}

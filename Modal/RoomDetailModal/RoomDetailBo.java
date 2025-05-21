package RoomDetailModal;

public class RoomDetailBo {
	RoomDetailDao rdDao = new RoomDetailDao();
	public RoomDetail getRoomDetailByUserID_RoomID(int roomId,int userId) {
		return rdDao.getRoomDetailByUserID_RoomID(roomId, userId);
	}
}

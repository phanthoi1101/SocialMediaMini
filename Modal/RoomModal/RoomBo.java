package RoomModal;

public class RoomBo {
	RoomDao roomDao = new RoomDao();
	public int getRoomId(int senderID , int ReceiverId) {
		return roomDao.GetRoomID(senderID, ReceiverId);
	}
}

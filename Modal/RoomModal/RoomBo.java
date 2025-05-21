package RoomModal;

import java.util.ArrayList;

public class RoomBo {
	RoomDao roomDao = new RoomDao();
	public int getRoomId(int senderID , int ReceiverId) {
		return roomDao.GetRoomID(senderID, ReceiverId);
	}
	public ArrayList<Integer> getRoomIdByUserID(int userID){
		return roomDao.GetRoomIDByUserId(userID);
	}
	public Room getRoomByRoomID(int roomid) {
		return roomDao.getRoomByRoomID(roomid);
	}
}

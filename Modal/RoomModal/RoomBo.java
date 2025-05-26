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
	public int CreateRoom(String roomName, boolean IsGroup) {
		return roomDao.CreateRoom(roomName, IsGroup);
	}
	public boolean checkIsRoom(int userid1, int userid2) {
		return roomDao.checkIsRoom(userid1, userid2);
	}
	public int selectRoomIdOf2User(int userid1, int userid2) {
		return roomDao.selectRoomIdOf2User(userid1, userid2);
	}
}

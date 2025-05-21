package RoomDetailModal;

public class RoomDetail {
	private int RoomDetailID;
	private int RoomID;
	private int UserID;
	public int getRoomDetailID() {
		return RoomDetailID;
	}
	public void setRoomDetailID(int roomDetailID) {
		RoomDetailID = roomDetailID;
	}
	public int getRoomID() {
		return RoomID;
	}
	public void setRoomID(int roomID) {
		RoomID = roomID;
	}
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		UserID = userID;
	}
	public RoomDetail(int roomDetailID, int roomID, int userID) {
		super();
		RoomDetailID = roomDetailID;
		RoomID = roomID;
		UserID = userID;
	}
	public RoomDetail() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

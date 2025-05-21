package RoomModal;

import java.sql.Date;

public class Room {
	private int RoomId;
	private String RoomName;
	private boolean IsGroup;
	private Date CreatedAt;
	public int getRoomId() {
		return RoomId;
	}
	public void setRoomId(int roomId) {
		RoomId = roomId;
	}
	public String getRoomName() {
		return RoomName;
	}
	public void setRoomName(String roomName) {
		RoomName = roomName;
	}
	public boolean isIsGroup() {
		return IsGroup;
	}
	public void setIsGroup(boolean isGroup) {
		IsGroup = isGroup;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Date createdAt) {
		CreatedAt = createdAt;
	}
	public Room(int roomId, String roomName, boolean isGroup, Date createdAt) {
		super();
		RoomId = roomId;
		RoomName = roomName;
		IsGroup = isGroup;
		CreatedAt = createdAt;
	}
	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

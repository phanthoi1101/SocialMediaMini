package MessageModal;

import java.sql.Timestamp;

public class Message {
	private int MessageID ;
	private int SenderID;
	private int RoomId;
	private String Content;
	private String Status;
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	private Timestamp SentAt;
	public int getMessageID() {
		return MessageID;
	}
	public void setMessageID(int messageID) {
		MessageID = messageID;
	}
	public int getSenderID() {
		return SenderID;
	}
	public void setSenderID(int senderID) {
		SenderID = senderID;
	}
	
	public int getRoomId() {
		return RoomId;
	}
	public void setRoomId(int roomId) {
		RoomId = roomId;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}

	
	public Message(int messageID, int senderID, int roomId, String content, String status, Timestamp sentAt) {
		super();
		MessageID = messageID;
		SenderID = senderID;
		RoomId = roomId;
		Content = content;
		Status = status;
		SentAt = sentAt;
	}
	public Timestamp getSentAt() {
		return SentAt;
	}
	public void setSentAt(Timestamp sentAt) {
		SentAt = sentAt;
	}
	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}

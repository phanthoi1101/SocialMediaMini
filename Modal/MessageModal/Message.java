package MessageModal;

import java.sql.Timestamp;

public class Message {
	private int MessageID ;
	private int SenderID;
	private int RoomId;
	private String Content;
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

	public Message(int messageID, int senderID, int roomId, String content, Timestamp sentAt) {
		super();
		MessageID = messageID;
		SenderID = senderID;
		RoomId = roomId;
		Content = content;
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

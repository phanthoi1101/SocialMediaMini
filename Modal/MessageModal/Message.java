package MessageModal;

import java.sql.Date;

public class Message {
	private int MessageID ;
	private int SenderID;
	private int RoomId;
	private String Content;
	private Date SentAt;
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
	public Date getSentAt() {
		return SentAt;
	}
	public void setSentAt(Date sentAt) {
		SentAt = sentAt;
	}
	public Message(int messageID, int senderID, int roomId, String content, Date sentAt) {
		super();
		MessageID = messageID;
		SenderID = senderID;
		RoomId = roomId;
		Content = content;
		SentAt = sentAt;
	}
	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}

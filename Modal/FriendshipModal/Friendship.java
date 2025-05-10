package FriendshipModal;

import java.util.Date;

public class Friendship {
	private int FriendshipID;
	private int SenderID;
	private int receiverID;
	private int status;
	private Date CreatedAt;
	public int getFriendshipID() {
		return FriendshipID;
	}
	public void setFriendshipID(int friendshipID) {
		FriendshipID = friendshipID;
	}
	public int getSenderID() {
		return SenderID;
	}
	public void setSenderID(int senderID) {
		SenderID = senderID;
	}
	public int getReceiverID() {
		return receiverID;
	}
	public void setReceiverID(int receiverID) {
		this.receiverID = receiverID;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Date createdAt) {
		CreatedAt = createdAt;
	}
	public Friendship(int friendshipID, int senderID, int receiverID, int status, Date createdAt) {
		super();
		FriendshipID = friendshipID;
		SenderID = senderID;
		this.receiverID = receiverID;
		this.status = status;
		CreatedAt = createdAt;
	}
	public Friendship() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	}

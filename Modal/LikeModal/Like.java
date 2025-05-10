package LikeModal;

import java.util.Date;

public class Like {
	private int LikeID;
	private int PostID;
	private int UserID;
	private Date CreatedAt;
	public int getLikeID() {
		return LikeID;
	}
	public void setLikeID(int likeID) {
		LikeID = likeID;
	}
	public int getPostID() {
		return PostID;
	}
	public void setPostID(int postID) {
		PostID = postID;
	}
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		UserID = userID;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Date createdAt) {
		CreatedAt = createdAt;
	}
	public Like(int likeID, int postID, int userID, Date createdAt) {
		super();
		LikeID = likeID;
		PostID = postID;
		UserID = userID;
		CreatedAt = createdAt;
	}
	public Like() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

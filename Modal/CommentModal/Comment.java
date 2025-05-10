package CommentModal;

import java.util.Date;

public class Comment {
	private int CommentID;
	private int UserID;
	private int PostID;
	private String content; 
	private Date CreatedAt;
	private int ParentID;
	public int getCommentID() {
		return CommentID;
	}
	public void setCommentID(int commentID) {
		CommentID = commentID;
	}
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		UserID = userID;
	}
	public int getPostID() {
		return PostID;
	}
	public void setPostID(int postID) {
		PostID = postID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Date createdAt) {
		CreatedAt = createdAt;
	}
	public int getParentID() {
		return ParentID;
	}
	public void setParentID(int parentID) {
		ParentID = parentID;
	}
	public Comment(int commentID, int userID, int postID, String content, Date createdAt, int parentID) {
		super();
		CommentID = commentID;
		UserID = userID;
		PostID = postID;
		this.content = content;
		CreatedAt = createdAt;
		ParentID = parentID;
	}
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

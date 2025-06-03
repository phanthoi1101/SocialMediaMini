package CommentContainModal;

import java.util.Date;

public class CommentContain {
	private int CommentID;
	private int PostID;
	private int UserID;
	private String Content;
	private java.sql.Date CreatedAt;
	private int ParentID;
	private String FullName;
	private String Avatar;
	public int getCommentID() {
		return CommentID;
	}
	public void setCommentID(int commentID) {
		CommentID = commentID;
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
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(java.sql.Date createdAt) {
		CreatedAt = createdAt;
	}
	public int getParentID() {
		return ParentID;
	}
	public void setParentID(int parentID) {
		ParentID = parentID;
	}
	public String getFullName() {
		return FullName;
	}
	public void setFullName(String FullName) {
		this.FullName = FullName;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	public CommentContain(int commentID, int postID, int userID, String content, java.sql.Date createdAt, int parentID,
			String FullName, String avatar) {
		super();
		CommentID = commentID;
		PostID = postID;
		UserID = userID;
		Content = content;
		CreatedAt = createdAt;
		ParentID = parentID;
		this.FullName = FullName;
		Avatar = avatar;
	}
	public CommentContain() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}

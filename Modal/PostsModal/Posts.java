package PostsModal;

import java.sql.Date;

public class Posts {
	private int PostID;
	private int UserID;
	private String Content;
	private String Image;
	private java.util.Date CreatedAt;
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
	public java.util.Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(java.util.Date createdAt) {
		CreatedAt = createdAt;
	}
	public String getImage() {
		return Image;
	}
	public void setImage(String image) {
		Image = image;
	}
	public Posts(int postID, int userID, String content, String image, java.util.Date createdAt) {
		super();
		PostID = postID;
		UserID = userID;
		Content = content;
		Image = image;
		CreatedAt = createdAt;
	}
	public Posts() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}

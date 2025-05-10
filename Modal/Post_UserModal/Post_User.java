package Post_UserModal;

import java.lang.reflect.Array;
import java.sql.Date;
import java.util.List;

public class Post_User {
	private int UserID;
	private int PostID;
	private String Username;
	private String FullName;
	private String Avatar;
	private String Content;
	private String Image;
	private Date CreatedAt;
	private int LikeCount;
	private List<Integer> likedUsers;
	public int getLikeCount() {
		return LikeCount;
	}
	public List<Integer> getLikedUsers() {
        return likedUsers;
    }

    public void setLikedUsers(List<Integer> likedUsers) {
        this.likedUsers = likedUsers;
    }
	public void setLikeCount(int likeCount) {
		LikeCount = likeCount;
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
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getFullName() {
		return FullName;
	}
	public void setFullName(String fullName) {
		FullName = fullName;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getImage() {
		return Image;
	}
	public void setImage(String image) {
		Image = image;
	}
	public Date getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Date createdAt) {
		CreatedAt = createdAt;
	}
	public Post_User(int userID, int postID, String username, String fullName, String avatar, String content,
			String image, Date createdAt, int likeCount) {
		super();
		UserID = userID;
		PostID = postID;
		Username = username;
		FullName = fullName;
		Avatar = avatar;
		Content = content;
		Image = image;
		CreatedAt = createdAt;
		LikeCount = likeCount;
	}
	public Post_User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public boolean isLikedByUser(int userID) {
        return likedUsers.contains(userID);
    }
    // Phương thức thêm người dùng vào danh sách likedUsers
    public void addLike(int userID) {
        if (!likedUsers.contains(userID)) {
            likedUsers.add(userID);
        }
    }
    // Phương thức bỏ like của người dùng
    public void removeLike(int userID) {
        likedUsers.remove(Integer.valueOf(userID));
    }
	
}

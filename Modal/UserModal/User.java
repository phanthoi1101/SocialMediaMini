package UserModal;

import java.util.Date;

public class User {
	private int UserID;
	private String Username;
	private String Email;
	private String PasswordHash;
	private String FullName;
	private String Avatar;
	private String PhotoCover;
	public String getPhotoCover() {
		return PhotoCover;
	}
	public void setPhotoCover(String photoCover) {
		PhotoCover = photoCover;
	}
	private Date CreatedAt;
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPasswordHash() {
		return PasswordHash;
	}
	public void setPasswordHash(String passwordHash) {
		PasswordHash = passwordHash;
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
	public User(int userID, String username, String email, String passwordHash, String fullName, String avatar,
			String photoCover, Date createdAt) {
		super();
		UserID = userID;
		Username = username;
		Email = email;
		PasswordHash = passwordHash;
		FullName = fullName;
		Avatar = avatar;
		PhotoCover = photoCover;
		CreatedAt = createdAt;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}

package SearchUserModal;

public class SearchUser {
	private int UserID;
	private String Username;
	private String Email;
	private String PasswordHash;
	private String FullName;
	private String Avatar;
	private String PhotoCover;
	private boolean IsFriend;
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int userID) {
		UserID = userID;
	}
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
	public String getPhotoCover() {
		return PhotoCover;
	}
	public void setPhotoCover(String photoCover) {
		PhotoCover = photoCover;
	}
	public boolean isIsFriend() {
		return IsFriend;
	}
	public void setIsFriend(boolean isFriend) {
		IsFriend = isFriend;
	}
	public SearchUser(int userID, String username, String email, String passwordHash, String fullName, String avatar,
			String photoCover, boolean isFriend) {
		super();
		UserID = userID;
		Username = username;
		Email = email;
		PasswordHash = passwordHash;
		FullName = fullName;
		Avatar = avatar;
		PhotoCover = photoCover;
		IsFriend = isFriend;
	}
	public SearchUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

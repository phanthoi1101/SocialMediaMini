package Post_UserModal;

import java.util.ArrayList;

public class Post_UserBo {
	ArrayList<Post_User> ds = new ArrayList<Post_User>();
	Post_UserDao post_userDao = new Post_UserDao();
	public ArrayList<Post_User> getPost_User(){
		return post_userDao.getPost_User();
	}
	public Post_User get1Post_User(int postID) {
		return post_userDao.get1Post_User(postID);
	}
	public ArrayList<Post_User> getPost_UserByUserId(int userID) {
		return post_userDao.getPost_UserByUserID(userID);
	}
	public ArrayList<Post_User> getAllPost_UserIsFriendByUserId(int UserID){
		return post_userDao.getAllPost_UserIsFriendByUserId(UserID);
	}
	
}

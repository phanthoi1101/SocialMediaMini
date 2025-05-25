package UserModal;

import java.util.ArrayList;

import FriendshipModal.Friendship;

public class UserBo {
	ArrayList<User> ds = new ArrayList<User>();
	UserDao userDao = new UserDao();
	public User getUserById(int id) {
		return userDao.getUserById(id);
	}
	public ArrayList<User> getUserByRoomID(int roomID){
		return userDao.getUserByRoomId(roomID);
	}
	public User getUserByDangNhap(String username, String password) {
		return userDao.getUserByDangNhap(username, password);
	}
	public int addUser(String fullname, String username, String email, String password) {
		return userDao.addUser(fullname, username, email, password);
	}
	public boolean checkUser(String username) {
		ArrayList<User> lstUser = userDao.getAllUser();
		for(User user : lstUser) {
			if(username.equals(user.getUsername())){
				return true;
			}
		}
		return false;
	}
	public int updateFullname(int userId , String Fullname) {
		return userDao.updateFullname(userId, Fullname);
	}
	public int updateAvatar(int userID , String avatar) {
		return userDao.updateAvatar(userID, avatar);
	}
	public int updatePhotoCover(int userID , String photoCover) {
		return userDao.updatePhotoCover(userID, photoCover);
	}
	public ArrayList<User> getUserIsNotFriend(int userID) {
		return userDao.getUserIsNotFriend(userID);
	}

	
	public boolean checkEmail(String email) {
		ArrayList<User> dsUser =  userDao.getAllUser();
		for(User u : dsUser) {
			if(u.getEmail().equals(email))
				return true;
		}
		return false;
	}
	
	public ArrayList<User> UserIsFriendNotHasGroupChat(ArrayList<Friendship> dsf,ArrayList<User> dsu, int userid){
		ArrayList<User> dsuser = new ArrayList<User>();
		for(Friendship f:dsf) {
			if(userid==f.getSenderID()) {
				User x = getUserById(f.getReceiverID());
				if(!checkUser(dsu, x.getUserID()))
					dsuser.add(x);
			}else {
				User x = getUserById(f.getSenderID());
				if(!checkUser(dsu, x.getUserID()))
					dsuser.add(x);
			}
		}
		return dsuser;
	}
	public boolean checkUser(ArrayList<User> dsu , int userid) {
	
		for(User x : dsu) {
			System.out.println("Cặp value Key "+x.getUserID()+" và " +userid);
			if(x.getUserID()==userid)
				return true;
		}
		return false;
	}
}

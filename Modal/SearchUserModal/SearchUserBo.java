package SearchUserModal;

import java.util.ArrayList;

import UserModal.User;

public class SearchUserBo {
	SearchUserDao userDao = new SearchUserDao();
	public ArrayList<SearchUser> getUserBySearch(int userID,String search) {
		return userDao.getUserBySearch(userID, search);
	}
}

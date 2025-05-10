package DangNhapModal;

import UserModal.User;
import UserModal.UserDao;

public class DangNhapBo {
	UserDao userdao = new UserDao();
	public User checkDn(String username, String password) {
		return userdao.getUserByDangNhap(username, password);
	}
}

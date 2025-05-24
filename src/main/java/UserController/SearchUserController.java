package UserController;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.ha.session.Constants;
import org.apache.tomcat.util.bcel.classfile.Constant;

import Constand.FriendshipStatus;
import FriendshipModal.FriendshipBo;
import SearchUserModal.SearchUser;
import SearchUserModal.SearchUserBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class SearchUserController
 */
@WebServlet("/SearchUser")
public class SearchUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchUserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		FriendshipStatus status = new FriendshipStatus();
		FriendshipBo fBo = new FriendshipBo();
		User currentUser = (User)session.getAttribute("User");
		int userId = currentUser.getUserID();
		SearchUserBo userBo = new SearchUserBo();
		ArrayList<SearchUser> ds_User = new ArrayList<SearchUser>();
		if(request.getParameter("thembanbe")!=null) {
			int user = Integer.parseInt(request.getParameter("userId"));
			fBo.CreateFriendshipBySender_Receiver(userId, user,status.PENDING);
			System.out.println("Thêm bạn thành công !");
		}
		if(request.getParameter("xacnhan")!=null) {
			int user = Integer.parseInt(request.getParameter("userId"));
			fBo.UpdateFriendshipBySender_Receiver(userId, user, status.ACCEPTED);
			System.out.println("Thêm bạn thành công !");
		}
		if(request.getParameter("huyyeucau")!=null) {
			int user = Integer.parseInt(request.getParameter("userId"));
			fBo.UpdateFriendshipBySender_Receiver(userId, user, status.REJECTED);
		}
		String searchUser = request.getParameter("searchUser");
		ds_User=userBo.getUserBySearch(userId, searchUser);
		session.setAttribute("UserBySeach", ds_User);
		request.setAttribute("searchUser", searchUser);
		
		RequestDispatcher rd = request.getRequestDispatcher("SearchUser.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

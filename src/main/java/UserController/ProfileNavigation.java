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

import FriendshipModal.Friendship;
import FriendshipModal.FriendshipBo;
import PostsModal.Posts;
import PostsModal.PostsBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class ListPictureOfUser
 */
@WebServlet("/ProfileNavigation")
public class ProfileNavigation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileNavigation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PostsBo postBo = new PostsBo();
		UserBo userBo  = new UserBo();
		FriendshipBo friendshipBo = new FriendshipBo();
		User currentUser = (User)session.getAttribute("User");
		ArrayList<Posts> dsPostByUserID = new ArrayList<Posts>();
		ArrayList<Friendship> dsFriendshipById = new ArrayList<Friendship>();
		if(request.getParameter("baiViet")!=null) {
			response.sendRedirect("ProfileController?id="+currentUser.getUserID());
			return;
		}
		if(request.getParameter("baiVietFriend")!=null) {
			int profileUserId = Integer.parseInt(request.getParameter("profileUserId"));
			response.sendRedirect("ProfileController?id="+profileUserId);
			return;
		}
		
		if(request.getParameter("banBe")!=null) {
			session.setAttribute("ProfileActive", "friend");
			dsFriendshipById = friendshipBo.getFriendshipByUserId(currentUser.getUserID());
			session.setAttribute("dsFriendshipById", dsFriendshipById);
			RequestDispatcher rd = request.getRequestDispatcher("ListFriendOfUser.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("banBeFriend")!=null) {
			session.setAttribute("ProfileActive", "friend");
			int profileUserId = Integer.parseInt(request.getParameter("profileUserId"));
			User user = userBo.getUserById(profileUserId);
			request.setAttribute("userFriend", user);
			dsFriendshipById = friendshipBo.getFriendshipByUserId(profileUserId);
			session.setAttribute("dsFriendshipById", dsFriendshipById);
			RequestDispatcher rd = request.getRequestDispatcher("ListFriendOfFriend.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("SearchFriend")!=null) {
			String searchFriend = request.getParameter("SearchFriend");
			session.setAttribute("ProfileActive", "friend");
			dsFriendshipById = friendshipBo.getFriendshipByUserId_Search(currentUser.getUserID(), searchFriend);
			session.setAttribute("dsFriendshipById", dsFriendshipById);
			RequestDispatcher rd = request.getRequestDispatcher("ListFriendOfUser.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("SearchFriendFriend")!=null) {
			int profileUserId = Integer.parseInt(request.getParameter("id"));
			User x = userBo.getUserById(profileUserId);
			request.setAttribute("userFriend", x);
			System.out.println("Tên muốn search"+request.getParameter("SearchFriendFriend")+"nguwowif dungf "+profileUserId);
			String searchFriend = request.getParameter("SearchFriendFriend");
			session.setAttribute("ProfileActive", "friend");
			dsFriendshipById = friendshipBo.getFriendshipByUserId_Search(profileUserId, searchFriend);
			System.out.println("danh sacsh banj laf "+dsFriendshipById.size());
			session.setAttribute("dsFriendshipById", dsFriendshipById);
			RequestDispatcher rd = request.getRequestDispatcher("ListFriendOfFriend.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("anh")!=null) {
			session.setAttribute("ProfileActive", "photo");
			dsPostByUserID = postBo.getPostByUserID(currentUser.getUserID());
			session.setAttribute("dsPostByUserId", dsPostByUserID);
			RequestDispatcher rd = request.getRequestDispatcher("ListPictureOfUser.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("anhFriend")!=null) {
			session.setAttribute("ProfileActive", "photo");
			int profileUserId = Integer.parseInt(request.getParameter("profileUserId"));
			User user = userBo.getUserById(profileUserId);
			request.setAttribute("userFriend", user);
			dsPostByUserID = postBo.getPostByUserID(profileUserId);
			session.setAttribute("dsPostByUserId", dsPostByUserID);
			RequestDispatcher rd = request.getRequestDispatcher("ListPictureOfFriend.jsp");
			rd.forward(request, response);
			return;
		}
		RequestDispatcher rd = request.getRequestDispatcher("ListPictureOfUser.jsp");
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

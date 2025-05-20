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
import javax.websocket.Session;

import DangNhapModal.DangNhapBo;
import FriendshipModal.Friendship;
import FriendshipModal.FriendshipBo;
import LikeModal.Like;
import LikeModal.LikeBo;
import Post_UserModal.Post_User;
import Post_UserModal.Post_UserBo;
import PostsModal.Posts;
import PostsModal.PostsBo;
import UserModal.User;

/**
 * Servlet implementation class HomePageController
 */
@WebServlet("/HomePageController")
public class HomePageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomePageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ArrayList<Post_User> dsPost_User = new ArrayList<Post_User>();
		ArrayList<Like> dsLike = new ArrayList<Like>();
		ArrayList<Friendship> dsFriendshipByUserId = new ArrayList<Friendship>();
		FriendshipBo frdBo = new FriendshipBo();
		User currentUser = (User)session.getAttribute("User");
		//Lấy toàn bộ danh sách like
		LikeBo likeBo = new LikeBo();
		dsLike = likeBo.getLike();
		session.setAttribute("dsLike", dsLike);
		//Lấy danh sách post_User
		Post_UserBo post_userBo = new Post_UserBo();
		dsPost_User = post_userBo.getPost_User();
		session.setAttribute("dsPost_User", dsPost_User);
		session.setAttribute("homeActive", "home");
		//ds bạn bè của user
		dsFriendshipByUserId = frdBo.getFriendshipByUserId(currentUser.getUserID());
		session.setAttribute("dsFriendshipByUserId", dsFriendshipByUserId);
		if(request.getParameter("timkiem")!=null) {
			ArrayList<Friendship> dsFriendshipByUserId_Search = new ArrayList<Friendship>();
			String search = request.getParameter("searchfriend");
			dsFriendshipByUserId_Search = frdBo.getFriendshipByUserId_Search(currentUser.getUserID(),search );
			session.setAttribute("dsFriendshipByUserId", dsFriendshipByUserId_Search);
		}
		RequestDispatcher rd = request.getRequestDispatcher("HomePage.jsp");
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


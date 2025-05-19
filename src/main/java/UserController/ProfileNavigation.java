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
		HttpSession session = request.getSession();
		PostsBo postBo = new PostsBo();
		FriendshipBo friendshipBo = new FriendshipBo();
		User currentUser = (User)session.getAttribute("User");
		ArrayList<Posts> dsPostByUserID = new ArrayList<Posts>();
		ArrayList<Friendship> dsFriendshipById = new ArrayList<Friendship>();
		if(request.getParameter("baiViet")!=null) {
			response.sendRedirect("ProfileController");
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
		if(request.getParameter("SearchFriend")!=null) {
			String searchFriend = request.getParameter("SearchFriend");
			session.setAttribute("ProfileActive", "friend");
			dsFriendshipById = friendshipBo.getFriendshipByUserId_Search(currentUser.getUserID(), searchFriend);
			session.setAttribute("dsFriendshipById", dsFriendshipById);
			RequestDispatcher rd = request.getRequestDispatcher("ListFriendOfUser.jsp");
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

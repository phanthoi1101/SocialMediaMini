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

import LikeModal.Like;
import LikeModal.LikeBo;
import Post_UserModal.Post_User;
import Post_UserModal.Post_UserBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class ProfileController
 */
@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		ArrayList<Like> dsLike = new ArrayList<Like>();
		LikeBo likeBo = new LikeBo();
		UserBo userbo = new UserBo();
		dsLike = likeBo.getLike();
		session.setAttribute("dsLike", dsLike);
		session.setAttribute("ProfileActive", "article");
		Post_UserBo post_UserBo = new Post_UserBo();
		ArrayList<Post_User> dsPost_User = new ArrayList<Post_User>();
		User user = (User)session.getAttribute("User");
		int id = Integer.parseInt(request.getParameter("id"));
		dsPost_User = post_UserBo.getPost_UserByUserId(id);
		session.setAttribute("dsPost_UserById", dsPost_User);
		session.setAttribute("homeActive", "");
		if(user.getUserID()==id) {
			RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
			rd.forward(request, response);
		}else {
			User userFriend = userbo.getUserById(id);
			request.setAttribute("UserFriend", userFriend);
			RequestDispatcher rd = request.getRequestDispatcher("ProfileFriend.jsp");
			rd.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

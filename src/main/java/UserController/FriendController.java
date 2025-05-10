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

import Constand.FriendshipStatus;
import FriendshipModal.Friendship;
import FriendshipModal.FriendshipBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class FriendController
 */
@WebServlet("/FriendController")
public class FriendController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		FriendshipStatus Status = new FriendshipStatus();
		UserBo userBo = new UserBo();
		session.setAttribute("homeActive", "friend");
		FriendshipBo friendshipBo = new FriendshipBo(); 
		User currentUser = (User)session.getAttribute("User");
		ArrayList<Friendship> dsFriendship = friendshipBo.getFriendshipByStatusAndReceiverID(currentUser.getUserID(), Status.PENDING);
		session.setAttribute("dsFriendshipSender", dsFriendship);
		ArrayList<User> dsIsNotFriend = userBo.getUserIsNotFriend(currentUser.getUserID());
		session.setAttribute("dsIsNotFriend", dsIsNotFriend);
		RequestDispatcher rd = request.getRequestDispatcher("Friends.jsp");
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

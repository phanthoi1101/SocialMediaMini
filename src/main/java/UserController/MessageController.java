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
import MessageModal.Message;
import MessageModal.MessageBo;
import RoomModal.RoomBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class MessageController
 */
@WebServlet("/MessageController")
public class MessageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int receiver = Integer.parseInt(request.getParameter("id"));
		User currentUser = (User)session.getAttribute("User");
		MessageBo messageBo = new MessageBo();
		RoomBo roomBo = new RoomBo();
		UserBo userBo = new UserBo();
		FriendshipBo frdship = new FriendshipBo();
		ArrayList<Friendship> dsUserIsFriend = new ArrayList<Friendship>();
		User user = userBo.getUserById(receiver);
		session.setAttribute("userFriend", user);
		dsUserIsFriend = frdship.getFriendshipByUserId(currentUser.getUserID());
		session.setAttribute("dsFriendshipIsFriend", dsUserIsFriend);
		ArrayList<Message> dsMessage = new ArrayList<Message>();
		int roomid = roomBo.getRoomId(currentUser.getUserID(), receiver);
		session.setAttribute("roomId", roomid);
		dsMessage = messageBo.getMessageByRoomId(roomid);
		session.setAttribute("dsMessage", dsMessage);
		RequestDispatcher rd = request.getRequestDispatcher("Message.jsp");
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

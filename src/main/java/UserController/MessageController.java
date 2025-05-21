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
import RoomDetailModal.RoomDetailBo;
import RoomModal.Room;
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
		MessageBo messageBo = new MessageBo();
		RoomBo roomBo = new RoomBo();
		UserBo userBo = new UserBo();
		RoomBo rBo = new RoomBo();
		User currentUser = (User)session.getAttribute("User");
		FriendshipBo frdship = new FriendshipBo();
		ArrayList<Friendship> dsUserIsFriend = new ArrayList<Friendship>();
		ArrayList<Message> dsMessage = new ArrayList<Message>();
		
		if(request.getParameter("id")!=null) {
			int receiver = Integer.parseInt(request.getParameter("id"));
			ArrayList<Integer> dsRoomId = rBo.getRoomIdByUserID(currentUser.getUserID());
			session.setAttribute("dsRoomId", dsRoomId);
			//Khác biệt
			User user = userBo.getUserById(receiver);
			session.setAttribute("userFriend", user);
			//Danh sách tim nhắn theo room id
			int roomid = roomBo.getRoomId(currentUser.getUserID(), receiver);
			session.setAttribute("roomId", roomid);
			dsMessage = messageBo.getMessageByRoomId(roomid);
			session.setAttribute("dsMessage", dsMessage);
			request.setAttribute("check","userFriend");
			RequestDispatcher rd = request.getRequestDispatcher("Message.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("roomId")!=null) {
			ArrayList<Integer> dsRoomId = rBo.getRoomIdByUserID(currentUser.getUserID());
			session.setAttribute("dsRoomId", dsRoomId);
			int roomId = Integer.parseInt(request.getParameter("roomId"));
			Room room = roomBo.getRoomByRoomID(roomId);
			session.setAttribute("room", room);
			session.setAttribute("roomId", roomId);
			dsMessage = messageBo.getMessageByRoomId(roomId);
			session.setAttribute("dsMessage", dsMessage);
			request.setAttribute("check","room");
			RequestDispatcher rd = request.getRequestDispatcher("Message.jsp");
			rd.forward(request, response);
			return;
		}
		if(request.getParameter("message")!=null) {
			ArrayList<Integer> dsRoomId = rBo.getRoomIdByUserID(currentUser.getUserID());
			session.setAttribute("dsRoomId", dsRoomId);
			request.setAttribute("check","message");
			session.setAttribute("dsMessage", null);
			RequestDispatcher rd = request.getRequestDispatcher("Message.jsp");
			rd.forward(request, response);
			return;
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

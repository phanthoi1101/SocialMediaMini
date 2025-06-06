package UserController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Constand.FriendshipStatus;
import FriendshipModal.FriendshipBo;
import RoomDetailModal.RoomDetailBo;
import RoomModal.Room;
import RoomModal.RoomBo;
import UserModal.User;

/**
 * Servlet implementation class FriendRequestController
 */
@WebServlet("/FriendRequestController")
public class FriendRequestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendRequestController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		FriendshipStatus status = new FriendshipStatus();
		RoomBo rBo = new RoomBo();
		RoomDetailBo rdBo = new RoomDetailBo();
		User currentUser = (User)session.getAttribute("User");
		FriendshipBo fBo = new FriendshipBo();
		int userId = currentUser.getUserID();
		int user = Integer.parseInt(request.getParameter("userId"));
		System.out.println("UserId là"+request.getParameter("userId"));
		if(request.getParameter("thembanbe")!=null) {
			fBo.CreateFriendshipBySender_Receiver(userId, user,status.PENDING);
			System.out.println("Thêm bạn thành công !");
		}
		if(request.getParameter("xacnhan")!=null) {
			fBo.UpdateFriendshipBySender_Receiver(userId, user, status.ACCEPTED);
			if(rBo.checkIsRoom(userId, user)) {
			}else {
				int x =rBo.CreateRoom("", false);
				rdBo.CreateRoomDetail(x, userId);
				rdBo.CreateRoomDetail(x, user);
			}
			System.out.println("Thêm bạn thành công !");
		}
		if(request.getParameter("huyyeucau")!=null) {
			fBo.DeleteFriendshipBySender_Receiver(userId, user);
			System.out.println("Huỷ yêu cầu thành công");
		}
		if(request.getParameter("huyketban")!=null) {
			fBo.DeleteFriendshipBySender_Receiver(userId, user);
			int rId = rBo.getRoomId(userId, user);
			rBo.UpdateStatus(0, rId);
			System.out.println("Huỷ kết bạn thành công");
		}
		response.sendRedirect("ProfileController?id="+user);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package UserController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import RoomDetailModal.RoomDetailBo;


/**
 * Servlet implementation class AddMemBerController
 */
@WebServlet("/AddMemBerController")
@MultipartConfig 
public class AddMemBerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMemBerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		request.setCharacterEncoding("UTF-8");
		 	RoomDetailBo rdBo = new RoomDetailBo();
	        // Lấy dữ liệu từ các phần không phải file
		 	System.out.println("room id "+request.getParameter("RoomId"));
	        int RoomID = Integer.parseInt(request.getParameter("RoomId"));
	        String[] userIds = request.getParameterValues("userIds");
	        for(String x : userIds) {
	        	int userId = Integer.parseInt(x);
	        	rdBo.CreateRoomDetail(RoomID, userId);
	        }  
	        String jsonString = "{\"status\":\"success\"}";
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(jsonString);
	}

}

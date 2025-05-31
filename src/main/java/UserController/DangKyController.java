package UserController;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import UserModal.UserBo;
import dto.ConvertData;

/**
 * Servlet implementation class DangKyController
 */
@WebServlet("/DangKyController")
public class DangKyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangKyController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		UserBo userBo = new UserBo();
		ConvertData cv= new ConvertData();
		String fullname = request.getParameter("fullname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		password = cv.hashMatKhau(password);
		int x = userBo.addUser(fullname, username, email, password);
		request.setAttribute("checkDangKy", x);
		RequestDispatcher rd = request.getRequestDispatcher("DangKy.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		UserBo uBo = new UserBo();
		String emailToCheck = request.getParameter("checkEmail");
		String usernameToCheck = request.getParameter("checkUsername");
		if(usernameToCheck !=null) {
			boolean isExist = uBo.checkUser(usernameToCheck);
		    response.setContentType("text/plain");
		    response.getWriter().write(isExist ? "exist" : "ok");
		    return; // kết thúc xử lý nếu là kiểm tra email
		}
		if (emailToCheck != null) {
		    boolean isExist = uBo.checkEmail(emailToCheck);
		    response.setContentType("text/plain");
		    response.getWriter().write(isExist ? "exist" : "ok");
		    return; // kết thúc xử lý nếu là kiểm tra email
		}
    }

}

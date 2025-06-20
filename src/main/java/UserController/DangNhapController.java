package UserController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import DangNhapModal.DangNhapBo;
import UserModal.User;
import UserModal.UserBo;
import dto.ConvertData;

/**
 * Servlet implementation class DangNhapController
 */
@WebServlet("/DangNhapController")

public class DangNhapController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangNhapController() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		ConvertData cv = new ConvertData();
		UserBo uBo = new UserBo();
		User user = uBo.getUserByUsername(username);
		boolean checkdn = false;
		if(password == null) {
			RequestDispatcher rd = request.getRequestDispatcher("DangNhap.jsp");
			rd.forward(request, response);
			return;
		}else {
			if(user.getUsername()!=null) {
				checkdn = cv.checkMatKhau(password,user.getPasswordHash());
			}
		}
		
		if(!checkdn) {
			String req = "Tên đăng nhập hoặc mật khẩu không chính xác";
			request.setAttribute("message", req);
			RequestDispatcher rd = request.getRequestDispatcher("DangNhap.jsp");
			rd.forward(request, response);
			return;
		}else {
			session.setAttribute("User", user);
			RequestDispatcher rd = request.getRequestDispatcher("HomePageController");
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

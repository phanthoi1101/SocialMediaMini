package UserController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import UserModal.User;
import UserModal.UserBo;
import dto.ConvertData;

/**
 * Servlet implementation class ForgotPasswordController
 */
@WebServlet("/ForgotPasswordController")
public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPasswordController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("ForgotPassword.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		if(request.getParameter("otp")!=null) {
			String inputOtp = request.getParameter("otp");
			String correctOtp = (String)session.getAttribute("otp");
			Long expireTime = (Long) session.getAttribute("otp_expire_time");
			if(inputOtp.equals(correctOtp)) {
				if(System.currentTimeMillis() <= expireTime) {
					session.removeAttribute("otp");
					response.setContentType("application/json");
			        response.setCharacterEncoding("UTF-8");
			        response.getWriter().write("{\"status\": \"success\", \"message\": \"Gửi thành công!\"}");
			        return;
				}else {
					session.removeAttribute("otp");
					response.setContentType("application/json");
			        response.setCharacterEncoding("UTF-8");
			        response.getWriter().write("{\"status\": \"error\", \"message\": \"Mã OTP đã hết hiệu lực1\"}");
			        return;
				}
			}else {
				session.removeAttribute("otp");
				response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        response.getWriter().write("{\"status\": \"error\", \"message\": \"Mã OTP không chính xác!\"}");
		        return;
			}
		}
		if(request.getParameter("Password")!=null) {
			String email = (String)session.getAttribute("email");
			UserBo uBo = new UserBo();
			ConvertData cv = new ConvertData();
			User user = uBo.getUserByEmail(email);
			String password = request.getParameter("Password");
			password = cv.hashMatKhau(password);
			uBo.ChangePassword(user.getUserID(), password);
			response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write("{\"status\": \"error\", \"message\": \"Đổi mật khẩu thành công!\"}");
		}
	}

}

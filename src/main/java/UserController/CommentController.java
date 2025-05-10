package UserController;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import CommentContainModal.CommentContain;
import CommentContainModal.CommentContainBo;
import CommentModal.CommentBo;
import PostWithCommentModal.PostWithComment;
import Post_UserModal.Post_User;
import Post_UserModal.Post_UserBo;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("/CommentController")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            // Lấy postId từ request
            int postId = Integer.parseInt(request.getParameter("postId"));
            session.setAttribute("postId", postId);
            // Lấy dữ liệu bài viết từ database (Giả sử có class Post_UserBo)
            Post_UserBo post_UserBo = new Post_UserBo();
            Post_User post_User = post_UserBo.get1Post_User(postId);
            //lấy dữ liệu comment từ database
            CommentContainBo cmtBo = new CommentContainBo();
            ArrayList<CommentContain> dsCommentContain = cmtBo.getCommentByPostId(postId);
            PostWithComment postWithComment = new PostWithComment(post_User, dsCommentContain);
            
            if (post_User == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Post not found\"}");
                return;
            }

            // Convert object Java thành JSON
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonResponse = objectMapper.writeValueAsString(postWithComment);

            // Gửi JSON về client
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal Server Error\"}");
            e.printStackTrace();
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

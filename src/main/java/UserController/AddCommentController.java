package UserController;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import CommentContainModal.CommentContain;
import CommentContainModal.CommentContainBo;
import CommentModal.CommentBo;
import PostWithCommentModal.PostWithComment;
import Post_UserModal.Post_User;
import Post_UserModal.Post_UserBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class AddCommentController
 */
@WebServlet("/AddCommentController")
@MultipartConfig
public class AddCommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCommentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		CommentBo commentBo = new CommentBo();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            // Lấy postId,userId từ request
            int postId = Integer.parseInt(request.getParameter("postId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            String content = request.getParameter("content");
            int x = commentBo.AddComment(postId, userId, content,parentId);
            System.out.println("Đã thành công"+x);
            // Lấy dữ liệu bài viết từ database (Giả sử có class Post_UserBo)
            Post_UserBo post_UserBo = new Post_UserBo();
            System.out.println("PostId truyền vào là gì??? "+postId);
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
		response.setCharacterEncoding("UTF-8");
		UserBo uBo = new UserBo();
		response.setContentType("application/json");
		if(request.getParameter("parentId")!=null) {
			int parentId = Integer.parseInt(request.getParameter("parentId"));
			User user = uBo.getUserById(parentId);
			Gson gson = new Gson();
			String json = gson.toJson(user);
			response.getWriter().write(json);
		}
		
	}

}

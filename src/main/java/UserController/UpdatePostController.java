package UserController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import LikeModal.LikeBo;
import Post_UserModal.Post_User;
import Post_UserModal.Post_UserBo;
import PostsModal.Posts;
import PostsModal.PostsBo;
import UserModal.User;
import UserModal.UserBo;

/**
 * Servlet implementation class UpdatePostController
 */
@WebServlet("/UpdatePostController")
@MultipartConfig
public class UpdatePostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		HttpSession session = request.getSession();
		User currentUser = (User)session.getAttribute("User");
		PostsBo pBo = new PostsBo();
		if(request.getParameter("postId")!=null) {
			int postId = Integer.parseInt(request.getParameter("postId"));
			Post_UserBo postUserBo = new Post_UserBo();
		    // TODO: lấy dữ liệu bài viết từ DB theo postId
		    Post_User post_User = postUserBo.get1Post_User(postId);
		    // trả về JSON
		    response.setContentType("application/json;charset=UTF-8");
		    PrintWriter out = response.getWriter();

		    if (post_User != null) {
		    	System.out.println("Đã lấy được post user");
		      String json = new Gson().toJson(post_User);
		      out.print(json);
		    } else {
		      out.print("{}"); 
		    }
		    out.flush();
		}
		if(request.getParameter("deleteId")!=null) {
			int postId = Integer.parseInt(request.getParameter("deleteId"));
			System.out.println(postId);		
			LikeBo likeBo = new LikeBo();
			likeBo.deleteLike(postId);
			pBo.DeletePostByPostID(postId);
			System.out.println("Xoá bài post thành công");
			response.sendRedirect("ProfileController?id="+currentUser.getUserID());
			return;
		}
		
		
	  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8"); // đảm bảo nhận UTF-8 từ client
	    
	    

	    int postId = Integer.parseInt(request.getParameter("postId"));
	    String content = request.getParameter("content");
	    Part imagePart = request.getPart("image"); // lấy file ảnh
	    PostsBo pBo= new PostsBo();
	    if (imagePart != null && imagePart.getSize() > 0) {
	        // Có ảnh mới
	        String fileName = imagePart.getSubmittedFileName();
	        System.out.println("Tên file ảnh mới: " + fileName);

	        if (fileName == null) {
	        	pBo.UpdatePost(postId, content, null);
	            System.out.println("Không có ảnh mới");
	        } else {
	            // Lưu ảnh vào thư mục trên server
	            String uploadPath = request.getServletContext().getRealPath("/images");
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) uploadDir.mkdir();

	            // Tách tên và phần mở rộng
	            String baseName = fileName;
	            String extension = "";
	            int dotIndex = fileName.lastIndexOf(".");
	            if (dotIndex != -1) {
	                baseName = fileName.substring(0, dotIndex);
	                extension = fileName.substring(dotIndex); // .jpg, .png,...
	            }

	            // Thêm timestamp vào tên file
	            String timestamp = new java.text.SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
	            String newFileName = baseName + "_" + timestamp + extension;

	            // Nếu vẫn bị trùng (rất hiếm), thêm số đếm
	            File file = new File(uploadPath + File.separator + newFileName);
	            int count = 1;
	            while (file.exists()) {
	                newFileName = baseName + "_" + timestamp + "_" + count + extension;
	                file = new File(uploadPath + File.separator + newFileName);
	                count++;
	            }

	            String filePath = uploadPath + File.separator + newFileName;
	            System.out.println("Đường dẫn lưu file là: " + filePath);
	            imagePart.write(filePath);
	            String imageUrl = "images/"+newFileName;
	            System.out.println(imageUrl);
	    	    pBo.UpdatePost(postId, content, imageUrl);
	        }
	    } else {
	    	pBo.UpdatePost(postId, content, null);
	        System.out.println("Không có ảnh mới được gửi.");
	    }
	    // Gửi phản hồi về client
	    HttpSession session = request.getSession();
	    User u = (User)session.getAttribute("User");
	    response.sendRedirect("ProfileController?id="+u.getUserID());
	    return;
	}
}

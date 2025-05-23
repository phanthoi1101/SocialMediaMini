package UserController;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import PostsModal.PostsBo;
import UserModal.User;

/**
 * Servlet implementation class CreatePostController
 */
@WebServlet("/CreatePostController")
public class CreatePostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreatePostController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	  } 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    HttpSession session = request.getSession();
	    User currentUser = (User)session.getAttribute("User");
	    String content = "";
	    String imagePath = "";
	    System.out.println("hello formFile");
	    try {
	      boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	      if (isMultipart) {
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        ServletFileUpload upload = new ServletFileUpload(factory);
	        List<FileItem> items = upload.parseRequest(request);

	        for (FileItem item : items) {
	          if (item.isFormField()) {
	            if ("content".equals(item.getFieldName())) {
	              content = item.getString("UTF-8");
	              System.out.println("Nội dung bài viết: " + content);
	            }
	          } else {
	            if ("image".equals(item.getFieldName())) {
	              String fileName = item.getName();
	              if (!fileName.equals("")) {
	                String uploadPath = request.getServletContext().getRealPath("/images");
	                File dir = new File(uploadPath);
	                if (!dir.exists()) dir.mkdir();

	                File file = new File(uploadPath + File.separator + fileName);
	                item.write(file);
	                imagePath = "images/" + fileName;
	                System.out.println("Ảnh lưu tại: " + imagePath+file);
	              }
	            }
	          }
	        }
	      }
	        if(content.isEmpty() && imagePath.isEmpty()) {
	        	response.getWriter().write("{\"status\":\"error\", \"content\":\"" + "Không được để trống nội dùng và ảnh" + "\", \"image\":\"");
	        }else {
	        	PostsBo pBo = new PostsBo();
	        	pBo.CreatePost(currentUser.getUserID(), content, imagePath);
	        }
	      // Trả kết quả JSON về client
	      response.getWriter().write("{\"status\":\"success\", \"content\":\"" + content + "\", \"image\":\"" + imagePath + "\"}");
	    } catch (Exception e) {
	      e.printStackTrace();
	      response.getWriter().write("{\"status\":\"error\"}");
	    }
	}

}

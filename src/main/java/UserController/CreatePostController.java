package UserController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
		User currentUser = (User) session.getAttribute("User");

		String content = "";
		String imagePath = "";

		try {
		    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		    if (isMultipart) {
		        DiskFileItemFactory factory = new DiskFileItemFactory();
		        ServletFileUpload upload = new ServletFileUpload(factory);
		        List<FileItem> items = upload.parseRequest(request);

		        for (FileItem item : items) {
		            if (item.isFormField()) {
		                if ("content".equals(item.getFieldName())) {
		                    content = item.getString("UTF-8").trim();
		                    System.out.println("Nội dung bài viết: " + content);
		                }
		            } else {
		                if ("image".equals(item.getFieldName())) {
		                    String fileName = item.getName();
		                    if (!fileName.isEmpty()) {
		                        String uploadPath = request.getServletContext().getRealPath("/images");
		                        File dir = new File(uploadPath);
		                        if (!dir.exists()) dir.mkdirs();

		                        // Thêm timestamp vào tên file để tránh trùng
		                        String extension = "";
		                        String baseName = fileName;
		                        int dotIndex = fileName.lastIndexOf(".");
		                        if (dotIndex != -1) {
		                            baseName = fileName.substring(0, dotIndex);
		                            extension = fileName.substring(dotIndex);
		                        }

		                        String timestamp = new java.text.SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
		                        String newFileName = baseName + "_" + timestamp + extension;
		                        File file = new File(uploadPath + File.separator + newFileName);
		                        item.write(file);
		                        imagePath = "images/" + newFileName;

		                        System.out.println("Ảnh lưu tại: " + imagePath);
		                    }
		                }
		            }
		        }
		    }

		    PrintWriter out = response.getWriter();

		    if (content.isEmpty() && imagePath.isEmpty()) {
		        out.write("{\"status\":\"error\", \"message\":\"Không được để trống nội dung và ảnh\"}");
		    } else {
		        PostsBo pBo = new PostsBo();
		        pBo.CreatePost(currentUser.getUserID(), content, imagePath);
		        out.write("{\"status\":\"success\", \"content\":\"" + content + "\", \"image\":\"" + imagePath + "\"}");
		    }

		} catch (Exception e) {
		    e.printStackTrace();
		    response.getWriter().write("{\"status\":\"error\", \"message\":\"Đã xảy ra lỗi khi xử lý dữ liệu\"}");
		}
	}

}

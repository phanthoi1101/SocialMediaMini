package PostsModal;

import java.util.ArrayList;

public class PostsBo {
	ArrayList<Posts> ds = new ArrayList<Posts>();
	PostsDao pDao = new PostsDao();
	public ArrayList<Posts> getPost(){
		return pDao.getPost();
	}
	public ArrayList<Posts> getPostByUserID(int userID){
		return pDao.getPostByUserID(userID);
	}
	public int CreatePost(int userID , String Content , String Image) {
		return pDao.CreatePost(Content, Image, userID);
	}
}

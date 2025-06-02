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
	public int UpdatePost(int postId, String content, String image) {
		return pDao.UpdatePost(postId, content, image);
	}
	public int DeletePostByPostID(int postID) {
		return pDao.DeletePostByPostID(postID);
	}
}

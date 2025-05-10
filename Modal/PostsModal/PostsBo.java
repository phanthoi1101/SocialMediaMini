package PostsModal;

import java.util.ArrayList;

public class PostsBo {
	ArrayList<Posts> ds = new ArrayList<Posts>();
	PostsDao pDao = new PostsDao();
	public ArrayList<Posts> getPost(){
		return pDao.getPost();
	}
}

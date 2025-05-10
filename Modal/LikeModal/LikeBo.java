package LikeModal;

import java.util.ArrayList;

public class LikeBo {
	ArrayList<Like> ds = new ArrayList<Like>();
	LikeDao likeDao = new LikeDao();
	public boolean CheckLike(int postID , int userid) {
		return likeDao.CheckLike(userid, postID);
	}
	public int LikeCount(int postid) {
		return likeDao.LikeCount(postid);
	}
	public ArrayList<Like> getLike(){
		return likeDao.getLike();
	}
}

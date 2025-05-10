package CommentContainModal;

import java.util.ArrayList;

public class CommentContainBo {
	CommentContainDao cmtDao = new CommentContainDao();
	ArrayList<CommentContain> ds = new ArrayList<CommentContain>();
	public ArrayList<CommentContain> getCommentByPostId(int postId){
		return cmtDao.getComment_PostId(postId);
	}
}

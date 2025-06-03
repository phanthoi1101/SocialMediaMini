package CommentModal;

public class CommentBo {
	CommentDao commentDao = new CommentDao();
	public int AddComment(int postId, int UserId , String content,int parentId) {
		return commentDao.AddComment(postId, UserId, content,parentId);
	}
}

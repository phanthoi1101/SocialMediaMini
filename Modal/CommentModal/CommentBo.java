package CommentModal;

public class CommentBo {
	CommentDao commentDao = new CommentDao();
	public int AddComment(int postId, int UserId , String content) {
		return commentDao.AddComment(postId, UserId, content);
	}
}

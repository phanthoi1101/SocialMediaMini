package PostWithCommentModal;

import java.util.ArrayList;

import CommentContainModal.CommentContain;
import Post_UserModal.Post_User;

public class PostWithComment {
	private Post_User PostUser;
	private ArrayList<CommentContain> comment;
	public Post_User getPostUser() {
		return PostUser;
	}
	public void setPostUser(Post_User postUser) {
		PostUser = postUser;
	}
	public ArrayList<CommentContain> getComment() {
		return comment;
	}
	public void setComment(ArrayList<CommentContain> comment) {
		this.comment = comment;
	}
	public PostWithComment(Post_User postUser, ArrayList<CommentContain> comment) {
		super();
		PostUser = postUser;
		this.comment = comment;
	}
	public PostWithComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

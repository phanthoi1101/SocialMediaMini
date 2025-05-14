package FriendshipModal;

import java.util.ArrayList;

public class FriendshipBo {
ArrayList<Friendship> ds = new ArrayList<Friendship>();
FriendshipDao friendshipDao = new FriendshipDao();
public ArrayList<Friendship> getFriendshipByStatusAndSenderID(int senderID, int status){
	return friendshipDao.getFriendshipByStatus(senderID, status);
}
public ArrayList<Friendship> getFriendshipByStatusAndReceiverID(int ReceiverId, int status){
	return friendshipDao.getFriendshipByStatusAndReceiveID(ReceiverId, status);
}
public ArrayList<Friendship> getFriendshipByUserId(int userID){
	return friendshipDao.getFriendshipByUserId(userID);
}
}

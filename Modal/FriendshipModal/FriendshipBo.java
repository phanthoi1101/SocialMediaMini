package FriendshipModal;

import java.util.ArrayList;

public class FriendshipBo {
ArrayList<Friendship> ds = new ArrayList<Friendship>();
FriendshipDao friendshipDao = new FriendshipDao();
public ArrayList<Friendship> getFriendshipByStatusAndSenderID(int senderID, int status){
	return friendshipDao.getFriendshipByStatus(senderID, status);
}
public ArrayList<Friendship> getAllFriendship(){
	return friendshipDao.getAllFriend();
}
public ArrayList<Friendship> getFriendshipByStatusAndReceiverID(int ReceiverId, int status){
	return friendshipDao.getFriendshipByStatusAndReceiveID(ReceiverId, status);
}
public ArrayList<Friendship> getFriendshipByUserId(int userID){
	return friendshipDao.getFriendshipByUserId(userID);
}
public ArrayList<Friendship> getFriendshipByUserId_Search(int userID, String Search){
	return friendshipDao.getFriendshipByUserId_Search(userID, Search);
}
public int UpdateFriendshipBySender_Receiver(int userId1, int userId2, int status) {
	return friendshipDao.UpdateFriendshipBySender_Receiver(userId1, userId2, status);
}
public int DeleteFriendshipBySender_Receiver(int userId1, int userId2) {
	return friendshipDao.DeleteFriendshipBySender_Receiver(userId1, userId2);
}
public int CreateFriendshipBySender_Receiver(int userId1, int userId2, int status) {
	return friendshipDao.CreateFriendshipBySender_Receiver(userId1, userId2, status);
}
public boolean checkFriendShip(int currentUserId,int receiver) {
	ArrayList<Friendship> lstFriendship = new ArrayList<Friendship>();
	lstFriendship = friendshipDao.getFriendshipByStatusAndReceiveID(receiver, 0);
	for(Friendship f : lstFriendship) {
		if(f.getSenderID()==currentUserId)
			return true;
	}
	return false;
}

public boolean userSent(int senderId , int receiverId) {
	ArrayList<Friendship> dsf = getAllFriendship();
	for(Friendship f:dsf) {
		if(senderId==f.getSenderID() && receiverId == f.getReceiverID() && f.getStatus()==0) {
			return true;
		}
	}
	return false;
}
public boolean IsSent(int senderId , int receiverId) {
	ArrayList<Friendship> dsf = getAllFriendship();
	for(Friendship f:dsf) {
		if(senderId==f.getReceiverID() && receiverId == f.getSenderID() && f.getStatus()==0) {
			return true;
		}
	}
	return false;
}

public String checkFriendship(int userid,int currentdId) {
	ArrayList<Friendship> dsfriend =getAllFriendship();
	String check = "guiloimoi";
	for(Friendship f : dsfriend) {
		if((userid==f.getSenderID() && currentdId==f.getReceiverID() && f.getStatus()==1) || (userid==f.getReceiverID() && currentdId==f.getSenderID() && f.getStatus()==1)) {
			check="huyketban";
			return check;
		}else if(f.getSenderID()==currentdId && f.getReceiverID()==userid && f.getStatus()==0) {
			check = "huyyeucau";
			return check;
		}else if(f.getReceiverID()==currentdId && f.getSenderID()==userid && f.getStatus()==0) {
			check = "xacnhan";
			return check;
		}
	}
	
	return check;
}
}

package MessageModal;

import java.util.ArrayList;

public class MessageBo {
	MessageDao messageDao = new MessageDao();
	public ArrayList<Message> getMessageByRoomId(int roomId){
		return messageDao.GetMessageByRoomId(roomId);
	}
	public int CreateMessage(int senderid, String content , int roomid,String status) {
		return messageDao.CreateMessage(senderid, content, roomid,status);
	}
}

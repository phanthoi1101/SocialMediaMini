package Websocket;

import java.io.StringWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import MessageModal.MessageBo;
import UserModal.User;
import UserModal.UserBo;

@ServerEndpoint(value="/chatroomServerEndpoint/{chatroom}",configurator = ChatroomServerConfigurator.class)
public class ChatroomServerEndpoint {
	static Map<Integer,Set<Session>> chatrooms= (Map<Integer, Set<Session>>)Collections.synchronizedMap(new HashMap<Integer, Set<Session>>());
	//trả về tất cả người dùng truy cập vào socket
	public Set<Session> getChatroom(int chatroomId){
		Set<Session> chatroom = chatrooms.get(chatroomId);
		if(chatroom == null) {
			chatroom = Collections.synchronizedSet(new HashSet<Session>());
			chatrooms.put(chatroomId, chatroom);
		}
		return chatroom;
	}
	
	
	@OnOpen
	public void handleOpen(EndpointConfig config, Session userSession, @PathParam("chatroom") int chatroom) {
		userSession.getUserProperties().put("userId", config.getUserProperties().get("userId"));
		userSession.getUserProperties().put("chatroom", chatroom);
		Set<Session> chatroomUsers = getChatroom(chatroom);
		chatroomUsers.add(userSession);	
		}
	
	@OnMessage
	public void handleMessage(String message, Session userSession) {
		UserBo ubo = new UserBo();
		int userId = (Integer) userSession.getUserProperties().get("userId");
		User user = ubo.getUserById(userId);
		Timestamp time = new Timestamp(System.currentTimeMillis());
		int chatroomId = (Integer) userSession.getUserProperties().get("chatroom");
		MessageBo messagebo = new MessageBo();
		messagebo.CreateMessage(userId, message, chatroomId);
		Set<Session> chatroomUsers = getChatroom(chatroomId);
		chatroomUsers.stream().forEach(x->{
			try {
				x.getBasicRemote().sendText(buildJsonData(userId, message,user.getAvatar(),time,user.getFullName()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	
	@OnClose
	public void handleClose(Session userSession) {
		int chatroom = (Integer)userSession.getUserProperties().get("chatroom");
		Set<Session> chatroomUsers = getChatroom(chatroom);
		chatroomUsers.remove(userSession);
	}
	@OnError
	public void handleError(Throwable t) {
		
	}
	private String buildJsonData(int userId, String message,String avatar,Timestamp time,String Fullname) {
	    try {
	    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	        String timeString = sdf.format(time);
	        
	        JsonObject jsonObject = Json.createObjectBuilder()
	            .add("userId", userId)
	            .add("message", message)
	            .add("avatar", avatar)
	            .add("SentAt", timeString)
	            .add("FullName", Fullname)
	            .build();
	        
	        StringWriter stringWriter = new StringWriter();
	        try (JsonWriter jsonWriter = Json.createWriter(stringWriter)) {
	            jsonWriter.write(jsonObject);
	        }
	        return stringWriter.toString();
	    } catch (Exception e) {
	        System.out.println("Exception occurred in buildJsonData + " + e.getMessage());
	        e.printStackTrace();
	        return "{}";
	    }
	}
}

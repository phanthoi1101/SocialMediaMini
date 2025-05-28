package Websocket;

import java.io.File;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Base64;
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

import com.fasterxml.jackson.databind.ObjectMapper;

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
		userSession.setMaxTextMessageBufferSize(2 * 1024 * 1024); // 2MB
	    userSession.setMaxBinaryMessageBufferSize(2 * 1024 * 1024);
		
		userSession.getUserProperties().put("userId", config.getUserProperties().get("userId"));
		userSession.getUserProperties().put("chatroom", chatroom);
		Set<Session> chatroomUsers = getChatroom(chatroom);
		chatroomUsers.add(userSession);	
		System.out.println("OnOpen");
		}
	
	@OnMessage
	public void handleMessage(String message, Session userSession) {
		ObjectMapper objMapper = new ObjectMapper();
		UserBo ubo = new UserBo();
		MessageBo messagebo = new MessageBo();

		try {
			MessageData messageData = objMapper.readValue(message, MessageData.class);
			if(messageData.getStatus().equals("text")) {
				int userId = (Integer) userSession.getUserProperties().get("userId");
				User user = ubo.getUserById(userId);
				Timestamp time = new Timestamp(System.currentTimeMillis());
				int chatroomId = (Integer) userSession.getUserProperties().get("chatroom");
				messagebo.CreateMessage(userId, messageData.getMessage(), chatroomId,"text");
				Set<Session> chatroomUsers = getChatroom(chatroomId);
				chatroomUsers.stream().forEach(x->{
					try {
						x.getBasicRemote().sendText(buildJsonData(userId, messageData.getMessage(),user.getAvatar(),time,user.getFullName(),messageData.getStatus()));
					} catch (Exception e) {
						e.printStackTrace();
					}
				});
			}
			if(messageData.getStatus().equals("file")) {
				System.out.println("file");
				byte[] fileBytes = Base64.getDecoder().decode(messageData.getFileData());
				String folderPath = "D:/CODE/JavaNangCao/SocialMedia/src/main/webapp/files/";
		        
				String originalFileName = messageData.getFileName();
		        String filePath = folderPath + originalFileName;
		        File file = new File(filePath);
		        int count = 1;
		        String newFileName=originalFileName;
		        while (file.exists()) {
		            String baseName = originalFileName.replaceAll("\\.[^.]+$", "");
		            String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
		            newFileName = baseName + "(" + count + ")" + extension;
		            filePath = folderPath + newFileName;
		            file = new File(filePath);
		            count++;
		        }
		        // Ghi dữ liệu ra file
		        Files.write(Paths.get(filePath), fileBytes);
		        System.out.println("File đã được lưu tại: " + filePath);
		        //lưu dữ liệu vào database
		        int userId = (Integer) userSession.getUserProperties().get("userId");
				User user = ubo.getUserById(userId);
				Timestamp time = new Timestamp(System.currentTimeMillis());
				int chatroomId = (Integer) userSession.getUserProperties().get("chatroom");
				messagebo.CreateMessage(userId, newFileName, chatroomId,"file");
				Set<Session> chatroomUsers = getChatroom(chatroomId);
				final String finalNewFileName = newFileName;
				chatroomUsers.stream().forEach(x->{
					try {
						x.getBasicRemote().sendText(buildJsonData(userId, finalNewFileName,user.getAvatar(),time,user.getFullName(),messageData.getStatus()));
					} catch (Exception e) {
						e.printStackTrace();
					}
				});
		        
			}
			if(messageData.getStatus().equals("image")) {
				System.out.println("image");
			    byte[] imageBytes = Base64.getDecoder().decode(messageData.getFileData());
			    String folderPath = "D:/CODE/JavaNangCao/SocialMedia/src/main/webapp/images/";
			    String originalFileName = messageData.getFileName();
			    
			    String newFileName = originalFileName;
			    String filePath = folderPath + newFileName;
			    File file = new File(filePath);
			    int count = 1;
			    while (file.exists()) {
			        String baseName = originalFileName.replaceAll("\\.[^.]+$", "");
			        String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
			        newFileName = baseName + "(" + count + ")" + extension;
			        filePath = folderPath + newFileName;
			        file = new File(filePath);
			        count++;
			    }
			    
			    Files.write(Paths.get(filePath), imageBytes);
			    System.out.println("Ảnh đã được lưu tại: " + filePath);
			    
			    int userId = (Integer) userSession.getUserProperties().get("userId");
			    User user = ubo.getUserById(userId);
			    Timestamp time = new Timestamp(System.currentTimeMillis());
			    int chatroomId = (Integer) userSession.getUserProperties().get("chatroom");
			    
			    messagebo.CreateMessage(userId, newFileName, chatroomId, "image");
			    
			    final String finalNewFileName = newFileName;
			    Set<Session> chatroomUsers = getChatroom(chatroomId);
			    chatroomUsers.forEach(session -> {
			        try {
			            session.getBasicRemote().sendText(buildJsonData(
			                userId,
			                finalNewFileName,
			                user.getAvatar(),
			                time,
			                user.getFullName(),
			                messageData.getStatus()
			            ));
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			    });
			}
		} catch (Exception e2) {
			e2.printStackTrace();
		}
	}
	
	@OnClose
	public void handleClose(Session userSession) {
		int chatroom = (Integer)userSession.getUserProperties().get("chatroom");
		Set<Session> chatroomUsers = getChatroom(chatroom);
		chatroomUsers.remove(userSession);
		System.out.println("OnClose");
	}
	@OnError
	public void handleError(Throwable t) {
		 System.err.println("Lỗi WebSocket:");
		    t.printStackTrace();
	}
	private String buildJsonData(int userId, String message,String avatar,Timestamp time,String Fullname,String Status) {
	    try {
	    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	        String timeString = sdf.format(time);
	        
	        JsonObject jsonObject = Json.createObjectBuilder()
	            .add("userId", userId)
	            .add("message", message)
	            .add("avatar", avatar)
	            .add("SentAt", timeString)
	            .add("FullName", Fullname)
	            .add("Status", Status)
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

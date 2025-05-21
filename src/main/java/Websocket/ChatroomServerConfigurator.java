package Websocket;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.*;

import UserModal.User;


public class ChatroomServerConfigurator extends ServerEndpointConfig.Configurator{
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request,HandshakeResponse response) {
		System.out.println("username cònigurator" + ((User) ((HttpSession) request.getHttpSession()).getAttribute("User")).getUserID())	;
		User user = (User) ((HttpSession) request.getHttpSession()).getAttribute("User");
		if (user != null) {
		    sec.getUserProperties().put("userId", user.getUserID());
		}
	}
	}
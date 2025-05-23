<%@page import="RoomModal.Room"%>
<%@page import="RoomModal.RoomBo"%>
<%@page import="RoomDetailModal.RoomDetail"%>
<%@page import="RoomDetailModal.RoomDetailBo"%>
<%@page import="UserModal.UserBo"%>
<%@page import="UserModal.User"%>
<%@page import="FriendshipModal.Friendship"%>
<%@page import="MessageModal.Message"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Message</title>
<!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Message.css">
</head>
<body>
	<%
	String check = (String)request.getAttribute("check");
	UserBo userbo = new UserBo();
	RoomDetailBo rdBo = new RoomDetailBo();
	RoomBo rBo = new RoomBo();
	User currentUser = (User)session.getAttribute("User");
	User user = new User();
	if(session.getAttribute("userFriend")!=null){
		user = (User)session.getAttribute("userFriend");
	}
	Room room = new Room();
	if(session.getAttribute("room")!=null){
		room = (Room)session.getAttribute("room");
	}
	int roomId=0;
	if(session.getAttribute("roomId")!=null){
		roomId = (int)session.getAttribute("roomId");
	}
	
	ArrayList<Message> dsMessage = (ArrayList<Message>)session.getAttribute("dsMessage"); 
	
	int indexMess = 0;
	if(session.getAttribute("dsMessage")!=null){
		indexMess = dsMessage.size();
	}
	
	ArrayList<Integer> dsRoomId = (ArrayList<Integer>)session.getAttribute("dsRoomId");
	int indexroomId = 0;
	if(session.getAttribute("dsRoomId")!=null){
		indexroomId = dsRoomId.size();
	}
	
	
	
	
//	ArrayList<Friendship> dsFriendshipIsFriend = (ArrayList<Friendship>)session.getAttribute("dsFriendshipIsFriend");
//	int indexUser = 0;
//	if(session.getAttribute("dsFriendshipIsFriend")!=null){
//		indexUser = dsFriendshipIsFriend.size();
//}
	%>
 	<%String homeActive = (String)session.getAttribute("homeActive"); %>
        <!-- Facebook Header -->
		<div class="fb-header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-3 d-flex align-items-center">
                       <img style="width: 50px; height: 50px" src="images/logo.avif" class="fs-1 me-2 text-primary">
                        <div class="position-relative">
                            <form action="SearchUser" method="get">
                            <input type="text" class="search-input ps-4" placeholder="Tìm kiếm người dùng" name="searchUser">
                            <button type="submit" style="position: absolute;top: 50%;right: 10px;
																				  transform: translateY(-50%);
																				  background: none;
																				  border: none;
																				  padding: 0;
																				  margin: 0;
																				  cursor: pointer;
																				  color: #333; /* hoặc text-primary */">
				                <i class="fas fa-search"></i> <!-- Font Awesome icon -->
				            </button>
                            </form>
                        </div>
                    </div>
                    <div id="homeParent" class="col-6 d-flex justify-content-center">
                        <div id="home" class="nav-icon <%= "home".equals(homeActive) ? "active" : "" %>" onclick="homeActive(this.id)"><i class="bi bi-house-door-fill"></i></div>
                        <div class="nav-icon"></div>
                        <div id="friend" class="nav-icon <%= "friend".equals(homeActive) ? "active" : "" %>" onclick="homeActive(this.id)"><i class="bi bi-people"></i></div>
                    </div>
                    <div class="col-3 d-flex justify-content-end align-items-center">
                        <a style="all:none;cursor: pointer; color: #333;" href="MessageController?message=1">
                            <div class="profile-icon me-2">
                            <i class="bi bi-messenger"></i>
                        	</div>
                        </a>
                        <div class="me-2">
                           
                        </div>
                        <div class="dropdown">						    
						      <div class="profile-icon dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i>
                        </div>	
						    <ul class="dropdown-menu">
						      <li><a class="dropdown-item" href="ProfileController">Trang cá nhân</a></li>
						      <li><a class="dropdown-item" href="#">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
                    </div>
                </div>
            </div>
		
<div class="container py-4">
  <div class="chat-container shadow"> 
    <!-- Sidebar - User List -->
    <div class="sidebar">
      <div class="p-3 border-bottom">
        <h5>Chat with</h5>
      </div>
    	<%if(indexroomId==0){ %>
    	<%}else{ 
    		for(int i = 0 ; i < indexroomId ; i++){
    			Room roomm = rBo.getRoomByRoomID(dsRoomId.get(i));
    			if(roomm.isIsGroup()){%>
    				<a style="text-decoration: none;color: inherit;" href="MessageController?roomId=<%=roomm.getRoomId()%>">
    				<div class="contact-item d-flex align-items-center">
			        	<img src="https://ui-avatars.com/api/?name=G&background=6f42c1&color=fff&bold=true" alt="Avatar" class="rounded-circle" width="40" height="40">
			        	<div class="contact-name"><%=roomm.getRoomName() %></div>
      				</div></a>
    			<%}else{
    				RoomDetail rd = rdBo.getRoomDetailByUserID_RoomID(dsRoomId.get(i), currentUser.getUserID());
    				User u = userbo.getUserById(rd.getUserID());
    			%>
    			<a style="text-decoration: none;color: inherit;" href="MessageController?id=<%=u.getUserID()%>"><div class="contact-item d-flex align-items-center">
				       <img src="<%=u.getAvatar() %>?img=2" alt="User 2">
				       <div class="contact-name"><%=u.getFullName() %></div>
		      	</div></a>
    			<%
    			}
    	%>
    	<%}
    		} %>
    	
    </div>

    <!-- Chat Area -->
    <div class="chat-main">
      <%if(check=="room"){ %>
	      <div class="chat-header">
	        <img src="https://ui-avatars.com/api/?name=G&background=6f42c1&color=fff&bold=true" alt="Avatar" class="rounded-circle" width="40" height="40">
	        <strong><%=room.getRoomName() %></strong>
	      </div>
      <%}else if(check=="userFriend") {%>
      	<div class="chat-header">
        <img src="<%=user.getAvatar() %>?img=1" width="40" height="40" class="rounded-circle">
        <strong><%=user.getFullName() %></strong>
      </div>
      <%} %>
      <div class="chat-messages" id="mess">
        <%if(indexMess==0){ %>
        <%}else{ 
        	for(int i = 0 ; i < indexMess ; i++){
        	%>
        	<div  style="display: flex; flex-direction: column;">
        	<%	if(dsMessage.get(i).getSenderID()==currentUser.getUserID()){
        %>
	        <div class="message sent" style="display:flex; justify-content: flex-end;">
	      
	      		<p style="text-align: justify;"><%=dsMessage.get(i).getContent() %></p>
	    
	        </div>
        <%}else{ %>
	         <div class="message received" style="display:flex; justify-content: flex-start;">
	           <p style="text-align: justify;"> <%=dsMessage.get(i).getContent() %></p>
	        </div>
        <%}%>
        </div>
        	<%	}
        	} %>
      </div>

      <%if(check=="message"){ %>
      <%}else{ %>
      <div class="chat-input">
        <input type="text" placeholder="Type a message..." id="messageText" autofocus="autofocus">
        <i class="bi bi-send-fill" onclick="sendMessage();" value="Send" ></i>
      </div>
      <%} %>
    </div>
    
  </div>
</div>
 
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
window.onload = function() {
	  var messElement = document.getElementById("mess");
	  messElement.scrollTop = messElement.scrollHeight;
	};
    var roomId = "<%=roomId%>";
    var websocket = new WebSocket("ws://localhost:8080/SocialMedia/chatroomServerEndpoint/" + roomId);
    websocket.onmessage = function processMessage(message) {
    	
    	const messElement = document.getElementById("mess");
      var jsonData = JSON.parse(message.data);
      if (jsonData.message != null)
        if(jsonData.userId===<%=currentUser.getUserID()%>){
        	messElement.insertAdjacentHTML("beforeend", "<div  style=\"display: flex; flex-direction: column;\"> <div class=\"message sent\" style=\"display:flex; justify-content: flex-end;\"> <p style=\"text-align: justify;\">" + jsonData.message + "</p> </div> </div>");
        }else{
        	messElement.insertAdjacentHTML("beforeend", "<div  style=\"display: flex; flex-direction: column;\"><div class=\"message received\" style=\"display:flex; justify-content: flex-start;\"> <p style=\"text-align: justify;\">" + jsonData.message + "</p> </div> </div>");
        }
      messElement.scrollTop = messElement.scrollHeight;
    };
    function sendMessage() {
    var messageText = document.getElementById("messageText");
      console.log(messageText.value);
      websocket.send(messageText.value);
      messageText.value = "";
    }
  </script>
</body>
</html>
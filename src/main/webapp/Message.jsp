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
	UserBo userbo = new UserBo();
	User currentUser = (User)session.getAttribute("User");
	User user = (User)session.getAttribute("userFriend");
	int roomId = (int)session.getAttribute("roomId");
	ArrayList<Friendship> dsFriendshipIsFriend = (ArrayList<Friendship>)session.getAttribute("dsFriendshipIsFriend");
	ArrayList<Message> dsMessage = (ArrayList<Message>)session.getAttribute("dsMessage"); 
	int indexUser = 0;
	if(session.getAttribute("dsFriendshipIsFriend")!=null){
		indexUser = dsFriendshipIsFriend.size();
	}
	int indexMess = 0;
	if(session.getAttribute("dsMessage")!=null){
		indexMess = dsMessage.size();
	}
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
                        <div class="profile-icon me-2">
                            <i class="bi bi-messenger"></i>
                        </div>
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
        <h5>Chats</h5>
      </div>
      <%if(indexUser==0){ %>
      <%}else{ 
      	for(int i = 0 ; i < indexUser ; i++){
      		 if(currentUser.getUserID()== dsFriendshipIsFriend.get(i).getReceiverID()){
  			   User x = userbo.getUserById(dsFriendshipIsFriend.get(i).getSenderID());
      	%>
	      	<div class="contact-item d-flex align-items-center">
		        <img src="<%=x.getAvatar() %>?img=2" alt="User 2">
		        <div class="contact-name"><%=x.getFullName() %></div>
      		</div>
      <%}else{
    	  User x = userbo.getUserById(dsFriendshipIsFriend.get(i).getReceiverID());
      %>
      	<div class="contact-item d-flex align-items-center">
		        <img src="<%=x.getAvatar() %>?img=2" alt="User 2">
		        <div class="contact-name"><%=x.getFullName() %></div>
      		</div>
      <%} %>
      	<%} 
      }%>
    </div>

    <!-- Chat Area -->
    <div class="chat-main">
      <div class="chat-header">
        <img src="<%=user.getAvatar() %>?img=1" width="40" height="40" class="rounded-circle">
        <strong><%=user.getFullName() %></strong>
      </div>
      <div class="chat-messages" id="mess">
        <%if(indexMess==0){ %>
        <%}else{ 
        	for(int i = 0 ; i < indexMess ; i++){
        	%>
        	<div style="display: flex; flex-direction: column;">
        	<%	if(dsMessage.get(i).getSenderID()==currentUser.getUserID()){
        %>
	        <div class="message sent" style="display:flex; justify-content: flex-end;">
	      		<p><%=dsMessage.get(i).getContent() %></p>
	        </div>
        <%}else{ %>
	         <div class="message received" style="display:flex; justify-content: flex-start;">
	          <%=dsMessage.get(i).getContent() %>
	        </div>
        <%}%>
        		</div>
        	<%	}
        	} %>
      </div>

      <div class="chat-input">
        <input type="text" placeholder="Type a message..." id="messageText">
        <i class="bi bi-send-fill" onclick="sendMessage();" value="Send" ></i>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var roomId = "<%=roomId%>";
    var websocket = new WebSocket("ws://localhost:8080/SocialMedia/chatroomServerEndpoint/" + roomId);
    websocket.onmessage = function processMessage(message) {
    	const messElement = document.getElementById("mess");
      var jsonData = JSON.parse(message.data);
      if (jsonData.message != null)
        if(jsonData.userId===<%=currentUser.getUserID()%>){
        	messElement.insertAdjacentHTML("beforeend", "<div class=\"message sent\">" + jsonData.message + "</div>");
          	console.log("hello"+`<div class="message sent">${jsonData.message} ${jsonData.userId}</div>`);
        }else{
        	messElement.insertAdjacentHTML("beforeend", "<div class=\"message received\">" + jsonData.message + "</div>");
          	console.log("hello"+`<div class="message sent">${jsonData.message} ${jsonData.userId}</div>`);
        }
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
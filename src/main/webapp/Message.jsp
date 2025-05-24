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
 	    <!-- Tom Select Bootstrap 5 CSS -->
    	<link href="https://cdn.jsdelivr.net/npm/tom-select/dist/css/tom-select.bootstrap5.min.css" rel="stylesheet" />
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
 
 <style >
/*Css button collapse*/
  .btn-no-border:focus,
  .btn-no-border:active {
    outline: none !important;
    box-shadow: none !important;
    border: none !important;
  }

  .chat-main {
    flex: 1;
    transition: margin-right 0.3s ease;
  }
/*Css sideBar*/
  #sidebar {
    position: absolute;
    top: 0;
    right: 0;
    height: 100%;
    width: 0;
    overflow: hidden;
    background-color: #f8f9fa;
    transition: width 0.3s ease;
    z-index: 50;
  }

  #sidebar.show {
    width: 250px;
    border-left: 1px solid #dee2e6;
  }

  .chat-container.shifted .chat-main {
    margin-right: 250px;
  }
    }</style>
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
	
	
	
	
	ArrayList<Friendship> dsFriendshipIsFriend = (ArrayList<Friendship>)session.getAttribute("dsFriendshipIsFriend");
	int indexUser = 0;
	if(session.getAttribute("dsFriendshipIsFriend")!=null){
		indexUser = dsFriendshipIsFriend.size();
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
		    	<!-- Modal tạo Group chat-->
    <div class="modal fade" id="createGroupModal" tabindex="-1" aria-labelledby="createGroupModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form id="createGroupForm" method="post" multipart/form-data>
            <div class="modal-header">
              <h5 class="modal-title" id="createGroupModalLabel">Tạo Group Chat</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                  <label for="groupName" class="form-label">Tên Phòng Chat</label>
                  <input type="text" class="form-control" id="groupName" name="groupName" placeholder="Nhập tên phòng" required />
              </div>
              <div class="mb-3">
                  <label for="usersSelect" class="form-label">Thêm Bạn Bè</label>
                   <%if(indexUser==0){ %>
                   	<select id="usersSelect" name="userIds" multiple placeholder="Vui lòng kết bạn để tạo phòng chat">
                  	</select>
                      <%}else{ %>
                  <select id="usersSelect" name="userIds" multiple placeholder="Chọn bạn bè...">
                     <%for(int i = 0 ; i < indexUser ; i++){
                    	 User u = new User();
                     	if(dsFriendshipIsFriend.get(i).getSenderID()==currentUser.getUserID()){
                     		 u = userbo.getUserById(dsFriendshipIsFriend.get(i).getReceiverID());
                     	}else{
                     		 u = userbo.getUserById(dsFriendshipIsFriend.get(i).getSenderID());
                     	}
                     %>
                     <option value="<%=u.getUserID()%>"><%=u.getFullName() %></option>
                     <%} %>
                  </select>
                  <%} %>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Create Group</button>
            </div>
          </form>
        </div>
      </div>
    </div>
<div class="container py-4" >
  <div class="chat-container shadow" style="position: relative;"> 
    <!-- Sidebar - User List -->
    <div class="sidebar">
      <div class="p-3 border-bottom d-flex justify-content-between align-items-center" id="headerSizebar">
        <h5>Chat with</h5>
        <button style="all: unset;cursor: pointer;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createGroupModal">
     		<i class="bi bi-people-fill me-4"></i>
    	</button>

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
    			<a style="text-decoration: none;color: inherit;" href="MessageController?id=<%=u.getUserID()%>">
    				<div class="contact-item d-flex align-items-center">
				       <img src="<%=u.getAvatar() %>?img=2" alt="User 2">
				       <div class="contact-name"><%=u.getFullName() %></div>
		      	</div>
		      	</a>
    			<%
    			}
    	%>
    	<%}
    		} %>
    	
    </div>

    <!-- Chat Area -->
    <div class="chat-main">
      <%if(check=="room"){ 
      	ArrayList<User> dsUserByRoomID = userbo.getUserByRoomID(room.getRoomId());
      %>
	      <div class="chat-header d-flex" >
	        <img src="https://ui-avatars.com/api/?name=G&background=6f42c1&color=fff&bold=true" alt="Avatar" class="rounded-circle" width="40" height="40">
	        <strong><%=room.getRoomName() %></strong>
			 <button id="toggleSidebarBtn" class="btn btn-light m-3 ms-auto">
			  ☰
			</button>
		 </div>
	  	<div id="sidebar">
			<div class="card card-body bg-light h-100"> 
			  <h5 style="text-align: center;"><%=room.getRoomName() %></h5> 
			  <!-- Nút để toggle danh sách thành viên -->
		<button class="btn mb-3 btn-no-border" type="button" data-bs-toggle="collapse" data-bs-target="#collapseMembers" aria-expanded="false" aria-controls="collapseMembers">
		  👥 Xem thành viên
		</button>
		<button class="btn mb-3 btn-no-border" type="button">
		  <i class="bi bi-person-plus-fill"></i>
		  Thêm thành viên
		</button>
<!-- Collapse chứa nguyên thẻ ul không đổi -->
<div class="collapse" id="collapseMembers">
  <ul class="nav flex-column"> 
    <% if (dsUserByRoomID.size() != 0) { 
         for (int i = 0; i < dsUserByRoomID.size(); i++) { %>
      <a href="ProfileController?id=<%= dsUserByRoomID.get(i).getUserID() %>" style="color: #333; text-decoration: none;">
        <div class="contact-item d-flex align-items-center">
          <img src="<%= dsUserByRoomID.get(i).getAvatar() %>?img=2" alt="User 2">
          <div class="contact-name"><%= dsUserByRoomID.get(i).getFullName() %></div>
        </div>		
      </a> 
    <% } 
       } %>
  </ul>
</div>
			</div>
		</div>
      <%}else if(check=="userFriend") {%>
      	<div class="chat-header">
        <img src="<%=user.getAvatar() %>?img=1" width="40" height="40" class="rounded-circle">
        <strong><%=user.getFullName() %></strong>
        <button id="toggleSidebarBtn" class="btn btn-light m-3 ms-auto d-none">
  ☰
</button>
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
	      
	      		<p class="mb-0" style="text-align: justify;"><%=dsMessage.get(i).getContent() %></p>
	    
	        </div>
        <%}else{ %>
	         <div class="message received" style="display:flex; justify-content: flex-start;">
	           <p class="mb-0" style="text-align: justify;"> <%=dsMessage.get(i).getContent() %></p>
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
<script src="https://cdn.jsdelivr.net/npm/tom-select/dist/js/tom-select.complete.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//Tom select
new TomSelect('#usersSelect', {
    plugins: ['remove_button'],
    maxItems: null, 
  });

//Gửi request cho tạo group
$(document).ready(function () {
	$('#createGroupForm').on('submit', function (e) {
		  e.preventDefault();
		  const formData = new FormData(this); // ✔️ Lấy đúng FormData
		  // Lấy dữ liệu cụ thể nếu cần debug
		  console.log('Group name:', formData.get('groupName'));
		  console.log('User IDs:', formData.getAll('userIds'));
			if(formData.getAll('userIds').length === 0){
				alert('Vui lòng chọn ít nhất một bạn bè để tạo nhóm!');
				  return; // Dừng submit
			}
		  $.ajax({
		    url: 'MessageController',
		    type: 'POST',
		    data: formData, // ✔️ Gửi FormData
		    processData: false, // ✔️ Không xử lý dữ liệu
		    contentType: false, // ✔️ Không đặt Content-Type (để browser tự set multipart/form-data)
			dataType: 'json',
		    success: function (response) {
		     
		      alert('Tạo group thành công!');
		      $('#createGroupModal').modal('hide');
		      var html = '<a style="text-decoration: none;color: inherit;" href="MessageController?roomId=' + 
		      response.roomId + '">' +
		    '<div class="contact-item d-flex align-items-center">' +
		      '<img src="https://ui-avatars.com/api/?name=G&background=6f42c1&color=fff&bold=true" alt="Avatar" class="rounded-circle" width="40" height="40">' +
		      '<div class="contact-name">' + response.roomName + '</div>' +
		    '</div>' +
		  '</a>';

		  $('#headerSizebar').after(html);
		    },
		    error: function (xhr, status, error) {
		      alert('Lỗi tạo nhóm: ' + error);
		    }
		  });
		});
  });

//gửi tin nhắn
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
        	messElement.insertAdjacentHTML("beforeend", "<div  style=\"display: flex; flex-direction: column;\"> <div class=\"message sent\" style=\"display:flex; justify-content: flex-end;\"> <p class=\"mb-0\" style=\"text-align: justify;\">" + jsonData.message + "</p> </div> </div>");
        }else{
        	messElement.insertAdjacentHTML("beforeend", "<div  style=\"display: flex; flex-direction: column;\"><div class=\"message received\" style=\"display:flex; justify-content: flex-start;\"> <p class=\"mb-0\" style=\"text-align: justify;\">" + jsonData.message + "</p> </div> </div>");
        }
      messElement.scrollTop = messElement.scrollHeight;
    };
    function sendMessage() {
    var messageText = document.getElementById("messageText");
      console.log(messageText.value);
      websocket.send(messageText.value);
      messageText.value = "";
    }
    
    
  //Thanh collapse
const toggleBtn = document.getElementById('toggleSidebarBtn');
  const sidebar = document.getElementById('sidebar');
  const container = document.querySelector('.chat-container');
  toggleBtn.addEventListener('click', () => {
    sidebar.classList.toggle('show');
    container.classList.toggle('shifted');
  });
  
  

  </script>
</body>
</html>
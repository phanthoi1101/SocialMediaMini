<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@page import="java.text.SimpleDateFormat"%>
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
 .file-preview, .image-preview {
      position: relative;
      background: #f1f3f5;
      border-radius: 10px;
      padding: 10px;
      display: flex;
      align-items: center;
      gap: 10px;
      max-width: 100%;
      font-size: 14px;
      margin-top: 5px;
    }

    .file-preview i {
      font-size: 20px;
    }
    .file-name {
      font-weight: 500;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .remove-file {
      position: absolute;
      top: 6px;
      right: 8px;
      background: transparent;
      border: none;
      font-size: 16px;
      cursor: pointer;
      color: #888;
    }

    .icon-btn {
      background: transparent;
      border: none;
      cursor: pointer;
      font-size: 20px;
    }

    a.download-link {
      text-decoration: none;
      color: #007bff;
    }

    a.download-link:hover {
      text-decoration: underline;
    }

    .preview-image {
      max-width: 100px;
      max-height: 80px;
      border-radius: 6px;
      object-fit: cover;
    }
/*Hover vô để hiện thời gian*/
.message.received p.time {
  display: none; /* Ẩn mặc định */
}
.message.received:hover p.time {
  display: block; /* Hiện khi hover vào div cha */
}
.message.sent p.time {
  display: none; /* Ẩn mặc định */
}

.message.sent:hover p.time {
  display: block; /* Hiện khi hover vào div cha */
}
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
	ArrayList<User> dsUserIsFriendNotHasGroupChat = userbo.UserIsFriendNotHasGroupChat(dsFriendshipIsFriend, userbo.getUserByRoomID(room.getRoomId()), currentUser.getUserID());
	%>
 	<%String homeActive = (String)session.getAttribute("homeActive"); %>
 	
 	
 	            
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
                  <label for="userSelect" class="form-label">Thêm Bạn Bè</label>
                   <%if(indexUser==0){ %>
                   	<select id="usersSelectCreate" name="userIds" multiple placeholder="Vui lòng kết bạn để tạo phòng chat">
                  	</select>
                      <%}else{ %>
                  <select id="usersSelectCreate" name="userIds" multiple placeholder="Chọn bạn bè...">
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
 	
 	
 	
 	<!-- Modal thêm thành viên cho group -->
 	<div style=" margin-top: 100px; " class="modal fade custom-modal" id="addMemberModal" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <form id="AddMemberServlet" method="post" enctype="multipart/form-data">
          <div class="modal-header">
            <h5 class="modal-title" id="addMemberModalLabel">Thêm thành viên</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
          </div>
          <input type="hidden" name="RoomId" value="<%=room.getRoomId()%>"/>
          <div class="modal-body">
            <label for="userSelect" class="form-label">Chọn thành viên</label>
            <select id="usersSelectAdd" name="userIds" multiple placeholder="Chọn bạn bè...">
              <%if(!dsUserIsFriendNotHasGroupChat.isEmpty()||dsUserIsFriendNotHasGroupChat!=null){
            	  for(int i = 0 ; i < dsUserIsFriendNotHasGroupChat.size();i++){%>
            		  <option value="<%=dsUserIsFriendNotHasGroupChat.get(i).getUserID()%>"><%=dsUserIsFriendNotHasGroupChat.get(i).getFullName() %></option>
            	  <%}

              }            	  %>
            </select>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="submit" class="btn btn-primary">Thêm</button>
          </div>
        </form>
      </div>
    </div>
    </div>
    
    
    
    
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
                        <div id="home" class="nav-icon" onclick="homeActive(this.id)"><i class="bi bi-house-door-fill"></i></div>
                        <div class="nav-icon"></div>
                        <div id="friend" class="nav-icon" onclick="homeActive(this.id)"><i class="bi bi-people"></i></div>
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
						      <li><a class="dropdown-item" href="ChangePasswordController">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
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
    		}%>
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
		 <button class="btn mb-3 btn-no-border" data-bs-toggle="modal" data-bs-target="#addMemberModal">
		    <i class="bi bi-person-plus-fill"></i>
		    Thêm thành viên
		  </button>
	 

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
        	SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        	SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        	String lastDate = "";
        	for(int i = 0 ; i < indexMess ; i++){
        		Timestamp currentDateObj = dsMessage.get(i).getSentAt();
        	    String currentDate = dateFormat.format(currentDateObj);
        	    String currentTime = timeFormat.format(currentDateObj);
        	    if(!currentDate.equals(lastDate)) {
        	%>
        	<div class="chat-date-separator" style="text-align:center; color:#666; margin:10px 0;">
		        <%= currentDate %>
		     </div>
		<%
		      lastDate = currentDate;
		    }
		%>
       <div  style="display: flex; flex-direction: column;">
        	<%	if(dsMessage.get(i).getSenderID()==currentUser.getUserID()){
        		User y = userbo.getUserById(dsMessage.get(i).getSenderID());
        %>
				<%if(dsMessage.get(i).getStatus().equals("text")){ %>
					<div class="message sent" style="display: flex; flex-direction: column; justify-content: flex-end;">
					  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0; align-self: flex-start;" >
					    <%= currentTime %>
					  </p>
					  <p class="mb-0" style="text-align: justify; margin: 0;">
					    <%= dsMessage.get(i).getContent() %>
					  </p>
					</div>
				<%}else if(dsMessage.get(i).getStatus().equals("file")){ %>
					<div class="message sent" style="display: flex; flex-direction: column; justify-content: flex-end;">
					  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0; align-self: flex-start;" >
					    <%= currentTime %>
					  </p>
					  <a style="text-decoration: none;color: #333" class="file-link" href="files/<%=dsMessage.get(i).getContent()%>" download>
					      📄 <%=dsMessage.get(i).getContent() %>
					   </a>
					</div>
				<%}else{ %>
					<div class="message sent" style="display: inline-flex; flex-direction: column; align-items: flex-start;">
					  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0;">
					    <%= currentTime %>
					  </p>
					  <img src="images/<%= dsMessage.get(i).getContent() %>" style="max-width: 300px; height: auto;">
					</div>
				<%} %>

        <%}else{ 
        	User y = userbo.getUserById(dsMessage.get(i).getSenderID());
        %>
        <p class="sender-name" style="text-align: left; margin: 0 0 4px 0;">
		  <%=y.getFullName()%>
		</p>
			<div style="display: flex; align-items: center;">
			  <img src="<%= y.getAvatar() %>" alt="Avatar" style="border-radius: 50%; width: 40px; height: 40px; margin-bottom: auto;">
			  <%if(dsMessage.get(i).getStatus().equals("text")){ %>
				 <div class="message received" style="display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;">
				  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0;">
				    <%= currentTime %>
				  </p>
				  <p class="mb-0" style="text-align: justify; margin: 0;">
				    <%= dsMessage.get(i).getContent() %>
				  </p>
				</div>
			  <%}else if(dsMessage.get(i).getStatus().equals("file")){ %>
				 <div class="message received" style="display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;">
				  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0;">
				    <%= currentTime %>
				  </p>
				  <a style="text-decoration: none;color: #333" class="file-link" href="files/<%=dsMessage.get(i).getContent()%>" download>
					      📄 <%=dsMessage.get(i).getContent() %>
				</a>
				</div>
			  <%}else{ %>
				  <div class="message received" style="display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;">
					  <p class="time" style="font-size: 0.75rem; color: gray; margin: 0 0 4px 0;">
					    <%= currentTime %>
					  </p>
					  <img src="images/<%= dsMessage.get(i).getContent() %>" style="max-width: 300px; height: auto;">
				</div>
			  <%} %>
		</div>
        <%}%>
        </div>
        	<%	}
        	} %>
      </div>
      <%if(check=="message"){ %>
      <%}else{ 
    	  Room z = new Room();
    	  if(session.getAttribute("roomId")!=null){
    		  int rz = (int)session.getAttribute("roomId");
    		  z = rBo.getRoomByRoomID(rz);
    	  }else if(session.getAttribute("userFriend")!=null){
    		  User ux = (User)session.getAttribute("userFriend");
    		  int m = rBo.selectRoomIdOf2User(ux.getUserID(), currentUser.getUserID());
    		  z = rBo.getRoomByRoomID(m); 
    	  }
      if(z.isStatus()){
      %>
      <div>
       	<div id="fileAttachment"></div>
  		<div class="chat-input">
	        <div style="width: 100%">
	        	<textarea  type="text" placeholder="Type a message..." id="messageText" style="width: 100%; border: 1px solid #ccc; " autofocus="autofocus"></textarea>
	         	<div id="filePreview"></div>
	        </div>
	        <label for="fileInput">
			  <i class="bi bi-paperclip file-icon" title="Đính kèm file"></i>
			</label>
			<input style="display: none;" type="file" id="fileInput" onchange="handleFile(event)">
	        <i class="bi bi-send-fill" onclick="sendMessage();" value="Send" ></i>
	    </div>
	   </div>
      <%} 
      }%>
      
    </div>
    
  </div>
</div>
 
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tom-select/dist/js/tom-select.complete.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//handle file
	let attachedFile = null;

  function isImage(file) {
    return file.type.startsWith("image/");
  }

  function handleFile(event) {
    const fileInput = event.target;
    const previewBox = document.getElementById('fileAttachment');
    previewBox.innerHTML = '';
    attachedFile = null;

    if (fileInput.files.length > 0) {
      const file = fileInput.files[0];
      attachedFile = file;

      const fileURL = URL.createObjectURL(file);
      const preview = document.createElement('div');
      preview.className = isImage(file) ? 'image-preview' : 'file-preview'; // thêm class cho thẻ div show thumnail ảnh

      const removeBtn = document.createElement('button');
      removeBtn.className = 'remove-file';
      removeBtn.innerHTML = '&times;';
      removeBtn.onclick = function () {
        attachedFile = null;
        previewBox.innerHTML = '';
        fileInput.value = '';
      };
      if (isImage(file)) {
        const img = document.createElement('img');
        img.src = fileURL;
        img.className = 'preview-image';
        preview.appendChild(img);
      } else {
        const icon = document.createElement('i');
        icon.className = 'bi bi-file-earmark-text';
        const name = document.createElement('span');
        name.className = 'file-name';
        name.textContent = file.name;

        preview.appendChild(icon);
        preview.appendChild(name);
      }

      preview.appendChild(removeBtn);
      previewBox.appendChild(preview);
    }
  }

  function sendMessage() {
	  const textInput = document.getElementById('messageText');
	  const previewBox = document.getElementById('fileAttachment');

	  if (textInput.value.trim() === '' && !attachedFile) return;

	  let messageData = {
	    status: '',
	    message: '',
	    fileName: '',
	    fileType: '',
	    fileData: ''
	  };

	  // Nếu có text
	  if (textInput.value.trim() !== '') {
	    messageData.status = 'text';
	    messageData.message = textInput.value;
	  }
	  // Nếu có file
	  if (attachedFile) {
		  const reader = new FileReader();
		  reader.onload = function () {
		    const base64Data = reader.result.split(',')[1]; // ✅ CHỈ LẤY phần base64 thuần
			console.log("phần 1"+reader.result.split(',')[0]);
		    let messageData = {
		      status: isImage(attachedFile) ? 'image' : 'file',
		      message: '',
		      fileName: attachedFile.name,
		      fileType: attachedFile.type,
		      fileData: base64Data
		    };
		    websocket.send(JSON.stringify(messageData));
			
		    // Reset giao diện
		    textInput.value = '';
		    document.getElementById('fileInput').value = '';
		    document.getElementById('fileAttachment').innerHTML = '';
		    attachedFile = null;
		  };

		  reader.readAsDataURL(attachedFile);
	  } else {
	    // Chỉ gửi text
	    websocket.send(JSON.stringify(messageData));
	    // Reset UI
	    textInput.value = '';
	    document.getElementById('fileInput').value = '';
	    document.getElementById('fileAttachment').innerHTML = '';
	    attachedFile = null;
	  }
	  console.log(messageData);
	}

  
  
//Tom select
new TomSelect('#usersSelectCreate', {
    plugins: ['remove_button'],
    maxItems: null, 
  });
new TomSelect('#usersSelectAdd', {
    plugins: ['remove_button'],
    maxItems: null, 
  });


//Home active
function homeActive(id){
	    		const icons = document.querySelectorAll('.nav-icon');
	    		icons.forEach(function (icon) {
					icon.classList.remove('active');
				});
	    		 // Thêm class 'active' vào thẻ có id được click
	    	    const activeElement = document.getElementById(id);
	    	    if (activeElement) {
	    	      activeElement.classList.add('active');
	    	    }
	    	    if(id==="home"){
	    	    	window.location.href = "HomePageController";
	    	    }
	    	    if(id==="friend"){
	    	    	window.location.href = "FriendController";
	    	    }
	    	}

//Gửi request cho thêm thành viên group
$(document).ready(function () {
	$('#AddMemberServlet').on('submit', function (e) {
		  e.preventDefault();
		  const formData = new FormData(this); // ✔️ Lấy đúng FormData
		  // Lấy dữ liệu cụ thể nếu cần debug
		  console.log('Group name:', formData.get('RoomId'));
		  console.log('User IDs:', formData.getAll('userIds'));
			if(formData.getAll('userIds').length === 0){
				alert('Vui lòng chọn bạn bè để thêm vào nhóm!');
				  return; // Dừng submit
			}
		  $.ajax({
		    url: 'AddMemBerController',
		    type: 'POST',
		    data: formData, // ✔️ Gửi FormData
		    processData: false, // ✔️ Không xử lý dữ liệu
		    contentType: false, // ✔️ Không đặt Content-Type (để browser tự set multipart/form-data)
			dataType: 'json',
		    success: function (response) {
		     
		      alert('Thêm thành công!');
		      $('#addMemberModal').modal('hide');
		    },
		    error: function (xhr, status, error) {
		      alert('Lỗi tạo nhóm: ' + error);
		    }
		  });
		});
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
        	if(jsonData.Status==="text"){
        		messElement.insertAdjacentHTML("beforeend",
          			  "<div style=\"display: flex; flex-direction: column;\">" +
          			    "<div class=\"message sent\" style=\"display: flex; flex-direction: column; justify-content: flex-end;\">" +
          			      "<p style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0; align-self: flex-start;\">" + jsonData.SentAt + "</p>" +
          			      "<p class=\"mb-0\" style=\"text-align: justify; margin: 0;\">" + jsonData.message + "</p>" +
          			    "</div>" +
          			  "</div>"
          			); 
        	}else if(jsonData.Status==="file"){
        		console.log("Đây là file nha mn");
        		messElement.insertAdjacentHTML("beforeend",
        				  "<div style=\"display: flex; flex-direction: column;\">" +
        				    "<div class=\"message sent\" style=\"display: flex; flex-direction: column; justify-content: flex-end;\">" +
        				      "<p style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0; align-self: flex-start;\">" + jsonData.SentAt + "</p>" +
        				      "<a href=\"files/" + jsonData.message + "\" download style=\"text-decoration: none; color: #333;\">" +
        				        "📄 " + jsonData.message +
        				      "</a>" +
        				    "</div>" +
        				  "</div>"
        				);
        	}else{
        		messElement.insertAdjacentHTML("beforeend",
        				  "<div style=\"display: flex; flex-direction: column;\">" +
        				    "<div class=\"message sent\" style=\"display: flex; flex-direction: column; justify-content: flex-end;\">" +
        				      "<p style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0; align-self: flex-start;\">" + jsonData.SentAt + "</p>" +
        				      "<img src=\"images/" + jsonData.message + "?v=" + new Date().getTime() + "\" style=\"max-width: 300px; height: auto;\">" +
        				    "</div>" +
        				  "</div>"
        				);
        	} 
        	}else{
        		if(jsonData.Status==="text"){
        			messElement.insertAdjacentHTML("beforeend",
            				  "<div style=\"display: flex; flex-direction: column;\">" +
            				    "<p class=\"sender-name\" style=\"text-align: left; margin: 0 0 4px 0;\">" +
            				      jsonData.FullName +
            				    "</p>" +
            				    "<div style=\"display: flex; align-items: center;\">" +
            				      "<img src=\"" + jsonData.avatar + "\" alt=\"\" style=\"border-radius: 50%; width: 40px; height: 40px;\">" +
            				      "<div class=\"message received\" style=\"display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;\">" +
            				        "<p class=\"time\" style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0;\">" +
            				          jsonData.SentAt +
            				        "</p>" +
            				        "<p class=\"mb-0\" style=\"text-align: justify; margin: 0;\">" +
            				          jsonData.message +
            				        "</p>" +
            				      "</div>" +
            				    "</div>" +
            				  "</div>"
            				);
        		}else if(jsonData.Status==="file"){
        			console.log("Đây là file");
        			messElement.insertAdjacentHTML("beforeend",
        				    "<div style=\"display: flex; flex-direction: column;\">" +
        				      "<p class=\"sender-name\" style=\"text-align: left; margin: 0 0 4px 0;\">" + jsonData.FullName + "</p>" +
        				      "<div style=\"display: flex; align-items: center;\">" +
        				        "<img src=\"" + jsonData.avatar + "\" alt=\"\" style=\"border-radius: 50%; width: 40px; height: 40px;\">" +
        				        "<div class=\"message received\" style=\"display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;\">" +
        				          "<p class=\"time\" style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0;\">" + jsonData.SentAt + "</p>" +
        				          "<a class=\"file-link\" href=\"files/" + jsonData.message + "\" download style=\"text-decoration: none; color: #333;\">" +
        				            "📄 " + jsonData.message +
        				          "</a>" +
        				        "</div>" +
        				      "</div>" +
        				    "</div>"
        				  );
        		}else{
        			messElement.insertAdjacentHTML("beforeend",
        				    "<div style=\"display: flex; flex-direction: column;\">" +
        				      "<p class=\"sender-name\" style=\"text-align: left; margin: 0 0 4px 0;\">" + jsonData.FullName + "</p>" +
        				      "<div style=\"display: flex; align-items: center;\">" +
        				        "<img src=\"" + jsonData.avatar + "\" alt=\"\" style=\"border-radius: 50%; width: 40px; height: 40px;\">" +
        				        "<div class=\"message received\" style=\"display: flex; flex-direction: column; justify-content: flex-end; margin-left: 8px;\">" +
        				          "<p class=\"time\" style=\"font-size: 0.75rem; color: gray; margin: 0 0 4px 0;\">" + jsonData.SentAt + "</p>" +
        				          "<img src=\"images/" + jsonData.message  + "\" style=\"max-width: 300px; height: auto;\">" +
        				        "</div>" +
        				      "</div>" +
        				    "</div>"
        				  );
        		}
        		
        }
      messElement.scrollTop = messElement.scrollHeight;
    };
    
//     function sendMessage() {
//     var messageText = document.getElementById("messageText");
//       console.log(messageText.value);
//       websocket.send(messageText.value);
//       messageText.value = "";
//     }
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
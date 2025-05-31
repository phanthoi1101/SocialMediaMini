<%@page import="FriendshipModal.FriendshipBo"%>
<%@page import="UserModal.UserBo"%>
<%@page import="FriendshipModal.Friendship"%>
<%@page import="PostsModal.Posts"%>
<%@page import="UserModal.User"%>
<%@page import="Post_UserModal.Post_User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="Layouts/ListFriendOfUser.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
        .dropdown-toggle::after{
        content:none;}
        </style>
</head>
<body> 
	<%
	FriendshipBo fBo = new FriendshipBo();
	User currentUser = (User)session.getAttribute("User");
	User userFriend = (User)request.getAttribute("userFriend");
	UserBo userBo = new UserBo();
	ArrayList<Friendship> dsFriendshipByUserId = (ArrayList<Friendship>)session.getAttribute("dsFriendshipById");
	int index = 0;
	if(session.getAttribute("dsFriendshipById")!=null){
		index= dsFriendshipByUserId.size();
	}
	String check="";
	check = fBo.checkFriendship(userFriend.getUserID(), currentUser.getUserID());
	
	%>
	    <!-- Navbar -->
     <%String homeActive = (String)session.getAttribute("homeActive"); %>
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
						      <li><a class="dropdown-item" href="ChangePasswordController">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
                    </div>
                </div>
            </div>
    <!-- Profile Header -->
    <div class="content-container">
    	<div class="profile-header">
        <div class="cover-photo">
	        <img alt="" src="<%=userFriend.getPhotoCover() %>" style="object-fit: cover;width: 100%;height: 100%;">
        </div>
        <div class="profile-info">
            <div class="profile-picture-container">
                <div class="profile-picture">
                <img alt="" src="<%=userFriend.getAvatar()%>" style="width: 100%;object-fit: cover;height: 100%;">
                </div>

            </div>
            <div class="profile-name-info">
                <h1 class="profile-name"><%=userFriend.getFullName() %></h1>
            </div>
            <%if(check.equals("xacnhan")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-primary me-5" name="xacnhan">Xác nhận kết bạn</button>
		            </form>
	         	</div>
            <%}else if(check.equals("huyyeucau")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-light me-5" name="huyyeucau">Huỷ yêu cầu</button>
		            </form>
	         	</div>
            <%}else if(check.equals("guiloimoi")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-primary me-5" name="thembanbe">Thêm bạn bè</button>
		            </form>
	         	</div>
            <%}else if(check.equals("huyketban")){ %>
            	<div class="profile-actions">
	                <form id="Unfriend" action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-danger" name="huyketban">Huỷ bạn bè</button>
		            </form>
		            <a href="MessageController?id=<%=userFriend.getUserID() %>" class="btn btn-primary me-5 ms-2">Nhắn tin</a>
	         	</div>
            <%} %>
        </div>
        <%String ProfileActive = "";
        if(session.getAttribute("ProfileActive")!=null){
        	ProfileActive = (String)session.getAttribute("ProfileActive");
        }
        %>
        <div class="profile-navigation">
            <form action="ProfileNavigation" style="display: flex ;gap: 16px;">
            <input type="hidden" name="profileUserId" value="<%=userFriend.getUserID()%>"/>
            <button name="baiVietFriend" style="all: unset;  cursor: pointer;"><div class="nav-item ">Bài viết</div></button>
            <button name="banBeFriend" style="all: unset;  cursor: pointer;"><div class="nav-item active">Bạn bè</div></button>
            <button name="anhFriend" style="all: unset;  cursor: pointer;"><div class="nav-item ">Anh</div></button>
            </form>
        </div>
    </div>
    </div>
	<!-- Danh sách ban; -->
	<div class="friends-container">
        <div class="friends-header">
            <h1 class="friends-title">Bạn bè</h1>
            <div class="friends-actions">
                <div class="search-bar">
                    <form action="ProfileNavigation" method="get">
                     	<input type="hidden" name="id" value="<%=userFriend.getUserID()%>">
                            <input type="text" class="search-input ps-4" placeholder="Tìm kiếm" name="SearchFriendFriend">
                            <button  type="submit" style="position: absolute;top: 50%;right: 10px;
																				  transform: translateY(-50%);
																				  background: none;
																				  border: none;
																				  padding: 0;
																				  margin: 0;
																				  cursor: pointer;
																				  color: #333; /* hoặc text-primary */">
				                <i class="fas fa-search"></i>
				            </button>
                            </form>
                </div>
                
                <div class="mx-4 px-4"></div>
            </div>
        </div>        
        <div class="friends-tabs">
        </div>
        <%if(index==0){ %>
        	<div class="text-center text-danger"><h3>Không có danh sách bạn bè!</h3></div>
        <%}else{ %>
        <div class="friends-list">
         <%for(int i =0 ; i < index ; i++){ 
        	 User user = new User();
         	if(dsFriendshipByUserId.get(i).getSenderID()==userFriend.getUserID()){
         		user = userBo.getUserById(dsFriendshipByUserId.get(i).getReceiverID());
         	}else{
         		user = userBo.getUserById(dsFriendshipByUserId.get(i).getSenderID());
         	}
         %>
         <div class="friend-item">
         <a href="ProfileController?id=<%=user.getUserID() %>" class="sidebar-item" style="all:unset;cursor:pointer;" >
                <div class="friend-avatar">
                    <img src="<%=user.getAvatar()%>?height=60&width=60" alt="<%=user.getFullName()%>">
                </div>
          </a>
          <a href="ProfileController?id=<%=user.getUserID() %>" class="sidebar-item" style="all:unset;cursor:pointer;">
                <div class="friend-info">
                    <div class="friend-name"><%=user.getFullName()%></div>
                </div>
				</a>
            </div>
         <%} %>
        <%} %>
   </div> 
    </div>
    
    
        <!-- Bootstrap JS Bundle with Popper -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
        //HomeActive
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
     // Khi click vào biểu tượng, kích hoạt input file
        document.querySelector('.composer-avatar').addEventListener('click', function() {
            document.getElementById('avatarInput').click();
        });
        // Tự động submit form khi chọn file
        document.getElementById('avatarInput').addEventListener('change', function() {
            document.getElementById('uploadFormAvatar').submit();
        });
    	/////////Ảnh bìa
        document.querySelector('.composer-photocover').addEventListener('click', function() {
            document.getElementById('photocoverInput').click();
        });
        // Tự động submit form khi chọn file
        document.getElementById('photocoverInput').addEventListener('change', function() {
            document.getElementById('uploadFormPhotoCover').submit();
        });
 </script>
</body>
</html>
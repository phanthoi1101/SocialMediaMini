<%@page import="FriendshipModal.FriendshipBo"%>
<%@page import="SearchUserModal.SearchUser"%>
<%@page import="UserModal.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search User</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="Layouts/SearchUser.css">
<body>
<!-- Header -->
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
						      <li><a class="dropdown-item" href="#">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
                    </div>
                </div>
            </div> 
<!-- Content -->
<%String searchUser = (String)request.getAttribute("searchUser") ;
FriendshipBo fbo = new FriendshipBo();
User currentUser = (User)session.getAttribute("User");
int index = 0;
	ArrayList<SearchUser> dsUserById = (ArrayList<SearchUser>)session.getAttribute("UserBySeach");
	if(session.getAttribute("UserBySeach")!=null){
		index = dsUserById.size();
	}
%>
	<div class="search-container">
        <!-- Profile 1 -->
        <%if(index==0){ %>
        	<div class="text-center text-danger"><h3>Không tìm thấy người dùng</h3></div>
        <%}else{ 
        	for(int  i = 0 ; i < index ; i++){
        		if(dsUserById.get(i).isIsFriend()){
        %>       
        <div class="profile-card">
            <div class="profile-avatar">
                <img src="<%=dsUserById.get(i).getAvatar() %>?height=60&width=60" alt="Phan Cảnh Luyện">
            </div>
            <div class="profile-info">
                <div class="profile-name"><%=dsUserById.get(i).getFullName() %></div>
                <div class="profile-meta">
                </div>
            </div>
            <div class="profile-actions">
            <a style="text-decoration: none;" href="MessageController?id=<%=dsUserById.get(i).getUserID()%>" class="fb-btn fb-btn-primary">Nhắn tin</a>
            </div>
        </div>
        <%}else if(fbo.userSent(currentUser.getUserID(), dsUserById.get(i).getUserID())){%>
        <!-- Profile 3 -->
	        <div class="profile-card">
	            <div class="profile-avatar">
	                <img src="<%=dsUserById.get(i).getAvatar() %>?height=60&width=60" alt="Phan Cảnh Tâm">
	            </div>
	            <div class="profile-info">
	                <div class="profile-name"><%=dsUserById.get(i).getFullName() %></div>
	                <div class="profile-meta">
	                </div>
	            </div>
	            <div class="profile-actions">
	                <form action="SearchController" method="get" style="all: unset;display: contents;">
	                		<input type="hidden" name="searchUser" value="<%=searchUser%>">
		                    <input type="hidden" name="userId" value="<%=dsUserById.get(i).getUserID()%>">
		                    <button class="fb-btn fb-btn-light" name="huyyeucau">Huỷ yêu cầu</button>
		            </form>
	            </div>
	        </div>
        <%}else if(fbo.IsSent(currentUser.getUserID(), dsUserById.get(i).getUserID())){ %>
        	<div class="profile-card">
	            <div class="profile-avatar">
	                <img src="<%=dsUserById.get(i).getAvatar() %>?height=60&width=60" alt="">
	            </div>
	            <div class="profile-info">
	                <div class="profile-name"><%=dsUserById.get(i).getFullName() %></div>
	                <div class="profile-meta">
	                </div>
	            </div>
	            <div class="profile-actions">
	                <form action="SearchUser" method="get" style="all: unset;display: contents;">
	                 		<input type="hidden" name="searchUser" value="<%=searchUser%>">
		                    <input type="hidden" name="userId" value="<%=dsUserById.get(i).getUserID()%>">
		                    <button class="fb-btn fb-btn-light" name="xacnhan">Xác nhận</button>
		            </form>
	            </div>
	        </div>
        <%} else{%>
        	<div class="profile-card">
	            <div class="profile-avatar">
	                <img src="<%=dsUserById.get(i).getAvatar() %>?height=60&width=60" alt="Phan Cảnh Tâm">
	            </div>
	            <div class="profile-info">
	                <div class="profile-name"><%=dsUserById.get(i).getFullName() %></div>
	                <div class="profile-meta">
	                </div>
	            </div>
	            <div class="profile-actions">
	                <form action="SearchUser" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=dsUserById.get(i).getUserID()%>">
		                    <input type="hidden" name="searchUser" value="<%=searchUser%>">
		                    <button class="fb-btn fb-btn-primary" name="thembanbe">Thêm bạn bè</button>
		            </form>
	            </div>
	        </div>
        <%}
        	}
        }%>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script >
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
    </script>
</body>
</html>
<%@page import="FriendshipModal.FriendshipBo"%>
<%@page import="UserModal.UserBo"%>
<%@page import="UserModal.User"%>
<%@page import="FriendshipModal.Friendship"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Friend</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap 5 Bundle JS (bao gồm cả Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Friends.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style >
        	.dropdown-toggle::after {
				    content: none; /* Hoặc không cần khai báo content */
			}
        </style>
</head>
<body>
<%
UserBo userBo = new UserBo();
FriendshipBo frdshipBo = new FriendshipBo();
User currentUser = (User)session.getAttribute("User");
ArrayList<Friendship> dsFriendshipSender = (ArrayList<Friendship>)session.getAttribute("dsFriendshipSender");
int sizeLstFriendSender = 0;	
if(dsFriendshipSender !=null && !dsFriendshipSender.isEmpty()){
		sizeLstFriendSender = dsFriendshipSender.size();
	}
ArrayList<User> lstIsNotFriend = (ArrayList<User>)session.getAttribute("dsIsNotFriend");
int sizeLstIsNotFriend = 0;
if(lstIsNotFriend!=null && !lstIsNotFriend.isEmpty()){
	sizeLstIsNotFriend = lstIsNotFriend.size();
}
%>
    
    <%@ include file="Layouts/FacebookHeader.jsp" %>
	
	<!-- Main Container -->
    <div class="fb-container">
        <!-- Sidebar -->
        <div class="fb-sidebar">
            <div class="fb-sidebar-title">
                <h2>Bạn bè</h2>
            </div>
            
            <ul class="fb-sidebar-menu">
            <a href="HomePageController" class="sidebar-item" style="text-decoration: none; /* Xoá gạch chân */      														color: inherit;">
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon">
                        <i class="bi bi-house-door-fill"></i>
                    </div>
                    	<div class="fb-sidebar-text">Trang chủ</div>

                </li>
                </a>
                <li class="fb-sidebar-item active">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-person-plus-fill"></i>
                    </div>
                    <div class="fb-sidebar-text">Lời mời kết bạn</div>
                    <div class="fb-sidebar-arrow">
                        <i class="bi bi-chevron-right"></i>
                    </div>
                </li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="fb-content">
            <div class="fb-content-header">
                <h3 class="fb-content-title">Lời mời kết bạn</h3>
            </div>
            
                <!-- Friend Request 1 -->
                <%if(sizeLstFriendSender==0){ %>
                	<div class="text-center text-danger"><h5>Không có yêu cầu kết bạn</h6></div>
                <%}else{ %>
                <div class="fb-requests-grid">
	                <%for(int i = 0 ; i < sizeLstFriendSender ; i++){ 
	                	User user = userBo.getUserById(dsFriendshipSender.get(i).getSenderID());
	                %>
	                <div class="fb-request-card">
	                    <a href="ProfileController?id=<%=user.getUserID()%>"><img src="<%=user.getAvatar()%>?height=200&width=200" alt="" class="fb-request-img"></a>
	                    <div class="fb-request-info">
	                        <div class="fb-request-name"><%=user.getFullName()%></div>
	                        <div class="fb-request-mutual">
	                        </div>
	                        <div class="fb-request-actions">
	                            <form action="FriendController" method="get" style="all: unset;display: contents;">
	                            	<input type="hidden" name="userId" value="<%=user.getUserID()%>">
	                            	<button class="fb-btn fb-btn-primary" name="xacnhan">Xác nhận</button>
	                            	<button class="fb-btn fb-btn-secondary" name="xoa">Xóa</button>	
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <%} %>
	                            </div>
                <%} %>

			<hr>
			<div class="fb-content-header">
                <h3 class="fb-content-title">Những người bạn có thể quen</h3>
            </div>
            
                <!-- Friend Request 1 -->
                <%if(sizeLstIsNotFriend==0){ %>
                	<div class="text-center text-danger"><h5>Không có gợi ý kết bạn</h6></div>
                <%}else{ %>
                <div class="fb-requests-grid">
	                <%for(int i = 0 ; i < sizeLstIsNotFriend ; i++){ 
	                	if(frdshipBo.checkFriendShip(currentUser.getUserID(), lstIsNotFriend.get(i).getUserID())){%>
	                		<div class="fb-request-card">
	                    <a href="ProfileController?id=<%=lstIsNotFriend.get(i).getUserID()%>"><img src="<%=lstIsNotFriend.get(i).getAvatar()%>?height=200&width=200" alt="" class="fb-request-img"></a>
	                    <div class="fb-request-info">
	                        <div class="fb-request-name"><%=lstIsNotFriend.get(i).getFullName()%></div>
	                        <div class="fb-request-mutual">
	                        </div>
	                        <div class="fb-request-actions">
	                            <form action="FriendController" method="get" style="all: unset;display: contents;">
	                            	<input type="hidden" name="userId" value="<%=lstIsNotFriend.get(i).getUserID()%>">
	                            	<button class="fb-btn fb-btn-default" name="huyyeucau">Huỷ yêu cầu</button>	
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                	<%}else{%>
	                <div class="fb-request-card">
	                    <a href="ProfileController?id=<%=lstIsNotFriend.get(i).getUserID()%>"><img src="<%=lstIsNotFriend.get(i).getAvatar()%>?height=200&width=200" alt="" class="fb-request-img"></a>
	                    <div class="fb-request-info">
	                        <div class="fb-request-name"><%=lstIsNotFriend.get(i).getFullName()%></div>
	                        <div class="fb-request-mutual">
	                        </div>
	                        <div class="fb-request-actions">
	                            <form action="FriendController" method="get" style="all: unset;display: contents;">
	                            	<input type="hidden" name="userId" value="<%=lstIsNotFriend.get(i).getUserID()%>">
	                            	<button class="fb-btn fb-btn-primary" name="thembanbe">Thêm bạn bè</button>	
	                            </form>
	                        </div>
	                    </div>
	                </div>
	                <%}
	                	}%>
	                            </div>
                <%} %>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script >
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
    </script>
</body>
</html>
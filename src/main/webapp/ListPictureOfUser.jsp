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
        <link rel="stylesheet" type="text/css" href="Layouts/Profile.css">>
</head>
<body> 
	<%User currentUser = (User)session.getAttribute("User");
	%>
	    <!-- Navbar -->
    <%@ include file="Layouts/FacebookHeader.jsp" %>

    <!-- Profile Header -->
		<div class="content-container">
    	<div class="profile-header">
        <div class="cover-photo">
	        <img alt="" src="<%=currentUser.getPhotoCover() %>" style="object-fit: cover;width: 100%;height: 100%;">
	        <form id="uploadFormPhotoCover" action="UploadPhotoCoverController" method="post" enctype="multipart/form-data">
		        <div class="add-cover-photo composer-photocover">
		             <i class="bi bi-camera"></i> Thêm ảnh bìa
		        </div>
		        <input type="file" id="photocoverInput" name="photoCover" accept="image/*" style="display: none;">
		</form>
        </div>
        <div class="profile-info">
            <div class="profile-picture-container">
                <div class="profile-picture">
                <img alt="" src="<%=currentUser.getAvatar()%>" style="width: 100%;object-fit: cover;height: 100%;">
                </div>
                <form id="uploadFormAvatar" action="UploadFileController" method="post" enctype="multipart/form-data">
			        <div class="add-profile-photo composer-avatar">
			             <i class="bi bi-camera-fill"></i>
			        </div>
			        <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;">
			    </form>
            </div>
            <div class="profile-name-info">
                <h1 class="profile-name"><%=currentUser.getUsername() %></h1>
                <div class="profile-friends">239 người bạn</div>
            </div>
            <div class="profile-actions">
                <button class="action-button secondary">
                    <i class="bi bi-pencil"></i> Chỉnh sửa trang cá nhân
                </button>
                <button class="action-button secondary">
                    <i class="bi bi-caret-down-fill"></i>
                </button>
            </div>
        </div>
        <div class="profile-navigation">
            <div class="nav-item active">Bài viết</div>
            <div class="nav-item">Bạn bè</div>
            <div class="nav-item">Ảnh</div>
            <div class="nav-item nav-more">
                <i class="bi bi-three-dots"></i>
            </div>
        </div>
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
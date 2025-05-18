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
        <link rel="stylesheet" type="text/css" href="Layouts/ListPicture.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
        .dropdown-toggle::after{
        content:none;}
        </style>
</head>
<body> 
	<%User currentUser = (User)session.getAttribute("User");
	ArrayList<Posts> dsPostByUserId = (ArrayList<Posts>)session.getAttribute("dsPostByUserId");
	int index = 0;
	if(session.getAttribute("dsPostByUserId")!=null){
		index = dsPostByUserId.size();
	}
	%>
	    <!-- Navbar -->
     <%String homeActive = (String)session.getAttribute("homeActive"); %>
        <div class="fb-header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-3 d-flex align-items-center">
                        <i class="bi bi-facebook text-primary fs-1 me-2"></i>
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
						      <li><a class="dropdown-item" href="#">Trang cá nhân</a></li>
						      <li><a class="dropdown-item" href="#">Đổi mật khẩu</a></li>
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
        <%String ProfileActive = "";
        if(session.getAttribute("ProfileActive")!=null){
        	ProfileActive = (String)session.getAttribute("ProfileActive");
        }
        %>
        <div class="profile-navigation">
            <form action="ProfileNavigation" style="display: flex ;gap: 16px;">
            <button name="baiViet" style="all: unset;  cursor: pointer;"><div class="nav-item <%= ProfileActive=="article" ? "active" : ""%>">Bài viết</div></button>
            <button name="banBe" style="all: unset;  cursor: pointer;"><div class="nav-item <%= ProfileActive=="friend" ? "active" : ""%>">Bạn bè</div></button>
            <button name="anh" style="all: unset;  cursor: pointer;"><div class="nav-item <%= ProfileActive=="photo" ? "active" : ""%>">Anh</div></button>
            </form>
            <div class="nav-item nav-more">
                <i class="bi bi-three-dots"></i>
            </div>
        </div>
    </div>
    </div>
    
    <!-- Content Ảnh của user -->
        <div class="photo-container">
        <div class="photo-header">
            <h2>Ảnh</h2>
            <div class="photo-tabs">
            </div>
        </div>
        <%if(index==0){ %>
        	<div class="photo-gird text-center text-danger">
        		<h3>Không có ảnh trong ambum</h3>
        	</div>
        <%}else{ %>
        <div class="photo-grid">
        	<%for(int i = 0 ; i < index ; i ++){ %>
        	<!-- Row 1 -->
            <div class="photo-item" data-photo-id="<%=i+1%>">
                <img src="<%=dsPostByUserId.get(i).getImage() %>?height=180&width=180" alt="Ảnh <%=i+1%>">
            </div>
        	<%} %>
            
            
        </div>
        <%} %>
    </div>

        
    
    <!-- Photo Modal -->
    <div class="modal fade photo-modal" id="photoModal" tabindex="-1" aria-labelledby="photoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="photoModalLabel">Ảnh của Phan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <img src="/placeholder.svg" alt="Ảnh đã chọn" class="photo-modal-img" id="modalImage">
                    <button class="photo-nav-btn photo-prev" id="prevPhoto">
                        <i class="bi bi-chevron-left"></i>
                    </button>
                    <button class="photo-nav-btn photo-next" id="nextPhoto">
                        <i class="bi bi-chevron-right"></i>
                    </button>
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
        
        
        //Content xử lý ảnh của user
        document.addEventListener('DOMContentLoaded', function () {
    const photoItems = Array.from(document.querySelectorAll('.photo-item'));
    const photoModal = new bootstrap.Modal(document.getElementById('photoModal'));
    const modalImage = document.getElementById('modalImage');
    const prevButton = document.getElementById('prevPhoto');
    const nextButton = document.getElementById('nextPhoto');

    let currentIndex = 0;

    // Khi click vào ảnh, mở modal và hiển thị ảnh tương ứng
    photoItems.forEach((item, index) => {
        item.addEventListener('click', function () {
            currentIndex = index;
            updateModalImage();
            photoModal.show();
        });
    });

    // Hàm cập nhật ảnh trong modal
    function updateModalImage() {
        const selectedItem = photoItems[currentIndex];
        const img = selectedItem.querySelector('img');
        modalImage.src = img.src;
        modalImage.alt = img.alt;
    }

    // Nút prev
    prevButton.addEventListener('click', function () {
        currentIndex = (currentIndex - 1 + photoItems.length) % photoItems.length;
        updateModalImage();
    });

    // Nút next
    nextButton.addEventListener('click', function () {
        currentIndex = (currentIndex + 1) % photoItems.length;
        updateModalImage();
    });
});
        </script>
</body>
</html>
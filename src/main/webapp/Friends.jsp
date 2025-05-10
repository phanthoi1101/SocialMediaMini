<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Friend</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Friends.css">
</head>
<body>
	<%@ include file="Layouts/FacebookHeader.jsp"%>
	
	<!-- Main Container -->
    <div class="fb-container">
        <!-- Sidebar -->
        <div class="fb-sidebar">
            <div class="fb-sidebar-title">
                <h2>Bạn bè</h2>
                <div class="fb-sidebar-settings">
                    <i class="bi bi-gear-fill"></i>
                </div>
            </div>
            
            <ul class="fb-sidebar-menu">
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon">
                        <i class="bi bi-house-door-fill"></i>
                    </div>
                    <a href="HomePageController" class="sidebar-item" style="text-decoration: none; /* Xoá gạch chân */ 
                    														color: inherit;">
                    	<div class="fb-sidebar-text">Trang chủ</div>
                    </a>
                </li>
                <li class="fb-sidebar-item active">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-person-plus-fill"></i>
                    </div>
                    <div class="fb-sidebar-text">Lời mời kết bạn</div>
                    <div class="fb-sidebar-arrow">
                        <i class="bi bi-chevron-right"></i>
                    </div>
                </li>
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-chat-left-text-fill"></i>
                    </div>
                    <div class="fb-sidebar-text">Gợi ý</div>
                    <div class="fb-sidebar-arrow">
                        <i class="bi bi-chevron-right"></i>
                    </div>
                </li>
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="fb-sidebar-text">Tất cả bạn bè</div>
                    <div class="fb-sidebar-arrow">
                        <i class="bi bi-chevron-right"></i>
                    </div>
                </li>
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-gift-fill"></i>
                    </div>
                    <div class="fb-sidebar-text">Sinh nhật</div>
                </li>
                <li class="fb-sidebar-item">
                    <div class="fb-sidebar-icon gray">
                        <i class="bi bi-list-ul"></i>
                    </div>
                    <div class="fb-sidebar-text">Danh sách tùy chỉnh</div>
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
                <a href="#" class="fb-content-link">Xem tất cả</a>
            </div>
            
            <div class="fb-requests-grid">
                <!-- Friend Request 1 -->
                <%for(int i = 0 ; i < 15 ; i++){ %>
                <div class="fb-request-card">
                    <img src="https://anhnail.com/wp-content/uploads/2024/10/Hinh-gai-xinh-k8-cute.jpg?height=200&width=200" alt="Phan Đình Quốc" class="fb-request-img">
                    <div class="fb-request-info">
                        <div class="fb-request-name">Phan Đình Quốc</div>
                        <div class="fb-request-mutual">
                            <div class="fb-request-mutual-icon">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            4 bạn chung
                        </div>
                        <div class="fb-request-actions">
                            <button class="fb-btn fb-btn-primary">Xác nhận</button>
                            <button class="fb-btn fb-btn-secondary">Xóa</button>
                        </div>
                    </div>
                </div>
                <%} %>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
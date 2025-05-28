<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Change Password</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<style >
	:root {
            --fb-bg: #f0f2f5;
            --fb-blue: #1877f2;
            --fb-text: #65676b;
            --fb-hover: #e4e6e9;
            --fb-border: #dddfe2;
        }
        
        body {
            background-color: var(--fb-bg);
            font-family: Helvetica, Arial, sans-serif;
        }
        /* Facebook header */
            .fb-header {
                background-color: white;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
                padding: 8px 16px;
            }
            
            .fb-logo {
                color: var(--fb-blue);
                font-size: 40px;
            }
            
            .search-input {
                background-color: var(--fb-bg);
                border-radius: 50px;
                padding: 8px 16px;
                width: 240px;
                border: none;
            }
            
            .nav-icon {
                color: #65676b;
                font-size: 20px;
                padding: 10px 40px;
                border-bottom: 3px solid transparent;
            }
            
            .nav-icon.active {
                color: var(--fb-blue);
                border-bottom: 3px solid var(--fb-blue);
            }
            
            .profile-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #ddd;
                display: flex;
                align-items: center;
                justify-content: center;
            }           
	</style>
</head>
<body class="bg-light">
<!-- Header  -->
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
            
            <!-- Main -->
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow rounded-4">
        <div class="card-body">
          <h3 class="text-center mb-4">Đổi mật khẩu</h3>

          <!-- Old Password -->
          <div class="mb-3">
            <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
            <input type="password" class="form-control" id="oldPassword" placeholder="Enter old password">
          </div>

          <!-- New Password -->
          <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới</label>
            <input type="password" class="form-control" id="newPassword" placeholder="Enter new password">
          </div>

          <!-- Confirm New Password -->
          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới</label>
            <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm new password">
          </div>

          <!-- Submit Button -->
          <div class="d-grid">
            <button class="btn btn-success" onclick="changePassword()">Đổi mật khẩu</button>
          </div>

          <!-- Status Message -->
          <div id="status" class="mt-3 text-center"></div>

        </div>
      </div>
    </div>
  </div>
</div>
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

  function changePassword() {
    const oldPass = document.getElementById("oldPassword").value;
    const newPass = document.getElementById("newPassword").value;
    const confirmPass = document.getElementById("confirmPassword").value;
    const status = document.getElementById("status");

    if (!oldPass || !newPass || !confirmPass) {
      status.innerHTML = `<div class="text-danger">Please fill in all fields.</div>`;
      return;
    }

    if (newPass !== confirmPass) {
      status.innerHTML = `<div class="text-danger">New passwords do not match.</div>`;
      return;
    }

    // Giả lập thành công
    status.innerHTML = `<div class="text-success">Password changed successfully!</div>`;
  }
</script>

</body>
</html>
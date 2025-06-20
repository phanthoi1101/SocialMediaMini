<%@page import="UserModal.User"%>
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
						      <li><a class="dropdown-item" href="ChangePasswordController">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
                    </div>
                </div>
            </div>
  
  <%User currentUser = (User)session.getAttribute("User"); %>          
            <!-- Main -->
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow rounded-4">
        <div class="card-body">
          <h3 class="text-center mb-4">Đổi mật khẩu</h3>

          <!-- STEP 1: Hiển thị email và gửi OTP -->
          <div id="step1">
            <div class="mb-3">
              <div class="text-center"><label class="form-label">Xác nhận gửi mã OTP để tiếp tục</label></div>
              <input id="email" type="email" class="form-control" value="<%=currentUser.getEmail() %>" readonly>
            </div>
            <div class="d-grid">
              <button class="btn btn-primary" onclick="goToStep2()">Gửi mã OTP</button>
            </div>
          </div>

          <!-- STEP 2: Nhập OTP -->
          <div id="step2" class="d-none">
            <div class="mb-3">
              <label for="otpCode" class="form-label">Nhập mã OTP</label>
              <input type="text" class="form-control" id="otpCode" placeholder="Nhập mã xác nhận">
            </div>
            <div class="d-grid">
              <button class="btn btn-success" onclick="goToStep3()">Xác nhận</button>
            </div>
          </div>

          <!-- STEP 3: Đổi mật khẩu -->
          <div id="step3" class="d-none">
            <div class="mb-3">
              <label for="newPassword" class="form-label">Mật khẩu mới</label>
              <input type="password" class="form-control" id="newPassword" placeholder="Nhập mật khẩu mới">
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
              <input type="password" class="form-control" id="confirmPassword" placeholder="Nhập lại mật khẩu mới">
            </div>
            <div class="mb-3 text-center text-danger">
              <label id="errorChange" for="confirmPassword" class="form-label d-none"></label>
            </div>
            <div class="d-grid">
              <button class="btn btn-danger" onclick="ChangePassword()">Đổi mật khẩu</button>
            </div>
          </div>

          <!-- Status -->
          <div id="status" class="text-center text-danger mt-3"></div>

        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//Đổi mật khẩu
function goToStep2() {
	let email = document.getElementById("email").value;
	$.ajax({
	    url: "SendOtpService",
	    method: "POST",
	    data: {
	        email: email // gửi dữ liệu email
	    },
	    success: function(response) {
	        console.log("OTP sent successfully:", response);
	    },
	    error: function(xhr, status, error) {
	        console.error("Error sending OTP:", error);
	    }
	});
    document.getElementById("step1").classList.add("d-none");
    document.getElementById("step2").classList.remove("d-none");
    localStorage.setItem('changePassStep', '2');
  }

  function goToStep3() {
    const otp = document.getElementById("otpCode").value;
    if (otp.trim() === "") {
      document.getElementById("status").textContent = "Vui lòng nhập mã OTP.";
      return;
    }
    $.ajax({
	    url: "ChangePasswordController",
	    method: "POST",
	    data: {
	    	otp: otp // gửi dữ liệu email
	    },
	    success: function(response) {
	    	if(response.status==="success"){
	    		document.getElementById("status").textContent = "";
		        document.getElementById("step2").classList.add("d-none");
		        document.getElementById("step3").classList.remove("d-none");
		        localStorage.setItem('changePassStep', '3');
	    	}else {
	    		alert(response.message);
	    		document.getElementById("step2").classList.add("d-none");
	    		document.getElementById("step1").classList.remove("d-none");
	    		localStorage.setItem('changePassStep', '1');
	    	}
	    },
	    error: function(xhr, status, error) {
	        console.error("Error sending OTP:", error);
	    }
	});
    
  }
  function ChangePassword() {
	  const newPasswordInput = document.getElementById("newPassword");
	  const confirmPasswordInput = document.getElementById("confirmPassword");
	  const errorLabel = document.getElementById("errorChange");

	  const newPassword = newPasswordInput.value.trim();
	  const confirmPassword = confirmPasswordInput.value.trim();

	  // Reset trạng thái lỗi
	  errorLabel.classList.add("d-none");
	  errorLabel.textContent = "";
	  newPasswordInput.classList.remove("is-invalid");
	  confirmPasswordInput.classList.remove("is-invalid");

	  // Validate: không để trống
	  if (!newPassword || !confirmPassword) {
	    errorLabel.textContent = "Vui lòng nhập đầy đủ mật khẩu.";
	    errorLabel.classList.remove("d-none");
	    newPasswordInput.classList.add("is-invalid");
	    confirmPasswordInput.classList.add("is-invalid");
	    return;
	  }

	  // Validate: độ dài tối thiểu
	  if (newPassword.length < 5) {
	    errorLabel.textContent = "Mật khẩu phải có ít nhất 5 ký tự.";
	    errorLabel.classList.remove("d-none");
	    newPasswordInput.classList.add("is-invalid");
	    return;
	  }

	  // Validate: mật khẩu trùng khớp
	  if (newPassword !== confirmPassword) {
	    errorLabel.textContent = "Mật khẩu không trùng khớp!";
	    errorLabel.classList.remove("d-none");
	    confirmPasswordInput.classList.add("is-invalid");
	    return;
	  }

	  // Nếu hợp lệ, gọi Ajax
	  $.ajax({
	    url: "ChangePasswordController",
	    method: "POST",
	    data: {
	      Password: newPassword,
	    },
	    success: function(response) {
	      alert(response.message || "Đổi mật khẩu thành công!");
	      window.location.href = "HomePageController";
	    },
	    error: function(xhr, status, error) {
	      console.error("Lỗi:", error);
	      errorLabel.textContent = "Có lỗi xảy ra. Vui lòng thử lại sau.";
	      errorLabel.classList.remove("d-none");
	    }
	  });
	}
  
  //Load lại trang
//   function loadStep() {
// 	  let step = localStorage.getItem('changePassStep') || '1';
// 	  // Ẩn hết các step
// 	  document.getElementById("step1").classList.add("d-none");
// 	  document.getElementById("step2").classList.add("d-none");
// 	  document.getElementById("step3").classList.add("d-none");

// 	  // Hiện step đúng
// 	  document.getElementById("step" + step).classList.remove("d-none");
// 	}

// 	// Gọi hàm loadStep khi trang được load
// 	window.onload = loadStep;



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

</script>

</body>
</html>
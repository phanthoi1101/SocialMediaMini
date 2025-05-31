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
	</style>
</head>
<body class="bg-light">
        
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
              <label for="email" class="form-label">Email của bạn</label>
              <input type="email" class="form-control" id="email" placeholder="Nhập email đã đăng ký">
              <div id="email-error" class="text-danger mt-1" style="display:none;">Email không hợp lệ.</div>
            </div>
            <div class="d-grid">
              <button id="otpBtn" class="btn btn-primary" onclick="goToStep2()">Gửi mã OTP</button>
           </div>
           <div id="loadingSpinner" class="text-center my-2 d-none">
				  <div class="spinner-border text-primary" role="status">
				    <span class="visually-hidden">Loading...</span>
				  </div>
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
  const emailInput = document.getElementById("email");
  const email = emailInput.value.trim();
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const errorDiv = document.getElementById("email-error");
  const spinner = document.getElementById("loadingSpinner");
  const otpBtn = document.getElementById("otpBtn");

  // Reset trạng thái cũ
  emailInput.classList.remove("is-invalid");
  if (errorDiv) errorDiv.style.display = "none";

  // Kiểm tra định dạng email
  if (!emailRegex.test(email)) {
    emailInput.classList.add("is-invalid");
    if (errorDiv) {
      errorDiv.innerText = "Email không hợp lệ. Vui lòng kiểm tra lại.";
      errorDiv.style.display = "block";
    }
    return;
  }

  // Hiện spinner và disable nút
  spinner.classList.remove("d-none");
  otpBtn.disabled = true;

  // Gửi OTP qua AJAX
  $.ajax({
    url: "SendOtpService",
    method: "POST",
    data: { email: email },
    success: function (response) {
      console.log("OTP sent successfully:", response);

      // Ẩn spinner, enable lại nút
      spinner.classList.add("d-none");
      otpBtn.disabled = false;

      // Chuyển sang bước tiếp theo
      document.getElementById("step1").classList.add("d-none");
      document.getElementById("step2").classList.remove("d-none");
      localStorage.setItem('changePassStep', '2');
    },
    error: function (xhr, status, error) {
      console.error("Lỗi khi gửi OTP:", error);

      // Ẩn spinner, enable lại nút
      spinner.classList.add("d-none");
      otpBtn.disabled = false;

      if (errorDiv) {
        emailInput.classList.add("is-invalid");
        errorDiv.innerText = "Gửi OTP thất bại. Vui lòng thử lại.";
        errorDiv.style.display = "block";
      }
    }
  });
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
	    	}else {
	    		alert(response.message);
	    		document.getElementById("step2").classList.add("d-none");
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
	    url: "ForgotPasswordController",
	    method: "POST",
	    data: {
	      Password: newPassword,
	    },
	    success: function(response) {
	      alert(response.message || "Đổi mật khẩu thành công!");
	      window.location.href = "DangNhapController";
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


</script>

</body>
</html>
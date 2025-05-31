<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký tài khoản</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f0f8ff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .register-box {
      background-color: #ffffff;
      padding: 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
      width: 100%;
      max-width: 500px;
    }

    .register-title {
      color: #007BFF;
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .form-label {
      font-weight: 500;
    }
  </style>
</head>
<body>
	<%String checkUsername = (String)request.getAttribute("checkUsername"); 
	int checkDangKy =0;
		if(request.getAttribute("checkDangKy")!=null){
			 checkDangKy = (int)request.getAttribute("checkDangKy");
		}
	%>
  <div class="register-box">
    <h3 class="register-title">Đăng Ký Tài Khoản</h3>
    <%if(checkUsername!=null){ %>
		<div class="alert alert-warning mt-4 text-center">
		 	<%=checkUsername %>
		</div>
		<%} %>
    <form action="DangKyController" id="registerForm" onsubmit="return validateForm(event)" > <!-- enctype="multipart/form-data" -->
      <div class="">
        <label for="fullname" class="form-label">Họ và tên</label>
        <input type="text" class="form-control" id="fullname" name="fullname">
        <div class="invalid-feedback">Vui lòng nhập họ và tên (ít nhất 2 ký tự).</div>
      </div>
      <div class="mt-3">
        <label for="username" class="form-label">Tên đăng nhập</label>
        <input type="text" class="form-control" id="username" name="username" >
        <div id="username-feedback" class="invalid-feedback"></div>
      </div>
      <div class="mt-3">
        <label for="email" class="form-label">Email</label>
        <input class="form-control" id="email" name="email" >
        <div id="email-feedback" class="invalid-feedback"></div>
      </div>

      <div class="mt-3">
        <label for="password" class="form-label">Mật khẩu</label>
        <input type="password" class="form-control" id="password" name="password" >
        <div class="invalid-feedback">Mật khẩu phải từ 5 ký tự trở lên.</div>
      </div>

      <div class="d-grid mt-3">
        <button type="submit" class="btn btn-primary">Đăng ký</button>
      </div>
      <%if(checkDangKy>0){ %>
      	<div class="alert alert-success mt-3">
		  <strong>Success!</strong> Vui lòng nhấn đăng nhập để tiếp tục.
		</div>
      <%} %>
      <div class="d-grid mt-4">
        <a href="DangNhapController" class="btn btn-default">Đăng nhập</a>
      </div>
    </form>
  </div>
  
 <script>
 async function validateForm(event) {
	  event.preventDefault(); // chặn submit tạm thời
	  let isValid = true;

	  // Họ và tên
	  const fullName = document.getElementById("fullname");
	  if (fullName.value.trim().length < 2) {
	    fullName.classList.add("is-invalid");
	    isValid = false;
	  } else {
	    fullName.classList.remove("is-invalid");
	  }

	  // Username
	  const username = document.getElementById("username");
	  const usernameFeedback = document.getElementById("username-feedback");
	  const usernameRegex = /^[a-zA-Z0-9]{4,20}$/;
	  const usernameValue = username.value.trim();
	  if (!usernameRegex.test(usernameValue)) {
	    username.classList.add("is-invalid");
	    usernameFeedback.innerText = "Tên đăng nhập phải từ 4-20 ký tự, không có ký tự đặc biệt.";
	    isValid = false;
	  } else {
	    const usernameResult = await fetch("DangKyController", {
	      method: "POST",
	      headers: { "Content-Type": "application/x-www-form-urlencoded" },
	      body: "checkUsername=" + encodeURIComponent(usernameValue)
	    }).then(res => res.text());

	    if (usernameResult === "exist") {
	      username.classList.add("is-invalid");
	      usernameFeedback.innerText = "Username đã tồn tại.";
	      isValid = false;
	    } else {
	      username.classList.remove("is-invalid");
	      usernameFeedback.innerText = "";
	    }
	  }

	  // Email
	  const email = document.getElementById("email");
	  const emailFeedback = document.getElementById("email-feedback");
	  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	  const emailValue = email.value.trim();
	  if (!emailRegex.test(emailValue)) {
	    email.classList.add("is-invalid");
	    emailFeedback.innerText = "Vui lòng nhập email hợp lệ.";
	    isValid = false;
	  } else {
	    const emailResult = await fetch("DangKyController", {
	      method: "POST",
	      headers: { "Content-Type": "application/x-www-form-urlencoded" },
	      body: "checkEmail=" + encodeURIComponent(emailValue)
	    }).then(res => res.text());

	    if (emailResult === "exist") {
	      email.classList.add("is-invalid");
	      emailFeedback.innerText = "Email đã tồn tại.";
	      isValid = false;
	    } else {
	      email.classList.remove("is-invalid");
	      emailFeedback.innerText = "";
	    }
	  }

	  // Mật khẩu
	  const password = document.getElementById("password");
	  if (password.value.length < 5) {
	    password.classList.add("is-invalid");
	    isValid = false;
	  } else {
	    password.classList.remove("is-invalid");
	  }

	  // Nếu hợp lệ thì submit form
	  if (isValid) {
	    document.getElementById("registerForm").submit();
	  }
	}
    
  </script>
</body>
</html>

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
    <form action="DangKyController" method="post" > <!-- enctype="multipart/form-data" -->
      <div class="">
        <label for="fullname" class="form-label">Họ và tên</label>
        <input type="text" class="form-control" id="fullname" name="fullname" required>
      </div>
      <div class="mt-3">
        <label for="username" class="form-label">Tên đăng nhập</label>
        <input type="text" class="form-control" id="username" name="username" required>
      </div>
      <div class="mt-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>

      <div class="mt-3">
        <label for="password" class="form-label">Mật khẩu</label>
        <input type="password" class="form-control" id="password" name="passwordHash" required>
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

</body>
</html>

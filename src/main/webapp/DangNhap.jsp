<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f0f8ff;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .login-box {
      background-color: #ffffff;
      padding: 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
      width: 100%;
      max-width: 400px;
    }

    .login-title {
      color: #007BFF;
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .forgot-link {
      text-align: right;
    }
  </style>
</head>
<body>
<%String message = (String)request.getAttribute("message"); %>
  <div class="login-box">
    <h3 class="login-title">Đăng Nhập</h3>
    <form action="DangNhapController" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Tên đăng nhập</label>
        <input type="text" class="form-control" id="username" name="username" required autofocus>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Mật khẩu</label>
        <input type="password" class="form-control" id="password" name="password" required>
      </div>
		<%if(message!=null){%>
			<div class="text-center text-danger mb-4" style="font-size: 14px"><%=message %></div>
		<% }%>
      <div class="d-grid">
        <button type="submit" class="btn btn-primary">Đăng nhập</button>
      </div>
		
      <div class="forgot-link mt-3">
        <a href="DangKyController" class="text-primary ">Đăng ký
      </div>

      <!-- Thông báo lỗi nếu có -->

    </form>
  </div>

</body>
</html>

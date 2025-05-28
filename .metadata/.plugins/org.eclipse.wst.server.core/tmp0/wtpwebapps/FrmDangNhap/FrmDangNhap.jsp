<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="Style.css">
</head>
<body style="background-color: #0459ae;">
	<div class="slider mx-auto">
	<form style="background-color: white;"  class="from-slider mx-auto border border-info-subtle border-5" action="FrmDangNhap.jsp" method="get">
			<%String tendn="";
			String mk="";	
		  tendn = request.getParameter("txtTenDn");
		  mk = request.getParameter("txtMk");
		  if(tendn==null)
			  tendn="";
		  if(mk==null)
			  mk="";
		  if(tendn.equals("abc") && mk.equals("123")){
			  response.sendRedirect("http://ums.husc.edu.vn");
		  }
		  else {
		  }
		%>
			<img class="logo-img" alt="" src="https://student.husc.edu.vn/Themes/Login/images/logo-small.png">
			<h1 class="mb-2 pt-4" style="color: #25258e; padding-left: 20px;">SINH VIÊN:</h1>
			<span style="display: flex;margin-left: 20px;margin-bottom: 5px;font-weight: bold;">Mã sinh viên</span>
			<input class="tendn mb-2 border border-light-subtle border-3" style="border-radius:5px; text-indent: 10px;width: 270px;display:flex; position: relative; left: 20px; height: 40px" type="text" name="txtTenDn" placeholder="Tên đăng nhập" >
			<span style="display: flex;margin-left: 20px;margin-bottom: 5px; font-weight: bold;">Mật khẩu:</span>
			<input class="mk border border-light-subtle border-3" style="  border-radius:5px;width: 270px;position: relative;text-indent: 10px; left: 20px ; height: 40px" type="text" name="txtMk" placeholder="Mật Khẩu">
			<button class="btn btn-primary active" type="submit" name="dangnhap" style=" border-radius:5px;margin-left: 20px; margin-top: 25px;width: 270px;height: 40px;">Đăng nhập</button>
		</form>

	</div>
</body>
</html>
<%@page import="UserModal.User"%>
<%@page import="LikeModal.Like"%>
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
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Profile.css">
</head>
<body>

	<%ArrayList<Post_User> dsPost_UserById = (ArrayList<Post_User>)session.getAttribute("dsPost_UserById"); 
	ArrayList<Like> dsLike = (ArrayList<Like>)session.getAttribute("dsLike");
	int index = 0;
	if(session.getAttribute("dsPost_UserById")!=null){
		index = dsPost_UserById.size();
	}
	User currentUser = (User)session.getAttribute("User");
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
        <div class="profile-name-info" style="display: ruby;">
                <h1 class="profile-name"><%=currentUser.getFullName() %></h1>	
		<button type="button" class="" style="all:unset;cursor: pointer;" data-bs-toggle="modal" data-bs-target="#changeUsernameModal">
		  <i class="bi bi-pencil-fill fs-6 mx-2" style="cursor: pointer; color: #6c757d;"></i>
		</button>
		
		<!-- Modal đổi tên người dùng-->
		<div id="changeUsernameModal" class="modal fade" tabindex="-1" aria-labelledby="changeUsernameLabel" aria-hidden="true" style="margin-top: 10%">
		  <div class="modal-dialog">
		    <div class="modal-content" style="width:80%">
		      <form action="ChangeUsernameController" method="post">
		        <div class="modal-header">
		          <h5 class="modal-title" id="changeUsernameLabel">Đổi tên người dùng</h5>
		          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
		        </div>
		        <div class="modal-body">
		          <div class="mb-3">
		            <label for="inputNewUsername" class="form-label">Tên người dùng mới</label>
		            <input type="text" class="form-control" id="inputNewUsername" name="newUsername" required />
		          </div>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
		          <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
		        </div>
		      </form>
		    </div>
		  </div>
		</div>
		<!-- Đóng modal -->
		
         <!-- Modal chỉnh sửa bài viết -->
	   <div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered modal-lg">
	      <div class="modal-content rounded-4">
	        <div class="modal-header border-0">
	          <h5 class="modal-title mx-auto fw-bold" id="editPostModalLabel">Chỉnh sửa bài viết</h5>
	          <button type="button" class="btn-close position-absolute end-0 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	
	        <form id="editPostForm" enctype="multipart/form-data" method="post" action="/editPost">
	          <div class="modal-body pt-0">
	
	            <!-- Avatar + tên người dùng -->
	            <div class="d-flex align-items-center mb-3">
	              <img src="<%=currentUser.getAvatar() %>" alt="avatar" class="rounded-circle me-2" width="40" height="40">
	              <div><strong><%=currentUser.getFullName() %></strong></div>
	            </div>
	
	            <!-- Nội dung -->
	            <div class="mb-3">
	              <textarea class="form-control border-0"
	                        id="editPostContent"
	                        name="content"
	                        rows="4"
	                        placeholder="Bạn đang nghĩ gì?"
	                        style="resize: none; font-size: 1.2rem;"></textarea>
	            </div>
	            <!-- Ảnh hiện tại -->
	            <div class="mb-3" id="currentImageContainer" style="display: none;">
	              <img id="currentImage" src="" style="max-height: 200px;">
	              <input type="hidden" id="oldImageUrl" name="oldImageUrl" value="">
	            </div>
	
	            <!-- Chọn ảnh mới -->
	            <div class="mb-3">
	              <label for="editPostImage" class="form-label fw-bold">Chọn ảnh mới!</label>
	              <input class="form-control" type="file" id="editPostImage" name="image" accept="image/*">
	            </div>	
	          </div>
	
	          <div class="modal-footer border-0">
	            <button type="submit" class="btn btn-success w-100 fw-bold rounded-pill">Lưu thay đổi</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
         
         <!-- Đóng modal chỉnh sửa bài viết -->
            
            
            </div>
           
        </div>
        <div class="profile-navigation">
            <form action="ProfileNavigation" style="display: flex ;gap: 16px;">
            <button name="baiViet" style="all: unset;  cursor: pointer;"><div class="nav-item active">Bài viết</div></button>
            <button name="banBe" style="all: unset;  cursor: pointer;"><div class="nav-item">Bạn bè</div></button>
            <button name="anh" style="all: unset;  cursor: pointer;"><div class="nav-item">Anh</div></button>
            </form>
            
        </div>
    </div>
    </div>
    
    <!-- Main Content -->
    <div class="content-container">
        <!-- Post Composer -->
        <div class="card">
            <div class="post-composer">
                <div class="composer-input" data-bs-toggle="modal" data-bs-target="#fbPostModal">Thêm bài đăng mới?</div>
            </div>
            <!-- modal đăng bài viết mới -->
            <div class="modal fade" id="fbPostModal" tabindex="-1" aria-labelledby="fbPostModalLabel" aria-hidden="false">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		      <div class="modal-content rounded-4">
					
		        <div class="modal-header border-0">
		          <h5 class="modal-title mx-auto fw-bold" id="fbPostModalLabel">Tạo bài viết</h5>
		          <button type="button" class="btn-close position-absolute end-0 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
		        </div>
		        <form id="fbPostForm" enctype="multipart/form-data">
		          <div class="modal-body pt-0">
		
		            <!-- Avatar + Tên người dùng -->
		            <div class="d-flex align-items-center mb-3">
		              <img src="<%=currentUser.getAvatar() %>" alt="avatar" class="rounded-circle me-2" width="40" height="40">
		              <div>
		                <strong><%=currentUser.getFullName() %></strong><br>
		              </div>
		            </div>
		
		            <!-- Nội dung bài post -->
		            
		            <div class="mb-3" id="content">
		              <textarea class="form-control border-0" id="postContent" name="content" rows="5" placeholder="Bạn đang nghĩ gì?" style="resize: none; font-size: 1.2rem;"></textarea>
		            </div>
		            
		            <!-- Chọn ảnh -->
		            <div class="mb-3">
		              <label for="postImage" class="form-label fw-bold">Ảnh</label>
		              <input class="form-control" type="file" id="postImage" name="image" accept="image/*">
		            </div>
		
		          </div>
		
		          <div class="modal-footer border-0">
		            <button type="submit" class="btn btn-primary w-100 fw-bold rounded-pill">Đăng</button>
		          </div>
		        </form>
		
		      </div>
		    </div>
	  	</div>
                    
            <div class="composer-actions">
                    <form action="ProfileNavigation" style="display: flex ;gap: 16px;">
                    	<button class="composer-action photo" name="anh" style="all: unset;  cursor: pointer;"><i class="bi bi-image"></i> Ảnh</button>
                    </form>
            </div>
        </div>

        <!-- List các bài post -->
                <div class="">
                    <%if(index==0){ %>
                    
                    <%}else{ %>
                    	<div class="">
                        <!-- Post -->
                        <%for(int i = 0 ; i < index ; i++){ %>
                            <div class="post" data-post-id="<%= dsPost_UserById.get(i).getPostID() %>">
                            <div class="post-header">
                                <img src="<%=dsPost_UserById.get(i).getAvatar() %>" style="width: 40px;height: 40px" class="post-avatar">
                                <div class="post-info">
                                    <h6 class="post-author"><%=dsPost_UserById.get(i).getFullName() %></h6>
                                    <p class="post-time"><%=dsPost_UserById.get(i).getTimePost() %></p>
                                </div>
								<div class="dropdown">
                                    <button class="btn" type="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" class="btn btn-warning px-4 py-2" onclick="openEditPostModal(<%=dsPost_UserById.get(i).getPostID()%>)" style="cursor: pointer;">Chỉnh sửa bài viết</a></li>
                                        <li><a class="dropdown-item" href="#" onclick="deletePost(<%= dsPost_UserById.get(i).getPostID() %>)">Gỡ bài viết</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="post-content">
                                <%if(dsPost_UserById.get(i).getContent()!=null){ %>
                                <div class="post-text">
                                    <p><%=dsPost_UserById.get(i).getContent() %></p>
                                </div>
                                <%} %>
                                <%if(dsPost_UserById.get(i).getImage()!=null){ %>
                                <img src="<%=dsPost_UserById.get(i).getImage() %>" class="post-image" alt="<%=dsPost_UserById.get(i).getImage()%>">
                                <%} %>
                            </div>
                            <div class="post-reactions">
                                <div>
                                	<span id="likeCount_<%=dsPost_UserById.get(i).getPostID()%>"><%=dsPost_UserById.get(i).getLikeCount() %></span> <i class="bi bi-hand-thumbs-up-fill text-primary"></i>
                                </div>
                            </div>
                            <div class="post-actions">
                            <%String checklike = "default";
                            for(int j = 0 ; j < dsLike.size();j++){
                            	if(dsPost_UserById.get(i).getPostID()==dsLike.get(j).getPostID()){
                            		if(dsLike.get(j).getUserID()==currentUser.getUserID()){
                            			checklike = "liked";%>
                            		<%}
                            	}
                           }%>         
                                <div class="post-action">
                                <button style="border: none;outline: none;background: none;" id="likeButton_<%= dsPost_UserById.get(i).getPostID() %>" 
							        class="<%= checklike %>" 
							        onclick="likePost(<%= dsPost_UserById.get(i).getPostID() %>, <%=currentUser.getUserID()%>)"><i class="bi bi-hand-thumbs-up"></i>Like</button>
                                </div>
                                <div class="post-action">
                                 <button style="border: none;outline: none;background: none;" 
								        onclick="comment(<%=dsPost_UserById.get(i).getPostID()%>)">
								    <i class="bi bi-chat"></i>Bình luận
								</button>
                                </div>
                                <a href="MessageController?message=1" class="sidebar-item" style="text-decoration: none;">
                                <div class="post-action">
                                    <span style="color: black;">Nhắn tin</span>
                                </div>
                                </a>
                            </div>
                        </div>
                        <%} %>
                    </div>
                    <%} %>
                </div>

            </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <%@ include file="Layouts/ModelComment.jsp" %>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    
    <!-- Custom JavaScript for View Switching -->
    <script>
    
    let parentId = 0;
	
	//Lấy parentID
	function GuiPhanHoi(fullName,id){
		parentId = id;
		  document.getElementById("replying-to").style.display = "flex";
		  document.getElementById("replying-username").innerText = fullName;
		  // Tự động focus vào textarea khi nhấn phản hồi
	}
	function cancelReply() {
		  parentId = 0;
		  document.getElementById("replying-to").style.display = "none";
		}
	

    //deletePosst
    function deletePost(postId) {
    if (confirm("Bạn có chắc chắn muốn gỡ bài viết này không?")) {
      window.location.href = "UpdatePostController?deleteId=" + postId;
    }
  }
    
    //Chỉnh sửa bài viết
    function openEditPostModal(postId) {
    window.currentPostId = postId;
  $.ajax({
    url:  '/SocialMedia/UpdatePostController',
    type: 'GET',
    data: {postId: postId},
    dataType: 'json',
    success: function(post_User) {
      // Đổ dữ liệu vào modal
      $('#editPostContent').val(post_User.Content || '');
      if (post_User.Image) {
        $('#currentImage').attr('src', post_User.Image);
        $('#oldImageUrl').val(post_User.Image);
        $('#currentImageContainer').show();
      } else {
        $('#currentImageContainer').hide();
        $('#oldImageUrl').val('');
      }
       $('#editPostImage').val(''); // reset input file
      // Hiển thị modal
      const modal = new bootstrap.Modal(document.getElementById('editPostModal'));
      modal.show();
    },
    error: function() {
      alert('Lấy dữ liệu bài viết thất bại!');
    }
  });
}
    // Khi chọn ảnh mới
    document.addEventListener("DOMContentLoaded", function () {
  const fileInput = document.getElementById("editPostImage");
  const currentImage = document.getElementById("currentImage");
  const currentImageContainer = document.getElementById("currentImageContainer");

  // Biến để lưu file đã chọn trước đó
  let selectedFile = null;
  fileInput.addEventListener("change", function () {
    const file = this.files[0];

    // Nếu có chọn file => cập nhật selectedFile
    if (file) {
      selectedFile = file; // lưu file vào biến tạm
      const reader = new FileReader();
      reader.onload = function (e) {
        currentImage.src = e.target.result;
        currentImageContainer.style.display = "block";
      };
      reader.readAsDataURL(file);
    } else {
      console.log("Không có file được chọn. Giữ nguyên ảnh cũ.");
    }
  });

  // Ví dụ khi submit form, bạn có thể truy cập selectedFile:
  document.getElementById("editPostForm").addEventListener("submit", function (e) {
    console.log("File cuối cùng sẽ gửi là:", selectedFile ? selectedFile.name : "Không có ảnh mới");
      event.preventDefault();
      const content = document.getElementById("editPostContent").value.trim();
      const fileInput = document.getElementById("editPostImage");
      const oldImageUrl = document.getElementById("oldImageUrl").value;	  
      const postId = window.currentPostId || 0;
      console.log("PostID là : "+ postId);
      let image;
      if (fileInput.files.length > 0) {
    	  image = fileInput.files[0]; // file mới chọn
    	} else {
    	  if (selectedFile == null) {
    	    image = null; // chưa chọn file nào mới
    	  } else {
    	    image = selectedFile; // giữ file đã chọn trước đó
    	  }
    	}
      const formData = new FormData();
      formData.append("postId", postId.toString());
      formData.append("content", content);
      formData.append("image", image);
 
      $.ajax({
        url: '/SocialMedia/UpdatePostController',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
          alert('Cập nhật thành công!');
        },
        error: function () {
          alert('Có lỗi xảy ra khi gửi dữ liệu!');
        }
      });
	  
      
  });
});
    
    
    
    //Submit dữ liệu chỉnh sửa bài viết

    
    
 //Tạo bài đăng mới
 document.getElementById("fbPostForm").addEventListener("submit", function(e) {
	    e.preventDefault();
	    const formData = new FormData(this);
	    for (const [key, value] of formData.entries()) {
	    	  console.log(`${key}:`, value);
	    	}
	    fetch('/SocialMedia/CreatePostController', {
	      method: 'Post',
	      body: formData
	    })
	    .then(res => res.json())
	    .then(data => {
	      console.log('Status:', data.status);
	      console.log('Content:', data.content);
	      console.log('Image:', data.image);
	      this.reset();
	      bootstrap.Modal.getInstance(document.getElementById('fbPostModal')).hide();
	      alert("Thêm bài viết thành công");
	      const backdrops = document.querySelectorAll('.modal-backdrop.fade.show');
	      backdrops.forEach(element => element.remove());
	      document.body.classList.remove('modal-open');
	      setTimeout(() => {
	    	  location.reload();
	    	}, 500);
	    })
	    .catch(err => {
	    	const warning = document.createElement("div");
	        warning.className = "text-center text-danger";
	        warning.innerHTML = "<p>Vui lòng thêm nội dung hoặc ảnh</p>";

	        const contentDiv = document.getElementById("content");
	        if (contentDiv) {
	            contentDiv.parentNode.insertBefore(warning, contentDiv);
	        }
	    });
  });
    
 
    //Bắt sự kiện lưu thay đổi tên người dùng
    document.addEventListener('DOMContentLoaded', function () {
  const form = document.querySelector('form[action="ChangeUsernameController"]');
  const inputField = document.getElementById('inputNewUsername');

  form.addEventListener('submit', function (e) {
    e.preventDefault(); // Ngăn gửi form ban đầu

    const newUsername = inputField.value.trim();

    // Xóa thông báo lỗi cũ (nếu có)
    const oldError = document.querySelector('#username-error');
    if (oldError) {
      oldError.remove();
    }

    if (newUsername === "") {
      // Tạo thẻ span báo lỗi
      const error = document.createElement('span');
      error.id = 'username-error'; // để dễ kiểm tra và xóa
      error.style.color = 'red';
      error.style.fontSize = '0.875rem';
      error.textContent = 'Tên người dùng mới không được để trống';

      // Thêm ngay dưới input
      inputField.parentNode.appendChild(error);

      	return; // không gửi form
    }

    // Nếu hợp lệ thì gửi form
    	form.submit();
  	});
	});
    
    
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
    function comment(postId) {
    	document.getElementById("postId").value =postId;
		const modal = document.getElementById('modalcomment');
		  //modal.style.display = 'block'; // hoặc classList.add('show') tùy cách bạn hiển thị
		  setTimeout(() => {
		    modal.querySelector('.comment-input').focus();
		  }, 100);
	    $.ajax({
	        url: "CommentController",
	        type: "POST",
	        data: { postId: postId },
	        dataType: "json", // Xác định server trả về JSON
	        success: function(response) {
	            if (response.error) {
	                console.log("Lỗi: " + response.error);
	                return;
	            }
	            console.log("Dữ liệu nhận từ server:", response);
				$(".username").text(response.postUser.username);
				if(response.postUser.content==null){
					$(".model-content").hide();
				}else{
					$(".content").text(response.postUser.content);
				}
				$(".likecount").text(response.postUser.likeCount);
				if(response.postUser.image==null){
					$(".model-image").hide();
				}else{
					$(".image").attr("src", response.postUser.image);
				
				}
				$(".avatar").attr("src", response.postUser.avatar);
				displayComment(response.comment);
	            $("#modalcomment").addClass("show d-block");
	            
	        },
	        error: function(xhr) {
	            console.log("Lỗi khi gửi AJAX:", xhr.responseText);
	        }
	    });}
  //Add thêm bình luận
	 function addcomment(postId, userId) {
		postId = document.getElementById("postId").value;
	    // Lấy nội dung trong textarea gần nhất với nút gửi
	    const button = event.target.closest('button'); // Lấy button đang được bấm
	    const container = button.closest('.comment-input-container'); // Lấy container cha
	    const textarea = container.querySelector('.comment-input'); // Tìm textarea trong đó
	    const content = textarea.value.trim(); // Lấy nội dung bình luận
		console.log(button);
	    console.log("contain cha "+ container);
	    if (content === "") {
	        alert("Vui lòng nhập bình luận.");
	        return;
	    }

	    // Gửi bình luận bằng AJAX hoặc xử lý theo cách bạn muốn
	    console.log("Đang gửi bình luận:", content);
	    console.log("Post ID:", postId, "User ID:", userId);

	    // Ví dụ: Gửi bình luận đến server
	    $.ajax({
	        url: "AddCommentController",
	        type: "GET",
	        data: {
	            postId: postId,
	            userId: userId,
	            content: content,
	            parentId: parentId
	        },
	        success: function(response) {
	            textarea.value = ""; // Xóa nội dung sau khi gửi
	            if (response.error) {
	                console.log("Lỗi: " + response.error);
	                return;
	            }
	            console.log("Dữ liệu nhận từ server:", response);
				$(".username").text(response.postUser.Username);
				$(".content").text(response.postUser.content);
				$(".likecount").text(response.postUser.likeCount);
				$(".image").attr("src", response.postUser.image);
				$(".avatar").attr("src", response.postUser.avatar);
				displayComment(response.comment);
	            $("#modalcomment").addClass("show d-block");
				cancelReply();
	        },
	        error: function(xhr) {
	            console.log("Lỗi khi gửi bình luận:", xhr.responseText);
	        }
	    });
	} 
	function displayComment(comments) {
	    var commentsContainer = $('#commentsContainer');
	    commentsContainer.empty();
	    var commentHTML = "";

	    comments.forEach(function(comment) {
	        if (comment.parentID === 0) {
	            console.log(comment.username);
	            commentHTML += 
	                '<div class="comment">' +
	                    '<div class="comment-avatar">' +
	                        '<img src="' + comment.avatar + '" style="width: 40px;height: 40px" class="post-avatar">' +
	                    '</div>' +
	                    '<div class="comment-content">' +
	                        '<div class="comment-bubble">' +
	                            '<div class="comment-author">' + comment.fullName + '</div>' +
	                            '<p class="comment-text">' + comment.content + '</p>' +
	                        '</div>' +
	                        '<div class="comment-actions">' +
	                        '<span class="comment-action" onclick="GuiPhanHoi(\'' + comment.fullName + '\',' + comment.commentID + ')">Phản hồi</span>' +                            
	                        '</div>';
	            for (var i = comments.length - 1; i >= 0; i--) {
	                var cmt = comments[i];
	                console.log("comment cha" + comment.commentID);
	                console.log(cmt.parentID);
	                if (cmt.parentID == comment.commentID) {
	                    commentHTML += 
	                        '<div class="reply-section">' +
	                            '<div class="reply">' +
	                                '<div class="reply-avatar">' +
	                                    '<img src="' + cmt.avatar + '" style="width: 40px;height: 40px" class="post-avatar">' +
	                                '</div>' +
	                                '<div class="reply-content">' +
	                                    '<div class="reply-bubble">' +
	                                        '<div class="reply-author">' + cmt.fullName + '</div>' +
	                                        '<p class="reply-text">' + cmt.content + '</p>' +
	                                    '</div>' +
	                                    '<div class="reply-actions">' +
	                                    '</div>' +
	                                '</div>' +
	                            '</div>' +
	                        '</div>';
	                }
	            }        
		    	   commentHTML += '</div>' +
	                '</div>';
	        }

	    });
	    parentId=0;
	    commentsContainer.append(commentHTML);
	}


	function closemodal(){
		$("#modalcomment").removeClass("show d-block");
	}
	window.addEventListener('click', function (e) {
	    const modal = document.getElementById('modalcomment');
	    const modalContent = modal.querySelector('.modal-content');
	    if (e.target === modal && !modalContent.contains(e.target)) {
	      closemodal(); // gọi hàm bạn đã định nghĩa để đóng modal
	    }
	  });
    // Hàm xử lý Like/Unlike
    function likePost(postId, userId) {
    	console.log("Post ID: " + postId + ", User ID: " + userId);
        $.ajax({
            url: "LikeController",
            type: "POST",
            data: { postId: postId, userId: userId },
            success: function(response) {
                // Cập nhật số lượng Like
                $("#likeCount_" + postId).text(response.likeCount);

                // Thay đổi màu nút Like
                if (response.liked) {
                    $("#likeButton_" + postId).addClass("liked").removeClass("default");
                } else {
                    $("#likeButton_" + postId).addClass("default").removeClass("liked");
                }
            }
        });
    }
    </script>
</body>
</html>
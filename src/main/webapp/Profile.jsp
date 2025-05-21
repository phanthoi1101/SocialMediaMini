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
				
		<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#changeUsernameModal">
		  <i class="bi bi-pencil-fill fs-6 mx-2" style="cursor: pointer; color: #6c757d;"></i>
		</button>
		
		<!-- Modal -->
		<div id="changeUsernameModal" class="modal fade" tabindex="-1" aria-labelledby="changeUsernameLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
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
                <div class="composer-avatar">
                    <i class="bi bi-person-fill"></i>
                </div>
                <div class="composer-input">Bạn đang nghĩ gì?</div>
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
                    <div class="text-center text-danger"><h4>Không có bài viết được hiển thị</h4></div>
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
                                        <li><a class="dropdown-item" href="#">Xoá bài viết</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="post-content">
                                <div class="post-text">
                                    <p><%=dsPost_UserById.get(i).getContent() %></p>
                                </div>
                                <img src="<%=dsPost_UserById.get(i).getImage() %>" class="post-image" alt="<%=dsPost_UserById.get(i).getImage()%>">
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
                                <div class="post-action">
                                    <i class="bi bi-share"></i>
                                    Chia sẻ
                                </div>
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
				$(".content").text(response.postUser.content);
				$(".likecount").text(response.postUser.likeCount);
				$(".image").attr("src", response.postUser.image);
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
	        type: "POST",
	        data: {
	            postId: postId,
	            userId: userId,
	            content: content
	        },
	        success: function(response) {
	            textarea.value = ""; // Xóa nội dung sau khi gửi
	            if (response.error) {
	                console.log("Lỗi: " + response.error);
	                return;
	            }
	            console.log("Dữ liệu nhận từ server:", response);
				$(".username").text(response.postUser.username);
				$(".content").text(response.postUser.content);
				$(".likecount").text(response.postUser.likeCount);
				$(".image").attr("src", response.postUser.image);
				$(".avatar").attr("src", response.postUser.avatar);
				displayComment(response.comment);
				console.log()
	            $("#modalcomment").addClass("show d-block");
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
	                            '<div class="comment-author">' + comment.username + '</div>' +
	                            '<p class="comment-text">' + comment.content + '</p>' +
	                        '</div>' +
	                        '<div class="comment-actions">' +
	                            '<span class="comment-action">Thích</span>' +
	                            '<span class="comment-action">Phản hồi</span>' +
	                            '<span class="comment-time">thời gian</span>' +
	                            
	                        '</div>';
	            for (var i = comments.length - 1; i >= 0; i--) {
	                var cmt = comments[i];
	                console.log("comment cha" + comment.commentID);
	                console.log(cmt.parentID);
	                if (cmt.parentID == comment.commentID) {
	                	console.log("hello")
	                    commentHTML += 
	                        '<div class="reply-section">' +
	                            '<div class="reply">' +
	                                '<div class="reply-avatar">' +
	                                    '<img src="' + cmt.avatar + '" style="width: 40px;height: 40px" class="post-avatar">' +
	                                '</div>' +
	                                '<div class="reply-content">' +
	                                    '<div class="reply-bubble">' +
	                                        '<div class="reply-author">' + cmt.username + '</div>' +
	                                        '<p class="reply-text">' + cmt.content + '</p>' +
	                                    '</div>' +
	                                    '<div class="reply-actions">' +
	                                        '<span class="comment-action">Thích</span>' +
	                                        '<span class="comment-action">Phản hồi</span>' +
	                                        '<span class="comment-time">1 ngày</span>' +
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
	    commentsContainer.append(commentHTML);
	}


	function closemodal(){
		$("#modalcomment").removeClass("show d-block");
	}
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
<%@page import="FriendshipModal.FriendshipBo"%>
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
	
	<%FriendshipBo fbo = new FriendshipBo();
	ArrayList<Post_User> dsPost_UserById = (ArrayList<Post_User>)session.getAttribute("dsPost_UserById"); 
	ArrayList<Like> dsLike = (ArrayList<Like>)session.getAttribute("dsLike");
	int index = 0;
	if(session.getAttribute("dsPost_UserById")!=null){
		index = dsPost_UserById.size();
	}
	User userFriend = (User)request.getAttribute("UserFriend");
	User currentUser = (User)session.getAttribute("User");
	String check ="";
	check = fbo.checkFriendship(userFriend.getUserID(), currentUser.getUserID());
	%>
	    <!-- Navbar -->
    <%@ include file="Layouts/FacebookHeader.jsp" %>

    <!-- Profile Header -->
    <div class="content-container">
    	<div class="profile-header">
        <div class="cover-photo">
	        <img alt="" src="<%=userFriend.getPhotoCover() %>" style="object-fit: cover;width: 100%;height: 100%;">
        </div>
        <div class="profile-info">
            <div class="profile-picture-container">
                <div class="profile-picture">
                <img alt="" src="<%=userFriend.getAvatar()%>" style="width: 100%;object-fit: cover;height: 100%;">
                </div>
            </div>
            <div class="profile-name-info">
                <h1 class="profile-name"><%=userFriend.getFullName() %></h1>
            </div>
            <%if(check.equals("xacnhan")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-primary me-5" name="xacnhan">Xác nhận kết bạn</button>
		            </form>
	         	</div>
            <%}else if(check.equals("huyyeucau")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-light me-5" name="huyyeucau">Huỷ yêu cầu</button>
		            </form>
	         	</div>
            <%}else if(check.equals("guiloimoi")){ %>
            	<div class="profile-actions">
	                <form action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-primary me-5" name="thembanbe">Thêm bạn bè</button>
		            </form>
	         	</div>
            <%}else if(check.equals("huyketban")){ %>
            	<div class="profile-actions">
	                <form id="Unfriend" action="FriendRequestController" method="get" style="all: unset;display: contents;">
		                    <input type="hidden" name="userId" value="<%=userFriend.getUserID()%>">
		                    <button class="btn btn-danger" name="huyketban">Huỷ bạn bè</button>
		            </form>
		            <a href="MessageController?id=<%=userFriend.getUserID() %>" class="btn btn-primary me-5 ms-2">Nhắn tin</a>
	         	</div>
            <%} %>
        </div>
        <div class="profile-navigation">
            <form action="ProfileNavigation" style="display: flex ;gap: 16px;">
            <input type="hidden" name="profileUserId" value="<%=userFriend.getUserID()%>"/>
            <button name="baiVietFriend" style="all: unset;  cursor: pointer;"><div class="nav-item active">Bài viết</div></button>
            <button name="banBeFriend" style="all: unset;  cursor: pointer;"><div class="nav-item">Bạn bè</div></button>
            <button name="anhFriend" style="all: unset;  cursor: pointer;"><div class="nav-item">Anh</div></button>
            </form>
        </div>
    </div>
    </div>
    
    <!-- Main Content -->
    <div class="content-container">
        <!-- List các bài post -->
                <div class="">
                    <%if(check.equals("huyketban")){ %>
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
<!-- 								<div class="dropdown"> -->
<!--                                     <button class="btn" type="button" data-bs-toggle="dropdown"> -->
<!--                                         <i class="bi bi-three-dots"></i> -->
<!--                                     </button> -->
<!--                                     <ul class="dropdown-menu"> -->
<!--                                         <li><a class="dropdown-item" href="#">Ẩn bài viết</a></li> -->
<!--                                         <li><a class="dropdown-item" href="#">Báo cáo</a></li> -->
<!--                                     </ul> -->
<!--                                 </div> -->
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
                                <a href="MessageController?id=<%=dsPost_UserById.get(i).getUserID() %>" class="sidebar-item" style="text-decoration: none;">
	                                <div class="post-action">
	                                    <span style="color: black;">Nhắn tin</span>
	                                </div>
	                                </a>

                            </div>
                        </div>
                        <%} %>
                    </div>
                    <%} %>
                    <%}else{ %>
                    	<div class="text-center">Thêm bạn bè để biết thêm thông tin</div>
                    <%} %>
                </div>

            </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <%@ include file="Layouts/ModelComment.jsp" %>
    
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
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
    
    //Unfriend
    document.getElementById("Unfriend").addEventListener("submit", function(e) {
	    const isConfirmed = confirm("Bạn có chắc chắn muốn huỷ kết bạn không?");
	    if (!isConfirmed) {
	      e.preventDefault(); // Hủy gửi form nếu người dùng bấm Cancel
	    }
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
	        data: { postId: postId},
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
  //TODO: lúc nhấn vào phản hồi sẽ tiến hành lấy thằng id của thằng bình luận nhấn vào để làm parent
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
				console.log()
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
	                	console.log("hello")
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
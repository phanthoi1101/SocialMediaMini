<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <%@page import="UserModal.UserBo"%>
<%@page import="FriendshipModal.Friendship"%>
<%@page import="UserModal.User"%>
<%@page import="LikeModal.Like"%>
<%@page import="Post_UserModal.Post_User"%>
    <%@page import="PostsModal.Posts"%>
    <%@page import="java.util.ArrayList"%>
    <html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Homepage.css">
    </head>
    <body>
        <%
        User currentUser = (User)session.getAttribute("User");
        ArrayList<Post_User> dsPost_User = (ArrayList<Post_User>)session.getAttribute("dsPost_User"); 
        ArrayList<Like> dsLike = (ArrayList<Like>)session.getAttribute("dsLike");
        int index = 0;
        if(session.getAttribute("dsPost_User")!=null){
        	index = dsPost_User.size();
        }
        %>
        <!-- Facebook Header -->
		<%@ include file="Layouts/FacebookHeader.jsp" %>
        <!-- Main Content -->
        <div class="container-fluid main-content">
            <div class="row">
                <!-- Left Sidebar -->
                <div class="col-3">
                    <div class="sidebar">
                        <a href="ProfileController?id=<%=currentUser.getUserID() %>" class="sidebar-item">
                            <div class="me-2">
                                <img src="<%=currentUser.getAvatar() %>" style="width: 40px;height: 40px" class="post-avatar">
                            </div>
                            <span><%=currentUser.getFullName() %></span>
                        </a>
                        <a href="FriendController" class="sidebar-item">
                            <div class="sidebar-icon blue">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            <span>Bạn bè</span>
                        </a>
                        <a href="MessageController?message=1" class="sidebar-item">
                            <div class="sidebar-icon blue">
                                <i class="bi bi-chat-dots-fill"></i>
                            </div>
                            <span>Nhắn tin với bạn bè</span>
                        </a>
                        
                    </div>
                </div>
    
                <!-- List các bài post -->
		           <div class="col-6">
		             <div class="container mb-4">
					    <button class="btn btn-light w-100 text-start rounded-pill px-3 py-2 border" data-bs-toggle="modal" data-bs-target="#fbPostModal">
					      Thêm bài đăng mới?
					    </button>
					  </div>
		 <!-- Modal Thêm mới bài đăng-->
		  <div class="modal fade" id="fbPostModal" tabindex="-1" aria-labelledby="fbPostModalLabel" aria-hidden="true">
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
                    <%if(index==0){ %>
                    <div class="text-center "><h4>Thêm bạn bè để xem được nhiều bài viết hơn từ bạn bè!</h4></div>
                    <%}else{ %>
                    	<div class="feed">
                        <!-- Post -->
                        <%for(int i = 0 ; i < index ; i++){ %>
                            <div class="post" data-post-id="<%= dsPost_User.get(i).getPostID() %>">
                            <div class="post-header">
                                <a href="ProfileController?id=<%=dsPost_User.get(i).getUserID()%>"><img src="<%=dsPost_User.get(i).getAvatar() %>" style="width: 40px;height: 40px" class="post-avatar"></a>
                                <div class="post-info">
	                                <a style="all:unset;cursor:pointer;" href="ProfileController?id=<%=dsPost_User.get(i).getUserID()%>">
	                                   	<h6 class="post-author"><%=dsPost_User.get(i).getFullName() %></h6>
	                                   	<p class="post-time"><%=dsPost_User.get(i).getTimePost() %></p>
	                                </a>
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
                                <%if(dsPost_User.get(i).getContent()!=null){ %>
                                <div class="post-text">
                                    <p><%=dsPost_User.get(i).getContent() %></p>
                                </div>
                                <%} %>
                                <%if(dsPost_User.get(i).getImage()!=null){ %>
                                <img src="<%=dsPost_User.get(i).getImage() %>" class="post-image" alt="<%=dsPost_User.get(i).getImage()%>">
                                <%} %>
                            </div>
                            <div class="post-reactions">
                                <div>
                                	<span id="likeCount_<%=dsPost_User.get(i).getPostID()%>"><%=dsPost_User.get(i).getLikeCount() %></span> <i class="bi bi-hand-thumbs-up-fill text-primary"></i>
                                </div>
                            </div>
                            <div class="post-actions">
                            <%String checklike = "default";
                            for(int j = 0 ; j < dsLike.size();j++){
                            	if(dsPost_User.get(i).getPostID()==dsLike.get(j).getPostID()){
                            		if(dsLike.get(j).getUserID()==currentUser.getUserID()){
                            			checklike = "liked";%>
                            		<%}
                            	}
                           }%>         
                                <div class="post-action">
                                <!-- id = likeButton_postID -->
                     	           <button style="border: none;outline: none;background: none;" id="likeButton_<%=dsPost_User.get(i).getPostID()%>" 
							        class="<%= checklike%>" 
							        onclick="likePost(<%= dsPost_User.get(i).getPostID() %>, <%= currentUser.getUserID()%>)"><i class="bi bi-hand-thumbs-up"></i>Like</button>
                                </div>
                                <div class="post-action">
                                 <button style="border: none;outline: none;background: none;" 
								        onclick="comment(<%=dsPost_User.get(i).getPostID()%>)">
								    <i class="bi bi-chat"></i>Bình luận
								</button>
                                </div>
                                <%if(dsPost_User.get(i).getUserID()==currentUser.getUserID()){ %>
                                <a href="MessageController?message=1" class="sidebar-item">
                                <div class="post-action">
                                    <span style="color: black;">Nhắn tin</span>
                                </div>
                                </a>
                                <%}else{ %>
                                	<a href="MessageController?id=<%=dsPost_User.get(i).getUserID() %>" class="sidebar-item">
	                                <div class="post-action">
	                                    <span style="color: black;">Nhắn tin</span>
	                                </div>
	                                </a>
                                <%} %>
                            </div>
                        </div>
                        <%} %>
                    </div>
                    <%} %>
                </div>
    	<!-- Friended -->
    	<%ArrayList<Friendship> dsFriendship = (ArrayList<Friendship>)session.getAttribute("dsFriendshipByUserId"); 
    		int n = 0;
    		if(session.getAttribute("dsFriendshipByUserId")!=null){
    			n = dsFriendship.size();
    		}
    	%>
                <div class="col-3">
                    <div class="right-sidebar">
                        <div>
                            <div class="contacts-header">
                                <h5 class="section-title">Chat</h5>
                                <form action="HomePageController" method="get">
                                	<input type="text" name="searchfriend" placeholder="Tìm kiếm"/>
                                	<button style="border: none;" class="text-primary" type="submit" name="timkiem"><i class="fas fa-search"></i></button>
                                </form>
                            </div>
                           <%if(n!=0){
                        	   UserBo userbo = new UserBo();
                        	   for(int i = 0 ; i < n ; i++){
                        		   if(currentUser.getUserID()==dsFriendship.get(i).getReceiverID()){
                        			   User user = userbo.getUserById(dsFriendship.get(i).getSenderID());
                        	   %>   
                        	  <a style="text-decoration: none;color: inherit;" href="MessageController?id=<%=user.getUserID()%>">
                        	  	 <div class="contact-item">
	                                <img src="<%=user.getAvatar() %>" style="width: 40px;height: 40px" class="post-avatar">
	                                <div><%=user.getFullName() %></div> 
                            	</div> 
                        	  </a>
                        	   <%}else{ 
                        	   User user = userbo.getUserById(dsFriendship.get(i).getReceiverID());%>
                        	    <a  style=" text-decoration: none;color: inherit;" href="MessageController?id=<%=user.getUserID()%>">
                        	    	<div class="contact-item">
	                                <img src="<%=user.getAvatar() %>" style="width: 40px;height: 40px" class="post-avatar">
	                                <div><%=user.getFullName() %></div> 
                            	</div>
                        	    </a> 
                           <%} 
                        		}
                           }else{%>
                           <div class="text-center mt-4">
                           		<h5>Không tìm thấy người dùng</h5>
                           </div>
                           <%} %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    <%@ include file="Layouts/ModelComment.jsp" %>
    
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	      
	    })
	    .catch(err => {
	    	const warning = document.createElement("div");
	    	warning.className = "text-center text-danger";
	    	warning.innerHTML = "<p>Vui lòng thêm nội dung hoặc ảnh</p>";

	    	// Tìm thẻ #content
	    	const contentDiv = document.getElementById("content");

	    	// Thêm warning nằm trước content
	    	contentDiv.parentNode.insertBefore(warning, contentDiv);
		
	    });
  });
    	
    	
    	// Lấy đối tượng modal
	    	/*function comment(postId){
	    		console.log("postId" + postId);
	    		$.ajax({
	    	        url: "CommentController",
	    	        type: "POST",
	    	        data: { postId: postId},
	    	        success: function(response) {
	    	    		$("#modalcomment").addClass("show d-block");
	    	        }
	    	    });
	
	    	}*/
	    	//Home active
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
	    	//Mở modal bình luận bài viết
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
	    		console.log("postId là "+postId);
	    	    // Lấy nội dung trong textarea gần nhất với nút gửi
	    	    const button = event.target.closest('button'); // Lấy button đang được bấm
	    	    const container = button.closest('.comment-input-container'); // Lấy container cha
	    	    const textarea = container.querySelector('.comment-input'); // Tìm textarea trong đó
	    	    const content = textarea.value.trim(); // Lấy nội dung bình luận
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
	    	            console.log("Dữ liệu nhận từ server:", response.comment);
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
	    		console.log(comments);	
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
// 	    	                                        '<span class="comment-time">1 ngày</span>' +
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
		//Dóng modal
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
	    	//Tự động focus khi đến thẻ input khi modal mở
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
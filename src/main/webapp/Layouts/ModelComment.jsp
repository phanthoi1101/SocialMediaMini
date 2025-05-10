<%@page import="Post_UserModal.Post_User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% int postIdCurrent=0; 
if(session.getAttribute("postId")!=null){
	postIdCurrent = (int)session.getAttribute("postId");
}
%>

	

    	<div id="modalcomment" class="modal modal-backdrop show" data-bs-backdrop="true" tabindex="-1" style="--bs-backdrop-opacity: 1;
               background-color: rgba(0, 0, 0, 0.5);">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 style="margin-right: 2px" class="modal-title">Bài viết của</h5><h5 style="margin-left: 3px" class="username modal-title"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closemodal()"></button>
                </div>
                <div class="modal-body p-0">
                    <!-- Post Header -->
                    <div class="post-header">
                        <div class="post-avatar">
                            <img src="" style="width: 40px;height: 40px" class="post-avatar avatar">
                        </div>
                        <div class="post-info">
                            <div class="post-author username"> <span class="text-primary">· Theo dõi</span></div>
                            <div class="post-meta createdat">
                                 <span class="dot">·</span> <i class="bi bi-globe"></i>
                            </div>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><i class="bi bi-bookmark me-2"></i> Lưu bài viết</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-eye-slash me-2"></i> Ẩn bài viết</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-flag me-2"></i> Báo cáo bài viết</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Post Content -->
                    <div class="post-content">
                        <p class="content"></p>
                    </div>
                    
                    <!-- Post Images -->
                    <div class="post-images">
                        <div class="post-image">
                            <img class="image" src="" alt="">
                        </div>
                    </div>
                    
                    <!-- Engagement Stats -->
                    <div class="engagement">
                        <div class="reactions">
                            <div class="reaction-icon"><i class="bi bi-hand-thumbs-up-fill likecoutnt"></i></div>
							<p class="likecount text-center my-0"></p>
                        </div>

                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="actions">
                        <div class="text-center text-default">Chi tiết bài bình luận</div>
                    </div>
                    
                    <!-- Comments Section -->
                    <div id="commentsContainer" class="comments-section">
                        
                    </div> 
                    <!-- Comment Input -->
                    <div class="comment-input-section">
                        <div class="comment-input-avatar">
                        <!-- TODO: Add ảnh người đăng nhập -->
                            <img src="<%=currentUser.getAvatar() %>" alt="" style="width: 40px;height:40px">
                        </div>
                        <div class="comment-input-container">
                            <textarea class="comment-input" placeholder="Viết bình luận..." ></textarea>
                            <div class="comment-input-actions">
                             <button style="border: none;outline: none;background: none;" onclick="addcomment(<%=postIdCurrent%>,<%=currentUser.getUserID()%>)">
                                <div class="input-action"><i class="bi bi-send"></i></div>
                             </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

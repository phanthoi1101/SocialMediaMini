<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Message</title>
<!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="Layouts/Message.css">
</head>
<body>
 	<%String homeActive = (String)session.getAttribute("homeActive"); %>
        <!-- Facebook Header -->
		<div class="fb-header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-3 d-flex align-items-center">
                       <img style="width: 50px; height: 50px" src="images/logo.avif" class="fs-1 me-2 text-primary">
                        <div class="position-relative">
                            <form action="SearchUser" method="get">
                            <input type="text" class="search-input ps-4" placeholder="Tìm kiếm người dùng" name="searchUser">
                            <button type="submit" style="position: absolute;top: 50%;right: 10px;
																				  transform: translateY(-50%);
																				  background: none;
																				  border: none;
																				  padding: 0;
																				  margin: 0;
																				  cursor: pointer;
																				  color: #333; /* hoặc text-primary */">
				                <i class="fas fa-search"></i> <!-- Font Awesome icon -->
				            </button>
                            </form>
                        </div>
                    </div>
                    <div id="homeParent" class="col-6 d-flex justify-content-center">
                        <div id="home" class="nav-icon <%= "home".equals(homeActive) ? "active" : "" %>" onclick="homeActive(this.id)"><i class="bi bi-house-door-fill"></i></div>
                        <div class="nav-icon"></div>
                        <div id="friend" class="nav-icon <%= "friend".equals(homeActive) ? "active" : "" %>" onclick="homeActive(this.id)"><i class="bi bi-people"></i></div>
                    </div>
                    <div class="col-3 d-flex justify-content-end align-items-center">
                        <div class="profile-icon me-2">
                            <i class="bi bi-messenger"></i>
                        </div>
                        <div class="me-2">
                           
                        </div>
                        <div class="dropdown">						    
						      <div class="profile-icon dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i>
                        </div>	
						    <ul class="dropdown-menu">
						      <li><a class="dropdown-item" href="ProfileController">Trang cá nhân</a></li>
						      <li><a class="dropdown-item" href="#">Đổi mật khẩu</a></li>
						      <li><a class="dropdown-item" href="DangXuatController">Đăng xuất</a></li>
						    </ul>
						  </div>
						</div>
                    </div>
                </div>
            </div>
		
	<div class="container py-4">
  <div class="chat-container shadow">
    
    <!-- Sidebar - User List -->
    <div class="sidebar">
      <div class="p-3 border-bottom">
        <h5>Chats</h5>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=1" alt="User 1">
        <div class="contact-name">Alice</div>
      </div>
      <div class="contact-item d-flex align-items-center">
        <img src="https://i.pravatar.cc/100?img=2" alt="User 2">
        <div class="contact-name">Bob</div>
      </div>
      <!-- Add more contacts as needed -->
    </div>

    <!-- Chat Area -->
    <div class="chat-main">
      <div class="chat-header">
        <img src="https://i.pravatar.cc/100?img=1" width="40" height="40" class="rounded-circle">
        <strong>Alice</strong>
      </div>

      <div class="chat-messages">
        <div class="message received">
          Hello! How are you?
        </div>
        <div class="message sent">
          I'm good, thanks! You?
        </div>
        <div class="message received">
          I'm fine too. What are you doing?
        </div>
        <div class="message sent">
          Just working on a project.
        </div>
        <div class="message received">
          Hello! How are you?
        </div>
        <div class="message sent">
          I'm good, thanks! You?
        </div>
        <div class="message received">
          I'm fine too. What are you doing?
        </div>
        <div class="message sent">
          Just working on a project.
        </div>
        <div class="message received">
          Hello! How are you?
        </div>
        <div class="message sent">
          I'm good, thanks! You?
        </div>
        <div class="message received">
          I'm fine too. What are you doing?
        </div>
        <div class="message sent">
          Just working on a project.
        </div>
      </div>

      <div class="chat-input">
        <input type="text" placeholder="Type a message...">
        <button><i class="bi bi-send-fill"></i></button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
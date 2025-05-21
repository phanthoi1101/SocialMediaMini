<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%if(indexUser==0){ %>
      <%}else{ 
      	for(int i = 0 ; i < indexUser ; i++){
      		 if(currentUser.getUserID()== dsFriendshipIsFriend.get(i).getReceiverID()){
  			   User x = userbo.getUserById(dsFriendshipIsFriend.get(i).getSenderID());
      	%>
	      	<div class="contact-item d-flex align-items-center">
		        <img src="<%=x.getAvatar() %>?img=2" alt="User 2">
		        <div class="contact-name"><%=x.getFullName() %></div>
      		</div>
      <%}else{
    	  User x = userbo.getUserById(dsFriendshipIsFriend.get(i).getReceiverID());
      %>
      	<div class="contact-item d-flex align-items-center">
		        <img src="<%=x.getAvatar() %>?img=2" alt="User 2">
		        <div class="contact-name"><%=x.getFullName() %></div>
      	</div>
      <%} %>
      	<%} 
      }%>
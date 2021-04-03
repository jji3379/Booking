<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
 	ul{
    	list-style:none;
    	padding:0px 0px 0px 0px;
    	
   	}
   	
   	ul li {
   		align:center;
 
   	}
  	
  	#profileImages{
		width: 120px;
		height: 120px;
		border: 1px solid #cecece;
		border-radius: 50%;
		margin-top:10px;
	}
	.linkIcon{
		width:40px; 
		height:40px;
		margin-left:12px;
		margin-bottom:20px;
	}
</style>
<div class="col-3" >
	<a href="${pageContext.request.contextPath }/users/private/my_review.do">
		<img src="${pageContext.request.contextPath }/resources/images/myreview.png" class="linkIcon"/>
	</a>
	<a href="${pageContext.request.contextPath }/users/private/my_order.do">
		<img src="${pageContext.request.contextPath }/resources/images/delivery.png" class="linkIcon"/>
	</a>
	<a href="${pageContext.request.contextPath }/users/private/pwd_updateform.do">
		<img src="${pageContext.request.contextPath }/resources/images/password.png" class="linkIcon"/>
	</a>
	<a href="${pageContext.request.contextPath }/users/private/updateform.do">
		<img src="${pageContext.request.contextPath }/resources/images/info.png" class="linkIcon"/>
	</a>
	<div class="w3-card w3-round w3-white">
        <div class="w3-container">
         <h4 class="w3-center"><a href="${pageContext.request.contextPath }/users/private/info.do">
         <img src="${pageContext.request.contextPath }/resources/images/home.png" style="width:25px; height:25px" />
         My Profile</a></h4>
         <p class="w3-center">
			<c:choose>
				<c:when test="${empty dto.profile }">
					<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="106" height="106" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
			  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
					</svg>
				</c:when>
				<c:otherwise>
					<img id="profileImages" 
						src="${pageContext.request.contextPath }${dto.profile}" />
				</c:otherwise>
			</c:choose>	
         </p>
         <hr>
         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i>${sessionScope.id }</p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> ${dto.email }</p>
         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i>${dto.regdate }</p>
         <p><b> 관심사 : </b> ${dto.care }</p> 
         <p><b> 최근 검색어 : </b> ${dto.recentSearch }</p> 
        </div>
      </div>	
</div>
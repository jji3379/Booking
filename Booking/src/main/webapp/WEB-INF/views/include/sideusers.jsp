<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<style>
 	ul{
    	list-style:none;
    	padding:0px 0px 0px 0px;
    	
   	}
   	
   	ul li {
   		align:center;
 
   	}
  	
  	.boss{
  		border: 2px solid #f1f1f1;
  		width:200px; 
  		height:row; 
  		background-color:#0f4c81; 
  		text-align:center;
  		border-color:#f5e9dd;
  	}
  	
  	#profileImages{
		width: 120px;
		height: 120px;
		border: 1px solid #cecece;
		border-radius: 50%;
		margin-top:10px;
	}
</style>
<div class="boss" >
	<h2 style="margin-top:15px;  color: #f5e9dd;">나의 계정</h2>		
	<ul>
		<li>
			<c:choose>
				<c:when test="${empty dto.profile }">
					<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
			  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
					</svg>
				</c:when>
				<c:otherwise>
					<img id="profileImages" 
						src="${pageContext.request.contextPath }${dto.profile}" />
				</c:otherwise>
			</c:choose>	
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/users/private/info.do" style="font-size:22px;font-weight:bold; color:white;">${id }</a>
		</li>
		<li style="margin-top: 10px; margin-left:10px; text-align:left; color:#000000">
			<a>[활동내역]</a>
		</li>
		<li style="margin-top: 15px;">
			<a href="my_review.do" style="color:#f5e9dd;">내가 쓴 리뷰 모아보기</a>
		</li>
		<li style="margin-top: 15px;">
			<a href="my_order.do" style="color:#f5e9dd;">주문 조회하기</a>
		</li>
		<li style="margin-top: 30px; margin-left:10px; text-align:left; color:#000000">
			<a>[회원정보관리]</a>
		</li>
		<li style="margin-top: 15px;">
			<a style="color:#f5e9dd;" href="pwd_updateform.do">비밀번호 수정하기</a>
		</li>
		<li style="margin-top: 15px;">
			<a style="color:#f5e9dd;" href="updateform.do">개인정보 수정하기</a>
		</li>
		<li style="margin-top: 15px;">
			<a style="color:#f5e9dd;" href="javascript:deleteConfirm();">회원탈퇴</a>
		</li>
	</ul>
</div>
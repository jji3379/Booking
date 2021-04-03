<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
	.profileBox{
		display:inline-block; 
		border:3px solid #135fa1; 
		width:300px; 
		height:165px;
		margin:0px 20px 40px;
		padding:15px 15px;
	}
	.menuIcon{
		width:80px; 
		height:80px; 
		float:right;
	}
</style>
<body style="background-color:#f5f5f5">
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div style="margin-top:30px"></div>
<div class="row" style="width:1050px; margin:auto;">
	<jsp:include page="../../include/sideusers.jsp"></jsp:include>
	<div class="col-9">
		<h1 class="d-flex justify-content-center">${id}님 환영합니다</h1>
		<div class="profileBox">
			<h3>
				<a href="${pageContext.request.contextPath }/users/private/my_review.do">내가 작성한 리뷰
					<img src="${pageContext.request.contextPath }/resources/images/myreview.png" class="menuIcon"/>
				</a>
			</h3>
		</div>
		<div class="profileBox">
			<h3>
				<a href="${pageContext.request.contextPath }/users/private/my_order.do">주문 조회
					<img src="${pageContext.request.contextPath }/resources/images/delivery.png" class="menuIcon"/>
				</a>
			</h3>
		</div>
		<div class="profileBox">
			<h3>
				<a href="${pageContext.request.contextPath }/users/private/pwd_updateform.do">비밀번호 수정
					<img src="${pageContext.request.contextPath }/resources/images/password.png" class="menuIcon"/>
				</a>
			</h3>
		</div>
		<div class="profileBox">
			<h3>
				<a href="${pageContext.request.contextPath }/users/private/updateform.do">개인정보 수정
					<img src="${pageContext.request.contextPath }/resources/images/info.png" class="menuIcon"/>
				</a>
			</h3>
		</div>
	</div><!-- col-9 END -->
</div><!-- row End -->
<script>
//회원탈퇴묻기
function deleteConfirm(){
		let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		} else {
			location.reload();
		}
}
</script>
</body>
</html>
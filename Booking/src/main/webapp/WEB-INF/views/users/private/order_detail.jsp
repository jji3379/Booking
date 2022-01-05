<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="content">
	<div class="order-info">
		<div class="orderDetail-num">주문번호 <span>1234567890</span></div>
		<div class="orderDetail-date">주문일자 <span>2022/01/02</span></div>
	</div>
	<div class="orderDetail-tb">
		<h3>booking</h3>
		<div class="orderDetail-tbody">
			<div class="orderDetail-tr">
				<a href="">
					<img class="left" src="https://bookthumb-phinf.pstatic.net/cover/164/054/16405427.jpg?type=m1&udate=20210813" alt="" />
					<div class="right">
						<div>팩토리나인</div>
						<div>달러구트 꿈 백화점</div>
						<div>이미예</div>
						<div>1</div>
						<span>13800</span>>
						<span>12420</span> 원
					</div>
					<div class="action">
						<button>리뷰 작성하기</button>
					</div>
				</a>
			</div>
			<div class="orderDetail-tr">
				<a href="">
					<img class="left" src="https://bookthumb-phinf.pstatic.net/cover/164/054/16405427.jpg?type=m1&udate=20210813" alt="" />
					<div class="right">
						<div>팩토리나인</div>
						<div>달러구트 꿈 백화점</div>
						<div>이미예</div>
						<span>13800</span>>
						<span>12420</span> 원
					</div>
					<div class="action">
						<button>리뷰 작성하기</button>
					</div>
				</a>
			</div>
		</div>
		<div class="orderDetail-payment">
			<h3>결제 정보</h3>
			<div class="orderDetail-rows">
				<div class="orderDetail-row">
					<div class="orderDetail-label">상품가</div>
					<div class="orderDetail-price">13800 원</div>
				</div>
				<div class="orderDetail-row">
					<div class="orderDetail-label">할인</div>
					<div class="discount orderDetail-price">-1380 원</div>
				</div>
				<div class="orderDetail-row">
					<div class="orderDetail-label">배송비</div>
					<div class="orderDetail-price">2500 원</div>
				</div>
				<hr style="margin: 15px 0;"/>
				<div class="final-price orderDetail-row">
					<div class="orderDetail-label">최종결제 금액</div>
					<div class="orderDetail-price">14920 원</div>
				</div>
			</div>
		</div>
	</div>
</div>  
</body>
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
</html>
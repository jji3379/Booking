<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css">
<style>

</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<a href="${pageContext.request.contextPath }/user/${sessionScope.id}/info">
				<h4>안녕하세요 ,</h4>
				<span>${loginId } </span>님!
			</a>
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="${pageContext.request.contextPath }/user/${sessionScope.id}/review">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="reviewCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="${pageContext.request.contextPath }/user/${sessionScope.id}/reply">
					<dl id="top-reply" class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="replyCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="${pageContext.request.contextPath }/user/${sessionScope.id}/cart">
					<dl class="card">
						<dt class="label">
							<span>북카트 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="cartCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="navigation">
			<div class="section">
				<div class="section-name">나의 쇼핑</div>
				<div class="linkList">
					<a id="side-order" class="link" href="${pageContext.request.contextPath }/user/${sessionScope.id}/order">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="${pageContext.request.contextPath }/user/${sessionScope.id}/account">계정정보 수정</a>
					<a id="side-pwd" class="link" href="${pageContext.request.contextPath }/user/${sessionScope.id}/pwd">비밀번호 수정</a>
					<a id="side-recent" class="link" href="${pageContext.request.contextPath }/user/${sessionScope.id}/search">최근 검색 기록</a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">북킹 소개</div>
			</div>
			<button class="logoutBtn">
				<a href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a>
       		</button>
     	 </div>
      <div class="content">
         <div class="order-info">
            <div class="orderDetail-num">주문번호 <span id="orderDetailNum">1234567890</span></div>
            <div class="orderDetail-date">주문일자 <span id="orderDate">2022/01/02</span></div>
         </div>
         <div class="orderDetail-tb">
            <h3>booking</h3>
            <div class="orderDetail-tbody" id="orderDetailList">
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
                     <div class="orderDetail-price" id="originalTotalPrice">13800 원</div>
                  </div>
                  <div class="orderDetail-row">
                     <div class="orderDetail-label">할인</div>
                     <div class="discount orderDetail-price" id="discountPrice">-1380 원</div>
                  </div>
                  <div class="orderDetail-row">
                     <div class="orderDetail-label">배송비</div>
                     <div class="orderDetail-price" id="deliveryFee">2500 원</div>
                  </div>
                  <hr style="margin: 15px 0;"/>
                  <div class="final-price orderDetail-row">
                     <div class="orderDetail-label">최종결제 금액</div>
                     <div class="orderDetail-price" id="totalPrice">14920 원</div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>  
<script>
	//작성글, 작성 댓글, 북카트, 나의 정보 호출
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/user/${id}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			
			$("#reviewCount").html(data.review.totalElements);
			$("#replyCount").html(data.reviewDtl.totalElements);
			$("#cartCount").html(data.cart.totalElements);
			
		},
		error : function(data) {
			console.log("오류");
		}
	});

	$.ajax({
		url:"${pageContext.request.contextPath}/v1/user/${sessionScope.id}/order/${orderId}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			$("#orderDetailNum").html(data[0].orderNum.regdate.replace('-','').replace('-','').slice(0,8)+(data[0].orderNum.id+"").padStart(8,'0'));
			$("#orderDate").html(data[0].orderNum.regdate);
			var orderDetail = "";				
			var originalTotalPrice = 0;
			var discountPrice = 0;
			
			for(var i=0; i<data.length; i++){
				originalTotalPrice += data[i].price;
				discountPrice += data[i].d_price;
				
				orderDetail += '<div class="orderDetail-tr">'
					orderDetail += '<a href="${pageContext.request.contextPath}/new-review/'+data[i].isbn+'">'
						orderDetail += '<img class="left" src="'+data[i].image+'" alt="" />'
						orderDetail += '<div class="right">'
							orderDetail += '<div>'+data[i].publisher+'</div>'
							orderDetail += '<div>'+data[i].title+'</div>'
							orderDetail += '<div>'+data[i].author+'</div>'
							orderDetail += '<div>'+data[i].count+'</div>'
							orderDetail += '<span class="bookPrice">'+data[i].price.toLocaleString()+'</span>>'
							orderDetail += '<span class="bookDiscountPrice">'+data[i].d_price.toLocaleString()+'</span> 원'
						orderDetail += '</div>'
						orderDetail += '<div class="action">'
							orderDetail += '<button>리뷰 작성하기</button>'
						orderDetail += '</div>'
					orderDetail += '</a>'
				orderDetail += '</div>'
			}
			$("#orderDetailList").html(orderDetail);
			
			$("#originalTotalPrice").html(originalTotalPrice.toLocaleString()+" 원");
			if(originalTotalPrice >= 20000) {
				$("#deliveryFee").html(0+" 원");
			}else{
				$("#deliveryFee").html(2500+" 원");
			}
			$("#discountPrice").html(discountPrice-originalTotalPrice+" 원");

			$("#totalPrice").html(data[0].orderNum.totalPrice.toLocaleString()+" 원");
				
		},
		error : function(data) {
			console.log("오류");
		}
	});

	
</script>
</body>
</html>
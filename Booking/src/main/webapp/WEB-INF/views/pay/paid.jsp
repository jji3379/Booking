<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#headset{
		width:85px;
		height:85px;
	}
	#btn1{
		margin-right:10px;
		background-color:#135fa1;
		
	}
	#btn2{
		margin-left:10px;
		background-color:#135fa1;
	}
</style>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/paid.css">

</head>
<body>
<div class="layout">
   <div class="breadcrumb">
      <ul class="steps">
           <li class="location">
              <span>주문완료</span> 주문이 성공적으로 완료되었습니다.
           </li>
         <li class="step">
              <a >북카트</a>
         </li>
         <li class="step">
              <a>주문 / 결제</a>
         </li>
         <li class="active">
              <a>주문 완료</a>
         </li>
      </ul>
   </div>
   <div class="orderWrap">
      <div class="order-box">
         <div class="order-header">
              <svg id="headset" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-headset" viewBox="0 0 16 16">
               <path d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5z"/>
            </svg>
         </div>
         <div class="order-body">
             <h5 class="order-msg">
                <strong>${loginId }</strong> 님의 주문이 정상적으로 완료되었습니다.
             </h5>
              <p>
              자세한 구매내역 확인은 <strong>마이페이지 > 주문내역</strong> 에서 확인 하실수 있습니다.
              </p>
              <div class="order-info">
                 <div class="order-num">
                    <p>주문번호</p>
                    <p class="order-text" id="orderNumber"></p>
                 </div>
                 <div class="order-date">
                    <p>주문일자</p>
                    <p class="order-text" id="orderDate"></p>
                 </div>
              </div>
         </div>
         <div class="order-footer">
            <a class="btn home" href="${pageContext.request.contextPath }/home.do" >계속 쇼핑하기</a> 
            <a class="btn order" href="${pageContext.request.contextPath }/user/${sessionScope.id}/order" >구매내역 확인</a>
         </div>
      </div>
   </div>
</div>
<script>
$.ajax({ 
   	url:"${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}",
    method:"get",
    success:function(data){
    	$("#orderNumber").html(data.content[0].regdate.replace('-','').replace('-','').slice(0,8)+(data.content[0].id+"").padStart(8,'0'));
    	$("#orderDate").html(data.content[0].regdate.slice(0, 10));
    }	
           
})
</script>
</body>
</html>
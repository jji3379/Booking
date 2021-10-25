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
</head>
<body>
<div class="card text-center">
  <div class="card-header">
    <h1>결제완료</h1>
  </div>
  <div class="card-body">
    <h5 class="card-title"> <strong>${id }</strong> 님의 주문이 정상적으로 완료되었습니다.</h5>
    <p class="card-text">
    	<svg id="headset" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-headset" viewBox="0 0 16 16">
  		<path d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5z"/>
		</svg>
    	 <br />
    	결제하신내역은 <strong>마이페이지 > 주문내역</strong> 에서 확인 하실수 있습니다.
    </p>
  </div>
  <div class="card-footer text-muted">
    <a id="btn1" href="${pageContext.request.contextPath }/home.do" class="btn btn-secondary">계속 쇼핑하기</a> <a id="btn2" href="../users/private/my_order.do" class="btn btn-secondary">구매내역 확인</a>
  </div>
</div>
</body>
</html>
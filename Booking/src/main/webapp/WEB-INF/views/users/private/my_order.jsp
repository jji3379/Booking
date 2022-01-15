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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.date.css">
<style>

</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<h4>안녕하세요 ,</h4>
			<span>catacat3 </span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="my_review.do">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count">3</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="my_reply.do">
					<dl id="top-reply" class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count">3</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="${pageContext.request.contextPath }/pay/cart.do">
					<dl class="card">
						<dt class="label">
							<span>북카트 ></span>
						</dt>
						<dd class="value">
							<span class="count">0</span>
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
					<a id="side-order" class="link" href="my_order.do">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="updateform.do">계정정보 수정</a>
					<a id="side-pwd" class="link" href="pwd_updateform.do">비밀번호 수정</a>
					<a id="side-recent" class="link" href="recentSearch.do">최근 검색 기록</a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">북킹 소개</div>
			</div>
			<button class="logoutBtn">
				<div>로그아웃</div>
			</button>
		</div>
		<div class="content">
			<div class="order-box">
				<h2>주문 내역</h2>
				<div class="myOrder-dateSort">
					<div class="myOrder-dateSort-main">
						<a href="javascript:" id="week">1주일</a>
						<a href="javascript:" id="month">1개월</a>
						<a href="javascript:" id="3month">3개월</a>
						<a href="javascript:" id="allDate">전체기간</a>
					</div>
					<div class="datepicker-div">
						<input type="text" name="startDate" class="datepicker" id="startDate" placeholder="-" />
						<img class="datepickerBtn" src="${pageContext.request.contextPath}/resources/images/calendar.svg" alt="날짜 선택" title="날짜 선택" />
					</div>
					<div class="datepicker-div">
						<input type="text" name="endDate" class="datepicker" id="endDate" placeholder="-" />
						<img class="datepickerBtn" src="${pageContext.request.contextPath}/resources/images/calendar.svg" alt="날짜 선택" title="날짜 선택" />
					</div>
					<button class="dateBtn">조회</button>
				</div>
				<div class="order-th">
					<div class="order-th-L">주문번호 / 일자</div>
					<div class="order-th-R">주문금액(수량)</div>
				</div>
				<div class="order-tbody">
					<ul class="order-list"></ul>
					<nav id="paging">
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/picker.date.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>
<script>
	$( '.datepicker' ).pickadate({
	    format: 'yyyy-mm-dd',
	    formatSubmit: 'yyyy-mm-dd'
	})
	
	$('.datepicker').pickadate();

	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
	
	function termOrder(page) {
		var data = {
				startDate:$("#startDate").val(),
				endDate:$("#endDate").val()
			};
		
	    $.ajax({ 
	       	url:"${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}?page="+page,
	        method:"post",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
	        success:function(data){
	        	var orderList = "";
		        	orderList += '<ul class="order-list">'
		        	
		        	for (var i=0; i<data.content.length; i++) {
			        	orderList += '<li class="order">'
				        	orderList += '<a id="orderDetail'+[i]+'" href="${pageContext.request.contextPath}/users/private/myOrder/detail/'+data.content[i].id+'">'
					        	orderList += '<div class="order-td-L">'
						        	orderList += '<div class="myOrder-num">'+data.content[i].regdate.replace('-','').replace('-','').slice(0,8)+(data.content[i].id+"").padStart(8,'0')+'</div>'
						        	orderList += '<div class="myOrder-date">'+data.content[i].regdate+'</div>'	
						        orderList += '</div>'
						        orderList += '<div class="order-td-R">'
						        	orderList += '<div class="myOrder-price">'+data.content[i].totalPrice+'</div>'
						        	orderList += '<div class="myOrder-count">'+data.content[i].orderCount+'</div>'				
						        orderList += '</div>'
					        	orderList += '<span class="detailBtn">></span>'
				        	orderList += '</a>'
			        	orderList += '</li>'
		        	}
		        	
		        	orderList += '</ul>'
	        		orderList += '<nav id = "paging">'
        			orderList += '</nav>'

     			
        		$(".order-tbody").html(orderList);
            	
				window.pagObj = $('#paging').twbsPagination({ 
					totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
					startPage: data.number+1, 
					visiblePages: 5, 
					prev: "‹", 
					next: "›", 
					first: '«', 
					last: '»', 
					onPageClick: function (event, page) { 
					} 
				}).on('page', function (event, page) { 
					termOrder(page-1);
				});
	        	
	        },
			error : function(data) {
				console.log("오류");
			}
       	})
	}
	
	function allDateOrder(page) {
	    $.ajax({ 
	       	url:"${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}?page="+page,
	        method:"get",
	        success:function(data){
	        	var orderList = "";

	        	orderList += '<ul class="order-list">'
		        	
		        	for (var i=0; i<data.content.length; i++) {
			        	orderList += '<li class="order">'
				        	orderList += '<a id="orderDetail'+[i]+'" href="${pageContext.request.contextPath}/users/private/myOrder/detail/'+data.content[i].id+'">'
					        	orderList += '<div class="order-td-L">'
						        	orderList += '<div class="myOrder-num">'+data.content[i].regdate.replace('-','').replace('-','').slice(0,8)+(data.content[i].id+"").padStart(8,'0')+'</div>'
						        	orderList += '<div class="myOrder-date">'+data.content[i].regdate+'</div>'	
						        orderList += '</div>'
						        orderList += '<div class="order-td-R">'
						        	orderList += '<div class="myOrder-price">'+data.content[i].totalPrice+'</div>'
						        	orderList += '<div class="myOrder-count">'+data.content[i].orderCount+'</div>'				
						        orderList += '</div>'
					        	orderList += '<span class="detailBtn">></span>'
				        	orderList += '</a>'
			        	orderList += '</li>'
		        	}
		        	
		        	orderList += '</ul>'
	        		orderList += '<nav id = "paging">'
        			orderList += '</nav>'

     			
        		$(".order-tbody").html(orderList);
	        	
				window.pagObj = $('#paging').twbsPagination({ 
					totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
					startPage: data.number+1, 
					visiblePages: 5, 
					prev: "‹", 
					next: "›", 
					first: '«', 
					last: '»', 
					onPageClick: function (event, page) { 
					} 
				}).on('page', function (event, page) { 
					allDateOrder(page-1);
				});
	        }    
       	})
	}
	
	// 초기 로딩
	$(document).ready(function(){
	    $.ajax({ 
	       	url:"${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}",
	        method:"get",
	        success:function(data){
	        	var orderList = "";
	        	orderList += '<ul class="order-list">'
		        	
		        	for (var i=0; i<data.content.length; i++) {
			        	orderList += '<li class="order">'
				        	orderList += '<a id="orderDetail'+[i]+'" href="${pageContext.request.contextPath}/users/private/myOrder/detail/'+data.content[i].id+'">'
					        	orderList += '<div class="order-td-L">'
						        	orderList += '<div class="myOrder-num">'+data.content[i].regdate.replace('-','').replace('-','').slice(0,8)+(data.content[i].id+"").padStart(8,'0')+'</div>'
						        	orderList += '<div class="myOrder-date">'+data.content[i].regdate+'</div>'	
						        orderList += '</div>'
						        orderList += '<div class="order-td-R">'
						        	orderList += '<div class="myOrder-price">'+data.content[i].totalPrice+'</div>'
						        	orderList += '<div class="myOrder-count">'+data.content[i].orderCount+'</div>'				
						        orderList += '</div>'
					        	orderList += '<span class="detailBtn">></span>'
				        	orderList += '</a>'
			        	orderList += '</li>'
		        	}
		        	
		        	orderList += '</ul>'
	        		orderList += '<nav id = "paging">'
        			orderList += '</nav>'

     			
        		$(".order-tbody").html(orderList);
     			
				window.pagObj = $('#paging').twbsPagination({ 
					totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
					startPage: data.number+1, 
					visiblePages: 5, 
					prev: "‹", 
					next: "›", 
					first: '«', 
					last: '»', 
					onPageClick: function (event, page) { 
					} 
				}).on('page', function (event, page) { 
					allDateOrder(page-1);
				});
	        }    
       	})
	})
	
	// 사용자 지정 날짜 조회
	$(".dateBtn").on("click", function(){
		termOrder(0);
	});
	
	// 1주일 조회
	$("#week").on("click", function(){
		var today = new Date();
		$("#endDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		today.setDate(today.getDate() - 7)
		$("#startDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		termOrder(0);
	});
	
	// 1개월 조회
	$("#month").on("click", function(){
		var today = new Date();
		$("#endDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		today.setMonth(today.getMonth() - 1)
		$("#startDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		termOrder(0);
	});
	
	// 3개월 조회
	$(document).on("click", "#3month", function(){
		var today = new Date();
		$("#endDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		today.setMonth(today.getMonth() - 3)
		$("#startDate").val(today.toLocaleDateString().replace('. ','-').replace('. ','-').replace('.',''));
		termOrder(0);
	});
	
	// 전체 조회
	$(document).on("click", "#allDate", function(){
		$("#endDate").val('');
		$("#startDate").val('');
		allDateOrder(0);
	});
	
	
	// by욱현. 주문내역 주문금액 표기법_2021322
 	let totalnum = $('#status').text(); 
	for(let i=1;i<=totalnum; i++) {
		
		let value = $('#totalPayment'+i).text();
		
		let result = addComma(value);
		
		$('#commaplusPayment'+i).text(result + "원");
		
	}
	
	function addComma(num){
		let regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	//회원탈퇴묻기
	function deleteConfirm(){
		let isDelete=confirm(" 회원님 정말로 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath}/users/private/delete.do";
		} else {
			location.reload();
		}
	}
</script>
</body>
</html>
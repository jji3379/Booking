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
</head>
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
				<a class="bd-card" href="javascript:">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="myReview">3</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="javascript:">
					<dl id="top-reply" class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="myReply">3</span>
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
							<span class="count" id="myCart">0</span>
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
					<a id="side-order" class="link" href="javascript:">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="javascript:">계정정보 수정</a>
					<a id="side-pwd" class="link" href="javascript:">비밀번호 수정</a>
					<a id="side-recent" class="link" href="javascript:">최근 검색 기록</a>
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
			<ul class="content-list">
				<li class="part">
					<div class="part-header">
						최근 주문내역
						<a href="">주문전체보기 ></a>
					</div>
					<div id="myOrder" class="part-body">
						<table>
							<colgroup>
								<col style="width:60%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div>총 1개 상품</div>
									</td>
									<td>
										<div>2021/10/10</div>
									</td>
									<td>
										<div class="order-num">1234567890</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
				<li class="part">
					<div class="part-header">
						내 계정 정보
						<a href="">변경하기 ></a>
					</div>
					<div class="part-body">
						<div class="info-account">
							catcat3
							<br />
							catcat3@naver.com
							<br />
							<span>고양이</span>
						</div>
					</div>
				</li>
			</ul>
			<nav id = "paging">
			</nav>
		</div>
	</div>
</div>
			
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>	
<script>
//by준영, 현재시간 출력
let today = new Date();

$('#date').html(today.toLocaleString());
	
	// 작성글 토탈
	$.ajax({ 
	   	url:"${pageContext.request.contextPath}/v1/users/review/${sessionScope.id}",
	    method:"GET",
	    success:function(data){
	    	$("#myReview").html(data.totalElements);
	    },
	})
	
	// 작성글 토탈
	$.ajax({ 
	   	url:"${pageContext.request.contextPath}/v1/users/reply/${sessionScope.id}",
	    method:"GET",
	    success:function(data){
	    	$("#myReply").html(data.totalElements);
	    },
	})
	
	// 작성글 토탈
	$.ajax({ 
	   	url:"${pageContext.request.contextPath}/v1/users/cart/${sessionScope.id}",
	    method:"GET",
	    success:function(data){
	    	$("#myCart").html(data.totalElements);
	    },
	})

	$('#top-post').on('click',function(){
		function myPost(){
		    $.ajax({ 
		       	url:"${pageContext.request.contextPath}/v1/users/review/${sessionScope.id}",
		        method:"GET",
		        success:function(data){
		        	var reviewList =  "";
		        	reviewList += '<div class="myPost">'
			        	reviewList += '<h1>작성 글 보기</h1>'
			        	reviewList += '<table class="myPost-tb">'
				        	reviewList += '<caption>Total : '+data.totalElements+'</caption>'
				        	reviewList += '<colgroup>'						
					        	reviewList += '<col style="width:10%"/>'
					        	reviewList += '<col style="width:55%"/>'
					        	reviewList += '<col style="width:15%"/>'
					        	reviewList += '<col style="width:10%"/>'
					        	reviewList += '<col style="width:10%"/>'
				        	reviewList += '</colgroup>'						
				        	reviewList += '<thead>'						
					        	reviewList += '<tr class="myPost-tr">'						
						        	reviewList += '<th>번호</th>'						
						        	reviewList += '<th>제목</th>'						
						        	reviewList += '<th>날짜</th>'						
						        	reviewList += '<th>조회 수</th>'						
						        	reviewList += '<th>댓글 수</th>'						
					        	reviewList += '</tr>'						
				        	reviewList += '</thead>'						
				        	reviewList += '<tbody>'
				        		
							for (var i = 0; i < data.content.length; i++) {
								reviewList += '<tr class="myPost-tr">'
									reviewList += '<td>'+(i+1)+'</td>'
									reviewList += '<td class="myPost-tdTitle">'+data.content[i].reviewTitle+'</td>'
									reviewList += '<td>'+data.content[i].regdate.slice(0, 10)+'</td>'
									reviewList += '<td>'+data.content[i].viewCount+'</td>'
									reviewList += '<td>'+data.content[i].viewCount+'</td>'
								reviewList += '</tr>'
							}
							reviewList += '</tbody>'
						reviewList += '</table>'
					reviewList += '</div>'

				$(".content").html(reviewList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		myPost();
	})
	
	$('#top-reply').on('click', function() {
		function myReply() {
			$.ajax({
				url : "${pageContext.request.contextPath}/v1/users/reply/${sessionScope.id}",
				method : "GET",
				success : function(data) {
					var replyList =  "";
		        	replyList += '<div class="myReply">'
			        	replyList += '<h1>작성 댓글 보기</h1>'
			        	replyList += '<table class="myReply-tb">'
				        	replyList += '<caption>Total : '+data.totalElements+'</caption>'
				        	replyList += '<colgroup>'						
					        	replyList += '<col style="width:8%"/>'
					        	replyList += '<col style="width:57%"/>'
					        	replyList += '<col style="width:15%"/>'
					        	replyList += '<col style="width:20%"/>'
				        	replyList += '</colgroup>'						
				        	replyList += '<thead>'						
					        	replyList += '<tr class="myReply-tr">'						
						        	replyList += '<th>번호</th>'						
						        	replyList += '<th>댓글</th>'						
						        	replyList += '<th>날짜</th>'						
						        	replyList += '<th>원문</th>'						
					        	replyList += '</tr>'						
				        	replyList += '</thead>'						
				        	replyList += '<tbody>'
				        		
							for (var i = 0; i < data.content.length; i++) {
								replyList += '<tr class="myReply-tr">'
									replyList += '<td>'+(i+1)+'</td>'
									replyList += '<td class="myReply-tdReply">'+data.content[i].content+'</td>'
									replyList += '<td>'+data.content[i].regdate.slice(0, 10)+'</td>'
									replyList += '<td class="myReply-tdTitle">'+data.content[i].content+'</td>'
								replyList += '</tr>'
							}
							replyList += '</tbody>'
						replyList += '</table>'
					replyList += '</div>'
					$(".content").html(replyList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		myReply();
	})
	$('#side-order').on('click',function() {
		function my_order() {
			$.ajax({
				url : "${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}",
				method : "GET",
				success : function(data) {
					var orderList = "";
					orderList += '<div class="content">'
						orderList += '<div class="order-box">'
							orderList += '<h2>주문 내역</h2>'
							orderList += '<ul class="order-list">'

							for (var i = 0; i < data.length; i++) {
								orderList += '<li class="order">'
									orderList += '<a class="" href="#" onclick="orderDetail('+data[i].id+')">'
										orderList += '<div>'
											orderList += '<div class="myOrder-num">'+ data[i].o_date.replace('-','').replace('-','').slice(0, 8)+ (data[i].id + "").padStart(8,'0')+ '</div>'
											orderList += '<div class="myOrder-date">'+ data[i].o_date + '</div>'
										orderList += '</div>'
										orderList += '<span class="detailBtn">></span>'
									orderList += '</a>'
								orderList += '</li>'
							}

							orderList += '</ul>'
						orderList += '</div>'
					orderList += '</div>'
					$(".content").html(orderList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		my_order();
	})
	
	function orderDetail(id) {
	$.ajax({
		url : "${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}",
		method : "GET",
		success : function(data) {
			var orderList = "";
			orderList += '<div class="content">'
				orderList += '<div class="order-box">'
					orderList += '<h2>주문 내역</h2>'
					orderList += '<ul class="order-list">'

					for (var i = 0; i < data.length; i++) {
						orderList += '<li class="order">'
							orderList += '<a class="" href="#" onclick="orderDetail('+data[i].id+')">'
								orderList += '<div>'
									orderList += '<div class="myOrder-num">'+ data[i].o_date.replace('-','').replace('-','').slice(0, 8)+ (data[i].id + "").padStart(8,'0')+ '</div>'
									orderList += '<div class="myOrder-date">'+ data[i].o_date + '</div>'
								orderList += '</div>'
								orderList += '<span class="detailBtn">></span>'
							orderList += '</a>'
						orderList += '</li>'
					}

					orderList += '</ul>'
				orderList += '</div>'
			orderList += '</div>'
			$(".content").html(orderList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		},

	})
}

	//sidebar ajax
	$('#side-profile').on('click', function() {
		function updateProfile() {
			$.ajax({
				url : "updateform.do",
				method : "GET",
				success : function(data) {
					$(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		updateProfile();
	})
	$('#side-pwd').on('click', function() {
		function updatePwd() {
			$.ajax({
				url : "pwd_updateform.do",
				method : "GET",
				success : function(data) {
					$(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		updatePwd();
	})
	$('#side-recent').on('click', function() {
		function recentSearch() {
			$.ajax({
				url : "recentSearch.do",
				method : "GET",
				success : function(data) {
					$(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
				},

			})
		}
		recentSearch();
	})

	//회원탈퇴묻기
	function deleteConfirm() {
		let isDelete = confirm(" 회원님 정말로 탈퇴 하시겠습니까?");
		if (isDelete) {
			location.href = "${pageContext.request.contextPath}/users/private/delete.do";
		} else {
			location.reload();
		}
	}
</script>
</body>
</html>
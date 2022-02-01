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
			<div class="myPost">
				<h1>작성 글 보기</h1>
				<table class="myPost-tb">
					<caption>Total : 3</caption>
					<colgroup>						
						<col style="width:8%"/>
						<col style="width:42%"/>
						<col style="width:20%"/>
						<col style="width:10%"/>
						<col style="width:10%"/>
					</colgroup>
					<thead>
						<tr class="myPost-tr">
							<th>번호</th>
							<th>제목</th>
							<th>날짜</th>
							<th>조회 수</th>
							<th>댓글 수</th>
						</tr>
					</thead>
					<tbody id="reviewList">
						<tr class="myPost-tr">
							<td>3</td>
							<td class="myPost-tdTitle">달러구트를 읽고..</td>
							<td>2022/01/03</td>
							<td>31</td>
							<td>3</td>
						</tr>
						<tr class="myPost-tr">
							<td>2</td>
							<td class="myPost-tdTitle">달러구트2를 읽고..</td>
							<td>2022/01/02</td>
							<td>21</td>
							<td>3</td>
						</tr>
						<tr class="myPost-tr">
							<td>1</td>
							<td class="myPost-tdTitle">아몬드를 읽고..</td>
							<td>2022/01/01</td>
							<td>1</td>
							<td>1</td>
						</tr>
					</tbody>
				</table>
				<nav id = "paging">
				</nav>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>
<script>
	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
	
	function pagingList(page) {
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/users/${id}?page="+page,
			method:"GET",
			dataType : "json",
			async: false,
			success:function(data) {
				$("#reviewCount").html(data.review.totalElements);
				$("#replyCount").html(data.reviewDtl.totalElements);
				$("#cartCount").html(data.cart.totalElements);
				
				reviewList = "";
					reviewList += '<div class="myPost">'
						reviewList += '<h1>작성 글 보기</h1>'
						reviewList += '<table class="myPost-tb">'
							reviewList += '<caption>Total : '+data.review.totalElements+'</caption>'
							reviewList += '<colgroup>'
								reviewList += '<col style="width:8%"/>'
								reviewList += '<col style="width:42%"/>'
								reviewList += '<col style="width:20%"/>'
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
					
							for(var i=0; i<data.review.content.length; i++){				
								reviewList += '<tr class="myPost-tr post-tbody" data-num="'+data.review.content[i].id+'" onclick="javascript:" >'
									reviewList += '<td>'+((data.review.number*5)+i+1)+'</td>'
									reviewList += '<td class="myPost-tdTitle">'+data.review.content[i].reviewTitle+'</td>'
									reviewList += '<td>'+data.review.content[i].regdate+'</td>'
									reviewList += '<td>'+data.review.content[i].viewCount+'</td>'
									reviewList += '<td>'+data.review.content[i].replyCount+'</td>'
								reviewList += '</tr>'				
							}
							reviewList += '</tbody>'
						reviewList += '</table>'
						reviewList += '<nav id = "paging">'
						reviewList += '</nav>'
					reviewList += '</div>'
				$(".content").html(reviewList);
			
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.review.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.review.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
				} 
			}).on('page', function (event, page) { 
				pagingList(page-1);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	}
	pagingList(0);
	
	//by준영, 작성글 클릭시 detail 링크 
	$(document).on("click",".post-tbody", function(){
		var id = $(this).attr("data-num");
		location.href="${pageContext.request.contextPath }/review/"+id;
	});
	/*
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/users/${id}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			$("#reviewCount").html(data.review.totalElements);
			$("#replyCount").html(data.reviewDtl.totalElements);
			$("#cartCount").html(data.cart.totalElements);
			
			reviewList = "";
				reviewList += '<div class="myPost">'
					reviewList += '<h1>작성 글 보기</h1>'
					reviewList += '<table class="myPost-tb">'
						reviewList += '<caption>Total : '+data.review.totalElements+'</caption>'
						reviewList += '<colgroup>'
							reviewList += '<col style="width:8%"/>'
							reviewList += '<col style="width:42%"/>'
							reviewList += '<col style="width:20%"/>'
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
				
						for(var i=0; i<data.review.content.length; i++){				
							reviewList += '<tr class="myPost-tr">'
								reviewList += '<td>'+(i+1)+'</td>'
								reviewList += '<td class="myPost-tdTitle">'+data.review.content[i].reviewTitle+'</td>'
								reviewList += '<td>'+data.review.content[i].regdate+'</td>'
								reviewList += '<td>'+data.review.content[i].viewCount+'</td>'
								reviewList += '<td>'+data.review.content[i].replyCount+'</td>'
							reviewList += '</tr>'				
						}
						reviewList += '</tbody>'
					reviewList += '</table>'
					reviewList += '<nav id = "paging">'
					reviewList += '</nav>'
				reviewList += '</div>'
			$(".content").html(reviewList);
				
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.review.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.review.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
				} 
			}).on('page', function (event, page) { 
				pagingList(page-1);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	*/
	
</script>
</body>
</html>
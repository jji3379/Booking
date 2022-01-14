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
							<span class="count" id="reviewCount"></span>
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
							<span class="count" id="replyCount"></span>
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
			<div class="myReply">
				<h1>작성 댓글 보기</h1>
				<table class="myReply-tb">
					<caption>Total : 3</caption>
					<colgroup>						
						<col style="width:8%"/>
						<col style="width:57%"/>
						<col style="width:15%"/>
						<col style="width:20%"/>
					</colgroup>
					<thead>
						<tr class="myReply-tr">
							<th>번호</th>
							<th>댓글</th>
							<th>날짜</th>
							<th>원문</th>
						</tr>
					</thead>
					<tbody>
						<tr class="myReply-tr">
							<td>3</td>
							<td class="myReply-tdReply">달러구트 별로던데..</td>
							<td>2022/01/03 11:31</td>
							<td class="myReply-tdTitle">달러구트를 읽고...</td>
						</tr>
						<tr class="myReply-tr">
							<td>2</td>
							<td class="myReply-tdReply">달러구트2는 내지말았어야함</td>
							<td>2022/01/02 11:12</td>
							<td class="myReply-tdTitle">달러구트2를 읽고...</td>
						</tr>
						<tr class="myReply-tr">
							<td>1</td>
							<td class="myReply-tdReply">아몬드브리즈 맛있어</td>
							<td>2022/01/01 11:11</td>
							<td class="myReply-tdTitle">아몬드를 읽고</td>
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
							reviewList += '<caption>Total : '+data.reviewDtl.totalElements+'</caption>'
							reviewList += '<colgroup>'
								reviewList += '<col style="width:8%"/>'
								reviewList += '<col style="width:52%"/>'
								reviewList += '<col style="width:20%"/>'
								reviewList += '<col style="width:20%"/>'
							reviewList += '</colgroup>'
							reviewList += '<thead>'
								reviewList += '<tr class="myPost-tr">'
									reviewList += '<th>번호</th>'
									reviewList += '<th>댓글</th>'
									reviewList += '<th>날짜</th>'
									reviewList += '<th>원문</th>'
								reviewList += '</tr>'
							reviewList += '</thead>'
							reviewList += '<tbody>'
					
							for(var i=0; i<data.reviewDtl.content.length; i++){				
								reviewList += '<tr class="myPost-tr">'
									reviewList += '<td>'+((data.reviewDtl.number*5)+i+1)+'</td>'
									reviewList += '<td class="myPost-tdTitle">'+data.reviewDtl.content[i].content+'</td>'
									reviewList += '<td>'+data.reviewDtl.content[i].regdate+'</td>'
									reviewList += '<td>'+data.reviewDtl.content[i].refGroup.reviewTitle+'</td>'
								reviewList += '</tr>'				
							}
							reviewList += '</tbody>'
						reviewList += '</table>'
						reviewList += '<nav id = "paging">'
						reviewList += '</nav>'
					reviewList += '</div>'
				$(".content").html(reviewList);
					
				window.pagObj = $('#paging').twbsPagination({ 
					totalPages: data.reviewDtl.totalPages, // 호출한 api의 전체 페이지 수 
					startPage: data.reviewDtl.number+1, 
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
						reviewList += '<caption>Total : '+data.reviewDtl.totalElements+'</caption>'
						reviewList += '<colgroup>'
							reviewList += '<col style="width:8%"/>'
							reviewList += '<col style="width:52%"/>'
							reviewList += '<col style="width:20%"/>'
							reviewList += '<col style="width:20%"/>'
						reviewList += '</colgroup>'
						reviewList += '<thead>'
							reviewList += '<tr class="myPost-tr">'
								reviewList += '<th>번호</th>'
								reviewList += '<th>댓글</th>'
								reviewList += '<th>날짜</th>'
								reviewList += '<th>원문</th>'
							reviewList += '</tr>'
						reviewList += '</thead>'
						reviewList += '<tbody>'
				
						for(var i=0; i<data.reviewDtl.content.length; i++){				
							reviewList += '<tr class="myPost-tr">'
								reviewList += '<td>'+(i+1)+'</td>'
								reviewList += '<td class="myPost-tdTitle">'+data.reviewDtl.content[i].content+'</td>'
								reviewList += '<td>'+data.reviewDtl.content[i].regdate+'</td>'
								reviewList += '<td>'+data.reviewDtl.content[i].refGroup.reviewTitle+'</td>'
							reviewList += '</tr>'				
						}
						reviewList += '</tbody>'
					reviewList += '</table>'
					reviewList += '<nav id = "paging">'
					reviewList += '</nav>'
				reviewList += '</div>'
			$(".content").html(reviewList);
				
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.reviewDtl.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.reviewDtl.number+1, 
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
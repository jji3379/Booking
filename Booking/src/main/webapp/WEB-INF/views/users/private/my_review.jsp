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
			<div class="myPost">
				<h1>작성 글 보기</h1>
				<table class="myPost-tb">
					<caption>Total : 3</caption>
					<colgroup>						
						<col style="width:8%"/>
						<col style="width:62%"/>
						<col style="width:10%"/>
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
					<tbody>
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
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="">
								<li class="page-item">
									<a class="page-link" href="reviewList.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">&lt;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">&lt;</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="" end="">
							<c:choose>
								<c:when test="">
									<li class="page-item active">
										<a class="page-link" href="reviewList.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="reviewList.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="">
								<li class="page-item">
									<a class="page-link" href="reviewList.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">&gt;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">&gt;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<script>
	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
	

	$('#top-post').on('click',function(){
		function myPost(){
		    $.ajax({ 
		       	url:"my_review.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	
	
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
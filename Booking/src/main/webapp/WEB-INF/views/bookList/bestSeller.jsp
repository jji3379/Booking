<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bestSeller.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
</style>
</head>
<body>
	<div class="layout">
		<div class="listWrap">
			<h1 class="page-title">
				> Booking 종합 베스트셀러 TOP 200
			</h1>
			<!-- <h2 class="notice-box">
				"<b id="keyword">keyword</b>" 에 대한 검색결과는 
				<b id="key-value">n</b>개의 상품이 검색되었습니다.
			</h2> -->
			<div class="ranking">
				<ul>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=1' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=1">1 위 <img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=51' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=51">51 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=101' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=101">101 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=151' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=151">151 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<div class="date-box">
						<span id="date"></span>
					</div>
				</ul>
				
			</div>
			<form action="">
				 <div class="book-box">
				 	<table>
				 		<colgroup>
				 			<col style="width:90px;">
				 			<col style="width:150px;">
				 			<col style="width:570px;">
				 			<col style="width:105px;">
				 		</colgroup>
				 		<c:forEach var="b" items="${bestSeller}" varStatus="status">
				 			<tr>
					 			<td class="td-info">
					 				<div class="book-rank">${status.count}.</div>
					 			</td>
					 			<td >
					 				<div>
					 					<a href=""><img src="${b.image}" class="book-img"></a>
					 				</div>
					 			</td>
					 			<td class="td-info" >
					 				<div class="infoWrap">
						 				<ul>
											<li class="grid-li bd-title">
												<span class="book-title">${b.title}</span>
											</li>
											<li class="grid-li bd-info">
												<div>
													<span class="book-info">${b.author}</span>
													<span class="book-info">${b.publisher}</span>
													<span class="book-info">${b.pubdate}</span>
												</div>
												<span class="bestSeller">베스트셀러</span>
											</li>
											<li class="grid-li bd-price">
												<div >
													<span class="book-price">${b.price} 원</span> → <span class="discount">${b.discount} 원</span>
												</div> 
											</li>
											<li class="grid-li bd-review">
												 <div class="book-review">
												 	<div class="star-box">
														<span class="total-star">★★★★★</span>
														<span>5.0</span>
													</div>
													<div class="total-comment">(<a href="">163</a>)</div>
												 </div>
											</li> 
										</ul>
									</div>
					 			</td>
					 			<td class="td-info" >
					 				<div class="buttonWrap">
					 					<div >
					 						<button class="cart btn" id="insertBtn">장바구니</button>
					 					</div>
					 					<div >
					 						<button class="buy btn" id="directBtn">바로구매</button>
					 					</div>
				 					</div>
					 			</td>
					 		</tr>
					 		<tr></tr>
				 		</c:forEach>
				 		<tr id="tr-load"></tr>
				 	</table>
				 	<div class="bottom-bar">
				 		바닥
				 	</div>
				 </div>
			</form>
		</div>
		<div id="topButton"><img id="topButtonImg" src="https://image.aladin.co.kr/img/bu/btn_top2.png" alt="맨위로"></div>
		<svg id="loader" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
		  viewBox="0 0 100 100" enable-background="new 0 0 0 0" xml:space="preserve">
		  <circle fill="#fff" stroke="none" cx="6" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 15 ; 0 -15; 0 15" 
		       repeatCount="indefinite" 
		       begin="0.1"/>
		  </circle>
		  <circle fill="#fff" stroke="none" cx="30" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 10 ; 0 -10; 0 10" 
		       repeatCount="indefinite" 
		       begin="0.2"/>
		  </circle>
		  <circle fill="#fff" stroke="none" cx="54" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 5 ; 0 -5; 0 5" 
		       repeatCount="indefinite" 
		       begin="0.3"/>
		  </circle>
		</svg>
	</div>
<script>

	$("#insertBtn, #directBtn, #reviewBtn").click(function(){
		if("${sessionScope.id}" == '') {
			alert("로그인이 필요합니다.");
			document.getElementById('modal-open').click();
			return false;
		}		
	});

	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString() + '&nbsp; 기준');
	
	//by준영, 맨위로 가기 버튼
	$(document).ready(function(){
		$(window).scroll(function(){
		    // top button controll
		    if ($(this).scrollTop() > 500) {
		        $('#topButton').fadeIn();
		    } else {
		        $('#topButton').fadeOut();
		    }
		});

		$("#topButtonImg").click(function(){
			$('html, body').animate({scrollTop:0}, '300');
		});
	});
	
	
</script>
</body>
</html>



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
	.layout {
	    padding: 0;
	    margin: 0 auto;
	    font-family: '777Balsamtint';
	    width: 960px;
	}
	.notice-box{
		font-weight: 500;
		border-bottom: 2px solid #e5e5e5;
		padding: 5px 0 3px 10px;
		margin-bottom: 0;
		font-size: 23px;
	}
	.notice-box > b {
		font-size: 27px;
	}
	.ranking {
		background: url(//bimage.interpark.com/renewPark/reBookpark/rankChart2016/common/img_rankContentsHeader.png) no-repeat;
    	background-size: 100%;
	}
	.ranking > ul {
		margin-block-start: 1em;
		margin-block-end: 1em;
		margin-inline-start: 0px;
		margin-inline-end: 0px;
		padding-inline-start: 0px;
		margin:0;
	}
	.rank-sort {
		display: block;
    	width: 100px;
	}
	.book-box{
	
	}
	.book-box > table {
		width: 100%;
		border-collapse: separate;
    	border-spacing: 0 7px;
	}
	.td-info{
		position: relative;
	}
	.book-rank{
		position: absolute;
		top:0;
		font-size: 40px;
		color: #333;
		border-bottom: 1px solid #333;
    	font-family: "dotum", "sans-serif";
	}
	.infoWrap{
		position: absolute;
		top:0;
		font-size: 22px;
    	color: #333;
	}
	.infoWrap > ul {
		display: grid;
		margin-block-start: 1em;
		margin-block-end: 1em;
		margin-inline-start: 0px;
		margin-inline-end: 0px;
		padding-inline-start: 0px;
		margin:0;
	}
	.buttonWrap{
		position: absolute;
		top: 0;
	}
	.cart{
		width: 125px;
	    border: 1px solid #5db794;
	    background-color: #5db794;
	    color: white;
	    margin-bottom: 4px;
	}
	.buy{
		width: 125px;
	    border: 1px solid #5394CB;
	    background-color: #5394CB;
	    color: white;
	}
	.btn {
		font-family: '777Balsamtint';
	    display: inline-block;
	    font-weight: 400;
	    text-align: center;
	    vertical-align: middle;
	    user-select: none;
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    line-height: 1.5;
	    border-radius: 0.25rem;
    }
</style>
</head>
<body>
	<div class="layout">
		<div class="listWrap">
			<h2 class="notice-box">
				"<b id="keyword">keyword</b>" 에 대한 검색결과는 
				<b id="key-value">n</b>개의 상품이 검색되었습니다.
			</h2>
			<div class="ranking">
				<ul>
					<li><a class="rank-sort">1 ~ 50</a></li>
					<li><a class="rank-sort">51 ~ 100</a></li>
					<li><a class="rank-sort">101 ~ 150</a></li>
					<li><a class="rank-sort">151 ~ 200</a></li>
				</ul>
			</div>
			<form action="">
				 <div class="book-box">
				 	<table>
				 		<colgroup>
				 			<%-- <col style="width:1%">
				 			<col style="width:10%">
				 			<col style="width:75%">
				 			<col style="width:14%"> --%>
				 		</colgroup>
				 		<tr>
				 			<td class="td-info" style="width:50px">
				 				<div class="book-rank">1.</div>
				 			</td>
				 			<td style="width:150px">
				 				<div>
				 					<a href=""><img src="https://image.aladin.co.kr/product/28060/6/cover150/k202734632_1.jpg" width="150" border="0" class="i_cover"></a>
				 				</div>
				 			</td>
				 			<td class="td-info" style="width:450px">
				 				<div class="infoWrap">
					 				<ul>
										<li>
											<span class="book-title">[<a>김치 책 제목</a>]</span><br>
										</li>
										<li>
											<span class="book-info"><a href="">지은이</a> (지은이) | <a href="">발행사</a> | 2022년 1월</span>
										</li>
										<li>
											<span class="book-price">128,000</span>원 → <span class="ss_p2"><b><span class="">115,200</span>원</b></span> 
										</li>
										<li>
											 <span class="book-comment">(<a href="">163</a>)</span>
										</li> 
									</ul>
								</div>
				 			</td>
				 			<td class="td-info" style="width:100px">
				 				<div class="buttonWrap">
				 					<div >
				 						<button class="cart btn">장바구니</button>
				 					</div>
				 					<div >
				 						<button class="buy btn">바로구매</button>
				 					</div>
			 					</div>
				 			</td>
				 		</tr>
				 		<tr></tr>
				 		<!-- 더미 2 -->
				 		<tr>
				 			<td class="td-info" style="width:50px">
				 				<div class="book-rank">2.</div>
				 			</td>
				 			<td style="width:150px">
				 				<div>
				 					<a href=""><img src="https://bookthumb-phinf.pstatic.net/cover/164/054/16405427.jpg?type=m1&udate=20210813" width="150" border="0" class="i_cover"></a>
				 				</div>
				 			</td>
				 			<td class="td-info" style="width:450px">
				 				<div class="infoWrap">
					 				<ul>
										<li>
											<span class="book-title">[<a>김치 책 제목</a>]</span><br>
										</li>
										<li>
											<span class="book-info"><a href="">지은이</a> (지은이) | <a href="">발행사</a> | 2022년 1월</span>
										</li>
										<li>
											<span class="book-price">128,000</span>원 → <span class="ss_p2"><b><span class="">115,200</span>원</b></span> 
										</li>
										<li>
											 <span class="book-comment">(<a href="">163</a>)</span>
										</li> 
									</ul>
								</div>
				 			</td>
				 			<td class="td-info" style="width:100px">
				 				<div class="buttonWrap">
				 					<div >
				 						<button class="cart btn">장바구니</button>
				 					</div>
				 					<div >
				 						<button class="buy btn">바로구매</button>
				 					</div>
			 					</div>
				 			</td>
				 		</tr>
				 		<tr></tr>
				 		<!-- 더미 3 -->
				 		<tr>
				 			<td class="td-info" style="width:50px">
				 				<div class="book-rank">3.</div>
				 			</td>
				 			<td style="width:150px">
				 				<div>
				 					<a href=""><img src="https://bookthumb-phinf.pstatic.net/cover/118/022/11802243.jpg?type=m1&udate=20211201" width="150" border="0" class="i_cover"></a>
				 				</div>
				 			</td>
				 			<td class="td-info" style="width:450px">
				 				<div class="infoWrap">
					 				<ul>
										<li>
											<span class="book-title">[<a>김치 책 제목</a>]</span><br>
										</li>
										<li>
											<span class="book-info"><a href="">지은이</a> (지은이) | <a href="">발행사</a> | 2022년 1월</span>
										</li>
										<li>
											<span class="book-price">128,000</span>원 → <span class="ss_p2"><b><span class="">115,200</span>원</b></span> 
										</li>
										<li>
											 <span class="book-comment">(<a href="">163</a>)</span>
										</li> 
									</ul>
								</div>
				 			</td>
				 			<td class="td-info" style="width:100px">
				 				<div class="buttonWrap">
				 					<div >
				 						<button class="cart btn">장바구니</button>
				 					</div>
				 					<div >
				 						<button class="buy btn">바로구매</button>
				 					</div>
			 					</div>
				 			</td>
				 		</tr>
				 		<!-- 더미 4 -->
				 		<tr>
				 			<td class="td-info" style="width:50px">
				 				<div class="book-rank">4.</div>
				 			</td>
				 			<td style="width:150px">
				 				<div>
				 					<a href=""><img src="https://bookthumb-phinf.pstatic.net/cover/207/771/20777131.jpg?type=m1&udate=20210720" width="150" border="0" class="i_cover"></a>
				 				</div>
				 			</td>
				 			<td class="td-info" style="width:450px">
				 				<div class="infoWrap">
					 				<ul>
										<li>
											<span class="book-title">[<a>김치 책 제목</a>]</span><br>
										</li>
										<li>
											<span class="book-info"><a href="">지은이</a> (지은이) | <a href="">발행사</a> | 2022년 1월</span>
										</li>
										<li>
											<span class="book-price">128,000</span>원 → <span class="ss_p2"><b><span class="">115,200</span>원</b></span> 
										</li>
										<li>
											 <span class="book-comment">(<a href="">163</a>)</span>
										</li> 
									</ul>
								</div>
				 			</td>
				 			<td class="td-info" style="width:100px">
				 				<div class="buttonWrap">
				 					<div >
				 						<button class="cart btn">장바구니</button>
				 					</div>
				 					<div >
				 						<button class="buy btn">바로구매</button>
				 					</div>
			 					</div>
				 			</td>
				 		</tr>
				 	</table>
				 </div>
			</form>
		</div>
	</div>
<script>

</script>
</body>
</html>



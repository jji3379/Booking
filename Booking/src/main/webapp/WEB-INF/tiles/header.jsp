<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<style>
	/* .nav-link{
		font-family: '777Balsamtint';
		font-size: 25px;
		width: max-content;
	}
	#log{
		font-family: '777Balsamtint';
	}
	
		
	
	#searchBook{
		font-family: '777Balsamtint';
		text-align: center;
	}
	
	#navbarsExampleDefault {
		min-width: 300px;
		width: 30%;
	}
	.nav-width {
		width: max-content;
	}
	nav {
		width: 100%;
		margin-right: auto;
		margin-left: auto;
	}
	.heading {
		
	} */
	.mainWrap {
		height: 93px;
	}
	.navWrap {
		height: 43px;
	}
	.mainWrap , .navWrap {
		font-family: '777Balsamtint';
	}
	.mainWrap .center{
		position: relative;
	    height: 100%;
	    width: 960px;
	    text-align: left;
	    margin: 0 auto;
	    display: block;
	    z-index: 100;
	}
	.center .logo {
		position: absolute;
	    top: 20px;
	    left: 0;
	    display: block;
	    width: 232px;
	    /* height: 63px; */
    }
	.center .search {
		position: absolute;
	    top: 38px;
	    left: 300px;
	    z-index: 20 !important;
	}
	.center .search input {
		font-family: '777Balsamtint';
	    font-size: 20px;
	    line-height: 32px;
	    height: 32px;
	    float: left;
	    width: 300px;
	    border: 0;
	    text-indent: 16px;
	    padding: 0;
	}
	.search{
		width:30px;
		padding:0px;
		display: flex;
	}
	.search > a > img {
		width:30px;
	}
	#searchForm {
		display: flex;
	}
	#searchBook{
		height: 42px;
		width: 400px;
		border: 2px solid #44695a;
		border-radius: 1px;
		margin-right: 8px;
	}
	.Users {
		position: absolute;
	    top: 26px;
	    right: -80px;
	    width: 220px;
	    height: 61px;
	    overflow: hidden;
	    z-index: 1;
	    text-align: right;
	}
	.Users > a > img {
		width: 45px;
    	border-radius: 1.25rem;
   	    position: relative;
    	top: 16px;
	}
	
	.navWrap {
		font-size: 25px;
		width: 100%;
	    height: 45px;
	    position: relative;
	    z-index: 21;
	    background-color: #41495c;
	}
	.Btns {
		height: 45px;
	    width: 1200px;
	    margin: 0 auto;
	    text-align: center;
	}
	.Btns > li {
		position: relative;
		width: 15%;
	    height: 35px;
	    float: left;
	 	margin: 0px 23px;
	}
	.Btns > li > a {
		color: #fff;
	    text-transform: uppercase;
	    text-decoration: none;
	    letter-spacing: 0.15em;
	    display: inline-block;
	    position: relative;
	}
	.Btns > li::before {
		content: "|";
		color: white;
		padding-right: 75px;
	    opacity: .7;
	}
	.Btns > li:first-child::before {
		content: "";
	}
	.Btns > li > a:after {   
		background: none repeat scroll 0 0 transparent;
		bottom: 2px;
		content: "";
		display: block;
		height: 2px;
		left: 50%;
		position: absolute;
		background: #fff;
		transition: width 0.3s ease 0s, left 0.3s ease 0s;
		width: 0;
	}
	.Btns > li > a:hover:after { 
		width: 100%; 
		left: 0; 
	}
	
	ul {
		display: block;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 180px;
	}
	ul li {
		list-style: none;
	    list-style-type: none;
	    float: left;
	}
	#nav-logo {
		width: 200px;
		
	}

	.navWrap ul.Btns li a {
	    line-height: 45px;
	    display: inline-block;
	    text-decoration: none;
	    letter-spacing: 0.05em;
	    font-size: 23px;
	    color: #ffffff;
	    text-decoration: none;
	}
	.srcBtn {
		background: url(${pageContext.request.contextPath }/resources/images/search.svg) no-repeat top left;
	    background-size: contain;
	    cursor: pointer;
	    display: inline-block;
	    height: 37px;
	    width: 30px;
	    margin-right: 6px;
	    border: none;
    	outline:none;
    	position: relative;
    	top: 3px;
	}
	.userBtn {
		height: 25px;
		line-height: 1.5;
		font-weight: bold;
		color: #212529;
		text-align: center;
		background-color: transparent;
		border: 1px solid gray;
		padding: 0.375rem 0.75rem;
		font-size: 15px;
		border-radius: 1.25rem;
	}
	.cartImg {
		position: relative;
    	top: 3px;
	}
	.userImg {
	
	}
	.cartBadge {
		position: absolute;
		display: inline-block;
		padding: 0.3em 0.28em;
		font-size: 30px;
		font-weight: 700;
		line-height: 1;
		text-align: center;
		white-space: nowrap;
		vertical-align: baseline;
		border-radius: 0.25rem;
		color: #fff;
		background-color: #86b3e3;
		transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}
	/* .srcBtn,
	.cartImg,
	.userBtn,
	.userImg:hover {
		color: #212529;
		text-decoration: none;
		
	}
	.srcBtn,
	.cartImg,
	.userBtn,
	.userImg:focus {
		outline: 0;
  		box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);	
	} */
    </style>
</head>
	<div class="mainWrap">
		<div class="center">
			<div class="logo">
				<a href="${pageContext.request.contextPath }/home.do">
					<img id="nav-logo" src="${pageContext.request.contextPath }/resources/images/bookinglogo.svg"/>
				</a>
			</div>
			<div class="search">
				<form id="searchForm" action="${pageContext.request.contextPath }/bookList/conditionSearch.do" method="get" >
			        <input id="searchBook" type="text" aria-label="Search"
			           name="keyword" placeholder="검색어를 입력하세요"/>
			        <input name="pageNum" value="1" hidden/>
			        <input name="start" value="1" hidden/>
			        <button type="submit" class="srcBtn" ></button>
			    </form>
			    <a class="cartImg" href="${pageContext.request.contextPath }/pay/cart.do">
		    		<img  src="${pageContext.request.contextPath }/resources/images/cart.svg"/>	
			    	<span class="cartBadge">${count}</span>
			   	</a>
			</div>
			<c:choose>
				<c:when test="${not empty sessionScope.id }">
				<div class="Users">
					<a href="" class="userImg"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="" /></a>
					<a href="" class="userBtn" >${id } 님</a>
					<a href="${pageContext.request.contextPath }/users/logout.do" class="userBtn">로그아웃</a>
				</div>
				</c:when>
				<c:otherwise>
				<div class="Users">
					<a href="${pageContext.request.contextPath }/users/login_form.do"  class="userBtn" >로그인</a>
					<a href="${pageContext.request.contextPath }/users/signup_form.do"  class="userBtn">회원가입</a>
				</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="navWrap">
		<ul class="Btns">
			<li>
				<a href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100&sort=count&start=1">전체도서</a>
			</li>
			<li>
	        	<a href="${pageContext.request.contextPath }/bookList/bestSeller.do">베스트셀러 </a>
	     	</li>
			<li>
				<a href="${pageContext.request.contextPath }/review">도서리뷰 </a>
			</li>
			<li>
		        <a href="${pageContext.request.contextPath }/map/mapsearch.do">서점 찾기</a>
		    </li>
		</ul>
	</div>
<script>
$(document).ready(function() {
    $('#searchForm').submit(function() {
        if ($('#searchBook').val() == '') {
            alert('검색어를 입력하세요.');
            return false;
        }
    }); 
}); 
</script>
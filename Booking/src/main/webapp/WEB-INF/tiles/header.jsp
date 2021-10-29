<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<style>
		
		.nav-link{
			font-family: '777Balsamtint';
			font-size: 25px;
			width: max-content;
	}
		#log{
			font-family: '777Balsamtint';
	}
		#searchBook{
			height:32px;
			width:300px;
			border-top:none;
			border-bottom:1px solid;
			border-right:none;
			border-left:none;
			background: transparent;
			border-radius:0px;
	}
		
		#search{
			width:30px;
			padding:0px
	}
		#searchBook{
			font-family: '777Balsamtint';
			text-align: center;
	}
	#nav-logo {
		width: 200px;
		
	}
	#navbarsExampleDefault {
		min-width: 300px;
		width: 30%;
	}
	.nav-width {
		width: max-content;
	}
	nav {
	}
	</style>
</head>
<div>
	<nav class="navbar navbar-expand-md navbar-light fixed-top ">
	  <img id="nav-logo" src="${pageContext.request.contextPath }/resources/images/bookinglogo.svg"/>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
	    <ul class="navbar-nav">
	      <li class="nav-item active">
	        <a class="nav-link" href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=100&sort=count&start=1">전체도서</a>
	      </li>
	      <li class="nav-item active">
	        <a class="nav-link" href="${pageContext.request.contextPath }/review/reviewList.do">도서 리뷰 </a>
	      </li>
	      <li class="nav-item active">
	        <a class="nav-link" href="${pageContext.request.contextPath }/bookList/bestSeller.do">베스트셀러 </a>
	      </li>
	      <li class="nav-item active">
	        <a class="nav-link" href="${pageContext.request.contextPath }/map/mapsearch.do">서점 찾기</a>
	      </li>
	    </ul>
	    </div>
	    <div style="align:center">
		   <form class="form-inline nav-width" id="searchForm" action="${pageContext.request.contextPath }/bookList/conditionSearch.do" method="get" >
		        <input id="searchBook" class="form-control" type="text" aria-label="Search"
		           name="keyword" placeholder="검색어를 입력하세요"/>
		        <input name="pageNum" value="1" hidden/>
		        <input name="start" value="1" hidden/>
		        <button type="submit" class="btn"><img id=search src="${pageContext.request.contextPath }/resources/images/search.svg"/></button>
		    </form>
	    </div>
	    <a href="${pageContext.request.contextPath }/pay/cart.do">
	    		<img style="width:30px;"src="${pageContext.request.contextPath }/resources/images/cart.svg"/>	
	     <span class="badge badge-danger">${count}</span>
	   	</a>
	   	&nbsp;&nbsp;&nbsp;
		<div class="d-flex justify-content-end">
			<c:choose>
				<c:when test="${not empty sessionScope.id }">
						<a href="${pageContext.request.contextPath }/users/private/info.do" style="font-size:20px;font-weight:bold; color:white; margin-right:10px">${id }</a>
						<a href="${pageContext.request.contextPath }/users/logout.do" class="btn btn-light btn-sm" id="log-out" style="font-weight:bold;">로그아웃</a>
				</c:when>
				<c:otherwise>
					<div class="usersBtn" style="margin-left:20px;">
						<a href="${pageContext.request.contextPath }/users/login_form.do" class="btn btn-light btn-sm nav-width" id="regist" style="font-weight:bold; margin-right:10px;">로그인</a>
						<a href="${pageContext.request.contextPath }/users/signup_form.do" class="btn btn-light btn-sm nav-width" id="sign-in" style="font-weight:bold;">회원가입</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
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
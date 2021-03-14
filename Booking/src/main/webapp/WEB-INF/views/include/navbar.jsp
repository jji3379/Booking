<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
<nav class="navbar navbar-expand-lg fixed-top navbar-dark" style="height:100px; color:#000000; background-color:black;">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath }/home.do" style="font-size:38px; margin-left:244px; font-family: 'Roboto', sans-serif;">
       <img src="${pageContext.request.contextPath }/resources/images/bookings.png"/></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" style="background-color:black;">
      <span class="navbar-toggler-icon"></span>
    </button><!--row justify-content-center : 정렬시 클래스 속성에다 넣고 정의  -->
    <div class="collapse navbar-collapse row justify-content-end" id="navbarSupportedContent" style="margin-right:200px;">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath }/bookList/bestSeller.do?d_cont=1&sort=count" style="font-size:18px; font-family: 'Roboto', sans-serif; margin-right: 20px">전체도서</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath }/review/reviewList.do" style="font-size:18px; font-family: 'Roboto', sans-serif;">책리뷰</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath }/map/mapsearch.do" style="font-size:18px; font-family: 'Roboto', sans-serif;">지도</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath }/pay/middle.do" style="font-size:18px; font-family: 'Roboto', sans-serif;">북카트</a>/a>
        </li>
      </ul>
      <form class="d-flex" action="${pageContext.request.contextPath }/bookList/conditionSearch.do" method="get">
        <input class="form-control me-2" type="text" aria-label="Search" style="border-radius:20px; height:34px; width:214px; margin-left: 30px"
        	name="keyword" value="${keyword }" >
        <input name="pageNum" value="1" hidden/> 
        <input name="start" value="1" hidden/> 
        <button type="submit" style="background-color:black; border:0; outline:0;">
           <img src="${pageContext.request.contextPath }/resources/images/magnifier.png"/>
        </button>
      </form>
      <c:choose>
         <c:when test="${not empty sessionScope.id }">
            <div style="margin-left:20px;">
               <a href="${pageContext.request.contextPath }/users/private/info.do" style="color:white; margin-right:10px;">${id }</a>
               <a href="${pageContext.request.contextPath }/users/logout.do" class="btn btn-warning">로그아웃</a>
            </div>
         </c:when>
         <c:otherwise>
            <div class="usersBtn" style="margin-left:20px;">
            <a href="${pageContext.request.contextPath }/users/login_form.do" class="btn btn-dark">로그인</a>
            <a href="${pageContext.request.contextPath }/users/signup_form.do" class="btn btn-dark" style="background-color:#5e5d5d;">회원가입</a>
          </div>
         </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>
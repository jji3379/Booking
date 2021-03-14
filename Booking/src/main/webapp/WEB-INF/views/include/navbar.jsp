<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
<nav class="navbar navbar-expand-lg fixed-top navbar-dark" style="height:50px; color:#f5e9dd; background-color:#135fa1;">
   <div class="container-fluid">
      <div class="collapse navbar-collapse row justify-content-start" id="navbarSupportedContent" style="margin-left:100px;">
         <ul class="navbar-nav">
            <li class="nav-item">
               <a class="nav-link" href="${pageContext.request.contextPath }/home.do" style="font-weight:bold; margin-left:20px; font-size:20px; font-family: 'Roboto', sans-serif; margin-right: 20px">홈</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="${pageContext.request.contextPath }/bookList/bestSeller.do?d_cont=1&sort=count" style="font-weight:bold; margin-left:20px; font-size:20px; font-family: 'Roboto', sans-serif; margin-right: 20px">전체도서</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="${pageContext.request.contextPath }/review/reviewList.do" style="font-weight:bold; font-size:20px; margin-left:20px; font-family: 'Roboto', sans-serif;">책리뷰</a>
            </li>
            <li class="nav-item">
               <a class="nav-link" href="${pageContext.request.contextPath }/map/mapsearch.do" style="font-weight:bold; font-size:20px; margin-left:35px; font-family: 'Roboto', sans-serif;">지도</a>
            </li>
         </ul>      
      </div>
      <div class="justify-content-end">
         <c:choose>
            <c:when test="${not empty sessionScope.id }">
               <div>
                  <a href="${pageContext.request.contextPath }/users/private/info.do" style="font-size:22px;font-weight:bold; color:white; margin-right:10px;">${id }</a>
                  <a href="${pageContext.request.contextPath }/users/logout.do" class="btn btn-warning" style="font-weight:bold;">로그아웃</a>
               </div>
            </c:when>
            <c:otherwise>
               <div class="usersBtn" style="margin-left:20px;">
                  <a href="${pageContext.request.contextPath }/users/login_form.do" class="btn btn-danger" style="font-weight:bold; margin-right:10px;">로그인</a>
                  <a href="${pageContext.request.contextPath }/users/signup_form.do" class="btn btn-warning" style="font-weight:bold;">회원가입</a>
               </div>
            </c:otherwise>
         </c:choose>
      </div>
   </div>
</nav>
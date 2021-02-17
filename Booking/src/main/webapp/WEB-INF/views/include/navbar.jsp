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
          <a class="nav-link" href="#" style="font-size:18px; font-family: 'Roboto', sans-serif;">전체도서</a>
        </li>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
        <li class="nav-item">
          <a class="nav-link" href="#" style="font-size:18px; font-family: 'Roboto', sans-serif;">인기도서</a>
        </li>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath }/review/list.jsp" style="font-size:18px; font-family: 'Roboto', sans-serif;">책리뷰</a>
        </li>
      </ul>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
      <form class="d-flex">
        <input class="form-control me-2" type="search" aria-label="Search" style="border-radius:20px; height:34px; width:214px;">&ensp;
        <button type="submit" style="background-color:black; border:0; outline:0;">
        	<img src="${pageContext.request.contextPath }/resources/images/magnifier.png"/>
        </button>
      </form>
    </div>
  </div>
</nav>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="resources/css/categoryList.css">
</head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<body>
	<div class="layout">
		<div class="row">
			<jsp:include page="../include/sideindex.jsp"></jsp:include>
			<div class="col-10">
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<a class="g-i nav-link ${param.sort eq 'count' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/CategoryList.do?d_catg=${d_catg }&sort=count&start=1">인기도서</a>
					</li>
					<li class="nav-item">
						<p class="nav-link blank"></p>
					</li>
					<li class="nav-item">
						<a class="g-i nav-link ${param.sort eq 'date' ? 'active' : ''}" href="${pageContext.request.contextPath }/CategoryList.do?d_catg=${d_catg }&sort=date&start=1">최신도서</a></li>
					</li>
					<li class="nav-item">
						<p class="nav-link blank"></p>
					</li>
					<li class="nav-item">
						<a class="g-i nav-link ${param.sort eq 'sim' ? 'active' : ''}" href="${pageContext.request.contextPath }/CategoryList.do?d_catg=${d_catg}&sort=sim&start=1">추천도서</a>
					</li>
					
				</ul>
				<div  class="row row-cols-5 list">
					<c:forEach var="b" items="${categoryList}"><!-- by 준익, pagingCategoryList 컨트롤러 적용된 list_2021.02.28 -->
						<div class="col mb-5">
							<div class=" h-100">
								<a href="${pageContext.request.contextPath }/bookDetail.do?d_isbn=${b.isbn}">
									<img src="${b.image }" class="card-img-top img-wrapper cardBook">
								</a>
								<div  class="card-body">
									<a href="${pageContext.request.contextPath }/bookDetail.do?d_isbn=${b.isbn}">
										<p class="card-title ellipsis2">${b.title }</p>
									</a>
									<small class="card-text ellipsis">${b.author }</small>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- by 준익, 페이징 처리_2021.02.26 -->
				<nav>
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${startPageNum != 1 }">
							<!-- by 준익, 시작페이지가 1이 아닌경우 pageNum 과 start 값 로직_2021.02.28 -->
							<li class="page-item"><a class="page-link"
								href="CategoryList.do?d_catg=${d_catg}&sort=${sort}&pageNum=${startPageNum-1 }&start=${(startPageNum-2)*PAGE_ROW_COUNT+1}">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- by 준익, 시작페이지가 1인 경우 Prev 비활성화_2021.02.28 -->
							<li class="page-item disabled"><a class="page-link"
								href="javascript:">&lt;</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
						<!-- by 준익, 페이징 시작부터 끝까지 만들기_2021.02.28 -->
						<c:choose>
							<c:when test="${i eq pageNum }">
								<!-- by 준익, 순서가 pageNum 과 같을 때 -->
								<li class="page-item active">
									<!-- by 준익, active 활성화_2021.02.28 --> <a class="page-link"
									href="CategoryList.do?d_catg=${d_catg}&sort=${sort}&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="CategoryList.do?d_catg=${d_catg}&sort=${sort}&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${endPageNum lt totalPageCount }">
							<!-- by 준익, 현재 페이지 끝 값이 전체 페이지끝 보다 작을   -->
							<li class="page-item"><a class="page-link"
								href="CategoryList.do?d_catg=${d_catg}&sort=${sort}&pageNum=${endPageNum+1}&start=${(endPageNum)*PAGE_ROW_COUNT+1 }">&gt;</a>
							<!— by 준익, 다음페이지 숫자가 나오게 하는 로직_2021.02.28 —></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<!— by 준익, 전체페이지 끝일 때 Next 비활성화 —> <a class="page-link"
								href="javascript:">&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
				</nav>
			</div> <!— col10 END —>
		</div> <!— row END —>
	</div> <!— container END —>
</body>
</html>
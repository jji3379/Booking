<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body style="background-color:#484848;">
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="row" style="width:80%; 
	margin-top:50px; margin-left:auto; margin-right:auto; background-color:#f5e9dd; width:fit-content;">
	<jsp:include page="../../include/sideusers.jsp"></jsp:include>
	<div style="margin-left:8px; margin-top:7px; width:1027px">
	<h1 style="margin-left:8px; margin-top:7px;">내가 쓴 리뷰</h1>
	<table class="table table-striped" style="width:1020px">
		<thead class="thead-dark"> 
			<tr>
				<th>리뷰 이미지</th>
				<th>리뷰 제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일</th>
				<th>리뷰 별점</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="t" items="${list }">
				<tr>
					<td>
						<div id="reviewImage">
							<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.num }">
								<img src="${t.imagePath}"/>
							</a>
						</div>
					</td>
					<td>${t.reviewTitle }</td>
					<td>${t.writer }</td>
					<td>${t.viewCount }</td>
					<td>${t.regdate }</td>
					<td>
						<p id="star">
							<c:if test="${t.rating  eq 1}">
								<a href="#">★</a>
							</c:if>
							<c:if test="${t.rating  eq 2}">
								<a href="#">★★</a>
							</c:if>
							<c:if test="${t.rating  eq 3}">
								<a href="#">★★★</a>
							</c:if>
							<c:if test="${t.rating  eq 4}">
								<a href="#">★★★★</a>
							</c:if>
							<c:if test="${t.rating  eq 5}">
								<a href="#">★★★★★</a>
							</c:if>
						<p>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
					<li class="page-item">
						<a class="page-link" href="my_review.do?pageNum=${startPageNum-1 }">Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<c:choose>
					<c:when test="${i eq pageNum }">
						<li class="page-item active">
							<a class="page-link" href="my_review.do?pageNum=${i }">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="my_review.do?pageNum=${i }">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="my_review.do?pageNum=${endPageNum+1 }">Next</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
	</div>
</div>
<div style="margin-top:200px">
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
</body>
</html>
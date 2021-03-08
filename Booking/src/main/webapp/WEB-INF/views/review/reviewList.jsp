<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/reviewList.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="review" name="thisPage"/>
</jsp:include>
<div style="margin-top:100px"></div>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">리뷰 목록</li>
		</ul>
	</nav>
	<a href="private/reviewInsertform.do">리뷰 작성</a>
	<h1>리뷰 목록 입니다.</h1>
	<table class="table table-striped">
		<thead class="thead-dark">
			<tr>
				<th>리뷰 이미지</th>
				<th>리뷰 제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일</th>
				<th>리뷰내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="t" items="${list}">
				<tr>
					<td>
						<img src="${t.imagePath}"/>
					</td>
					<td><a href="reviewDetail.do?num=${t.num }">${t.reviewTitle }</a></td>
					<td>${t.writer }</td>
					<td>${t.viewCount }</td>
					<td>${t.regdate }</td>
					<td>${t.content }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
					<li class="page-item">
						<a class="page-link" href="reviewList.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">Prev</a>
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
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="reviewList.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">Next</a>
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
	<form action="list.do" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="reviewTitle_content" ${condition eq 'reviewTitle_content' ? 'selected' : '' }>제목+내용</option>
			<option value="reviewTitle" ${condition eq 'reviewTitle' ? 'selected' : '' }>제목</option>
			<option value="isbn" ${condition eq 'isbn' ? 'selected' : '' }>책 고유번호</option>
			<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
		<button type="submit">검색</button>
	</form>
	<%-- by남기, 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. _210303 --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
</div>
</body>
</html>

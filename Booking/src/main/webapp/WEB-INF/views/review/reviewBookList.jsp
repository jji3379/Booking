<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
	div#box1 {
		margin-top: 100px
	}
	.ellipsis2 {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
.ellipsis{
  	  width:150px;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
}
/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
   .img-wrapper:hover{
      /* 원본 크기의 1.1 배로 확대 시키기*/
      transform: scale(1.02);
      transition: transform 0.3s ease-out;
   }
</style>
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container" style="margin-top: 30px;">
		<h1><span style="color:#135fa1"><b>${keyword }</b></span> 리뷰 책 검색   </h1>
		<div style="float:right;">
			<form action="reviewBookList.do" method="get">
				<input name="start" value="1" hidden /> <label for="condition"></label>
				<select style="width:120px; display:inline-block; border: 1px solid #135fa1;" class="form-control" name="condition" id="condition">
					<option  value="title_content"
						${condition eq 'title_content' ? "selected" : '' }>제목+내용</option>
					<option value="title" ${condition eq 'title' ? "selected" : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? "selected" : '' }>작성자</option>
				</select> 
				<input style="width:230px; display:inline-block;border: 1px solid #135fa1;" class="form-control" type="text" name="keyword" placeholder="검색어 입력" />
				<button type="submit" style="color:#135fa1; border: 1px solid #135fa1; margin-bottom:3px" class="btn btn-outline-light">검색</button>
			</form>
		</div>
		<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
		<c:if test="${not empty keyword}">
				<button style="width:300px; color:#135fa1; border: 1px solid #135fa1" class="btn btn-outline-light"><strong> ${total } </strong> 개의 자료가 검색되었습니다.</button>
		</c:if>
		<table>
			<div style="margin-top:20px" class="row row-cols-1 row-cols-md-4">
					<c:forEach var="b" items="${reviewBookList}"><!-- by 준익, pagingCategoryList 컨트롤러 적용된 list_2021.02.28 -->
						<div class="col mb-4">
							<div style="border: 3px solid #0f4c81;" class="card h-100">
							<a href="${pageContext.request.contextPath }/review/private/reviewInsertform.do?d_isbn=${b.isbn }" >
									<img src="${b.image }" class="card-img-top img-wrapper" style="height: 200px; border-bottom: 1px solid #0f4c81;">
								</a>
								<div style="background-color:#f5e9dd" class="card-body">
										<h5 style="margin-bottom: 30px; color:#484848; text-align:center" class="card-title ellipsis2">${b.title }</h5>
									</a>
									<div style="position: absolute; bottom: 10px;" class="card-text ellipsis">${b.author }</div>
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
							href="reviewBookList.do?keyword=${encodedK }&condition=${condition }&pageNum=${startPageNum-1 }&start=${(startPageNum-2)*PAGE_ROW_COUNT+1}">Prev</a>
						</li>
					</c:when>
					<c:otherwise>
						<!-- by 준익, 시작페이지가 1인 경우 Prev 비활성화_2021.02.28 -->
						<li class="page-item disabled"><a class="page-link"
							href="javascript:">Prev</a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
					<!-- by 준익, 페이징 시작부터 끝까지 만들기_2021.02.28 -->
					<c:choose>
						<c:when test="${i eq pageNum }">
							<!-- by 준익, 순서가 pageNum 과 같을 때 -->
							<li class="page-item active">
								<!-- by 준익, active 활성화_2021.02.28 --> <a class="page-link"
								href="reviewBookList.do?keyword=${encodedK }&condition=${condition }&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="reviewBookList.do?keyword=${encodedK }&condition=${condition }&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${endPageNum lt totalPageCount }">
						<!-- by 준익, 현재 페이지 끝 값이 전체 페이지끝 보다 작을   -->
						<li class="page-item"><a class="page-link"
							href="reviewBookList.do?keyword=${encodedK }&condition=${condition }&pageNum=${endPageNum+1}&start=${(endPageNum)*PAGE_ROW_COUNT+1 }">Next</a>
						<!-- by 준익, 다음페이지 숫자가 나오게 하는 로직_2021.02.28 --></li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<!-- by 준익, 전체페이지 끝일 때 Next 비활성화 --> <a class="page-link"
							href="javascript:">Next</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
</body>
</html>
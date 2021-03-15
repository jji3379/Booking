<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/reviewList.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	#star a{ 
		text-decoration: none; color: red; 
	} 
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="review" name="thisPage"/>
</jsp:include>
<div style="margin-top:-13px"></div>
<nav>
	<ul class="breadcrumb" style="border: 2px solid #135fa1; background-color:white; font-size: 18px; font-weight:bold; height:50px;">
		<li class="breadcrumb-item" style="margin-left:95px;">
			<a href="${pageContext.request.contextPath }/">Home</a>
		</li>
		<li class="breadcrumb-item active">리뷰 목록</li>
	</ul>
</nav>
<div class="container">
	<center><h1>리뷰 목록</h1></center>
	<a href="private/reviewInsertform.do" style="font-size:20px;">리뷰 작성</a>
	<table class="table table-border" style="table-layout: fixed;">
		<thead style="background-color:#f5e9dd;">
			<tr>
				<th width="10%">리뷰 이미지</th>
				<th width="15%">리뷰 제목</th>
				<th width="30%">책 제목</th>
				<th width="10%">작성자</th>
				<th width="10%">조회수</th>
				<th width="15%">등록일</th>
				<th width="10%">리뷰 별점</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="t" items="${list}">
				<tr>
					<td style="text-overflow:ellipsis; overflow:hidden"> 
						<img style="width:100px; height:60px" class="rounded-sm" 
						src="${t.imagePath }"/>
					</td>
					<td style="text-overflow:ellipsis; overflow:hidden"><a id="reviewTitle" href="reviewDetail.do?num=${t.num }" onClick="${t.spoCheck eq 'yes' ? 'spoAlert(event)' : '' }"> ${t.reviewTitle }</a></td>
					<td style="text-overflow:ellipsis; overflow:hidden">${t.bookTitle }</td>
					<td style="text-overflow:ellipsis; overflow:hidden">${t.writer }</td>
					<td style="text-overflow:ellipsis; overflow:hidden">${t.viewCount }</td>
					<td style="text-overflow:ellipsis; overflow:hidden">${t.regdate }</td>
					<td style="text-overflow:ellipsis; overflow:hidden">
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
	<form action="reviewList.do" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="bookTitle_content" ${condition eq 'bookTitle_content' ? 'selected' : '' }>책 제목+내용</option>
			<option value="bookTitle" ${condition eq 'bookTitle' ? 'selected' : '' }>책 제목</option>
			<option type="hidden" value="isbn" ${condition eq 'isbn' ? 'selected' : '' } >책 고유번호</option>
			<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
		<button style="background-color:#135fa1;" class="btn btn-primary" type="submit">검색</button>
	</form>
	<%-- by남기, 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. _210303 --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
</div>
<script>
	$("#isbn").attr('disabled','disabled').css('display','none');//by준영 검색조건 select에서 isbn검색 숨김_210228	
	
	//by채영_스포일러가 포함된 리뷰 읽을 확인 여부 
	var num=$("#num").val();
	function spoAlert(event){
		var alert = confirm("스포가 포함된 리뷰입니다. 읽으시겠습니까?");
		if(alert == true){
			location.href = "${pageContext.request.contextPath }/review/reviewDetail.do?num=num";
		}else{
			event.preventDefault();
			location.href = "${pageContext.request.contextPath }/review/reviewList.do";
		}
	}
</script>
</body>
</html>

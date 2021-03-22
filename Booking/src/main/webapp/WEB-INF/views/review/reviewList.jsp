<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	#star a{ 
		text-decoration: none; color: red; 
	} 
	.ellipsis{
  	  width:150px;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
   	}
   	.table th, .table td{
   		vertical-align:middle;
   	}
   
   	#writeR{
   		width:100px;
   		height:40px;
   		text-size:8px;
   		padding-bottom:3px;
   		margin-bottom:5px;
   		float:right;
   		background:#135fa1;
   		color:white;
   	}
   	#submitBtn{
   		background-color:#135fa1; 
   		color:white;
   	}
   	#searchIsbn{
   		display:none;
   	}
   	
   	
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="review" name="thisPage"/>
</jsp:include>
<div style="margin: auto; width:1050px;">
	<div style="margin-top:30px">
		<center><h1><strong>리뷰 목록</strong></h1></center>
		<a id="writeR" class="btn btn-primary" href="private/reviewInsertform.do">리뷰 작성</a>
		<table class="table table-border" style="table-layout: fixed;">
			<thead style="background-color:#f5e9dd; font-size:22px;">
				<tr>
					<th width="10%"><strong>도서</strong></th>
					<th width="20%"><strong>리뷰 제목</strong></th>
					<th width="20%"><strong>도서 제목</strong></th>
					<th width="10%"><strong>작성자</strong></th>
					<th width="15%"><strong>조회수</strong></th>
					<th width="15%"><strong>등록일</strong></th>
					<th width="10%"><strong>별점</strong></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="t" items="${list}">
					<tr>
						<td class="ellipsis"> 
							<img style="width:80px; height:100px;" class="rounded-sm" 
							src="${t.imagePath }"/>
						</td>
						<td class="ellipsis"><a id="reviewTitle" href="reviewDetail.do?num=${t.num }" onClick="${t.spoCheck eq 'yes' ? 'spoAlert(event)' : '' }"> ${t.reviewTitle }</a></td>
						<td class="ellipsis">${t.bookTitle }</td>
						<td class="ellipsis">${t.writer }</td>
						<td class="ellipsis">${t.viewCount }</td>
						<td class="ellipsis">${t.regdate }</td>
						<td class="ellipsis">
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
		<nav style="margin-top:30px">
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
		<form id="search" action="reviewList.do" method="get" style="margin-top:30px">
			<label for="condition">검색조건</label>
			<select name="condition" id="condition">
				<option value="bookTitle_content" ${condition eq 'bookTitle_content' ? 'selected' : '' }>도서 제목+내용</option>
				<option value="bookTitle" ${condition eq 'bookTitle' ? 'selected' : '' }>도서 제목</option>
				<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
				<option id="searchIsbn" value="isbn" ${condition eq 'isbn' ? 'selected' : '' }>도서 고유번호</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
			<button id="submitBtn" class="btn btn-primary" type="submit">검색</button>
		</form>
		<br />
		<%-- by남기, 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. _210303 --%>
		<c:if test="${not empty keyword }">
			<div class="alert alert-primary">
				<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
			</div>
		</c:if>
	</div>
</div>
<div style="margin-top:200px">
	<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
<script>
	// by남기_리뷰 작성 버튼을 눌렀을 때 로그인 안되어있으면 로그인 하세요 알림과 로그인 창으로 보내기
	var isLogin=${not empty id};
	
	document.querySelector("#writeR").addEventListener("click",function(){
		if(isLogin==false){			
			alert("로그인 하세요"); 
		}
	});
	
	$("#isbn").attr('disabled','disabled').css('display','none');//by준영 검색조건 select에서 isbn검색 숨김_210228
	
	//by채영_스포일러가 포함된 리뷰 읽을 확인 여부 
	var num=$("#num").val();
	function spoAlert(event){
		var alert = confirm("스포가 포함된 리뷰입니다. 읽으시겠습니까?");
		if(alert == true){
			location.href = "${pageContext.request.contextPath }/review/reviewDetail.do?num=num";
		}else{
			event.preventDefault();
		}
	}
	
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>

</style>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewBookList.css">
</head>
<body>
	<div class="searchBook">
		<div class="popup-title">
			<p><img id="nav-logo" src="/booking/resources/images/bookinglogo.svg"></p>
			
		</div>
		<div class="form-head">
			<form id="search-popup" class="formBox" action="${pageContext.request.contextPath }/review/book" method="get">
				<input name="start" value="1" hidden /> <label for="condition"></label>
				<select class="form-control" name="condition" id="condition">
					<option  value="title_content"
						${condition eq 'title_content' ? "selected" : '' }>제목 + 내용</option>
					<option value="title" ${condition eq 'title' ? "selected" : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? "selected" : '' }>작성자</option>
				</select> 
				<input id="search-text" class="form-control" type="text" name="keyword" placeholder="검색어 입력" />
				<button type="submit" class="btn"> 검 색 </button>
			</form>
		</div>
		<div class="form-body">
			<table>
				<colgroup>
					<col style="width:90px;">
					<col style="width:55%;">
					<col style="width:20%;">
					<col style="width:15;">
				</colgroup>
				<tr>
					<th class="th-first"></th>
					<th class="th-text">제목</th>
					<th class="th-text">저자</th>
					<th class="th-text">출판사</th>
				</tr>
				<c:forEach var="b" items="${reviewBookList}">
				
					<tr class="move" data-isbn='<c:out value="${b.isbn }"/>' data-title='<c:out value="${b.title}"/>' data-image='<c:out value="${b.image }"/>'>
						<td><img class="bookImg" src="${b.image }"/></td>
						<td class="td-text"><a >${b.title }</a></td>
						<td class="td-text">${b.author }</td>
						<td class="td-text">${b.publisher }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="pagination justify-content-center">
			<!-- by 준익, 페이징 처리_2021.02.26 -->
			<c:if test="${not empty keyword }">
					<nav>
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${startPageNum != 1 }">
							<!-- by 준익, 시작페이지가 1이 아닌경우 pageNum 과 start 값 로직_2021.02.28 -->
							<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath }/review/book?keyword=${encodedK }&condition=${condition }&pageNum=${startPageNum-1 }&start=${(startPageNum-2)*PAGE_ROW_COUNT+1}">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- by 준익, 시작페이지가 1인 경우 Prev 비활성화_2021.02.28 -->
							<li class="page-item disabled">
							<a class="page-link" href="javascript:">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
						<!-- by 준익, 페이징 시작부터 끝까지 만들기_2021.02.28 -->
						<c:choose>
							<c:when test="${i eq pageNum }">
								<!-- by 준익, 순서가 pageNum 과 같을 때 -->
								<li class="page-item active">
									<!-- by 준익, active 활성화_2021.02.28 --> <a class="page-link"
									href="${pageContext.request.contextPath }/review/book?keyword=${encodedK }&condition=${condition }&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath }/review/book?keyword=${encodedK }&condition=${condition }&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${endPageNum lt totalPageCount }">
							<!-- by 준익, 현재 페이지 끝 값이 전체 페이지끝 보다 작을때 비활성화  -->
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath }/review/book?keyword=${encodedK }&condition=${condition }&pageNum=${endPageNum+1}&start=${(endPageNum)*PAGE_ROW_COUNT+1 }">&gt;</a>
								<!-- by 준익, 다음페이지 숫자가 나오게 하는 로직_2021.02.28 -->
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<!-- by 준익, 전체페이지 끝일 때 Next 비활성화 --> 
								<a class="page-link" href="javascript:">&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
			</c:if>
		</div>
	</div>
<script>
	//by 준영, 책 검색폼 빈값 제출 막기
	$(document).ready(function() {
	    $('#search-popup').submit(function() {
	        if ($('#search-text').val() == '') {
	            return false;
	        }
	    }); 
	}); 
	//by 준영, 책 선택 및 팝업닫기
		$('.move').on('click', function(e){
			e.preventDefault();
			
			var name = $(this).data('title');
			var isbn = $(this).data('isbn');
			var image = $(this).data('image');
			//hmtl tag 떼기
			var title = name.replace(/(<([^>]+)>)/ig,"");
			var bookChk = $(opener.document).find('input[id=bookSelect]');
			
			$(opener.document).find('#bookTitle').val(title);
			$(opener.document).find('#isbn').val(isbn);
			$(opener.document).find('#imagePath').val(image);
			$(opener.document).find('#selected').attr("src" , image );
			
			if(bookChk.is(':checked') == false){
				bookChk.click();
			}
			
			$(opener.document).find('#selected').css({
				"width":"147px" ,
				"height":"167px",
				"border":"1px solid #333",
				"border-radius":"6px",
				"position":"absolute",
				"top":"-2px",
				"left":"-1px"
				
			});
			
			window.close();
		})
	
	
</script>
</body>
</html>
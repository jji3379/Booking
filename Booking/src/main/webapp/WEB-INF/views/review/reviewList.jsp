<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<style>


</style>
<link rel="stylesheet" href="resources/css/reviewList.css">
</head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<body>
	<div class="layout">
		<div class="menu">
			<div class="menuText">
				<h2>● Booking review</h2>
				<p>다양한 도서와 후기를 만나보세요</p>
			</div>
			
			<ul class="sortBar">
				<li class="viewSort"><a href="">조회순</a></li>
				<li class="starSort"><a href="">별점순</a></li>
				<li class="newSort"><a href="">최신순</a></li>
			</ul>
		</div>
		<div class="row">
			<div class="row row-cols-4">
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex1 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>	
				</a>
				<!-- card ex2 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" style="background-image: url('https://bookthumb-phinf.pstatic.net/cover/095/203/09520318.jpg?type=m1&udate=20171016');">
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>t</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>	
				</a>
				<!-- card ex3 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex4 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex5 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header"  style="background-image: url('https://bookthumb-phinf.pstatic.net/cover/074/430/07443083.jpg?type=m1&udate=20190817');" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex6 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex7 -->
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 -->
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 -->
						<div class="card-body">
							<!--  카드 바디 헤더 -->
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 -->
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 -->
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
				<!-- card ex8 -->	
			</div>	<!-- row row-col-4 end  -->
		</div>	<!-- row end  -->
		<div class="bottom">
			<form id="search" action="reviewList.do" method="get">
				<label for="condition" hidden>검색조건</label>
				<select name="condition" id="condition">
					<option value="bookTitle_content" ${condition eq 'bookTitle_content' ? 'selected' : '' }>제목 + 내용</option>
					<option value="bookTitle" ${condition eq 'bookTitle' ? 'selected' : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
					<option id="searchIsbn" value="isbn" ${condition eq 'isbn' ? 'selected' : '' } >고유번호</option>
				</select>
				<input type="search" id="reviewInput" name="keyword" class="searchBar" placeholder="검색어..." value="${keyword }"/>
			</form>
			<nav id = "paging">
				<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${!list.first}">
							<li class="page-item">
								<a class="page-link" href="reviewList.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link" href="javascript:">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${startPageNum}" end="${endPageNum }">
						<c:choose>
							<c:when test="${i eq list.number }">
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
								<a class="page-link" href="reviewList.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">&gt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link" href="javascript:">&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
			<button id="writeR" type="button" >리뷰 작성</button>
		</div>
		
		<br />
		<%-- by남기, 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. _210303 --%>
		<c:if test="${not empty keyword }">
			<div class="alert alert-primary">
				<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
			</div>
		</c:if>
		
	</div>	<!-- layout end  -->
<script>
//by 준영, 리뷰검색폼 빈값 제출 막기
$(document).ready(function() {
    $('#search').submit(function() {
        if ($('#reviewInput').val() == '') {
            return false;
        }
    }); 
}); 
function spoAlert(spoCheck){
	console.log(spoCheck);
	if(spoCheck == "yes"){
		var alert = confirm("스포가 포함된 리뷰입니다. 읽으시겠습니까?");
		if(alert == true){
		}else{
			event.preventDefault();
		}
	}else if(spoCheck == "no"){
		$('.card-header-is_closed').css('display', 'none');
	}
}

//by 남기, 리뷰작성폼 로그인 해야 넘어가게끔함
var isLogin=${not empty id};

document.querySelector("#writeR").addEventListener("click",function(){
	if(isLogin == false){			
		$('#modal-open').trigger('click');
	}else{
		location.href="private/reviewInsertform.do";
	}
});
	
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<style>
	.star-value {
		color: #ffc80b;
		font-family: emoji;
	}
</style>
<link rel="stylesheet" href="resources/css/reviewList.css">
</head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<body>
	<div class="layout">
		<div class="menu">
			<div class="menuText">
				<h2>다양한 도서와 후기를 만나보세요</h2>
			</div>
			<ul class="sortBar">
				<li class="viewSort"><a href="#" id="viewCount" onclick="sortList(0, 'viewCount')">조회순</a></li>
				<li class="starSort"><a href="#" id="rating" onclick="sortList(0, 'rating')">별점순</a></li>
				<li class="newSort"><a href="#" id="regdate" onclick="sortList(0, 'regdate')">최신순</a></li>
			</ul>
		</div>
		<div>
		
		</div>
		<div class="row-box">
			<div class="row row-cols-4" id="reviewList">
			<!--  
				<a href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${t.id }" class="cardLink">
					<div class="card col">
						<!-- 카드 헤더 
						<div class="card-header" >
							<div class = "card-header-is_closed" > 
				                <div class = "card-header-text" > 스포 포함 </div > 
				            </div >
						</div>
						<!--  카드 바디 
						<div class="card-body">
							<!--  카드 바디 헤더 
							<div class="card-body-header">
								<h1>r</h1>
								<p class="card-body-hashtag">rating": 5</p>
								<p class = "card-body-nickname"> 
				                     	작성자: catcat3
				           		</p>
							</div>
							<!--  카드 바디 본문 
							<p class="card-body-description">
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore voluptatibus repellendus dolorum temporibus est velit delectus minima itaque consequuntur quod qui maxime veritatis asperiores quia perferendis soluta possimus labore. Hic.
							</p>
							<!--  카드 바디 푸터 
							<div class="card-body-footer">
								<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
								<div class="viewCount">조회 17회</div>
								<div class="comment">댓글 4개</div>
								<div class="regdate">2021-11-29</div>
							</div>
						</div>
					</div>
				</a>
			-->
			</div>	<!-- row row-col-4 end  -->
		</div>	<!-- row end  -->
		<div class="bottom">
			<form id="search" onSubmit="return false;">
				<label for="condition" hidden>검색조건</label>
				<select name="condition" id="condition">
					<option value="bookTitle_content" ${condition eq 'bookTitle_content' ? 'selected' : '' }>제목 + 내용</option>
					<option value="bookTitle" ${condition eq 'bookTitle' ? 'selected' : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
					<option id="searchIsbn" value="isbn" ${condition eq 'isbn' ? 'selected' : '' } >고유번호</option>
				</select>
				<input type="search" id="reviewInput" name="keyword" class="searchBar" placeholder="검색어..." onkeyup="if(window.event.keyCode==13){conditionSearchList(0,'regdate')}" value="${keyword }"/>
			</form>
			<div id="page"></div>
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
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>
<script>
	// 검색어가 있을 경우와 없을 경우의 정렬 분기
	function sortList(page, sort) {
		if($("#reviewInput").val() ==''){
			pagingList(page, sort);
		}else{
			conditionSearchList(page, sort);
		}
	}
	
	// 선택한 정렬에 active 추가
	$(".sortBar").children().children().on("click", (event) => {
		$(".sortBar").children().children().removeClass('active');
		event.target.className += "active";
	});

	var isLogin=${not empty id};
	
	document.querySelector("#writeR").addEventListener("click",function(){
		if(isLogin == false){			
			alert("로그인이 필요합니다.");
			$('#modal-open').trigger('click');
		}else{
			location.href="new-review";
		}
	});
	
	// 기본 리뷰 조회
	function pagingList(page, sort) {
		$.ajax({
		url:"${pageContext.request.contextPath}/v1/reviews?page="+page+"&sort="+sort,
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			// item list
			var dataSize = data.content.length;
			var reviewList = "";
			var star = '';
			for(var i=0; i<data.content.length; i++) {
				if(data.content[i].spoCheck == 'Y'){
					reviewList += '<a onclick="return spoAlert();" href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink warning">'
				}else{
					reviewList += '<a href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink">'
				}
				
					reviewList += '<div class="card col">'
					reviewList += '<div class="card-header" style="background-image:url('+data.content[i].imagePath+')">'
					
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<div	id="spoCheck-badge" class="card-spoCheck-on" >'
					}else{
						reviewList += '<div	id="spoCheck-badge" class="card-spoCheck-off">'
					}
					
					reviewList += '<div class = "card-header-text" > 스포일러 </div >'
					reviewList += '</div >'
					reviewList += '</div >'
	
					reviewList += '<div class="card-body">'
					reviewList += '<div class="card-body-header">'
	
					reviewList += '<h1>'+data.content[i].reviewTitle+'</h1>'
					reviewList += '<div class="star-value" id="star-rating'+[i]+'">'

					switch(data.content[i].rating) {
						case 1 :
							reviewList += ('★☆☆☆☆')
							break;
						case 2 :
							reviewList += ('★★☆☆☆')
							break;
						case 3 :
							reviewList += ('★★★☆☆')
							break;
						case 4 :
							reviewList += ('★★★★☆')
							break;
						case 5 :
							reviewList += ('★★★★★')
							break;
					}
					
					reviewList += '</div>'
					reviewList += '<p class = "card-body-nickname"> 작성자: '+data.content[i].loginId+'</p>'
					reviewList += '</div>'
					
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<p class="card-body-description spoAlert">'+data.content[i].content+'</p>'
					}else{
						reviewList += '<p class="card-body-description">'+data.content[i].content+'</p>'
					}
					
					
					reviewList += '<div class="card-body-footer">'
					reviewList += '<hr class="underline">'
					reviewList += '<div class="viewCount">조회 '+data.content[i].viewCount+'회 </div>'
					reviewList += '<div class="comment">'
					reviewList += '댓글 '+data.content[i].replyCount+'개'
					reviewList += '</div>'
					reviewList += '<div class="regdate">'+new Date(data.content[i].regdate).toLocaleDateString()+'</div>'
					reviewList += '</div>'
					reviewList += '</div>'
					reviewList += '</div>'
				reviewList += '</a>'
			}
			$("#reviewList").html(reviewList);
			
			var pagingWrap = "";

			pagingWrap += '<nav id = "paging">'					
			pagingWrap += '</nav>'					
			
			$("#page").html(pagingWrap);
			
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
				} 
			}).on('page', function (event, page) { 
				var sortValue = $(".sortBar").find(".active").attr('id');
				if(sortValue == null){
					sortValue = "regdate";
				}
				pagingList(page-1, sortValue);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	}
	
	// 조건 검색
	function conditionSearchList(page, sort) {
		var condition = $("#condition").val();
		var keyword = $("#reviewInput").val();
		
		$.ajax({
		url:"${pageContext.request.contextPath}/v1/review/"+condition+"/"+keyword+"?page="+page+"&sort="+sort,
		method:"get",
		success:function(data) {
			// item list
			var dataSize = data.content.length;
			var reviewList = "";
			var star = '';
			for(var i=0; i<data.content.length; i++) {
				if(data.content[i].spoCheck == 'Y'){
					reviewList += '<a onclick="return spoAlert();" href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink warning">'
				}else{
					reviewList += '<a href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink">'
				}
				
					reviewList += '<div class="card col">'
					reviewList += '<div class="card-header" style="background-image:url('+data.content[i].imagePath+')">'
					
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<div	id="spoCheck-badge" class="card-spoCheck-on" >'
							reviewList += '<div class = "card-header-text" > 스포일러 </div >'
					}else{
						reviewList += '<div	id="spoCheck-badge class="card-spoCheck-off">'
							reviewList += '<div class = "card-header-text" ></div >'
					}
					
					
					reviewList += '</div >'
					reviewList += '</div >'
	
					reviewList += '<div class="card-body">'
					reviewList += '<div class="card-body-header">'
	
					reviewList += '<h1>'+data.content[i].reviewTitle+'</h1>'
					reviewList += '<div class="star-value" id="star-rating'+[i]+'">'

					switch(data.content[i].rating) {
						case 1 :
							reviewList += ('★☆☆☆☆')
							break;
						case 2 :
							reviewList += ('★★☆☆☆')
							break;
						case 3 :
							reviewList += ('★★★☆☆')
							break;
						case 4 :
							reviewList += ('★★★★☆')
							break;
						case 5 :
							reviewList += ('★★★★★')
							break;
					}
					
					reviewList += '</div>'
					reviewList += '<p class = "card-body-nickname"> 작성자: '+data.content[i].loginId+'</p>'
					reviewList += '</div>'
					
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<p class="card-body-description spoAlert">'+data.content[i].content+'</p>'
					}else{
						reviewList += '<p class="card-body-description">'+data.content[i].content+'</p>'
					}
					
					
					reviewList += '<div class="card-body-footer">'
					reviewList += '<hr class="underline">'
					reviewList += '<div class="viewCount">조회 '+data.content[i].viewCount+'회 </div>'
					reviewList += '<div class="comment">'
					reviewList += '댓글 '+data.content[i].replyCount+'개'
					reviewList += '</div>'
					reviewList += '<div class="regdate">'+new Date(data.content[i].regdate).toLocaleDateString()+'</div>'
					reviewList += '</div>'
					reviewList += '</div>'
					reviewList += '</div>'
				reviewList += '</a>'
			}
			$("#reviewList").html(reviewList);
			
			var pagingWrap = "";

			pagingWrap += '<nav id = "paging">'					
			pagingWrap += '</nav>'					
			
			$("#page").html(pagingWrap);
			
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
				} 
			}).on('page', function (event, page) { 
				var sortValue = $(".sortBar").find(".active").attr('id');
				if(sortValue == null){
					sortValue = "regdate";
				}
				conditionSearchList(page-1, sortValue);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	}
	
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/reviews",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			// item list
			var dataSize = data.content.length;
			var reviewList = "";
			var star = '';
			for(var i=0; i<data.content.length; i++) {

				if(data.content[i].spoCheck == 'Y'){
					reviewList += '<a onclick="return spoAlert();" href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink warning">'
				}else{
					reviewList += '<a href="${pageContext.request.contextPath }/review/'+data.content[i].id+'" class="cardLink">'
				}
				
					reviewList += '<div class="card col">'
					reviewList += '<div class="card-header" style="background-image:url('+data.content[i].imagePath+')">'
					
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<div	id="spoCheck-badge" class="card-spoCheck-on" >'
					}else{
						reviewList += '<div	id="spoCheck-badge" class="card-spoCheck-off" >'
					}
					reviewList += '<div class = "card-header-text" > 스포일러 </div >'
					reviewList += '</div >'
					reviewList += '</div >'
	
					reviewList += '<div class="card-body">'
					reviewList += '<div class="card-body-header">'
	
					reviewList += '<h1>'+data.content[i].reviewTitle+'</h1>'
					reviewList += '<div class="star-value" id="star-rating'+[i]+'">'

					switch(data.content[i].rating) {
						case 1 :
							reviewList += ('★☆☆☆☆')
							break;
						case 2 :
							reviewList += ('★★☆☆☆')
							break;
						case 3 :
							reviewList += ('★★★☆☆')
							break;
						case 4 :
							reviewList += ('★★★★☆')
							break;
						case 5 :
							reviewList += ('★★★★★')
							break;
					}
					
					reviewList += '</div>'
					reviewList += '<p class = "card-body-nickname"> 작성자: '+data.content[i].loginId+'</p>'
					reviewList += '</div>'
	
					if(data.content[i].spoCheck == 'Y'){
						reviewList += '<p class="card-body-description spoAlert">'+data.content[i].content+'</p>'
					}else{
						reviewList += '<p class="card-body-description">'+data.content[i].content+'</p>'
					}
					
					reviewList += '<div class="card-body-footer">'
					reviewList += '<hr class="underline">'
					reviewList += '<div class="viewCount">조회 '+data.content[i].viewCount+'회 </div>'
					reviewList += '<div class="comment">'
					reviewList += '댓글 '+data.content[i].replyCount+'개'
					reviewList += '</div>'
					reviewList += '<div class="regdate">'+new Date(data.content[i].regdate).toLocaleDateString()+'</div>'
					reviewList += '</div>'
					reviewList += '</div>'
					reviewList += '</div>'
				reviewList += '</a>'
			}
			$("#reviewList").html(reviewList);
			
			var pagingWrap = "";

			pagingWrap += '<nav id = "paging">'					
			pagingWrap += '</nav>'					
			
			$("#page").html(pagingWrap);
			
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
				} 
			}).on('page', function (event, page) { 
				var sortValue = $(".sortBar").find(".active").attr('id');
				if(sortValue == null){
					sortValue = "regdate";
				}
				pagingList(page-1, sortValue);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	
	
	
	
	//by 준영, 리뷰검색폼 빈값 제출 막기
	$('#search').submit(function() {
	    if ($('#reviewInput').val() == '') {
	        return false;
	    }
	});
	
	function spoAlert(){
		var spoCheck = confirm("스포일러가 포함된 리뷰입니다. 그래도 읽으시겠습니까?");
		if(spoCheck == true){
			return true;
		}else{
			return false;
			//event.preventDefault();
		}
	}
	
</script>
</body>
</html>
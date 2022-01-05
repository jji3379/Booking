<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/reviewDetail.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
</style>
</head>
<body>
	<div class="container">
		<div class="review">
			<table class="tb">
				<div class="tb-head">
					<h2 class="head-title">> ${dto.bookTitle }</h2>
					<div class="head-star">
						<p id="star">별점
						<div class="star-value">
							<c:if test="${dto.rating  eq 1}">
								<a href="#">★☆☆☆☆</a>
							</c:if>
							<c:if test="${dto.rating  eq 2}">
								<a href="#">★★☆☆☆</a>
							</c:if>
							<c:if test="${dto.rating  eq 3}">
								<a href="#">★★★☆☆</a>
							</c:if>
							<c:if test="${dto.rating  eq 4}">
								<a href="#">★★★★☆</a>
							</c:if>
							<c:if test="${dto.rating  eq 5}">
								<a href="#">★★★★★</a>
							</c:if>
							<p>
						</div>
					</div>
				</div>
				<tr>
					<td class="tdImg" rowspan="4"><a
						href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${dto.isbn}">
							<img id="image" src="${dto.imagePath }" />
					</a></td>
				</tr>
				<tr class="book-info">
					<td colspan="2" class="tdInfo">
						<ul class="info-list">
							<li id="writer">작성자 : ${dto.writer.loginId }</li>
							<li id="regdate">등록일 : ${dto.regdate }</li>
							<li id="viewCount">조회수 : ${dto.viewCount }</li>
						</ul>
					</td>
				</tr>
				<tr class="tr-review">
					<th>리뷰제목</th>
					<td >
						<div><input class="input-title" type="text" value="${dto.reviewTitle }"  readonly/></div>
					</td>
				</tr>
				<tr class="tr-review">
					<th>리뷰내용</th>
					<td rowspan="2">
						<div id="content"><input class="input-content" type="text" value="${dto.content }" readonly/></div>
					</td>
				</tr>
			</table>
		</div>
		<div class="list-menu">
			<ul >
				<li><a class="listBtn" href="/review">목록보기</a></li>
				<c:if test="${dto.writer.loginId eq sessionScope.loginId }">
					<li><a class="listBtn" href="private/reviewUpdateform.do?num=${dto.id }">수정</a></li>
					<li><a class="listBtn" href="#" onclick="deletea();">삭제</a></li>
				</c:if>
			</ul>
		</div>
		<div class="commentWrap">
       		<div class="comment-header">
       			<h3 class="list-title"></h3>
       		</div>
	       	<div class="comment-body">
	       		<div class="registWrap">
	       			<div class="textarea-box">
	       				<form class="comment-form reviewInsert-form" action="private/reviewComment_insert.do" method="post">
							<!-- by남기, 원글의 글번호가 refGroup 번호가 된다. _210303 -->
							<input type="hidden" name="refGroup" value="${dto.id }"/>
							<!-- by남기, 원글의 작성자가 댓글의 수신자가 된다. _210303 -->
							<input type="hidden" name="target_id" value="${dto.writer.id }"/>
							<textarea name="content" cols="80" rows="3"  maxlength="200" placeholder="최대 200자 이내로 작성해 주세요."><c:if test="${empty id }">로그인이 필요합니다</c:if></textarea>
							<button class="commentBtn" type="submit"><c:if test="${empty id }">로그인이 필요합니다</c:if>등록</button>
						</form>	
	       			</div>
	        	</div>
				<div class="comment-box">
		        	<h3>전체 댓글 <span id="total-reply"></span> 개</h3>
					<!-- by남기, 댓글 목록 _210303 -->
					<div class="comments">
						<table>							
							<colgroup>
								<col style="width:5%">
								<col style="width:75%"> 
							</colgroup>
							<c:forEach var="tmp" items="${reviewCommentList }">
							<!-- 기본 tr, 삭제표시 tr 분기 start -->
							<c:choose>
							<c:when test="${tmp.deleted eq 'yes' }">
								<tr>삭제된 댓글 입니다.</tr>
							</c:when>
							<c:otherwise>
								<!-- 원댓글, 대댓글 tr 분기 start -->
								<c:choose>
									<c:when test="${tmp.id ne tmp.commentGroup }">
										<!-- 대댓글 tr -->
										<tr class="tr-comment tr-reply"> 
											<th class="td-userId tr-comment">
											</th>
											<!-- 댓댓글 td-content -->
											<td class="td-content tr-comment" >
												<a data-num="${tmp.id }" href="javascript:" class="reply-link">
													<b>${tmp.writer.loginId }</b>
													<div class="comment-reply">
														<svg class="reply-icon" width="1em" height="1em"
															viewBox="0 0 16 16" class="bi bi-arrow-return-right"
															fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								  						<path fill-rule="evenodd"
																d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z" />
								  						<path fill-rule="evenodd"
																d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z" /></svg>
													
														<span><i>@<b>${tmp.target_id.loginId }</b></i></span>
														<span id="content">&nbsp;${tmp.content }</span>
														<div class="content-regdate">
															<span>${tmp.regdate }1234</span> 
															<c:if test="${tmp.writer.id eq sessionScope.id }">
												    			<a data-num="${tmp.id }" href="javascript:"
																	class="update-link">수정</a>
																<a data-num="${tmp.id }" href="javascript:"
																	class="delete-link">삭제</a>
															</c:if>
														</div>
													</div>
												</a>
											</td>
										</tr>
										<tr id="comment${tmp.id }" class="tr-hidden">
											<td colspan="2">
												<form class="comment-form reply-form" action="private/reviewComment_insert.do" method="post">
													<input type="hidden" name="refGroup" value="${dto.id }" /> <input
														type="hidden" name="target_id" value="${tmp.writer.id }" /> <input
														type="hidden" name="commentGroup" value="${tmp.commentGroup }" />
													<textarea name="content"></textarea>
													<button class="replyBtn" type="submit">등록</button>
												</form> 
												<!-- by남기, 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 _210303 -->
											 	<c:if test="${tmp.writer.id eq sessionScope.id }">
													<form class="comment-form reviewUpdate-form"
														action="private/reviewComment_update.do" method="post">
														<input type="hidden" name="id" value="${tmp.id }" />
														<textarea name="content">${tmp.content }</textarea>
														<button class="updateBtn" type="submit">수정</button>
													</form>
												</c:if>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<!-- 원댓글 tr -->
										<tr class="tr-comment">
											<th class="td-userId tr-comment">
												<span>${tmp.writer.loginId }</span>
											</th>
											<td class="td-content tr-comment">
												<a data-num="${tmp.id }" href="javascript:" class="reply-link">
													<div class="comment-full">
														<span id="content">${tmp.content }</span>
														<div class="content-regdate">
															<span>${tmp.regdate }</span> 
															<c:if test="${tmp.writer.id eq sessionScope.id }">
																<a data-num="${tmp.id }" href="javascript:"
																	class="update-link">수정</a>
																<a data-num="${tmp.id }" href="javascript:"
																	class="delete-link">삭제</a>
															</c:if>
														</div>
													</div>
												</a>
											</td>
										</tr>
										<tr id="comment${tmp.id }" class="tr-hidden">
											<td colspan="2">
												<form class="comment-form reply-form" action="private/reviewComment_insert.do" method="post">
													<input type="hidden" name="refGroup" value="${dto.id }" /> <input
														type="hidden" name="target_id" value="${tmp.writer.id }" /> <input
														type="hidden" name="commentGroup" value="${tmp.commentGroup }" />
													<textarea name="content"></textarea>
													<button class="replyBtn" type="submit">등록</button>
												</form> 
												<!-- by남기, 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 _210303 -->
											 	<c:if test="${tmp.writer.id eq sessionScope.id }">
													<form class="comment-form reviewUpdate-form"
														action="private/reviewComment_update.do" method="post">
														<input type="hidden" name="id" value="${tmp.id }" />
														<textarea name="content">${tmp.content }</textarea>
														<button class="updateBtn" type="submit">수정</button>
													</form>
												</c:if>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<!-- 원댓글, 대댓글 tr 분기 end -->
							</c:otherwise>
							</c:choose>
							<!-- 기본 tr, 삭제표시 tr 분기 end -->
							</c:forEach>
						</table>
					</div>
					<div class="comment-paging">    
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
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/review/reply/${reviewId}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			$("#total-reply").html(data);
		},
		error : function(data) {
			console.log("오류");
		}
	});

	$(document).ready(function(){
		var review = $('.input-content').val();
		
		var content = review.replace(/(<([^>]+)>)/ig,"");
		$(document).find('.input-content').val(content);
	})
	
	function deletea() {
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/review/${reviewId}",
			method:"DELETE",
			dataType : "json",
			success:function(data){
				alert("삭제됨");
			}
		});
	}
	$(document).ready(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/review/${reviewId}",
			method:"GET",
			dataType : "json",
			success:function(data) {
				$("#image")[0].src = data.imagePath;
				$("#reviewTitle")[0].textContent = data.reviewTitle;
				$("#bookTitle")[0].textContent = data.bookTitle;
				$("#writer")[0].textContent = data.writer.loginId;
				$("#viewCount")[0].textContent = data.viewCount;
				$("#regdate")[0].textContent = new Date(data.regdate).toLocaleDateString();
				switch(data.rating) {
				case 1 :
					star = '<a href="#">★☆☆☆☆</a>';
					break;
				case 2 :
					star = '<a href="#">★★☆☆☆</a>';
					break;
				case 3 :
					star = '<a href="#">★★★☆☆</a>';
					break;
				case 4 :
					star = '<a href="#">★★★★☆</a>';
					break;
				case 5 :
					star = '<a href="#">★★★★★</a>';
					break;
				}
				$("#star")[0].innerHTML = star;
				$("#content")[0].innerHTML = data.content;
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}); 

	// by남기. _210303
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");
		//구성된 id  선택자를 이용해서 원하는 li 요소에서 .update-form 을 찾아서 동작하기
		$(selector)
		.find(".reviewUpdate-form")
		.slideToggle();
		
		if($(this).text()=="수정"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 클릭하면 
			$(this).text("수정");//답들로 바꾼다. 
		}	
	});
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정폼을 
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".reviewUpdate-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){
			//console.log(data);
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#comment"+data.id; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".reviewUpdate-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find(".reviewUpdate-form").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		var isDelete=confirm("댓글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/review/private/reviewComment_delete.do?num="+num+"&refGroup=${dto.id}";
		}
	});
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin="${not empty sessionScope.id}";
		console.log("isLogin:"+isLogin);
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/review/${dto.id}";
		}
		
		var selector="#comment"+$(this).attr("data-num");
		$(selector)
		.find(".reply-form")
		.slideToggle();
		
		/* if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 클릭하면 
			$(this).text("답글");//답들로 바꾼다. 
		}	*/
	});
	$(document).on("submit",".comment-form", function(){
		//로그인 여부
		var isLogin=${not empty sessionScope.id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/login_form.do?"+
					"url=${pageContext.request.contextPath }/review/${dto.id}";
			return false; //폼 전송 막기 		
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="reviewDelete.do?num=${dto.id}";
		}
	}
	
	//페이지가 처음 로딩될때 1page 를 보여준다고 가정
	var currentPage=1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	//var totalPageCount=${totalPageCount};
	//현재 로딩중인지 여부
	var isLoading=false;
	
	/*
	페이지 로딩 시점에 document 의 높이가 window 의 실제 높이 보다 작고
	전체 페이지의 갯수가(totalPageCount) 현재페이지(currentPage)
	보다 크면 추가로 댓글을 받아오는 ajax 요청을 해야한다.
	*/
	var dH=$(document).height();//문서의 높이
	var wH=window.screen.height;//window 의 높이
	
	//if(dH < wH && totalPageCount > currentPage){
		//로딩 이미지 띄우기
		$(".loader").show();
		
		currentPage++; //페이지를 1 증가 시키고 
		//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
		/*
		$.ajax({
			url:"reviewCommentList.do",
			method:"get",
			data:{pageNum:currentPage, refGroup:${dto.id}},
			success:function(data){
				console.log(data);
				//data 가 html 마크업 형태의 문자열 
				$(".comments ul").append(data);
				//로딩 이미지를 숨긴다. 
				$(".loader").hide();
			}
		});
		*/
	//}	
	
	//웹브라우저에 scoll 이벤트가 일어 났을때 실행할 함수 등록 
	$(window).on("scroll", function(){
		
		//위쪽으로 스크롤된 길이 구하기
		var scrollTop=$(window).scrollTop();
		//window 의 높이
		var windowHeight=$(window).height();
		//document(문서)의 높이
		var documentHeight=$(document).height();
		//바닥까지 스크롤 되었는지 여부
		var isBottom = scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){//만일 바닥까지 스크롤 했다면...
			if(currentPage == totalPageCount || isLoading){//만일 마지막 페이지 이면 
				return; //함수를 여기서 종료한다. 
			}
			//현재 로딩 중이라고 표시한다. 
			isLoading=true;
			//로딩 이미지 띄우기
			$(".loader").show();
			
			currentPage++; //페이지를 1 증가 시키고 
			//해당 페이지의 내용을 ajax  요청을 해서 받아온다
			/*
			$.ajax({
				url:"reviewCommentList.do",
				method:"get",
				data:{pageNum:currentPage, refGroup:${dto.id}},
				success:function(data){
					console.log(data);
					//data 가 html 마크업 형태의 문자열 
					$(".comments ul").append(data);
					//로딩 이미지를 숨긴다. 
					$(".loader").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
				}
			});
			*/
		}
	});	
	
	
</script>
</body>
</html>
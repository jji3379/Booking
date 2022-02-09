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
						<div id="star">별점
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
							</div>
						</div>
					</div>
				</div>
				<tr>
					<td class="tdImg" rowspan="4">
						<div style="position:relative;">
							<a href="${pageContext.request.contextPath }/book/${dto.isbn}">
								<img id="image" src="${dto.imagePath }" />
								<span class="mask">
							  		<span class="bg1"></span>
							  		<span class="bg2"></span>
						  		</span>
							</a>
						</div>
					</td>
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
						<div><input class="input-title" id="reviewTitle" type="text" value="${dto.reviewTitle }"  readonly/></div>
					</td>
				</tr>
				<tr class="tr-review">
					<th>리뷰내용</th>
					<td rowspan="2" >
						<div id="review-content">${dto.content}</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="list-menu">
			<ul >
				<li><a class="listBtn" href="${pageContext.request.contextPath }/reviews">목록보기</a></li>
				<c:if test="${dto.writer.loginId eq sessionScope.loginId }">
					<li><a class="listBtn" href="${pageContext.request.contextPath }/review/${dto.id }/edit">수정</a></li>
					<li><a class="listBtn" href="#" onclick="deleteReview();">삭제</a></li>
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
	       				<form class="comment-form reviewInsert-form" action="${pageContext.request.contextPath }/v1/review/reply" method="post">
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
					<div class="comments">
						<table>							
							<colgroup>
								<col style="width:5%">
								<col style="width:75%"> 
							</colgroup>
							<c:forEach var="tmp" items="${reviewCommentList }">

								<!-- 대댓글 -->
								<c:choose>
									<c:when test="${tmp.id ne tmp.commentGroup }">
										<!-- 대댓글 tr -->
										<tr class="tr-comment tr-reply"> 
											<th class="td-userId tr-comment"></th>
											<!-- 댓댓글 td-content -->
											<td class="td-content tr-comment" >
												<a data-num="${tmp.id }" href="javascript:" class="reply-link">
													<b>${tmp.writer.loginId }</b>
													<!-- 대댓글 div start-->
													<div class="comment-reply">
														<span>
															<svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
										  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z" />
										  						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z" />
									  						</svg>
													
															<i>@<b>${tmp.target_id.loginId }</b></i>
														</span>
														<span id="reply-content">${tmp.content }</span>
														
														<!-- 작성자일 경우 대댓글 수정, 삭제 출력 -->
														<div class="content-regdate">
															<span>${tmp.regdate }</span> 
															<c:if test="${tmp.writer.id eq sessionScope.id }">
												    			<a data-num="${tmp.id }" href="javascript:" class="update-link">수정</a>
																<a data-num="${tmp.id }" href="javascript:" class="delete-link">삭제</a>
															</c:if>
														</div>
														
													</div>
													<!-- 대댓글 div end -->
												</a>
											</td>
										</tr>
										<!-- 대댓글을 달 수 있는 히든 tr start -->
										<tr id="comment${tmp.id }" class="tr-hidden">
											<td colspan="2">
												<form class="comment-form reply-form" action="${pageContext.request.contextPath }/v1/review/reply" method="post">
													<input type="hidden" name="refGroup" value="${dto.id }" /> 
													<input type="hidden" name="target_id" value="${tmp.writer.id }" /> 
													<input type="hidden" name="commentGroup" value="${tmp.commentGroup }" />
													<textarea name="content"></textarea>
													<button class="replyBtn" type="submit">등록</button>
												</form> 
												<!-- 작성자 이면 수정폼 출력 -->
											 	<c:if test="${tmp.writer.id eq sessionScope.id }">
													<form class="comment-form commentUpdate-form">
														<textarea name="content" id="content${tmp.id }">${tmp.content }</textarea>
														<button data-num="${tmp.id }" class="updateBtn" type="button">수정</button>
													</form>
												</c:if>
											</td>
										</tr>
										<!-- 대댓글 히든 tr end -->
									</c:when>
									
									
									<c:otherwise>
										<!-- 댓글 tr -->
										<tr class="tr-comment">
											<th class="td-userId tr-comment">
												<span>${tmp.writer.loginId }</span>
											</th>
											<!-- 댓글 content start -->
											<td class="td-content tr-comment">
												<a data-num="${tmp.id }" href="javascript:" class="reply-link">
													<div class="comment-full">
														<span id="comment-content">${tmp.content }</span>
														<div class="content-regdate">
															<span>${tmp.regdate }</span> 
															<c:if test="${tmp.writer.id eq sessionScope.id }">
																<a data-num="${tmp.id }" href="javascript:" class="update-link">수정</a>
																<a data-num="${tmp.id }" href="javascript:" class="delete-link">삭제</a>
															</c:if>
														</div>
													</div>
												</a>
											</td><!-- 댓글 content end -->
										</tr><!-- 댓글 tr end -->
										
										<!-- 댓글의 대댓글 입력 폼 start -->
										<tr id="comment${tmp.id }" class="tr-hidden">
											<td colspan="2">
												<form class="comment-form reply-form" action="${pageContext.request.contextPath }/v1/review/reply" method="post">
													<input type="hidden" name="refGroup" value="${dto.id }" /> 
													<input type="hidden" name="target_id" value="${tmp.writer.id }" /> 
													<input type="hidden" name="commentGroup" value="${tmp.commentGroup }" /> 
													<textarea name="content"></textarea>
													<button class="replyBtn" type="submit">등록</button>
												</form> 
												<!-- 작성자가 같을 경우 수정 출력 -->
											 	<c:if test="${tmp.writer.id eq sessionScope.id }">
													<form class="comment-form commentUpdate-form">
														<textarea name="content" id="content${tmp.id }">${tmp.content }</textarea>
														<button data-num="${tmp.id }" class="updateBtn" type="button">수정</button>
													</form>
												</c:if>
											</td>
										</tr><!-- 댓글의 대댓글 입력 폼 end -->
										
									</c:otherwise>
								</c:choose><!-- 원댓글, 대댓글 tr 분기 end -->
							</c:forEach>
						</table>
					</div>
					<div class="comment-paging">    
						<nav id = "paging">

						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>

	// 해당 리뷰에 해당하는 댓글들 조회
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/review/${reviewId}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			$("#total-reply").html(data.replyCount);
		},
		error : function(data) {
			console.log("오류");
		}
	});
	
	// 리뷰 내용 조회
	$(document).ready(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/review/${reviewId}",
			method:"GET",
			dataType : "json",
			success:function(data) {
				$("#image")[0].src = data.imagePath;
				$("#reviewTitle")[0].text() = data.reviewTitle;
				$("#bookTitle")[0].text() = data.bookTitle;
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
				$("#content")[0].text() = data.content;
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}); 
	
	//by준영, 답글 달기 링크 클릭시 슬라이드 토글 
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
	});
	//by준영, 댓글 수정 링크 클릭시 슬라이드 토글
	$(document).on("click",".update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");

		//구성된 id  선택자를 이용해서 원하는 li 요소에서 .update-form 을 찾아서 동작하기
		$(selector)
		.find(".commentUpdate-form")
		.slideToggle();
		
		if($(this).text()=="수정"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 클릭하면 
			$(this).text("수정");//답들로 바꾼다. 
		}	
	});
	
	//by 준영, 댓글 추가 폼 제출 시 함수
	$(document).on("submit",".comment-form", function(){
		//로그인 여부
		var isLogin=${not empty sessionScope.id};
		if(isLogin == false){
			alert("로그인이 필요합니다.");
			document.getElementById('modal-open').click();
			
			return false; //폼 전송 막기 		
		}
	});
	
	//by 준영, 대댓글 작성폼 제출 시 함수
	$(document).on("submit",".reply-form", function(){
		//로그인 여부
		var isLogin=${not empty sessionScope.id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/login_form.do?"+
					"url=${pageContext.request.contextPath }/review/${dto.id}";
			return false; //폼 전송 막기 		
		}
	});
	
	//by준영, 댓글 수정 폼 제출 시 함수
	$(document).on("click", ".updateBtn", function(){
		var replyId=$(this).attr("data-num");
		var content = $("#content"+replyId).val();
		var data = {
				id : replyId,
				content : content
		}

		$.ajax({
			url:"${pageContext.request.contextPath }/v1/review/reply",
			method:"put",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success:function(data) {
				location.reload();
			},
			error : function(data) {
				console.log("실패");
			}
		});
	});
	
	//by 준영, 댓글 수정 폼 제출시 로그인필터
	$(document).on("submit",".commentUpdate-form", function(){
		//로그인 여부
		var isLogin=${not empty sessionScope.id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.reload();

			return false; //폼 전송 막기 		
		}
	});
	
	//by준영, 게시글 삭제 함수
	function deleteReview() {
		var isDelete=confirm("리뷰를 삭제 하시겠습니까?");
		if(isDelete){
			$.ajax({
				url:"${pageContext.request.contextPath}/v1/review/${reviewId}",
				method:"DELETE",
			}).done(function(response){
				alert("리뷰가 삭제 되었습니다.");
				window.location = '${pageContext.request.contextPath}/reviews'; 
			});
		}
		
	}
	//by준영, 댓글 삭제 클릭시 함수
	$(document).on("click",".delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");

		var isDelete=confirm("댓글을 삭제 하시겠습니까?");
		if(isDelete){
			$.ajax({
				url:"${pageContext.request.contextPath}/v1/review/reply/"+num,
				method:"DELETE",
			}).done(function(response){
				location.reload();
			});
		}

	});
	
</script>
</body>
</html>
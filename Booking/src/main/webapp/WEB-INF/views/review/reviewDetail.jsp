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
	.tb {
		width: 100%;
	}
	.tb-head {
		padding: 15px 0 16px 10px;
		border-top: 1px solid #e5e5e5;
		border-bottom: 1px solid #a8a8a8;
		display: block;
		width: 100%;
	}
	.head-title {
		display:inline;
		font-size: 36px;
    	font-weight: 500;
	}
	.head-star {
		display:block;
		float: right;
		padding-top: 9px;
	    padding-right: 15px;
		font-size: 19px;
		color: #333333;
	}
	.head-star > p {
		display: inline;
		vertical-align: middle;
		margin: 0;
		padding: 0;
	}
	.star-value {
		font-family: emoji;
		display: inline;
		vertical-align: baseline;
	}
	.star-value > a {
		color: red;
		text-decoration: none;
		vertical-align: bottom;
	}
	.star-value::before {
	    content: "|";
	    padding-left: 8px;
	    padding-right: 2px;
	    vertical-align: bottom;
	    opacity: 0.9;
	}
	.tdInfo {
		border-bottom: 1px solid #e5e5e5;
		font-size:18px;
		padding: 10px 10px;
	}
	.tdImg {
		width: 240px; 
		height: 300px; 
		padding: 20px 15px 0 20px; 
	}
	#reviewTitle{
		height: 53px;
	}
	.input-title {
	    width: 100%;
	    height: 40px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	.input-content {
		width: 100%;
	    height: 200px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	.tr-review > th, td {
		padding: 12px 10px;
    	font-size: 20px;
    }
	th{
		text-align: left;
	    width: 55px;
	    font-size: 20px;
	}
	.book-info {
		margin: 0;
		padding: 0;
	}
	.info-list{
		margin: 0;
		padding: 0;
	}
	.info-list > li{
		display:inline-block;
	}
	.info-list > li::before{
	    content: "|";
	    color: 33333387;
	    padding-left: 10px;
	    padding-right: 10px;
	    vertical-align: middle;
	    opacity: 0.4;
	    font-size: 27px
	}
	.info-list > li:first-child::before {
		content: "";
	    vertical-align: middle;
		padding: 0;
	}
	.mylistBox{
		border-bottom: 1px solid #e5e5e5;
		width: 100%;
	}
	.list-header {
		border-bottom: 2px solid #333333;
	}
	.list-title {
		margin-bottom: 0;
		font-size: 28px;
		padding-left: 20px;
    	padding-bottom: 3px;
	}
	.registWrap{
	    width: 100%;
	    margin-top: 20px;
	    padding: 20px 0;
	    border: 1px solid #e3e3e3;
	    background-color: #f9f9f9;
	}
	.textarea-box{
		width: 1135px;
		margin: 0 auto;
	}
	.comment-form > textarea {
	    color: #999;
	    width: 950px;
	    height: 45px;
	    padding: 8px;
	    margin: 0 auto;
	    resize: none;
	    border: none;
	    overflow-y: scroll;
	    border-top: 1px solid #999;
	    border-left: 1px solid #999;
	    border-bottom: 1px solid #ccc;
	    border-right: 1px solid #ccc;
	}
	.commentBtn {
	    margin-left: 5px;
	    width: 160px;
	    height: 62px;
	    border-left: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    border-right: 1px solid #999;
	    border-bottom: 1px solid #999;
	    background-color: #fff;
	    color: #333;
	    font-size: 14px;
	}
	
	
	.commentWrap {
		margin-top: 30px;
	}
	.commentWrap > h3 {
		border-bottom: 2px solid #eee;
		margin: 0 auto;
    	padding: 0 0 6px 15px;
    	font-weight: 500;
	}
	.comment-row {
		width:100%;
		display: flex;
		margin: 0;
		padding: 20px 0;
		border-bottom: 1px solid #eee;
	}
	.comment-userId{
		width: 5%;
		margin:0;
	}
	.comment-content{
		width:75%;
		margin:0;
	}
	.comment-content  {
		text-decoration: none;
		color: #333;
	}
	.comment-content > div, a {
		text-decoration: none;
		color: #333;
	}
	.comment-regdate{
		width: 10%;
		margin:0;
	}
	.commentList > tr {
		padding: 8px 0;
	    border-bottom: 1px solid #eee;
	    text-align: left;
	    font-size: 14px;
	    color: #333;
	}
	.comment-paging{
	    width: 100%;
	    *width: auto;
	    height: 33px;
	    text-align: center;
	    border-top: 1px solid #9e9e9e;
	    border-bottom: 1px solid #e5e5e5;
	    position: relative;
	    background-color: #fafafa;
	    font-family: "dotum";
	}
	.reply-form {
	    display: block;
	    border-bottom: 1px solid;
	    margin: 13px 0;
	}
	.reviewUpdate-form {
	    display: block;
	    padding-bottom: 15px;
    	border-bottom: 1px solid #eee; 
	}
	.reply-form {
		display: block;
		padding-bottom: 15px;
    	border-bottom: 1px solid #eee; 
	}
	.reply-form > textarea {
	    color: #999;
	    margin-left: 128px;
	    width: 885px;
	    height: 45px;
	    padding: 8px;
	    resize: none;
	    border: none;
	    overflow-y: scroll;
	    border-top: 1px solid #999;
	    border-left: 1px solid #999;
	    border-bottom: 1px solid #ccc;
	    border-right: 1px solid #ccc;
	}
	.replyBtn {
	    margin-left: 5px;
	    width: 115px;
	    height: 62px;
	    border-left: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    border-right: 1px solid #999;
	    border-bottom: 1px solid #999;
	    background-color: #fff;
	    color: #333;
	    font-size: 14px;
	}
	.reviewUpdate-form > textarea {
	    color: #999;
	    margin-left: 128px;
	    width: 885px;
	    height: 45px;
	    padding: 8px;
	    resize: none;
	    border: none;
	    overflow-y: scroll;
	    border-top: 1px solid #999;
	    border-left: 1px solid #999;
	    border-bottom: 1px solid #ccc;
	    border-right: 1px solid #ccc;
	}
	.updateBtn {
		margin-left: 5px;
	    width: 115px;
	    height: 62px;
	    border-left: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    border-right: 1px solid #999;
	    border-bottom: 1px solid #999;
	    background-color: #fff;
	    color: #333;
	    font-size: 14px;
	}
	
	
</style>
</head>
<body>
	<div class="layout">
		<table class="tb">
			<div class="tb-head">
				<h2 class="head-title">> ${dto.bookTitle }</h2>
				<div class="head-star">
					<p id="star">별점
					<div class="star-value">
						<c:if test="${dto.rating  eq 1}">
							<a href="#">★</a>
						</c:if>
						<c:if test="${dto.rating  eq 2}">
							<a href="#">★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 3}">
							<a href="#">★★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 4}">
							<a href="#">★★★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 5}">
							<a href="#">★★★★★</a>
						</c:if>
						<p>
					</div>
				</div>
			</div>
			<tr>
				<td class="tdImg" rowspan="5"><a
					href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${dto.isbn}">
						<img id="image" src="${dto.imagePath }" />
				</a></td>
			</tr>
			<tr class="book-info">
				<td colspan="2" class="tdInfo">
					<ul class="info-list">
						<li id="writer">작성자 : ${dto.writer }</li>
						<li id="regdate">등록일 : ${dto.regdate }</li>
						<li id="viewCount">조회수 : ${dto.viewCount }</li>
					</ul>
				</td>
			</tr>
			<tr class="tr-review">
				<th>리뷰제목</th>
				<td id="reviewTitle" colspan="2"><div><input class="input-title" type="text" value="${dto.reviewTitle }" readonly/></div></td>
			</tr>
			<tr class="tr-review">
				<th>리뷰내용</th>
				<td rowspan="2">
					<div id="content"><input class="input-content" type="text" value="${dto.content }" readonly/></div>
				</td>
			</tr>
			<tr>

			</tr>
		</table>
		<%-- <table class="table table-striped">
			<tr>
				<td rowspan="8">
					<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${dto.isbn}">
						<img id="image" src="${dto.imagePath }"/>
					</a>
				</td>
			</tr>
			<tr>
				<td><strong>작성자</strong></td>
				<td id="writer"></td>
			</tr>
			<tr>
				<td><strong>도서 제목</strong></td>
				<td id="bookTitle">${dto.bookTitle }</td>
			</tr>
			<tr>
				<td><strong>리뷰 제목</strong></td>
				<td id="reviewTitle">${dto.reviewTitle }</td>
			</tr>
			<tr>
				<td><strong>별점</strong></td>
				<td>
					<p id="star">
						<c:if test="${dto.rating  eq 1}">
							<a href="#">★</a>
						</c:if>
						<c:if test="${dto.rating  eq 2}">
							<a href="#">★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 3}">
							<a href="#">★★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 4}">
							<a href="#">★★★★</a>
						</c:if>
						<c:if test="${dto.rating  eq 5}">
							<a href="#">★★★★★</a>
						</c:if>
					<p>
				</td>
			</tr>
			<tr>
				<td><strong>조회수</strong></td>
				<td id="viewCount">${dto.viewCount }</td>
			</tr>
			<tr>
				<td><strong>등록일</strong></td>
				<td id="regdate">${dto.regdate }</td>
			</tr>
			<tr>
				<td><strong>내용</strong></td>
				<td colspan="2">
					<div id="content">${dto.content }</div>
				</td>
			</tr>
		</table> --%>
		<ul class="mylist">
			<li><a href="review">목록보기</a></li>
			<c:if test="${dto.writer.loginId eq sessionScope.loginId }">
				<li><a href="private/reviewUpdateform.do?num=${dto.id }">수정</a></li>
				<li><a href="#" onclick="deletea();">삭제</a></li>
			</c:if>
		</ul>
		<div class="comment-list">
       		<div class="list-header">
       		<h3 class="list-title">기대평</h3>
       	</div>
       	<div class="list-body">
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
			<div class="commentWrap">
	        	<h3>전체 댓글 <span>n</span> 개</h3>
	        			
				<!-- by남기, 댓글 목록 _210303 -->
				<div class="comments">
					<ul>
					<c:forEach var="tmp" items="${reviewCommentList }">
						<c:choose>
						<c:when test="${tmp.deleted eq 'yes' }">
							<li>삭제된 댓글 입니다.</li>
						</c:when>
						<c:otherwise>
							<li id="comment${tmp.id }"
								<c:if test="${tmp.id ne tmp.commentGroup }"></c:if>>
								
								<dl class="comment-row">
									<dd class="comment-userId">
										<%-- <c:choose>
											<c:when test="${empty tmp.profile }">
												<svg class="profile-image"  width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  							<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
												</svg>
											</c:when>
											<c:otherwise>
												<img class="profile-image" 
													src="${pageContext.request.contextPath }${tmp.profile }"/>
											</c:otherwise>
										</c:choose> --%>
										
										<span>${tmp.writer.loginId }</span>
									</dd>
									<dd class="comment-content">
										<c:choose>
											<c:when test="${tmp.id ne tmp.commentGroup }">
												<div>
													<c:if test="${tmp.id ne tmp.commentGroup }">
														<svg class="reply-icon" width="1em" height="1em"
															viewBox="0 0 16 16" class="bi bi-arrow-return-right"
															fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								  						<path fill-rule="evenodd"
																d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z" />
								  						<path fill-rule="evenodd"
																d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z" /></svg>
													</c:if>
													@<i>${tmp.target_id.loginId }</i>
													<a data-num="${tmp.id }" href="javascript:" class="reply-link"><pre>${tmp.content }</pre></a>
												</div>
											</c:when>
											<c:otherwise>
												<a data-num="${tmp.id }" href="javascript:" class="reply-link"><pre>${tmp.content }</pre></a>
											</c:otherwise>
										</c:choose>
									</dd>
									<dd class="comment-regdate">
										<span>${tmp.regdate }1234</span> 
										<c:if test="${tmp.writer.id eq sessionScope.id }">
											| <a data-num="${tmp.id }" href="javascript:"
												class="reviewComment-update-link">수정</a>
											| <a data-num="${tmp.id }" href="javascript:"
												class="reviewComment-delete-link">삭제</a>
										</c:if>
									</dd>
								</dl>

								<form class="comment-form reply-form"
									action="private/reviewComment_insert.do" method="post">
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
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
	</div>
	<script>
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
				$("#regdate")[0].textContent = data.regdate;
				switch(data.rating) {
				case 1 :
					star = '<a href="#">★</a>';
					break;
				case 2 :
					star = '<a href="#">★★</a>';
					break;
				case 3 :
					star = '<a href="#">★★★</a>';
					break;
				case 4 :
					star = '<a href="#">★★★★</a>';
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
	$(document).on("click",".reviewComment-update-link", function(){
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
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".reviewComment-delete-link", function(){
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
		
		$(selector).find(".reply-form").css('border-bottom','none');
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
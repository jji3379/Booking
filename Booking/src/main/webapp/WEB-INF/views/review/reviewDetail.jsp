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
	body{
		font-size:20px;
	}
	/* by남기, 글 내용을 출력할 div 에 적용할 css _210303 */
	.contents{
		width: 100%;
		border: 1px dotted #cecece;
	}
	/* by남기, 댓글 프로필 이미지를 작은 원형으로 만든다. _210303 */
	.profile-image{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	/* by남기, ul 요소의 기본 스타일 제거 _210303 */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 50px;
	}
	.comment-form textarea, .comment-form button{
		float: left;
	}
	.comments li{
		clear: left;
	}
	.comments ul li{
		border-top: 1px solid #888;
	}
	.comment-form textarea{
		width: 85%;
		height: 100px;
	}
	.comment-form button{
		width: 15%;
		height: 100px;
	}
	/* by남기, 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다 _210303 */
	.comments .comment-form{
		display: none;
	}
	/* by남기, .reply_icon 을 li 요소를 기준으로 배치 하기  _210303 */
	.comments li{
		position: relative;
	}
	.comments .reply-icon{
		position: absolute;
		top: 1em;
		left: 1em;
		color: red;
	}
	pre {
	  display: block;
	  padding: 9.5px;
	  margin: 0 0 10px;
	  font-size: 13px;
	  line-height: 1.42857143;
	  color: #333333;
	  word-break: break-all;
	  word-wrap: break-word;
	  background-color: #f5f5f5;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	/* by남기, 글 내용중에 이미지가 있으면 최대 폭을 100%로 제한하기 _210303 */
	.contents img{
		max-width: 100%;
	}
	.loader{
		position: fixed; /* by남기, 좌하단 고정된 위치에 배치 하기 위해 _210303 */
		width: 100%;
		left: 0;
		bottom: 0;
		text-align: center; /* by남기, 이미지를 좌우로 가운데  정렬 _210303 */
		z-index: 1000;
		display: none; /* by남기, 일단 숨겨 놓기 _210303 */
	}	
	#image{
		object-fit;
		text-align:center;
		width:300px;
		height:400px;
	}
	#star a{ 
		text-decoration: none; color: red; 
	} 
	ul.mylist li:before {
	    content: ">";
	    display: inline-block;
	    vertical-align: middle;
	    padding: 0px 5px 6px 0px;
	}
	ul.mylist {
    list-style: none;
    margin: 0px;
    padding: 0px;
    font-size: 18px;
  
    max-width: 250px;
    width: 100%;
	}
	
	.table th, .table td{
		padding:0.3rem;
		vertical-align: middle;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="review" name="thisPage"/>
</jsp:include>
<div style="margin-top:30px"></div>
<div style="width:1050px; margin:auto">
	<center><h1><strong>리뷰 디테일 폼</strong></h1></center>
	<table class="table table-striped" style="margin-top:30px">
		<tr>
			<td rowspan="8" style="width:300px;">
				<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${dto.isbn}">
					<img id="image" src="${dto.imagePath }"/>
				</a>
			</td>
		</tr>
		<tr>
			<td><strong>작성자</strong></td>
			<td>${dto.writer }</td>
		</tr>
		<tr>
			<td><strong>책 제목</strong></td>
			<td>${dto.bookTitle }</td>
		</tr>
		<tr>
			<td><strong>리뷰 제목</strong></td>
			<td>${dto.reviewTitle }</td>
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
			<td>${dto.viewCount }</td>
		</tr>
		<tr>
			<td><strong>등록일</strong></td>
			<td>${dto.regdate }</td>
		</tr>
		<tr>
			<td><strong>내용</strong></td>
			<td colspan="2">
				<div>${dto.content }</div>
			</td>
		</tr>
	</table>
	<ul class="mylist" style="margin-top:30px">
		<li><a href="reviewList.do">목록보기</a></li>
		<c:if test="${dto.writer eq id }">
			<li><a href="private/reviewUpdateform.do?num=${dto.num }">수정</a></li>
			<li><a href="private/reviewDelete.do?num=${dto.num }">삭제</a></li>
		</c:if>
	</ul>
	<hr/>
	<!-- by남기, 원글에 댓글을 작성하는 form _210303 -->
	<form class="comment-form reviewInsert-form" action="private/reviewComment_insert.do" method="post" style="margin-top:30px">
		<!-- by남기, 원글의 글번호가 ref_group 번호가 된다. _210303 -->
		<input type="hidden" name="ref_group" value="${dto.num }"/>
		<!-- by남기, 원글의 작성자가 댓글의 수신자가 된다. _210303 -->
		<input type="hidden" name="target_id" value="${dto.writer }"/>
		<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다</c:if></textarea>
		<button class="btn btn-primary" type="submit">등록</button>
	</form>	
	<!-- by남기, 댓글 목록 _210303 -->
	<div class="comments">
		<ul>
			<c:forEach var="tmp" items="${reviewCommentList }">
				<c:choose>
					<c:when test="${tmp.deleted eq 'yes' }">
						<li>삭제된 댓글 입니다.</li>
					</c:when>
					<c:otherwise>
						<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
							<c:if test="${tmp.num ne tmp.comment_group }"><svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
		  						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/></svg>
							</c:if>
							<dl>
								<dt>
									<c:choose>
										<c:when test="${empty tmp.profile }">
											<svg class="profile-image"  width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  							<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
											</svg>
										</c:when>
										<c:otherwise>
											<img class="profile-image" 
												src="${pageContext.request.contextPath }${tmp.profile }"/>
										</c:otherwise>
									</c:choose>
									<span>${tmp.writer }</span>
									<c:if test="${tmp.num ne tmp.comment_group }">
										@<i>${tmp.target_id }</i>
									</c:if>
									<span>${tmp.regdate }</span>
									<a data-num="${tmp.num }" href="javascript:" class="reply-link">답글</a>
									<c:if test="${tmp.writer eq id }">
										| <a data-num="${tmp.num }" href="javascript:" class="reviewComment-update-link">수정</a>
										| <a data-num="${tmp.num }" href="javascript:" class="reviewComment-delete-link">삭제</a>
									</c:if>
								</dt>
								<dd>
									<pre>${tmp.content }</pre>
								</dd>
							</dl>
							<form class="comment-form re-reviewInsert-form" 
								action="private/reviewComment_insert.do" method="post">
								<input type="hidden" name="ref_group"
									value="${dto.num }"/>
								<input type="hidden" name="target_id"
									value="${tmp.writer }"/>
								<input type="hidden" name="comment_group"
									value="${tmp.comment_group }"/>
								<textarea name="content"></textarea>
								<button class="btn btn-primary" type="submit">등록</button>
							</form>
							<!-- by남기, 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 _210303 -->
							<c:if test="${tmp.writer eq id }">
								<form class="comment-form reviewUpdate-form" 
									action="private/reviewComment_update.do" method="post">
									<input type="hidden" name="num" value="${tmp.num }"/>
									<textarea name="content">${tmp.content }</textarea>
									<button type="submit">수정</button>
								</form>
							</c:if>
						</li>						
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<script>
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
	});
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정폼을 
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".reviewUpdate-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){
			//console.log(data);
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#comment"+data.num; //"#comment6" 형식의 선택자 구성
			
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
			"/review/private/reviewComment_delete.do?num="+num+"&ref_group=${dto.num}";
		}
	});
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/review/reviewDetail.do?num=${dto.num}";
		}
		
		var selector="#comment"+$(this).attr("data-num");
		$(selector)
		.find(".re-reviewInsert-form")
		.slideToggle();
		
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답들로 바꾼다.
		}	
	});
	$(document).on("submit",".reviewInsert-form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/login_form.do?"+
					"url=${pageContext.request.contextPath }/review/reviewDetail.do?num=${dto.num}";
			return false; //폼 전송 막기 		
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="reviewDelete.do?num=${dto.num}";
		}
	}
	
	//페이지가 처음 로딩될때 1page 를 보여준다고 가정
	var currentPage=1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	var totalPageCount=${totalPageCount};
	//현재 로딩중인지 여부
	var isLoading=false;
	
	/*
	페이지 로딩 시점에 document 의 높이가 window 의 실제 높이 보다 작고
	전체 페이지의 갯수가(totalPageCount) 현재페이지(currentPage)
	보다 크면 추가로 댓글을 받아오는 ajax 요청을 해야한다.
	*/
	var dH=$(document).height();//문서의 높이
	var wH=window.screen.height;//window 의 높이
	
	if(dH < wH && totalPageCount > currentPage){
		//로딩 이미지 띄우기
		$(".loader").show();
		
		currentPage++; //페이지를 1 증가 시키고 
		//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
		$.ajax({
			url:"reviewCommentList.do",
			method:"get",
			data:{pageNum:currentPage, ref_group:${dto.num}},
			success:function(data){
				console.log(data);
				//data 가 html 마크업 형태의 문자열 
				$(".comments ul").append(data);
				//로딩 이미지를 숨긴다. 
				$(".loader").hide();
			}
		});		
	}	
	
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
			$.ajax({
				url:"reviewCommentList.do",
				method:"get",
				data:{pageNum:currentPage, ref_group:${dto.num}},
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
		}
	});			
</script>
<div style="margin-top:200px">
	<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
</body>
</html>
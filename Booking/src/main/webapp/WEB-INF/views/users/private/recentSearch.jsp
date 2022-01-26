<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css">
<style>

</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<h4>안녕하세요 ,</h4>
			<span>${loginId } </span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="my_review.do">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="reviewCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="my_reply.do">
					<dl id="top-reply" class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="replyCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="${pageContext.request.contextPath }/pay/cart.do">
					<dl class="card">
						<dt class="label">
							<span>북카트 ></span>
						</dt>
						<dd class="value">
							<span class="count" id="cartCount"></span>
							<span>개</span>
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="navigation">
			<div class="section">
				<div class="section-name">나의 쇼핑</div>
				<div class="linkList">
					<a id="side-order" class="link" href="my_order.do">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="updateform.do">계정정보 수정</a>
					<a id="side-pwd" class="link" href="pwd_updateform.do">비밀번호 수정</a>
					<a id="side-recent" class="link" href="recentSearch.do">최근 검색 기록</a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">북킹 소개</div>
			</div>
			<button class="logoutBtn">
				<a href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a>
			</button>
		</div>
		<div class="content">
			<div class="recent-box">
				<h2>검색 기록<span class="recent-sysdate">오늘 - <span id="date"></span></span></h2>
				<div class="recent-list">
					<div class="recent-listheader">
						<div class="allCheckWrap">
							<div class="allCheck">
								<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label> 
								<span>전체선택</span>
							</div>
							<button id="selectDeleteBtn" type="submit" class="selectDelete_btn" onClick="deleteChk(this)" >선택 삭제</button> 
							<script>
								//by준영, 체크박스 전체선택,전체해제 기능_210307
								$("#allCheck").click(function(){
									var chk = $("#allCheck").prop("checked");
									if(chk) {
										$(".chBox").prop("checked", true);
									} else {
										$(".chBox").prop("checked", false);
									}
								});
							</script>
						</div>	
						<script>
							//by준영, 체크박스 선택한 값을 읽어서 삭제한는 ajax로직_210311
							function deleteChk(){
								var url ="deleteCart.do";
								var valueArr = new Array();
								var list =$("input[name='chBox']");
								for(var i=0; i< list.length; i++){
									if(list[i].checked){//선택되어 있으면 배열에 값을 저장
										valueArr.push(list[i].value);	
									}
								}
								if(valueArr.length == 0){
									alert("선택된 항목이 없습니다.");
								}else{
									var chk = confirm("정말 삭제하시겠습니까");
									$.ajax({
										url:url,
										type:'post',
										traditional :true,
										data:{'valueArr' : valueArr},
										success:function(){
											if(chk){
												location.replace("cart.do");	
											}else{
												return false;
											}
											
										}
									})
								}
							}
						</script>
					</div>
					<div class="recent-listbody" id="recentSearchList">
							<!-- 
						<div class="recent-li">
							<div class="recent-Chk">
								<input class="chBox" name="chBox" type="checkbox"/>
							</div>
							<div class="recent-date"></div>
							<div class="recent-word"></div>
							<div class="recent-delete">
								<button class="recent-btn"></button>
							</div>
						</div>
							 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath }/resources/js/info.js"></script>

<script>
	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
		
    $.ajax({ 
       	url:"${pageContext.request.contextPath}/v1/users/search/${sessionScope.id}",
        method:"GET",
        dataType : "json",
        success:function(data){
        	var searchList = "";
        	for (var i=0; i<data.content.length; i++) {
	        	searchList += '<div class="recent-li">'
		        	searchList += '<div class="recent-Chk">'
			        	searchList += '<input class="chBox" name="chBox" type="checkbox"/>'
		        	searchList += '</div>'
		        	searchList += '<div class="recent-date">'+data.content[i].regdate+'</div>'
		        	searchList += '<div class="recent-word">'+data.content[i].keyword+'</div>'
		        	searchList += '<div class="recent-delete">'
			        	searchList += '<button class="recent-btn">삭제</button>'
		        	searchList += '</div>'
	        	searchList += '</div>'
        	}
           $("#recentSearchList").html(searchList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
        },
    })
    
    // 작성글, 작성 댓글, 북카트, 나의 정보 호출
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/users/${id}",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			
			$("#reviewCount").html(data.review.totalElements);
			$("#replyCount").html(data.reviewDtl.totalElements);
			$("#cartCount").html(data.cart.totalElements);
			
		},
		error : function(data) {
			console.log("오류");
		}
	});
	
</script>
</body>
</html>
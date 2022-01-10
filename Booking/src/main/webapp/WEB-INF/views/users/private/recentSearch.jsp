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
			<span>catacat3 </span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="my_review.do">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count">3</span>
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
							<span class="count">3</span>
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
							<span class="count">0</span>
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
				<div>로그아웃</div>
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
					<div class="recent-listbody">
						<div class="recent-li">
							<div class="recent-Chk">
								<input class="chBox" name="chBox" type="checkbox"/>
							</div>
							<div class="recent-date">2022/01/03</div>
							<div class="recent-word">김치</div>
							<div class="recent-delete">
								<button class="recent-btn">삭제</button>
							</div>
						</div>
						<div class="recent-li">
							<div class="recent-Chk">
								<input class="chBox" name="chBox" type="checkbox"/>
							</div>
							<div class="recent-date">2022/01/02</div>
							<div class="recent-word">딸기</div>
							<div class="recent-delete">
								<button class="recent-btn">삭제</button>
							</div>
						</div>
						<div class="recent-li">
							<div class="recent-Chk">
								<input class="chBox" name="chBox" type="checkbox"/>
							</div>
							<div class="recent-date">2022/01/01</div>
							<div class="recent-word">초코</div>
							<div class="recent-delete">
								<button class="recent-btn">삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
	
	$('#side-recent').on('click',function(){
		function recentSearch(){
		    $.ajax({ 
		       	url:"recentSearch.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	
	
	
	//회원탈퇴묻기
	function deleteConfirm(){
		let isDelete=confirm(" 회원님 정말로 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath}/users/private/delete.do";
		} else {
			location.reload();
		}
	}
	
</script>
<script>
let time = new Date();

$('#date').html(time.toLocaleString());
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/paid.css">

</head>
<body>
	<div class="popup">		
		<a id="close"><img src="${pageContext.request.contextPath }/resources/images/x.svg"/></a>
		<div class="login-wrap">
			<div class="popup-head">	
				<div class="head-logo"><img src="${pageContext.request.contextPath }/resources/images/bookinglogo.svg"/></div>
				<h2 class="title">북킹 로그인</h2>
			</div>
			<div class="popup-body">	
				<form id="loginForm" class="loginForm" novalidate="" action="${pageContext.request.contextPath }/users/login" method="post">
					<%-- 원래 가려던 목적지 정보를 url 이라는 파라미터 명으로 전송될수 있도록 한다. --%>
					<input type="hidden" id="url" name="url" value="${url }"/>
					<div class="errorValid-off">아이디 혹은 비밀번호가 잘못 입력되었습니다.</div>
					<div class="idBox">
						<label for="id" hidden>아이디</label>
						<input type="text" class="loginId" id="loginId" name="loginId" placeholder="아이디"  value="${savedId }">
						<span class="errorId-off">필수 입력 항목입니다.</span>
					</div>
					<div class="pwdBox">
						<label for="pwd" hidden>비밀번호</label>
						<input type="password" class="pwd" id="pwd" name="pwd" placeholder="비밀번호" value="${savedPwd }">
						<span class="errorPwd-off">필수 입력 항목입니다.</span>
					</div>
					<div class="checkId">
						<label>
     						<input type="checkbox" id="saveId" name="isSave" value="yes"> 로그인 유지하기
   						</label>
					</div>
				<button class="submitBtn" type="button" onclick="login()">로그인</button>
				</form>
			</div>
			<div class="popup-foot"> 
				<span>회원이 아니신가요? <a href="${pageContext.request.contextPath }/signup_form.do">회원가입</a></span>
			</div>	
		</div>		
	</div>
</body>
</html>
<script>	
var loginId = $("#loginId").val();
var loginPwd = $("#pwd").val();
if(loginId && loginPwd != null){
	$("input:checkbox[id='saveId']").prop("checked", true);
}

$(document).ready(function() {
    $('#searchForm').submit(function() {
        if ($('#searchBook').val() == '') {
            return false;
        }
    }); 
}); 

function modalClose(){
    $("#popup").fadeOut(); //페이드아웃 효과
    $('.loginForm')[0].reset();
	$('.errorId-on').attr('class','errorId-off');
	$('.loginId-error').attr('class','loginId');
	$('.errorPwd-on').attr('class','errorPwd-off');
	$('.pwd-error').attr('class','pwd');
} 
//by준영. 로그인 시 모달창 기능

$(function(){
	$("#modal-open").click(function(){        
    	$("#popup").css('display','flex').hide().fadeIn();
    //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
	});
	$("#close").click(function(){
	    modalClose(); //모달 닫기 함수 호출
	});
	//by준영 모달영역 밖 클릭시 나가지는 기능(폼 초기화)
	$(document).mouseup(function (e){
		var popup = $('#popup');
		if( popup.has(e.target).length === 0){
			modalClose();
		}
	});
});


//by 준영 로그인폼 제출 엔터키로 가능하게끔 하는 기능
$('#loginForm').keypress(function(event){
     if ( event.which == 13 ) {
    	 login();
         return false;
     }
});

//by 준영, 로그인버튼 클릭시 유효성체크 및 제출
var loginClickCheck = 0;

function login(){
	loginClickCheck = 1;
	var loginId = $("#loginId").val();
	var loginPwd = $("#pwd").val();
	var saveIdCheck = $('#saveId:checked').val();
	var error = ((loginId === '' || loginPwd === '') ? 1 : 0 );
 	
	var loginData = {loginId : loginId, pwd : loginPwd};
	
	switch(error){
		case 0:
			$.ajax({
				type : 'POST',
				url:"${pageContext.request.contextPath}/v1/users/login",
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(loginData),
				success : function(result){
					$("#url").val(window.location.href);
					$("#loginForm").submit()
					$("#popup").fadeOut();
				},
				error : function(result) {
					// 로그인 실패시 (아이디 또는 비밀번호가 틀린 경우)
					alert("아이디 또는 비밀번호를 확인해주세요.");
				}
			});
			break;
		case 1:
			if(loginId == '' && loginPwd == ''){
				$('.errorId-off').attr('class','errorId-on');
				$('.loginId').attr('class','loginId-error');
				$('.errorPwd-off').attr('class','errorPwd-on');
				$('.pwd').attr('class', 'pwd-error');
				$('#loginId').focus();
				return;
			}else if(loginId == ''){
				$('.errorId-off').attr('class','errorId-on');
				$('.loginId').attr('class','loginId-error');
				$('#loginId').focus();
				return;
			}else if(loginPwd == ''){
				$('.errorPwd-off').attr('class','errorPwd-on');
				$('.pwd').attr('class','pwd-error');
				$('#pwd').focus();
				return;
			}
	 	}	
	}  
	
	//by 준영, 유효성검사 -실시간체크
	$("#loginId").keyup(function(){
		if(loginClickCheck == 0){
			return;
		}
		if($('#loginId').val().length > 0){
			$('.errorId-on').attr('class','errorId-off');
			$('.loginId-error').attr('class','loginId');
		}else{
			$('.errorId-off').attr('class','errorId-on');
			$('.loginId').attr('class','loginId-error');
			$('#loginId').focus();
		}
	})
	$("#pwd").keyup(function(){
		if(loginClickCheck == 0){
			return;
		}
		if($('#pwd').val().length > 0){
			$('.errorPwd-on').attr('class','errorPwd-off');
			$('.pwd-error').attr('class','pwd');
		}else{
			$('.errorPwd-off').attr('class','errorPwd-on');
			$('.pwd').attr('class','pwd-error');
			$('#pwd').focus();
		}
	})
	
</script>
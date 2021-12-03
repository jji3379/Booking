<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>

	<style>
	/*  --- header --- */
	.mainWrap {
		height: 93px;
	}
	.navWrap {
		height: 43px;
	}
	.mainWrap , .navWrap {
		font-family: '777Balsamtint';
	}
	.mainWrap .center{
		position: relative;
	    height: 100%;
	    width: 960px;
	    text-align: left;
	    margin: 0 auto;
	    display: block;
	    z-index: 100;
	}
	.center .logo {
		position: absolute;
	    top: 20px;
	    left: 0;
	    display: block;
	    width: 232px;
	    /* height: 63px; */
    }
	.center .search {
		position: absolute;
	    top: 38px;
	    left: 300px;
	    z-index: 20 !important;
	}
	.center .search input {
		font-family: '777Balsamtint';
	    font-size: 20px;
	    line-height: 32px;
	    height: 32px;
	    float: left;
	    width: 300px;
	    border: 0;
	    text-indent: 16px;
	    padding: 0;
	}
	.search{
		width:30px;
		padding:0px;
		display: flex;
	}
	.search > a > img {
		width:30px;
	}
	#searchForm {
		display: flex;
	}
	#searchBook{
		height: 42px;
		width: 400px;
		border: 2px solid #44695a;
		border-radius: 1px;
		margin-right: 8px;
	}
	.Users {
		position: absolute;
	    top: 26px;
	    right: -80px;
	    width: 220px;
	    height: 61px;
	    overflow: hidden;
	    z-index: 1;
	    text-align: right;
	}
	.Users > a > img {
		width: 45px;
    	border-radius: 1.25rem;
   	    position: relative;
    	top: 13px;
	}
	
	.navWrap {
		font-size: 25px;
		width: 100%;
	    height: 45px;
	    position: relative;
	    z-index: 21;
	    background-color: #41495c;
	}
	.Btns {
		height: 45px;
	    width: 1200px;
	    margin: 0 auto;
	    text-align: center;
	}
	.Btns > li {
		position: relative;
		width: 15%;
	    height: 35px;
	    float: left;
	 	margin: 0px 23px;
	}
	.Btns > li > a {
		color: #fff;
	    text-transform: uppercase;
	    text-decoration: none;
	    letter-spacing: 0.15em;
	    display: inline-block;
	    position: relative;
	}
	.Btns > li::before {
		content: "|";
		color: white;
		padding-right: 75px;
	    opacity: .7;
	}
	.Btns > li:first-child::before {
		content: "";
	}
	.Btns > li > a:after {   
		background: none repeat scroll 0 0 transparent;
		bottom: 2px;
		content: "";
		display: block;
		height: 2px;
		left: 50%;
		position: absolute;
		background: #fff;
		transition: width 0.3s ease 0s, left 0.3s ease 0s;
		width: 0;
	}
	.Btns > li > a:hover:after { 
		width: 100%; 
		left: 0; 
	}
	
	ul {
		display: block;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 180px;
	}
	ul li {
		list-style: none;
	    list-style-type: none;
	    float: left;
	}
	#nav-logo {
		width: 200px;
		
	}

	.navWrap ul.Btns li a {
	    line-height: 45px;
	    display: inline-block;
	    text-decoration: none;
	    letter-spacing: 0.05em;
	    font-size: 23px;
	    color: #ffffff;
	    text-decoration: none;
	}
	.srcBtn {
		background: url(${pageContext.request.contextPath }/resources/images/search.svg) no-repeat top left;
	    background-size: contain;
	    cursor: pointer;
	    display: inline-block;
	    height: 37px;
	    width: 30px;
	    margin-right: 6px;
	    border: none;
    	outline:none;
    	position: relative;
    	top: 3px;
	}
	.member {
		font-weight: bold;
		color: #212529;
		text-align: center;
		border: 1px solid gray;
		padding: 0.375rem 0.75rem;
		font-size: 15px;
		border-radius: 1.25rem;
	}
	.nonMember {
		position: relative;
		top: 47%;
		line-height: 1.5;
		font-weight: bold;
		color: #212529;
		text-align: center;
		border: 1px solid gray;
		padding: 0.375rem 0.75rem;
		font-size: 15px;
		border-radius: 1.25rem;
	}
	.cartImg {
		position: relative;
    	top: 3px;
	}
	.userImg {
	
	}
	.cartBadge {
		position: absolute;
		display: inline-block;
		padding: 0.3em 0.28em;
		font-size: 30px;
		font-weight: 700;
		line-height: 1;
		text-align: center;
		white-space: nowrap;
		vertical-align: baseline;
		border-radius: 0.25rem;
		color: #fff;
		background-color: #86b3e3;
		transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}
	/* --- modal ---*/
	.popup-wrap{
		background-color:rgba(0,0,0,.6); 
		/* 배경색과 투명도로 살짝 어둡지만 투명한 배경
		허공에 붕 떠있는 느낌을 주고 싶으면 안넣어도 무방 */
		justify-content:center; /* 수평 중앙정렬 */
		align-items:center;     /* 수직 중앙정렬 */
		position:fixed;          /* 포지션 픽스, 화면이 스크롤되더라도 고정되기 위함 */
		top:0;
		left:0;
		right:0;
		bottom:0;               /* 모든 방향에 0을 주면 화면에 꽉차게 됩니다. */
		display:none; 
		/* 이벤트가 발생할 때 띄우기 위해 숨김
		처음부터 보이게 하는 상황이라면 display:flex; */
		padding:15px; 
		/* 반응형의 경우 padding이 없으면 박스가 화면에 붙어서 안이뻐짐 */
		z-index: 9999;
		
	}
	.popup{
		width:100%;               /* 반응형 이기 때문에 가로값은 100% */
		max-width:440px;          /* 팝업의 최대 크기지정 */
		height: 476px;
		border-radius:5px;       /* 둥글둥글한 디자인을 위해 각을 없앱니다. */
		overflow:hidden;          /* 각을 없앴을 때 내부 영역이 튀어나오는걸 방지 */
		background-color: #fff; 
		/* 팝업이 허공에 떠있는 듯한 느낌을 주기 위한 그림자 효과. */
		box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3); 
		padding: 20px;
	}
	.login-wrap{
		max-width:420px;
		margin: 0 auto;
	    width: 100%;
	    position: relative;
	    box-sizing: border-box;
	}
	.popup-head{
		width: 100%;/* 부모요소를 따라가기 때문에 굳이 가로값을 주지 않아도 되지만 일부 ie에서 인식 못하는 문제가 있음 */
		margin-bottom: 40px;
		justify-content:center;
		text-align: center;
		
	}
	.head-logo{
		background: url(${pageContext.request.contextPath }/resources/images/bookinglogo.svg) no-repeat top left;
		background-position: center;
		background-size: contain;
		display: block;
    	height: 50px;
    	margin-top:30px;
    	
	}
	.title {
		font-family: '777Balsamtint';
		margin-top: 15px;
	    margin-bottom: 15px;
	    text-align: center;
	    font-size: 24px;
	    color: #111111;
	    font-weight: 500;
	}
	.popup-body{         		/* 몸통 */
		width:100%;
		background-color:#ffffff; /* 컨텐츠 영역의 배경색 */
	}
	.body-content{              /* 몸통 내부 컨텐츠 영역 */
		width:100%;
		
	}
	.idBox{             /* 컨텐츠 타이틀 영역 */
		
		margin-bottom:10px;     /* 내용과 간격 조정 */
	}
	.loginId {
		width: 100%;
	    height: 40px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	.loginId-error {
		width: 100%;
	    height: 40px;
	    border: 1px solid #fe0000;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	
	
	.pwdBox{          /* 컨텐츠 내용 영역 */
		word-break:break-word;    /* 단어가 짤리지 않음 */
		overflow-y:auto;          /* 내부요소가 지정한 세로 값보다 클 경우 스크롤 생성 */
		         
	}
	.pwd {
		width: 100%;
	    height: 40px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	.pwd-error {
		width: 100%;
	    height: 40px;
	    border: 1px solid #fe0000;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	
	.errorValid-off {
	    display: none;
	}
	.errorValid-on {
		font-size: 10px;
	   	color: #fe0000;
	    padding: 0 0 10px 0;
	    display: none;
	}
	.errorId-off {
    	display: none;
	}
	.errorId-on {
		margin: 8px 0 1px 0;
    	font-size: 10px;
    	color: #fe0000;
	}
	.errorPwd-off {
    	display: none;
	}
	.errorPwd-on {
		margin: 8px 0 1px 0;
    	font-size: 10px;
    	color: #fe0000;
	}
	
	.checkId{
		font-size: 12px;
		color: #8d8d8d;
		margin-top: 13px;
	}
	.popup-foot {
		margin-top: 35px;
		text-align: center;
	}
	.popup-foot > span {
		font-size: 11px;
	}
	.popup-foot > span > a {
		font-size: 11px;
		text-decoration: underline;
		color: #000;
	}
	
	.submitBtn {
		margin-top: 30px;
		padding-left: 0px !important;
	    padding-right: 0px !important;
	    width: 100%;
	    text-align: center;
	    height: 40px;
	    font-size: 14px;
	    padding: 13px 30px;
	    background-color: black;
	    border: 1px solid black;
	    color: white;
	    line-height: 1;
	    cursor: pointer;
	}
	#close {
		float: right;
		background: url(${pageContext.request.contextPath }/resources/images/x.svg) no-repeat top left;
		background-size: contain;
		width: 15px;
		height: 15px;
		cursor: pointer;
	}
	

    </style>
    <script src="http://code.jquery.com/jquery-1.12.0.js"></script>

</head>
	<div class="mainWrap">
		<div class="center">
			<div class="logo">
				<a href="${pageContext.request.contextPath }">
					<img id="nav-logo" src="${pageContext.request.contextPath }/resources/images/bookinglogo.svg"/>
				</a>
			</div>
			<div class="search">
				<form id="searchForm" action="${pageContext.request.contextPath }/bookList/conditionSearch.do" method="get" >  
			        <input id="searchBook" type="text" aria-label="Search"
			           name="keyword" placeholder="검색어를 입력하세요"/>
			        <input name="pageNum" value="1" hidden/>
			        <input name="start" value="1" hidden/>
			        <button type="submit" class="srcBtn" ></button>
			    </form>
			    <a class="cartImg" href="${pageContext.request.contextPath }/pay/cart.do">
		    		<img  src="${pageContext.request.contextPath }/resources/images/cart.svg"/>	
			    	<span class="cartBadge">${count}</span>
			   	</a>
			</div>
			<div id="signin">
			
			</div>
			<c:choose>
				<c:when test="${not empty sessionScope.id }">
				<div class="Users">
					<a href="" class="userImg "><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="" /></a>
					<a href="" class="member" >${loginId } 님</a>
					<a href="${pageContext.request.contextPath }/users/logout.do" class="member">로그아웃</a>
				</div>
				</c:when>
				<c:otherwise>
				<div class="Users">
					<a href="#"  class="nonMember" id="modal-open" data-toggle="modal" data-target="#login">로그인</a>
					<a href="${pageContext.request.contextPath }/signup_form.do"  class="nonMember">회원가입</a>
				</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="navWrap">
		<ul class="Btns">
			<li>
				<a href="${pageContext.request.contextPath }/CategoryList.do?d_catg=100&sort=count&start=1">전체도서</a>
			</li>
			<li>
	        	<a href="${pageContext.request.contextPath }/bestSeller.do">베스트셀러 </a>
	     	</li>
			<li>
				<a href="${pageContext.request.contextPath }/review">도서리뷰 </a>
			</li>
			<li>
		        <a href="${pageContext.request.contextPath }/map/mapsearch.do">서점 찾기</a>
		    </li>
		</ul>
	</div>
	<!-- The Modal -->
	<div id="container"> 
		<div class="popup-wrap" id="popup"> 
			<div class="popup">		
				<a id="close"></a>
				<div class="login-wrap">
					<div class="popup-head">	
						<span class="head-logo"></span>
						<h2 class="title">북킹 로그인</h2>
					</div>
					<div class="popup-body">	
						<form id="loginForm" class="loginForm" novalidate="">
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
						</form>
						<button class="submitBtn" type="button" onclick="login()">로그인</button>
					</div>
					<div class="popup-foot"> 
						<span>회원이 아니신가요? <a href="${pageContext.request.contextPath }/signup_form.do">회원가입</a></span>
					</div>	
				</div>		
			</div>
		</div>
	</div>
<script>	
	var url = $('#url').val();
	$(document).ready(function() {
	    $('#searchForm').submit(function() {
	        if ($('#searchBook').val() == '') {
	            alert('검색어를 입력하세요.');
	            return false;
	        }
	    }); 
	}); 
	//by준영. 로그인 시 모달창 기능
	$(function(){
		$("#modal-open").click(function(){        
		    $("#popup").css('display','flex').hide().fadeIn();
			    //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
		});
		$("#close").click(function(){
		    modalClose(); //모달 닫기 함수 호출
		});
		function modalClose(){
		    $("#popup").fadeOut(); //페이드아웃 효과
		}
		//by준영 모달영역 밖 클릭시 나가지는 기능(폼 초기화)
		$(document).mouseup(function (e){
			var popup = $('#popup');
			if( popup.has(e.target).length === 0){
				$("#popup").fadeOut();
	  			$('.loginForm')[0].reset();
	  			$('.errorId-on').attr('class','errorId-off');
				$('.loginId-error').attr('class','loginId');
				$('.errorPwd-on').attr('class','errorPwd-off');
				$('.pwd-error').attr('class','pwd');
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
		var pwd = $("#pwd").val();
		var saveIdCheck = $('#saveId:checked').val();
		var error = ((loginId === '' || pwd === '') ? 1 : 0 );
	 	
		/* if(saveIdCheck == 'on'){
			localStorage.setItem("saveId",loginId);
		}else{
			localStorage.setItem("saveId",'N');
		}
		*/
		var loginData = {loginId : loginId, pwd : pwd};
		
		switch(error){
			case 0:
				$.ajax({
					type : 'POST',
					url:"${pageContext.request.contextPath}/v1/users/login",
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(loginData),
					success : function(result){
						if(result == 0){
							alert("아이디,비번 확인");
							return false;
						}else{//로그인성공	
							/* $('.mainWrap').load(document.URL +  ' .mainWrap'); */
							location.reload();
							$("#popup").fadeOut();
						}
					},
					
				});
			break;
		case 1:
			if(loginId == '' && pwd == ''){
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
			}else if(pwd == ''){
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



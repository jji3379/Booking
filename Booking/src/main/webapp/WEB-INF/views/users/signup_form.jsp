<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<title>책과의 즉석만남 Booking</title>
<style>
	.is-Blank {
		margin: 8px 0 1px 0;
	    font-size: 10px;
	    color: #fe0000;
	    margin-bottom: 10px;
	}
	.is-Valid {
		display:none;
	}
	.is-inValid {
		margin: 8px 0 1px 0;
	    font-size: 10px;
	    color: #fe0000;
	    margin-bottom: 10px;
	}
	.boxError {
		width: 100%;
	    height: 44px;
	    border: 1px solid #fe0000;
	    border-radius: 2px;
	    margin-top: 15px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	

</style>
<link rel="stylesheet" href="resources/css/signup_form.css">
</head>
<body>
<div class="container">
	<!-- 
		[ novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기 ]
		<input type="email" /> 같은 경우 웹브라우저가 직접 개입하기도 한다.
		해당기능 사용하지 않기 위해서는 novalidate 를 form에 명시해야 한다.
	 -->
	 <div class="signup-wrap">
	 	 <div class="signup-head">
	 	 	<h2>북킹 멤버 가입</h2>
	 	 	<p>멤버가 되어 북킹에서의 <br /> 최고의 혜택을 만나보세요</p>
	 	 </div>
	 	 <div class="signup-body">
	 	 	<form action="${pageContext.request.contextPath }/users/signup.do" method="post" id="myForm" novalidate>
		 	<div class="form-group">
		 		<label for="id" hidden>아이디</label>
		 		<input class="form-control" type="text" name="loginId" id="signupId" placeholder="사용하실 ID를 입력해주세요. (영문 소문자 5~10글자 이내)"/>
		 		<span id="idMsg" class="is-Blank"></span>
		 		<div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
		 	</div>
		 	<div class="form-group">
		 		<label for="pwd" hidden>비밀번호</label>
		 		<input class="form-control" type="password" name="pwd" id="signupPwd" placeholder="사용하실 패스워드를 입력해주세요. (5글자~10글자 이내)"/>
		 		<span id="pwdMsg" class="is-Blank"></span>
		 		<div class="invalid-feedback">비밀번호를 형식에 맞게 입력하세요</div>
		 	</div>
		 	<div class="form-group">
		 		<label for="pwd2" hidden>비밀번호 확인</label>
		 		<input class="form-control" type="password" id="pwd2" placeholder="패스워드를 다시 입력해주세요." />
		 		<span id="pwd2Msg" class="is-Blank"></span>
		 		<div class="invalid-feedback">비밀번호를 확인 하세요</div>
		 	</div>
		 	<div class="form-group">
		 		<label for="email" hidden>이메일</label>
		 		<input class="form-control" type="email" name="email" id="email" placeholder="E-mail을 입력해주세요 (수신 가능 E-mail)"/>
		 		<span id="emailMsg" class="is-Blank"></span>
		 		<div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
		 	</div>
		 	<div class="form-group">
		 		<h6>관심사 선택 (최대 세가지 선택해주세요)</h6>
		 		<div class="scroll-box">
		 			<table>
						<colgroup>
							<col style="width:20%">
							<col style="width:25%">
							<col style="width:25%">
							<col style="width:30%">
						</colgroup>
						<tr >
							<td rowspan="10"><h6 class="interest">> 관심사</label></h6></td>
						</tr>
						<tr class="interestChk" >
							<td><input type="checkbox" /> 소설</td>
							<td><input type="checkbox" /> 인문</td>
							<td><input type="checkbox" /> 시 / 에세이</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 취미/레저</td>
							<td><input type="checkbox" /> 건강</td>
							<td><input type="checkbox" /> 가정/생활/요리</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 경제/경영</td>
							<td><input type="checkbox" /> 자기계발</td>
							<td><input type="checkbox" /> 사회</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 역사/문화</td>
							<td><input type="checkbox" /> 종교</td>
							<td><input type="checkbox" /> 예술/대중문화</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 사전</td>
							<td><input type="checkbox" /> 잡지</td>
							<td><input type="checkbox" /> 국어/외국어</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 과학/공학</td>
							<td><input type="checkbox" /> 여행/지도</td>
							<td><input type="checkbox" /> 취업/수험서</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 컴퓨터/IT</td>
							<td><input type="checkbox" /> 청소년</td>
							<td><input type="checkbox" /> 학습/참고서</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 유아</td>
							<td><input type="checkbox" /> 어린이</td>
							<td><input type="checkbox" /> 만화</td>
						</tr>
						<tr class="interestChk">
							<td><input type="checkbox" /> 해외도서</td>
							<td></td>
							<td></td>
						</tr>
						
					</table>
				</div>							
		 	</div>
		 	<!-- 이용약관 -->
		 	<div class="register-terms">
		 		<h6>개인정보 수집.이용동의</h6>
		 		<div class="grid">
		 			<table>
						<colgroup>
							<col style="width:23%">
							<col style="width:27%">
							<col style="width:25%">
							<col style="width:25%">
						</colgroup>
						<thead>
							<tr class="agree">
								<th>일시</th>
								<th>수집항목</th>
								<th>수집목적</th>
								<th>보유기간</th>
							</tr>
						</thead>
						<tbody>
							<tr class="agree">
								<td>가입시</td>
								<td>아이디, 이메일, 비밀번호</td>
								<td>회원식별 및 연락</td>
								<td><strong>회원탈퇴시까지(탈퇴 후 부정이용 방지를 위하여 3개월간 보관 후 파기)</strong></td>
							</tr>
							<tr class="agree">
								<td>최초 구매시</td>
								<td>성별, 생년월일, 이름, 휴대폰 번호</td>
								<td>본인확인</td>
								<td><strong>회원탈퇴시까지</strong></td>
							</tr>
							<tr class="agree">
								<td>상품 주문시</td>
								<td>수령인 정보(이름, 연락처, 주소), 결제수단 정보</td>
								<td>상품 주문 및 배송 등 구매계약의 이행, 상품구매 관련문의사항과 반품, 환불등 민원사항의 상담 및 처리</td>
								<td><strong>전자상거래법 등 관련 법령에 따른 보관기간</strong></td>
							</tr>
						</tbody>
					</table>
		 		</div>
		 		<input type="checkbox" id="isCheckAgree" name="isCheckAgree">
		 		<span >[필수] 개인정보 수집.이용동의</span>
		 	</div>
		 	<div class="agree-warn">
		 		※ 약관 및 개인정보 처리방침은 홈페이지 하단에 전문이 게재되어 있습니다. <br />
				※ 이용약관 및 개인정보 수집.이용 내용에 대해 동의 거부가 가능하며, <br />
				이 경우 회원가입 및 관련 서비스는 이용이 불가합니다.
		 	</div>
		 	<button class="signupBtn" type="button" onclick="signup()">회원가입하기</button>
		 </form>
	 	 </div>
	 </div>
</div>
<script>
	//[아이디를 검증할 정규 표현식]
	//영문자 소문자로 시작하고 5~10 글자 이내인지 검증
	let reg_id=/^[a-z].{4,9}$/;
	
	//[비밀번호를 검증할 정규 표현식]
	//5~10글자 이내인지 검증
	let reg_pwd=/^.{5,10}$/;
	
	//[이메일을 검증할 정규 표현식](정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용!)
	//@가 포함되어 있는지 검증
	let reg_email=/@/;
	
	//아이디 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isIdValid = false;
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isPwdValid = false;
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isEmailValid = false;
	//폼 전체의 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isFormValid = false;
	
	
	//by 준영, 로그인버튼 클릭시 유효성체크 및 제출
	var signupClickCheck = 0;
	//폼에 submit 이벤트가 일어 났을 때 jquery 를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm 인 요소에 submit 이벤트가 일어 났을때 실행할 함수 등록
	function signup(){
		signupClickCheck = 1;
		var signupId = $('#signupId').val();
		var signupPwd = $('#signupPwd').val();
		var pwd2 = $('#pwd2').val();
		var email = $('#Email').val();
		
		function formValidation() {
			if(signupId == ''){
				$('#idMsg').html('필수 입력 항목입니다.');
				$('#signupId').attr('class', 'boxError');
				$('#signupId').focus();
				return false;
			}
			if(signupPwd == ''){
				$('#pwdMsg').html('필수 입력 항목입니다.');
				$('#signupPwd').attr('class', 'boxError');
				$('#signupPwd').focus();
				return false;
			}
			if(pwd2 == ''){
				$('#pwd2Msg').html('필수 입력 항목입니다.');
				$('#pwd2').attr('class', 'boxError');
				$('#pwd2').focus();
				return false;
			}
			if(email == ''){
				$('#emailMsg').html('필수 입력 항목입니다.');
				$('#email').attr('class', 'boxError');
				$('#email').focus();
				return false;
			}
			return true;
		}
			
		
		
		
		//폼 전체의 유효성 여부를 얻어낸다.
		isFormValid = isPwdValid && isEmailValid;
		//만일 폼이 유효하지 않는다면
		if(!isFormValid) {
			return false; //폼 전송 막기
		}
	};
	
	//이메일을 입력했을 때 실행할 함수 등록
	$("#email").on("input", function(){ // == document.querySelector("#email").addEventListener("input", function(){...})
		let inputEmail = $("#email").val();
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-Blank boxError");
		//만일 이메일이 정규표현식에 매칭되지 않는다면
		if(!reg_email.test(inputEmail)) {
			$('#emailMsg').html('이메일 형태로 작성하세요');
			$('#email').addClass('is-inValid');
			isPwdValid = false;
		} else {
			$("#email").addClass("is-valid");
			isEmailValid = true;
			
		}
	});
	
	//id가 pwd와 pwd2인 요소에 input 이벤트가 일어났을 때 실행할 함수 등록
	$("#signupPwd, #pwd2").on("input", function(){
		// input 이벤트가 언제 일어나는지 확인 요망!
		console.log("input!!");
		
		//입력한 두 비밀번호를 읽어온다.
		let signupPwd=$("#signupPwd").val();
		let pwd2 =$("#pwd2").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#signupPwd").removeClass("is-Blank boxError");
		$("#pwd2").removeClass("is-Blank boxError");
		
		//비밀번호가 정규표현식에 매칭되지 않으면
		if(!reg_pwd.test(pwd)){
			//비밀번호가 유효하지 않는다고 표시하고
			$("#pwdMsg").html('비밀번호를 5~10 글자 이내로 작성하세요');
			$("#signupPwd").addClass("is-inValid");
			isPwdValid = false;
		} else {
			$("#pwdMsg").addClass("is-valid");
			$("#pwd2").removeClass("is-Blank boxError");
		}
		
		//두 비밀번호가 같은지 확인
		if(pwd == pwd2) {
			//같으면 유효하다는 클래스를 추가
			$("#pwd2").addClass("is-valid");
			$("#pwd2").removeClass("is-Blank boxError");
		} else {
			$("#pwdMsg").html('비밀번호가 다릅니다.');
			$("#signupPwd").addClass("is-inValid");
			//다르면 유효하지 않다는 클래스 추가
			
			isPwdValid = false;
		}
	});
	
	//아이디 입력란에 입력했을 때 실행할 함수 등록
	$("#signupId").on("input", function(){
		//1. 입력한 아이디를 읽어와서
		let inputId = $("#id").val();
		
		//2. 서버에 ajax 요청으로 보내서 사용 가능 여부를 응답 받아서 반응을 보여준다.
		//일단 모든 검증 클래스를 제거하고
		$("#signupId").removeClass("is-valid is-Blank")
		
		//입력한 문자열이 정규표현식과 매칭되는지 테스트
		if(!reg_id.test(inputId)) {
		//만일 매칭되지 않으면
		//아이디가 유효하지 않다고 표시하고
			$("#idMsg").html('영문 소문자 5~10 글자 이내로 입력해주세요.');
			$("#signupId").addClass("is-inValid");
			isIdValid = false;
		//함수를 여기서 종료 한다
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/users/checkid.do",
			method:"GET",
			data:"inputId="+inputId,
			success:function(responseData){
				/*
					checkid.jsp 페이지에서 응답할 때
					contentType="application/json" 이라고 설정하면
					함수의 인자로 전달되는 responseData 는 object 이다.
					{isExist:true} or {isExist:false}
					형식의 object 이기 때문에 바로 사용할 수 있다.
 				*/
 				console.log(responseData);
				if(responseData.isExist) {
					$("#signupId").addClass("is-invalid");
					isIdValid = false;
				} else { //존재하지 않는 아이디 즉 사용가능한 아이디인 경우
					$("#signupId").addClass("is-valid");
					//아이디가 유효하다고 표시한다.
					isIdValid=true;
				}
			}
		})
	})
</script>
</body>
</html>
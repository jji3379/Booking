<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>

<title>책과의 즉석만남 Booking</title>
<style>
	
	.form-group label.error { 
		margin: 8px 0 1px 0;
	   font-size: 10px;
	   color: #fe0000;
	   margin-bottom: 10px; 
	}
	.form-control.error {
		width: 100%;
	    height: 44px;
	    border: 1px solid #fe0000;
	    border-radius: 2px;
	    margin-top: 15px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
	}
	.register-terms label.error {
		font-weight: bold;
	    font-size: 14px;
	    color: #fe0000; 
	}
	
	

</style>
<link rel="stylesheet" href="resources/css/signup_form.css">
<script src="http://code.jquery.com/jquery-1.3.2.min.js" ></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js" ></script>
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
	 	 	<form action="${pageContext.request.contextPath }/v1/users/signup" method="post" id="myForm" novalidate>
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
		 		<input class="form-control" type="password" name="pwd2" id="pwd2" placeholder="패스워드를 다시 입력해주세요." />
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
							<td rowspan="10"><h6 id="interest">> 관심사</label></h6></td>
						</tr>
						<tr class="interestChk" >
							<td><label for="novel"><input onclick="CountChecked(this)" type="checkbox" name="care" id="novel" value="novel"/> 소설</label></td>
							<td><label for="humanities"><input onclick="CountChecked(this)" type="checkbox" name="care" id="humanities" value="humanities"/> 인문</label></td>
							<td><label for="poetry"><input onclick="CountChecked(this)" type="checkbox" name="care" id="poetry" value="poetry"/> 시 / 에세이</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="hobby"><input onclick="CountChecked(this)" type="checkbox" name="care" id="hobby" value="hobby"/> 취미/레저</label></td>
							<td><label for="health"><input onclick="CountChecked(this)" type="checkbox" name="care" id="health" value="health"/> 건강</label></td>
							<td><label for="home"><input onclick="CountChecked(this)" type="checkbox" name="care" id="home" value="home"/> 가정/생활/요리</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="economy"><input onclick="CountChecked(this)" type="checkbox" name="care" id="economy" value="economy"/> 경제/경영</label></td>
							<td><label for="self"><input onclick="CountChecked(this)" type="checkbox" name="care" id="self" value="self"/> 자기계발</label></td>
							<td><label for="society"><input onclick="CountChecked(this)" type="checkbox" name="care" id="society" value="society"/> 사회</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="history"><input onclick="CountChecked(this)" type="checkbox" name="care" id="history" value="history"/> 역사/문화</label></td>
							<td><label for="religion"><input onclick="CountChecked(this)" type="checkbox" name="care" id="religion" value="religion"/> 종교</label></td>
							<td><label for="art"><input onclick="CountChecked(this)" type="checkbox" name="care" id="art" value="art"/> 예술/대중문화</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="dictionary"><input onclick="CountChecked(this)" type="checkbox" name="care" id="dictionary" value="dictionary"/> 사전</label></td>
							<td><label for="magazine"><input onclick="CountChecked(this)" type="checkbox" name="care" id="magazine" value="magazine"/> 잡지</label></td>
							<td><label for="language"><input onclick="CountChecked(this)" type="checkbox" name="care" id="language" value="language"/> 국어/외국어</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="science"><input onclick="CountChecked(this)" type="checkbox" name="care" id="science" value="science"/> 과학/공학</label></td>
							<td><label for="trip"><input onclick="CountChecked(this)" type="checkbox" name="care" id="trip" value="trip"/> 여행/지도</label></td>
							<td><label for="employment"><input onclick="CountChecked(this)" type="checkbox" name="care" id="employment" value="employment"/> 취업/수험서</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="IT"><input onclick="CountChecked(this)" type="checkbox" name="care" id="IT" value="IT"/> 컴퓨터/IT</label></td>
							<td><label for="teenager"><input onclick="CountChecked(this)" type="checkbox" name="care" id="teenager" value="teenager"/> 청소년</label></td>
							<td><label for="reference"><input onclick="CountChecked(this)" type="checkbox" name="care" id="reference" value="reference"/> 학습/참고서</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="infant"><input onclick="CountChecked(this)" type="checkbox" name="care" id="infant" value="infant"/> 유아</label></td>
							<td><label for="child"><input onclick="CountChecked(this)" type="checkbox" name="care" id="child" value="child"/> 어린이</label></td>
							<td><label for="comic"><input onclick="CountChecked(this)" type="checkbox" name="care" id="comic" value="comic" /> 만화</label></td>
						</tr>
						<tr class="interestChk">
							<td><label for="overseas"><input onclick="CountChecked(this)" type="checkbox" name="care" id="overseas" value="overseas"/>해외도서</label></td>
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
		 		<input type="checkbox" id="terms" name="terms" >
		 		<label id="labelTerms" for="terms">[필수] 개인정보 수집.이용동의</label>
		 		
		 	</div>
		 	<div class="agree-warn">
		 		※ 약관 및 개인정보 처리방침은 홈페이지 하단에 전문이 게재되어 있습니다. <br />
				※ 이용약관 및 개인정보 수집.이용 내용에 대해 동의 거부가 가능하며, <br />
				이 경우 회원가입 및 관련 서비스는 이용이 불가합니다.
		 	</div>
		 	<button onclick="min()" type="button" class="signupBtn" >회원가입하기</button>
		 </form>
	 	 </div>
	 </div>
</div>
<script>

//by 준영, 관심사 최대 갯수 이상 체크 막음
function CountChecked(obj){
	var count = 0;
	var care = document.getElementsByName("care");
	
	for(var i = 0; i < care.length; i++){
		if(care[i].checked){
			count++;
		}
	}
	if(count > 3){
		obj.checked = false;
		return false;
	}
}

//by 준영, 관심사 최소 개수 알림
function min() {
	var care = $('input:checkbox[name="care"]:checked');
	if (!care) {
		alert("관심사를 한가지 이상 선택해 주세요.");
		return;
	}
	/*
	var careList = '';
	
	for(var i=0; i<care.length; i++) {
		if(i == care.length-1) {
			careList += care[i].value;
		} else {
			careList += care[i].value + ", ";
		}
	}
	
	var data = {
		loginId : $("#signupId").val(),
		pwd : $("#signupPwd").val(),
		email : $("#email").val(),
		care : careList 
			//writer : $("#writer").val()
		};
		console.log(data);
		
		$.ajax({
			url:"${pageContext.request.contextPath }/v1/users/signup",
			method:"post",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success:function(data) {
				console.log("성공");
			},
			error : function(data) {
				console.log("오류");
			}
		});
		*/
}
//by 준영, Validate.js 라이브러리 
$(document).ready(function () { 
    // validate signup form on keyup and submit
    $('#myForm').validate({
        rules: {
            loginId:{
            	required:true, 
            	minlength:5, 
            	maxlength:10, 
	            remote : {            	
				    url : '${pageContext.request.contextPath }/v1/users/signup',
				    type : "get",
				    data : {
				    	loginId : function() {
				    		return $("#signupId").val();
				    	}
				    }
				    
	            }
            },
            pwd: {required:true, minlength:5, maxlength:10},
            pwd2: {required:true, equalTo:'#signupPwd'},               
            email: {required:true, email:true},
            terms: 'required'
        },
        messages: {
            loginId: {
                 required:"필수 입력 항목입니다.",
                 minlength: "영문 소문자 5~10글자 이내로 입력해 주세요.",
                 remote : "이미 존재하는 아이디 입니다."
                 },

            pwd:"필수 입력 항목입니다.",
            pwd2: {
                required: "필수 입력 항목입니다.",
                equalTo: "암호를 다시 확인하세요" 
                },
            email: {
                required:"필수 입력 항목입니다.",
                email: "이메일 형식으로 입력해 주세요."
                },
            terms: "!"
        }
//여기부터
,
		
        submitHandler: function (frm){
            frm.submit();   //유효성 검사를 통과시 전송
        },
        success: function(e){
            //
        }
//여기까지는 생략 가능           
    });
    
});



	
</script>
</body>
</html>
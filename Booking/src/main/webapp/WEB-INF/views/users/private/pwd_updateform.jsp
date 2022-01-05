<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="pwd-updateform">
	<h2>비밀번호 변경</h2>
	<form action="pwd_update.do" method="post" id="myPwd-form">
		<div class="myForm-header">
			<p class="contxt">안전한 비밀번호로 내정보를 보호하세요</p>
			<p class="contxt contxt_list"><em>다른 아이디/사이트에서 사용한 적 없는 비밀번호</em></p>
			<p class="contxt contxt_list"><em>이전에 사용한 적 없는 비밀번호</em>가 안전합니다.</p>			
		</div>	
		<div class="pwdform-group" >
			<label for="pwd">현재 비밀번호</label>
			<input class="pwdform-control" type="password" name="pwd"/>
		</div>
		<div class="pwdform-group" >
			<label for="newPwd">새 비밀번호</label>
			<input class="pwdform-control" type="password" name="newPwd" id="pwd"/>
		</div>
		<div class="pwdform-group" >
			<label for="newPwd2">새 비밀번호 확인</label>
			<input class="pwdform-control" type="password" id="pwd2"/>
		</div>
		<button type="submit" class="pwd-updateformBtn" >저장</button>
		<button type="reset" class="pwd-resetBtn" >초기화</button>
	</form>
</div>
<script>
	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm")
	.addEventListener("submit", function(event){
		let pwd1=document.querySelector("#pwd").value;
		let pwd2=document.querySelector("#pwd2").value;
		//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd1 != pwd2){
			alert("비밀번호를 확인 하세요!");
			event.preventDefault();//폼 전송 막기 
		}
	});
	
	//[비밀번호를 검증할 정규 표현식]
	//5~10글자 이내인지 검증
	let reg_pwd=/^.{5,10}$/;
	
	//id가 pwd와 pwd2인 요소에 input 이벤트가 일어났을 때 실행할 함수 등록
	$("#pwd, #pwd2").on("input", function(){
		// input 이벤트가 언제 일어나는지 확인 요망!
		console.log("input!!");
		
		//입력한 두 비밀번호를 읽어온다.
		let pwd=$("#pwd").val();
		let pwd2 =$("#pwd2").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#pwd").removeClass("is-valid is-invalid");
		
		//비밀번호가 정규표현식에 매칭되지 않으면
		if(!reg_pwd.test(pwd)){
			//비밀번호가 유효하지 않는다고 표시하고
			$("#pwd").addClass("is-invalid");
			isPwdValid = false;
			//함수를 여기서 종료
			return;
		}
		
		//두 비밀번호가 같은지 확인
		if(pwd == pwd2) {
			//같으면 유효하다는 클래스를 추가
			$("#pwd").addClass("is-valid");
			isPwdValid = true;
		} else {
			//다르면 유효하지 않다는 클래스 추가
			$("#pwd").addClass("is-invalid");
			isPwdValid = false;
		}
	});
	
	//회원탈퇴묻기
	function deleteConfirm(){
			let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
			if(isDelete){
				location.href="${pageContext.request.contextPath }/users/private/delete.do";
			} else {
				location.reload();
			}
	}
</script>
</body>
</html>

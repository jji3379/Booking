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
<body style="background-color:#484848;">
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="row" style="width:80%; height:650px;
	margin-top:50px; margin-left:auto; margin-right:auto; background-color:#f5e9dd; width:fit-content;">
	<jsp:include page="../../include/sideusers.jsp"></jsp:include>
	<div>
		<h1 style="margin-left:8px; margin-top:7px;">비밀번호 수정 폼</h1>
		<form action="pwd_update.do" method="post" id="myForm" style="margin-left:8px; margin-top:7px; width:800px">
			<div class="form-group" style="width:750px;">
				<label for="pwd">기존 비밀번호</label>
				<input class="form-control" type="password" name="pwd"/>
			</div>
			<div class="form-group" style="width:750px;">
				<label for="newPwd">새 비밀번호</label>
				<input class="form-control" type="password" name="newPwd" id="pwd"/>
				<small class="form-text text-muted">5글자~10글자 이내로 입력하세요</small>
				<div class="invalid-feedback">비밀번호를 확인 하세요</div>
			</div>
			<div class="form-group" style="width:750px;">
				<label for="newPwd2">새 비밀번호 확인</label>
				<input class="form-control" type="password" id="pwd2"/>
			</div>
			<button type="submit" class="btn btn-outline-primary" >수정하기</button>
			<button type="reset" class="btn btn-outline-warning" >리셋</button>
		</form>
	</div>
</div>
<div style="margin-top:200px">
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm")
	.addEventListener("submit", function(event){
		let pwd1=document.querySelector("#newPwd").value;
		let pwd2=document.querySelector("#newPwd2").value;
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
</script>
</body>
</html>

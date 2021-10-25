<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/* 프로필 업로드 폼을 화면에 안보이게 숨긴다 */
	#profileForm{
		display: none;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div style="margin-top:30px"></div>
<div class="row">
	<jsp:include page="../../include/sideusers.jsp"></jsp:include>
	<div class="col-9">
		<h1>개인정보 수정</h1>
		<a id="profileLink" href="javascript:">
		<c:choose>
			<c:when test="${empty dto.profile }">
				<span style="margin-left:7px" >프로필 이미지 수정</span>
			</c:when>
			<c:otherwise>
				<span>프로필 이미지 수정</span>
				<span><a href="javascript:deleteProfile();">삭제</a></span>
			</c:otherwise>
		</c:choose>
		</a>
		<form action="update.do" method="post" id="myForm">
			<div class="form-group" >
				<label for="id">아이디</label>
				<input type="text" id="id" value="${id }" class="form-control" disabled/>
			</div>
			<div class="form-group" >
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" value="${dto.email }" class="form-control"/>
				<div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
			</div>
			<div class="form-group" >
				<label for="care">관심사</label>
				<input type="text" id="care" name="care" value="${dto.care }" class="form-control"/>
			</div>
			<div>
				<button type="button" class="btn btn-outline-info" id="btn">수정확인</button>
				<button type="reset" class="btn btn-outline-secondary">취소</button>
				<a href="javascript:deleteConfirm();" class="btn btn-outline-danger" style="float:right; margin-right:50px">회원탈퇴</a>
			</div>
		</form>
	</div>
	<form action="profile_upload.do" method="post" 
		enctype="multipart/form-data" id="profileForm">
		<label for="image">프로필 이미지 선택</label>
		<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		<button type="submit">업로드</button>
	</form>
	
</div>
<script>
	//프로필 링크를 클릭했을때 실행할 함수 등록
	$("#profileLink").on("click", function(){
		// 아이디가 image 인 요소를 강제 클릭하기
		$("#image").click();
	});
	
	//이미지를 선택했을때 실행할 함수 등록
	$("#image").on("change", function(){
		//폼을 강제 제출해서 선택된 이미지가 업로드 되도록 한다.
		$("#profileForm").submit();
	});

	
	//[이메일을 검증할 정규 표현식](정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용!)
	//@가 포함되어 있는지 검증
	let reg_email=/@/;
	
	//이메일을 입력했을 때 실행할 함수 등록
	$("#email").on("input", function(){ 
		let inputEmail = $("#email").val();
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-valid is-invalid");
		//만일 이메일이 정규표현식에 매칭되지 않는다면
		if(!reg_email.test(inputEmail)) {
			isEmailValid = false;
			$("#email").addClass("is-invalid");
		} else {
			isEmailValid = true;
			$("#email").addClass("is-valid");
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
	//욱현.db에 있는 이메일과 관심사 대조해서 수정을 안했다면 수정완료했다는 메세지 안뜨게 하기_2021323
	
	//현재 폼에 입력되어있는 내용
	let email = $("#email").val();
	let care = $("#care").val();
	let profile = $("#profileImage").attr('src');
	
	//인풋이 된 이후의 폼에 있는 내용
	$("#email").on("input", function(){
		email = $("#email").val();
	});
	$("#care").on("input", function(){
		care = $("#care").val();
	})
	
	//db에 저장된 모델(버튼을 누르는 동시에 데이터를 받아 대조)
	document.querySelector("#btn")
	.addEventListener("click", function(event){//이미지를 선택했을때 실행할 함수 등록
	
		let inputId = $("#id").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath }/users/private/check_update.do",
			method:"POST",
			data:"inputId="+inputId,
			success:function(responseData){
 				console.log(responseData);
				let dbcare = responseData["care"];
				let dbemail = responseData["email"];
				let dbprofile = "/booking" + responseData["image"];
				if(care==dbcare && email==dbemail ) {
					alert("수정되지 않았습니다.");
					event.preventDefault();//폼 전송 막기
				} else {
					$("#myForm").trigger("submit");
				}
			}
		})
	});
	
	
	//욱현.프로필이미지 삭제_2021323
	function deleteProfile(){
		let inputId = $("#id").val();
		$.ajax({
			url:"${pageContext.request.contextPath }/users/private/delete_profile.do",
			method:"POST",
			data:"inputId="+inputId,
			success:function(){
				console.log("문어병장황준성");
				location.reload();
			}
		})
	}
	
</script>
</body>
</html>
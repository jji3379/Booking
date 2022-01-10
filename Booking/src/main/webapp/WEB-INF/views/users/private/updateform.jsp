<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<div class="account-form">
	<h2>기본 정보</h2>
	<div class="profile-box">
		<img id="preImg" src="" alt="" />
		<c:choose>
			<c:when test="${empty dto.profile }">
				<form name="profile" action="profile_upload.do" method="post" 
					enctype="multipart/form-data" id="profileForm">
					<label for="image"></label>
					<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG" style="display:none;"/>
					<input type="hidden" name = "target_url">
					<div class="profile-buttons" style="padding-top:40px;">
						<button type="submit">업로드</button>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<form name="profile" action="profile_upload.do" method="post" 
					enctype="multipart/form-data" id="profileForm">
					<label for="image"></label>
					<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG" style="display:none;"/>
					<input type="hidden" name = "target_url">
					<div class="profile-buttons">
						<button type="submit">업로드</button>
						<a href="javascript:deleteProfile();">삭제</a>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
	<form action="update.do" method="post" id="myProfile-form">
		<div class="account-inputBox">
			<div class="account-formGroup">
				<div class="account-label"><label for="id">아이디</label></div>
				<div><input type="text" id="id" class="account-updateform" value="${sessionScope.loginId }" class="form-control" disabled/></div>
			</div>
			<div class="account-formGroup" >
				<div class="account-label"><label for="email">이메일</label></div>
				<div><input type="text" id="email" class="account-updateform" name="email" value="${dto.email }" class="form-control"/></div>
			</div>
		</div>
		<div class="account-formGroup">
			<label class="account-label" for="care">관심사 <span>(최대 세가지 선택해주세요)</span></label>
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
		<div>
			<button type="button" class="account-save">저장</button>
			<a href="javascript:deleteConfirm();" class="account-delete" >회원탈퇴</a>
		</div>
	</form>
</div>
<script>
	$('#preImg').attr('src', '${pageContext.request.contextPath }/resources/images/home.png');
	$('#preImg').click(function (e) {
	    document.profile.target_url.value = document.getElementById( 'preImg' ).src;
	    e.preventDefault();
	    $('#image').click();
	}); 
	
	
	//by 준영, 프로필 사진 업로드시, 미리보기
	$(function() {
	    $("#image").on('change', function(){
	        readURL(this);
	    });
	});
	function readURL(input) {
	    if (input.files && input.files[0]) {
	       var reader = new FileReader();
	       reader.onload = function (e) {
	          $('#preImg').attr('src', e.target.result);
	       }
	       reader.readAsDataURL(input.files[0]);
	    }
	}

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
			success:function(data){
 				console.log(data);
				let currentCare = data["care"];
				let currentEmail = data["email"];
				let currentProfile = "/booking" + data["image"];
				if(care==currentCare && email==currentEmail ) {
					alert("수정되지 않았습니다.");
					event.preventDefault();//폼 전송 막기
				} else {
					$("#myProfile-form").trigger("submit");
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
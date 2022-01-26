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
			<div class="account-form">
				<h2>기본 정보</h2>
				<div class="profile-box">
					<img id="preImg" src="${dto.profile }" alt="" />
					<c:choose>
						<c:when test="${empty dto.profile }">
							<form name="profile" action="${pageContext.request.contextPath }/users/private/profile_upload" method="post" 
								enctype="multipart/form-data" id="profileForm">
								<label for="image"></label>
								<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG" style="display:none;"/>
								<input type="hidden" id="profileImg" name = "target_url">
								<div class="profile-buttons" style="padding-top:40px;">
									<button type="submit">업로드</button>
								</div>
							</form>
						</c:when>
						<c:otherwise>
							<form name="profile"  method="post" 
								enctype="multipart/form-data" id="profileForm">
								<label for="image"></label>
								<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG" style="display:none;"/>
								<input type="hidden" name = "target_url">
								<input type="hidden" id="profileImg" value="${dto.profile}" />
								<div class="profile-buttons">
									<button type="submit">업로드</button>
									<a href="javascript:deleteProfile();">삭제</a>
								</div>
							</form>
						</c:otherwise>
					</c:choose>
				</div>
				<form id="myProfile-form"  action="${pageContext.request.contextPath }/users/private/update" method="post" >
					<div class="account-inputBox">
						<div class="account-formGroup">
							<div class="account-label"><label for="id">아이디</label></div>
							<div><input type="text" id="id" class="account-updateform updateId" value="${loginId }" class="form-control" disabled/></div>
						</div>
						<div class="account-formGroup" >
							<div class="account-label"><label for="email">이메일</label><span id="errorMsg">이메일 형식으로 작성해 주세요.</span></div>
							<div><input type="text" id="email" class="account-updateform" name="email" value="${dto.email }" class="form-control"/></div>
						</div>
					</div>
					<div class="account-formGroup">
						<label class="account-label" for="care">관심사 <span>(최대 세가지 선택해주세요)</span></label>
				 		<div class="scroll-box">
				 			<table>
								<colgroup>
									<col style="width:20%">
									<col style="width:27%">
									<col style="width:26%">
									<col style="width:27%">
								</colgroup>
								<tr >
									<td rowspan="10"><h6 id="interest">> 관심사</label></h6></td>
								</tr>
								<tr class="interestChk" >
									<td><label for="novel"><input onclick="CountChecked(this)" type="checkbox" name="care" id="novel" value="100"/> 소설</label></td>
									<td><label for="poetry"><input onclick="CountChecked(this)" type="checkbox" name="care" id="poetry" value="110"/> 시 / 에세이</label></td>
									<td><label for="humanities"><input onclick="CountChecked(this)" type="checkbox" name="care" id="humanities" value="120"/> 인문</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="home"><input onclick="CountChecked(this)" type="checkbox" name="care" id="home" value="130"/> 가정/생활/요리</label></td>
									<td><label for="health"><input onclick="CountChecked(this)" type="checkbox" name="care" id="health" value="140"/> 건강</label></td>
									<td><label for="hobby"><input onclick="CountChecked(this)" type="checkbox" name="care" id="hobby" value="150"/> 취미/레저</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="economy"><input onclick="CountChecked(this)" type="checkbox" name="care" id="economy" value="160"/> 경제/경영</label></td>
									<td><label for="self"><input onclick="CountChecked(this)" type="checkbox" name="care" id="self" value="170"/> 자기계발</label></td>
									<td><label for="society"><input onclick="CountChecked(this)" type="checkbox" name="care" id="society" value="180"/> 사회</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="history"><input onclick="CountChecked(this)" type="checkbox" name="care" id="history" value="190"/> 역사/문화</label></td>
									<td><label for="religion"><input onclick="CountChecked(this)" type="checkbox" name="care" id="religion" value="200"/> 종교</label></td>
									<td><label for="art"><input onclick="CountChecked(this)" type="checkbox" name="care" id="art" value="210"/> 예술/대중문화</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="reference"><input onclick="CountChecked(this)" type="checkbox" name="care" id="reference" value="220"/> 학습/참고서</label></td>
									<td><label for="language"><input onclick="CountChecked(this)" type="checkbox" name="care" id="language" value="230"/> 국어/외국어</label></td>
									<td><label for="dictionary"><input onclick="CountChecked(this)" type="checkbox" name="care" id="dictionary" value="240"/> 사전</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="science"><input onclick="CountChecked(this)" type="checkbox" name="care" id="science" value="250"/> 과학/공학</label></td>
									<td><label for="employment"><input onclick="CountChecked(this)" type="checkbox" name="care" id="employment" value="260"/> 취업/수험서</label></td>
									<td><label for="trip"><input onclick="CountChecked(this)" type="checkbox" name="care" id="trip" value="270"/> 여행/지도</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="IT"><input onclick="CountChecked(this)" type="checkbox" name="care" id="IT" value="280"/> 컴퓨터/IT</label></td>
									<td><label for="magazine"><input onclick="CountChecked(this)" type="checkbox" name="care" id="magazine" value="290"/> 잡지</label></td>
									<td><label for="teenager"><input onclick="CountChecked(this)" type="checkbox" name="care" id="teenager" value="300"/> 청소년</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="infant"><input onclick="CountChecked(this)" type="checkbox" name="care" id="infant" value="310"/> 유아</label></td>
									<td><label for="child"><input onclick="CountChecked(this)" type="checkbox" name="care" id="child" value="320"/> 어린이</label></td>
									<td><label for="comic"><input onclick="CountChecked(this)" type="checkbox" name="care" id="comic" value="330" /> 만화</label></td>
								</tr>
								<tr class="interestChk">
									<td><label for="overseas"><input onclick="CountChecked(this)" type="checkbox" name="care" id="overseas" value="340"/>해외도서</label></td>
									<td></td>
									<td></td>
								</tr>
							</table>
						</div>	
					</div>
					<div>
						<button type="javascript:" id="updateBtn" class="account-save">저장</button>
						<a href="javascript:deleteConfirm();" class="account-delete" >회원탈퇴</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	//작성글, 작성 댓글, 북카트, 나의 정보 호출
	/* $.ajax({
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
	var myCare = "${care}"; 
	var careList = myCare.split(',');
	for (var i = 0; i < careList.length; i++) {
		$('input:checkbox[value=' + careList[i] + ']').attr("checked", true);
		
	} */

	//프로필 미리보기

	var profileImg = $('#profileImg').val();
	

	if( profileImg != null ){
		$('#preImg').attr('src', profileImg );
	}else{
		$('#preImg').attr('src', 'https://ssl.pstatic.net/static/common/myarea/myInfo.gif');
	}
	
	/*
	var request = new XMLHttpRequest();
	request.open("POST", "${pageContext.request.contextPath }", true);
	var data = new FormData();
	data.append("image", dataURL, profileImg);
	request.send(data);
	*/
	
	$('#preImg').click(function (e) {
	    document.profile.target_url.value = document.getElementById( 'preImg' ).src;
	    e.preventDefault();
	    $('#image').click();//파일 첨부버튼 
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
		//$("#profileForm").submit();
	});
	//by 준영, 리뷰검색폼 빈값 제출 막기
	$('#email').keyup(function(){
		//[이메일을 검증할 정규 표현식](정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용!)
		//@가 포함되어 있는지 검증
		var reg_email = /@/;
		//이메일을 입력했을 때 실행할 함수 등록
		$("#email").on("input", function(){ 
			var inputEmail = $("#email").val();
			//만일 이메일이 정규표현식에 매칭되지 않는다면
			
			if(!reg_email.test(inputEmail)) { 
				$("#email").addClass("error");
				$("#errorMsg").css('display','block');
				document.querySelector('#updateBtn').setAttribute('type','button');
				$('#updateBtn').on('click',function(e){
					e.preventDefault();
				})
			} else {/* 
				$("#email").removeClass("valid"); */
				$("#errorMsg").css('display','none');
				document.querySelector('#updateBtn').setAttribute('type','submit');
			}
		});
	})
	
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
	/*
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
	*/
	
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
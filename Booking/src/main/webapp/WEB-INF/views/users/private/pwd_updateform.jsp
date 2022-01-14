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
<script src="http://code.jquery.com/jquery-1.3.2.min.js" ></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js" ></script>
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
			<div class="pwd-updateform">
				<h2>비밀번호 변경</h2>
				<form  id="myPwd-form">
					<div class="myForm-header">
						<p class="contxt">안전한 비밀번호로 내정보를 보호하세요</p>
						<p class="contxt contxt_list"><em>다른 아이디/사이트에서 사용한 적 없는 비밀번호</em></p>
						<p class="contxt contxt_list"><em>이전에 사용한 적 없는 비밀번호</em>가 안전합니다.</p>			
					</div>	
					<div class="pwdform-group" >
						<label for="pwd">현재 비밀번호</label>
						<input class="pwdform-control" type="password" name="pwd" id="currentPwd"/>
					</div>
					<div class="error-msg"></div>
					<div class="pwdform-group" >
						<label for="newPwd">새 비밀번호</label>
						<input class="pwdform-control" type="password" name="newPwd" id="newPwd"/>
					</div>
					<div class="error-msg"></div>
					<div class="pwdform-group">
						<label for="newPwd2">새 비밀번호 확인</label>
						<input class="pwdform-control" type="password" name="pwd2" id="pwd2"/>
					</div>
					<div class="error-msg"></div>
					<button type="submit" class="pwd-updateformBtn" >저장</button>
					<button type="reset" class="pwd-resetBtn" >초기화</button>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	
	//by 준영, Validate.js 라이브러리 
	$(document).ready(function () { 
	    // validate signup form on keyup and submit
	    $('#myPwd-form').validate({
	    	errorPlacement:function(error,element){ 
	            $(element).parent().after(error)
	    	},
	        rules: {
	            pwd:{
	            	required:true, 
	            	minlength:5, 
	            	maxlength:10, 
		            remote : {            	
					    url : '${pageContext.request.contextPath }/v1/users/signup',
					    type : "get",
					    data : {
					    	pwd : function() {
					    		return $("#currentPwd").val();
					    	}
					    }
		            }
	            },
	            newPwd: {required:true, minlength:5, maxlength:10},
	            pwd2: {required:true, equalTo:'#newPwd'},               
	        },
	        messages: {
	            pwd: {
	                 required:"필수 입력 항목입니다.",
	                 minlength: "영문 소문자 5~10글자 이내로 입력해 주세요.",
	                 maxlength: "비밀번호를 최대 10자 이내로 입력해 주세요.",
	                 remote : "현재 비밀번호와 다른 비밀번호를 입력해 주세요."
                	},
	            newPwd:{
	            	 required: "필수 입력 항목입니다.",
	            	 minlength: "영문 소문자 5~10글자 이내로 입력해 주세요.",
	                 maxlength: "비밀번호를 최대 10자 이내로 입력해 주세요."
	            	},
	          	  
	            pwd2: {
	                required: "필수 입력 항목입니다.",
	                equalTo: "비밀번호를 다시 확인하세요" 
	                }
	        }
	//여기부터
	,
	        submitHandler: function (frm){
	        	$.ajax({
	    			url:"${pageContext.request.contextPath}/v1/users/pwd/${id}",
	    			method:"GET",
	    			dataType : "text",
	    			success:function(data) {
	    				if(currentPwd == data){
	    					alert("현재 비밀번호와 다르게 변경해 주세요.");
	    				}
	    			},
	    			error : function(data) {
	    				console.log("오류");
	    			}
	    		});
	        },
	        success: function(e){
	            //
	        }
	//여기까지는 생략 가능           
	    });
	    
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
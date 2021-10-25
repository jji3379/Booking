<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>

</head>
<body class="text-center">
<form class="form-signin" action="login.do" method="post">
	<%-- 원래 가려던 목적지 정보를 url 이라는 파라미터 명으로 전송될수 있도록 한다. --%>
	<input type="hidden" name="url" value="${url }"/>
	
  	<h1 class="h3 mb-3 font-weight-normal">BOOKING </h1>
  	
  	<label for="id" class="sr-only">아이디</label>
  	<input style="margin-bottom:10px" type="text" id="id" name="id" class="form-control" 
  		placeholder="아이디 입력..." value="${savedId }" required autofocus>
  		
  	<label for="pwd" class="sr-only">비밀번호</label>
  	<input type="password" id="pwd" name="pwd" class="form-control" 
  		placeholder="비밀번호 입력..." value="${savedPwd }" required>
  		
	<button class="btn btn-lg btn-info btn-block" type="submit">로 그 인 </button>
	<div class="checkbox mb-3">
	    <label style="float:left">
	      <input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
	    </label>
		<a style="color:black; float:right" href="signup_form.do">회원가입</a>
	</div>
	<p class="mt-5 mb-3 text-muted">&copy; 2017-2021</p>
</form>
</body>
</html>
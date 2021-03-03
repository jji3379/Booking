<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* example 로그인 폼을 만들기 위한 css */
	html,
	body {
	  height: 100%;
	}
	
	body {
	  display: -ms-flexbox;
	  display: flex;
	  -ms-flex-align: center;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
	}
	
	.form-signin {
	  width: 100%;
	  max-width: 330px;
	  padding: 15px;
	  margin: auto;
	}
	.form-signin .checkbox {
	  font-weight: 400;
	}
	.form-signin .form-control {
	  position: relative;
	  box-sizing: border-box;
	  height: auto;
	  padding: 10px;
	  font-size: 16px;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="email"] {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
		
</style>
</head>
<body class="text-center">
<form class="form-signin" action="login.do" method="post">
	<%-- 원래 가려던 목적지 정보를 url 이라는 파라미터 명으로 전송될수 있도록 한다. --%>
	<input type="hidden" name="url" value="${url }"/>
	
  	<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  	
  	<label for="id" class="sr-only">아이디</label>
  	<input type="text" id="id" name="id" class="form-control" 
  		placeholder="아이디 입력..." value="${savedId }" required autofocus>
  		
  	<label for="pwd" class="sr-only">비밀번호</label>
  	<input type="password" id="pwd" name="pwd" class="form-control" 
  		placeholder="비밀번호 입력..." value="${savedPwd }" required>
  		
	<div class="checkbox mb-3">
	    <label>
	      <input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
	    </label>
	</div>
	<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	<p class="mt-5 mb-3 text-muted">&copy; 2017-2020</p>
</form>
</body>
</html>

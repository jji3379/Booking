<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/login.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>알림</h1>
	<c:choose>
		<c:when test="${isValid }">
			<p>
				<strong>${sessionScope.id }</strong> 님 로그인 되었습니다.
				<a id="url"href="${url }">${url }</a>
			</p>
		</c:when>
		<c:otherwise>
			<p>
				<strong>아이디</strong>혹은 <strong>비밀번호</strong>를 다시 확인 해주세요
				<a href="login_form.do?url=${encodedUrl }">다시 시도</a>
			</p>
		</c:otherwise>
	</c:choose>
</div>
	<script>
		var url=$("#url").text();	
	
		alert("${id}님 반갑습니다!");
		location.href=url;
	</script>
</body>
</html>

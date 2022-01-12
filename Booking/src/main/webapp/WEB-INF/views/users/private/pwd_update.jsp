<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${isSuccess }">
			<script>
				alert("수정 했습니다.");
				location.href="${pageContext.request.contextPath }";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("이전 비밀번호가 일치 하지 않습니다.");
				location.href="${pageContext.request.contextPath }/users/private/pwd_updateform.do";
			</script>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>
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
<c:if test="${isSuccess }">
	<script>
		alert("비밀번호가 변경되었습니다. 다시 로그인 해주세요.");
		location.href="${pageContext.request.contextPath }/";
	</script>
</c:if>
</body>
</html>
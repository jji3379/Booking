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
		alert("수정 했습니다.");
		location.href="${pageContext.request.contextPath }";
	</script>
</c:if>
</body>
</html>
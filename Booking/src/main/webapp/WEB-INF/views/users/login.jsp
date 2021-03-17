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
	<input id="url" type="hidden" value="${url}"/>
</body>
<script>
		var url=$("#url").val();	
	
		alert("${id}님 반갑습니다!");
		location.href=url;
	</script>
</html>


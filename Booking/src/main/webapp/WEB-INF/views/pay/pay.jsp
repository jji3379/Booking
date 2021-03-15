<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<form id="idForm" action="paid.do" method="post">
	    <input name="id" type="hidden" value="${id}" />
	    <button type="submit"></button>
	</form>
<script>
$(document).ready(function(){
	$("#idForm").submit();
});
</script>
</body>
</html>
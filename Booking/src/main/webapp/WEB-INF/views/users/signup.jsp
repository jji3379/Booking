<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert('${id} 님 회원가입 성공하셨습니다.');
		location.href='${pageContext.request.contextPath }/login_form.do';
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>/review/private/delete.jsp</title>
</head>
<body>
	<script>
		alert("리뷰를 삭제했습니다.");
		location.href="${pageContext.request.contextPath}/review/detail.do";
	</script>
</body>
</html>
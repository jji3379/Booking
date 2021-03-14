<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/private/update.jsp</title>
</head>
<body>
	<script>
		alert("글을 수정했습니다.");
		location.href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${dto.num}";
	</script>
</body>
</html>
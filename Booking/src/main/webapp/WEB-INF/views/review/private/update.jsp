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
		alert("${dto.writer} 님 리뷰를 수정했습니다.");
		location.href="${pageContext.request.contextPath }/review/detail.do?num=${dto.num}";
	</script>
</body>
</html>
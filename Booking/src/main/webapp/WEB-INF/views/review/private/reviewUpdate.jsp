<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
</head>
<body>
	<script>
		alert("글을 수정했습니다.");
		location.href="${pageContext.request.contextPath }/review/reviewDetail.do?num=${dto.id}";
	</script>
</body>
</html>
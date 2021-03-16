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
<script>
	//by_준영 로그인된 id 파라미터를 자동 전송해줘서 페이지 거치지 않게 하는기능_210311
	$(document).ready(function(){
		location.href="middle2.do";
	});
</script>
</body>
</html>
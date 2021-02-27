<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="include/resource.jsp"></jsp:include>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div style="margin-top:100px" class="container">
	<div class="row"><!-- by 준익, 왼쪽 카테고리 검색과 메인페이지를 나누기 위한 row_2021.02.28 -->
		<jsp:include page="include/sideindex.jsp"></jsp:include><!-- by 준익, 왼쪽에 카테고리 검색기능_2021.02.28 -->
		<div style="border:1px solid #f1f1f1" class="col-10"><!-- by 준익, 메인 페이지 div_2021.02.28 -->
			
		</div>
	</div>
</div>
</body>
</html>
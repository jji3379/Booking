<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Cart db 삭제 전 Order db insert</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<table class="table">
	    <thead class="thead-light">
	    <tr>
	      <th>주문번호</th>
	      <th>구매자</th>
	      <th>이미지</th>
	      <th>제목</th>
	      <th>정가</th>
	      <th>할인가</th>
	      <th>갯수</th>
	      <th>주문일</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="o" items="${list}" varStatus="status">
	        <tr>
		        <td>
		        	<form id="form${status.count }" action="pay.do" method="post">
			        	<input type="text" name="buyer" value="${o.id }" />
			        	<input type="text" name="image" value="${o.image }" />
			        	<input type="text" name="image" value="${o.title }" />
			        	<input type="text" name="image" value="${o.price }" />
			        	<input type="text" name="image" value="${o.d_price }" />
			        	<input type="text" name="image" value="${o.count }" />
			        	<button type="button${status.count}"></button>
		        	</form>
		        </td>
	        </tr>
	    </c:forEach>
	  </tbody>
	</table>
</body>
<script>
</script>
</html>
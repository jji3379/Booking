<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
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
		/* $('.minus').click(function(){ 
		//감소버튼에 인접한 input type="number" 선택
			var  $input = $(this).parent().find("input[type=number]");
			//현재 숫자값
			var currentNumber = parseInt( $input.val() );
			if(currentNumber <= 0){
				currentNumber;
			}else{
				currentNumber--;//1 감소시키기
				//감소 시킨값 다시 넣어주기
				$input.val( currentNumber );
			}
		}); */

</script>
</html>
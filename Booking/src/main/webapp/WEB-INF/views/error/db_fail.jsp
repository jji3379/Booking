<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body style="background-color:#484848;">
<div class="card" style="width: 18rem; left:0; right:0; margin-left:auto; margin-right:auto;
  top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">
  <div class="card-body">
    <h5 class="card-title">Oops !</h5>
    <h6 class="card-subtitle mb-2 text-muted">${exception.message }</h6>
    <a href="${pageContext.request.contextPath }/users/login_form.do" class="card-link">다시 시도하기</a>
  </div>
  <input id="url" type="hidden" value="${url}"/>
</div>
<script>
	var url=$("#url").val();	
	
	
	location.href=('${pageContext.request.contextPath }/');
</script>

</body>
</html>
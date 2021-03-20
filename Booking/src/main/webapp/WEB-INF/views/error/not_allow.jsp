<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<title>/views/error/not_allow.jsp</title>
</head>
<body style="background-color:#484848;">
<div class="card" style="width: 18rem; left:0; right:0; margin-left:auto; margin-right:auto;
  top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">
  <div class="card-body">
    <h5 class="card-title">Oops !</h5>
    <h6 class="card-subtitle mb-2 text-muted">${exception.message }</h6>
    <a href="${pageContext.request.contextPath }/" class="card-link">허용되지 않는 요청입니다.</a>
  </div>
</div>
</body>
</html>
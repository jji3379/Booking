<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body style="background-color:#484848;">
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="row" style="width:80%; height:650px; 
	margin-top:50px; margin-left:auto; margin-right:auto; background-color:#f5e9dd; width:fit-content;">
	<jsp:include page="../../include/sideusers.jsp"></jsp:include>
	<div>
		<h1 style="margin-left:8px; margin-top:7px;">가입 정보 입니다.</h1>
	<table class="table table-striped" style="width:800px">
		<colgroup >
			<col width="150"/>
			<col />
		</colgroup>
		<tr>
			<th>아이디</th>
			<td>${sessionScope.id }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${dto.email }</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td>${dto.regdate }</td>
		</tr>
		<tr>
			<th>관심사</th>
			<th>${dto.care }</th>
		</tr>
		<tr>
			<th>최근검색어</th>
			<th>${dto.recentSearch }</th>
		</tr>
	</table>
	</div>
	
</div>
<div style="margin-top:200px">
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		}
	}
</script>
</body>
</html>
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
	<div class="row">
		<div style="border:solid; height:600px" class="col-2">
			<ul>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=100&d_cont=1">소설</a>				
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=110&d_cont=1">시/에세이</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=120&d_cont=1">인문</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=130&d_cont=1">가정/생활/요리</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=140&d_cont=1">건강</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=150&d_cont=1">취미/레저</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=160&d_cont=1">경제/경영</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=170&d_cont=1">자기계발</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=180&d_cont=1">사회</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=190&d_cont=1">역사/문화</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=200&d_cont=1">종교</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=210&d_cont=1">예술/대중문화</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=220&d_cont=1">학습/참고서</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=230&d_cont=1">국어/외국어</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=240&d_cont=1">사전</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=250&d_cont=1">과학/공학</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=260&d_cont=1">취업/수험서</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=270&d_cont=1">여행/지도</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=280&d_cont=1">컴퓨터/IT</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=290&d_cont=1">잡지</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=300&d_cont=1">청소년</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=310&d_cont=1">유아</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=320&d_cont=1">어린이</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=330&d_cont=1">만화</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/bookList.do?d_catg=340&d_cont=1">해외도서</a>
				</li>
			</ul>
		</div>
		<div style="border:solid" class="col-10">
			살려줘...
		</div>
	</div>
</div>
</body>
</html>
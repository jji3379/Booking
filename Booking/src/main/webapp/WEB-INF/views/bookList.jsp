<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="include/resource.jsp"></jsp:include>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
  	<div class="container" style="margin-top:100px">
  	</div>
  	<div class="container">
	  	<div class="row">
			<jsp:include page="include/sideindex.jsp"></jsp:include>
			<div style="border:solid" class="col-10">
				
			    <table>
			        <tr>
			            <td colspan="7" width="100%" bgcolor="pink"></td>
			        </tr>
			        <c:forEach items="${bookList}" var ="b">
			            <tr>
			                <td rowspan="2"><img src="${b.image}"></td>
			                <td rowspan="4" width="800">"${b.title}"</td>
			                <td width="200">${b.author}</td>
			            </tr>
			            <tr>
			                <td width="200">${b.price }</td>
			                <td width="200">${b.discount }</td>
			                <td width="200">${b.publisher }</td>
			                <td width="200">${b.pubdate }</td>
			                <td width="200">${b.isbn }</td>
			            </tr>
			            <tr>
			                <td colspan="7">${b.description}</td>
			            </tr>
			            <tr>
			                <td colspan="7" width="100%" bgcolor="pink"></td>
			            </tr>
			        </c:forEach>
			    </table>
			    <!-- 페이징 처리 -->
			    <nav>
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${startPageNum != 1 }">
								<li class="page-item">
									<a class="page-link" href="bookList.do?d_catg=${d_catg}&d_cont=1&start=${startPageNum-1 }">Prev</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">Prev</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
							<c:choose>
								<c:when test="${i eq 1 }">
									<li class="page-item">
										<a class="page-link" href="bookList.do?d_catg=${d_catg}&d_cont=1&start=${i}">${i }</a>
									</li>
								</c:when>
								<c:when test="${i eq pageNum }">
									<li class="page-item active">
										<a class="page-link" href="bookList.do?d_catg=${d_catg}&d_cont=1&start=${(i-1)*display+1}">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="bookList.do?d_catg=${d_catg}&d_cont=1&start=${(i-1)*display+1}">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${endPageNum lt totalPageCount }">
								<li class="page-item">
									<a class="page-link" href="bookList.do?d_catg=100&d_cont=1&start=${5*display+1 }">Next</a><!-- by 준익, PAGE_DISPLAY_COUNT -->
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">Next</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</div>
		</div>
  	</div>
</body>
</html>
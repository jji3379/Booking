<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
 .ellipsis2 {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
.ellipsis{
  	  width:150px;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
}
/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
   .img-wrapper:hover{
      /* 원본 크기의 1.1 배로 확대 시키기*/
      transform: scale(1.02);
      transition: transform 0.3s ease-out;
   }
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
	<div style="margin-bottom:20px">
	   <center><h1>Top 50</h1></center>
	</div>
<div class="row" style="width:80%; margin:auto">
	<jsp:include page="../include/sideindex.jsp"></jsp:include>
	<div class="col-10">
	   <div class="row row-cols-1 row-cols-md-5">
					<c:forEach var="b" items="${bestSeller}" varStatus="c">
						<!-- by 준익, pagingCategoryList 컨트롤러 적용된 list_2021.02.28 -->
						<div class="col mb-4">
							${c.count }
							<div style="border: 3px solid #0f4c81;" class="card h-100">
								<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${b.isbn}">
									<img src="${b.image }" class="card-img-top img-wrapper" style="height: 200px; border-bottom: 1px solid #0f4c81;">
								</a>
								<div style="background-color:#f5e9dd" class="card-body">
									<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${b.isbn}">
										<h5 style="margin-bottom: 30px; color:#484848; text-align:center" class="card-title ellipsis2">${b.title }</h5>
									</a>
									<div style="position: absolute; bottom: 10px;" class="card-text ellipsis">${b.author }</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>	   
	</div><!-- div col-10End -->
</div>
<script>
   
</script>
</body>
</html>


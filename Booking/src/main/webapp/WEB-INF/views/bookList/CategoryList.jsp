<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
  	<div class="container" style="margin-top:100px">
  	</div>
  	<div class="container">
	  	<div class="row">
			<jsp:include page="../include/sideindex.jsp"></jsp:include>
			<div class="col-10">
			    <table>
			        <c:forEach items="${categoryList}" var ="b"><!-- by 준익, pagingCategoryList 컨트롤러 적용된 list_2021.02.28 -->
			        	<tr>
							<td colspan="7" bgcolor="#f1f1f1"></td>
			        	</tr>
			            <tr>
							<td width="20%" rowspan="7"><img style="width:75%; margin:20px 20px" src="${b.image}"/></td>			            
			            </tr>
			            <tr>
				            <td>
					            <span style="font-weight:bold">
					            	${b.title}
					            </span> 
				            </td>
				            <td style="text-align:center; font-weight:bold">
				            	${b.price} 원 
				            </td>
			            </tr>
			            <tr>
			            	<td>
			            		${b.author } 지음 | ${b.publisher } | ${b.pubdate }
			            	</td>
			             	<td style="text-align:center; color:red ">
				             		할인가 ${b.discount }
			             	</td>
			            </tr>
			            <tr>
			            </tr>
			            <tr>
			            	<td style="background:#f1f1f1;" rowspan="3"width="60%">
								<div style="PAGE_ROW_COUNT:inline-block; margin:20px 20px">
			            			${b.description}
			            			<a href="${b.link}">더보기</a>
								</div>
			            	</td>
			            	<td style="text-align:center" width="20%">
			            		<button style="width:70%" class="btn btn-info">바로구매</button>
			            	</td>
			            </tr>
			            <tr>
			            	<td style="text-align:center">
			            		<button style="width:70%" class="btn btn-outline-dark">장바구니</button>
			            	</td>
			            </tr>
			            <tr>
			            	<td style="text-align:center">
								<button style="width:70%" class="btn btn-outline-dark">보관함담기</button>
			            	</td>
			            </tr>
			            <tr>
			            	<td></td>
			            </tr>
			            <tr>
			                <td colspan="7" bgcolor="#f1f1f1"></td>
			            </tr>
			        </c:forEach>
			    </table>
			    <!-- by 준익, 페이징 처리_2021.02.26 -->
			    <nav>
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${startPageNum != 1 }"> <!-- by 준익, 시작페이지가 1이 아닌경우 pageNum 과 start 값 로직_2021.02.28 -->
								<li class="page-item">
									<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&pageNum=${startPageNum-1 }&start=${(startPageNum-2)*PAGE_ROW_COUNT+1}">Prev</a>
								</li>
							</c:when>
							<c:otherwise> <!-- by 준익, 시작페이지가 1인 경우 Prev 비활성화_2021.02.28 -->
								<li class="page-item disabled">
									<a class="page-link" href="javascript:">Prev</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }"> <!-- by 준익, 페이징 시작부터 끝까지 만들기_2021.02.28 -->
							<c:choose>
								<c:when test="${i eq pageNum }"> <!-- by 준익, 순서가 pageNum 과 같을 때 -->
									<li class="page-item active">  <!-- by 준익, active 활성화_2021.02.28 -->
										<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&pageNum=${i}&start=${(i-1)*PAGE_ROW_COUNT+1}">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${endPageNum lt totalPageCount }"> <!-- by 준익, 현재 페이지 끝 값이 전체 페이지끝 보다 작을   --> 
								<li class="page-item">
									<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&pageNum=${endPageNum+1}&start=${(endPageNum)*PAGE_ROW_COUNT+1 }">Next</a><!-- by 준익, 다음페이지 숫자가 나오게 하는 로직_2021.02.28 -->
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"> <!-- by 준익, 전체페이지 끝일 때 Next 비활성화 -->
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
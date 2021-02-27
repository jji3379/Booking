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
			        <c:forEach items="${categoryList}" var ="b">
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
			             		</span>
			             	</td>
			            </tr>
			            <tr>
			            </tr>
			            <tr>
			            	<td style="background:#f1f1f1;" rowspan="3"width="60%">
								<div style="display:inline-block; margin:20px 20px">
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
			    <!-- 페이징 처리 -->
			    <nav>
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${startPageNum != 1 }">
								<li class="page-item">
									<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&d_isbn=9&pageNum=${startPageNum-1 }&start=${(startPageNum-2)*display+1}">Prev</a>
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
								<c:when test="${i eq pageNum }">
									<li class="page-item active">
										<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&d_isbn=9&pageNum=${i}&start=${(i-1)*display+1}">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&d_isbn=9&pageNum=${i}&start=${(i-1)*display+1}">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${endPageNum lt totalPageCount }">
								<li class="page-item">
									<a class="page-link" href="CategoryList.do?d_catg=${d_catg}&d_isbn=9&pageNum=${endPageNum+1}&start=${(endPageNum)*display+1 }">Next</a><!-- by 준익, PAGE_DISPLAY_COUNT -->
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
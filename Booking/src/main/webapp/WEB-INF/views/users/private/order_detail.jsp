<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="row">
    <jsp:include page="../../include/sideusers.jsp"></jsp:include>
    <div>
   <h1 >내 주문 내역</h1>
   <table class="table table-striped">
      <thead class="thead-dark">
         <tr>
            <th>이미지</th>
             <th>책 제목</th>
             <th>개수</th>
             <th>주문 날짜</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach var="o" items="${list}">
           <tr class="orderRow">
             <td>
                <a href="../../detail/bookDetail.do?d_isbn=${o.isbn }">
                   <img src="${o.image}"/>
                </a>
             </td>
             <td>${o.title }</td>
             <td>${o.count }</td>
             <td>${o.o_date }</td>
           </tr>
       </c:forEach>
      </tbody>
   </table>
   <a href="my_order.do" class="btn btn-outline-primary" >뒤로가기</a>
   </div>
</div>
</body>
<script>
//회원탈퇴묻기
function deleteConfirm(){
		let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		} else {
			location.reload();
		}
}
</script>
</html>
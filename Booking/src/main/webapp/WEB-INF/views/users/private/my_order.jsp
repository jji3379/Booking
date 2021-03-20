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
<body style="background-color:#484848;">
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="row" style="width:80%; 
   margin-top:50px; margin-left:auto; margin-right:auto; background-color:#f5e9dd; width:fit-content;">
    <jsp:include page="../../include/sideusers.jsp"></jsp:include>
    <div style="margin-left:8px; margin-top:7px; width:1027px">
   <h1 style="margin-left:8px; margin-top:7px;">내 주문 내역</h1>
   <table class="table table-striped" style="width:1020px">
      <thead class="thead-dark">
         <tr>
            <th>주문 번호</th>
             <th>주문 금액</th><!-- 할인가로 -->
             <th>주문 일자</th>
             <th>주문 갯수</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach var="os" items="${oslist}">
           <tr class="orderRow">
             <td><a href="order_detail.do?o_id=${os.o_id }">${os.o_id }</a></td>
             <td>${os.totalPayment }</td>
             <td>${os.o_date }</td>
             <td>${os.totalNum }</td>
           </tr>
       </c:forEach>
      </tbody>
   </table>
   <nav>
      <ul class="pagination justify-content-center">
         <c:choose>
            <c:when test="${startPageNum != 1 }">
               <li class="page-item">
                  <a class="page-link" href="my_order.do?pageNum=${startPageNum-1 }">Prev</a>
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
                     <a class="page-link" href="my_order.do?pageNum=${i }">${i }</a>
                  </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a class="page-link" href="my_order.do?pageNum=${i }">${i }</a>
                  </li>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         <c:choose>
            <c:when test="${endPageNum lt totalPageCount }">
               <li class="page-item">
                  <a class="page-link" href="my_order.do?pageNum=${endPageNum+1 }">Next</a>
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
</body>
</html>
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
            <th>이미지</th>
             <th>책 제목</th>
             <th>갯수</th>
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
   <a href="my_order.do" class="btn btn-outline-primary" style="margin-left:10px;">뒤로가기</a>
   </div>
   
</div>
</body>
</html>
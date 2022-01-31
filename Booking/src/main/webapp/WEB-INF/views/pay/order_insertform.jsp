<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<style>
	
</style>
</head>
<body>
   <table class="table">
       <thead class="thead-light">
       <tr>
       	 <th>장바구니번호</th>
         <th>주문번호</th>
         <th>구매자</th>
         <th>이미지</th>
         <th>제목</th>
         <th>정가</th>
         <th>할인가</th>
         <th>갯수</th>
       </tr>
     </thead>
     <tbody>
          <form id="form" action="pay.do" method="post">
           <c:forEach var="o" items="${list}" varStatus="status">
           	<tr>
	            <td id="c_id${status.count }" hidden>${o.id }</td><!-- 장바구니번호 -->
	            <td id="o_id${status.count }"></td>
	            <td id="buyer${status.count }">${o.userId.loginId }</td>
	            <td id="image${status.count }">${o.image }</td>
	            <td id="title${status.count }">${o.title }</td>
	            <td id="price${status.count }">${o.price }</td>
	            <td id="d_price${status.count }">${o.d_price }</td>
	            <td id="count${status.count }">${o.count }</td>    
	            <td id="status" hidden>${fn:length(list)}</td>
	            <td id="isbn${status.count }" hidden>${o.isbn }</td>
	            <td id="publisher${status.count }" hidden>${o.publisher }</td>
	            <td id="author${status.count }" hidden>${o.author }</td>
          </tr>
         </c:forEach>
         </form>
     </tbody>
   </table>
</body>
<script>
   // by욱현.주문번호(o_id) 만들기_2021317
   //책 단품의 장바구니 고유번호의 합 + 랜덤수 (일단은 난수만으로 테스트)
   //let ran = Math.floor(Math.random()*10000 + 1);// 난수
   
   // by욱현.각 구매책의 정보를 post방식으로 pay.do에 전송_2021317
   let totalnum = $('#status').text(); // 총 책의 갯수
   //let o_id = ran; //주문번호
   $(window).ready(function(){ //페이지 로딩완료시 함수호출
      for(let i=1; i<=totalnum; i++) { //각 로우별로 값을 추출해 전송한다.
         //$("#o_id"+[i]).text(o_id); //row의 주문번호 표시
         let buyer = $('#buyer'+[i]).text();//구매자
         let image = $('#image'+[i]).text();//이미지
         let title = $('#title'+[i]).text();//제목
         let price = $('#price'+[i]).text(); // 정가
         let d_price = $('#d_price'+[i]).text();//할인가
         let count = $('#count'+[i]).text();//책별 갯수
         let isbn = $('#isbn'+[i]).text(); //책별 isbn
         let publisher = $('#publisher'+[i]).text(); //책별 isbn
         let author = $('#author'+[i]).text(); //책별 author
         (function(){ //for문을 돌때마다 호출되는 익명함수
        	var data = {buyer_id:${sessionScope.id}, image:image, title:title, price:price,
                d_price:d_price, count:count, isbn:isbn , publisher:publisher, author:author }; 
         console.log(data);
            $.ajax({
               url:"${pageContext.request.contextPath }/pay/orderInsert",
	   		   method:"post",
			   dataType : "json",
			   contentType : "application/json; charset=utf-8",
			   data : JSON.stringify(data),
               success : function(){
                  if(i==totalnum) { //장바구니에 담긴 책의 종류를 모두 post전송을 했다면 paid.do로 이동한다.
                     location.replace = "${pageContext.request.contextPath }/pay/paid.do";
                  }
               }
               
            })
         })();
         
      }
   });
</script>
</html>
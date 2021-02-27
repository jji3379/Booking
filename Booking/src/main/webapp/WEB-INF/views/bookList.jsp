<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
   /* card 이미지 부모요소의 높이 지정 */
   .img-wrapper{
      height: 280px;
      /* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
      transition: transform 0.3s ease-out;
   }
   /* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
   .img-wrapper:hover{
      /* 원본 크기의 1.1 배로 확대 시키기*/
      transform: scale(1.05);
   }
   
   	.card .card-text{
      /* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
   }
   
   #card{
   		position: relative;
	    min-height: 1px;
	    padding-right: 15px;
	    padding-left: 15px;
   }
   
   /* img  가  가운데 정렬 되도록 */
   .back-drop{
      /* 일단 숨겨 놓는다. */
      display:none;
   
      /* 화면 전체를 투명도가 있는 회색으로 덮기 위한  css*/
      position: fixed;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background-color: #cecece;
      padding-top: 300px;
      z-index: 10000;
      opacity: 0.5;
      text-align: center;
   }
   
   .back-drop img{
      width: 100px;
      /* rotateAnimation 이라는 키프레임을 2초 동한 일정한 비율로  무한 반복하기 */
      animation: rotateAnimation 2s ease-out infinite;
   }
   
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
<div class="container" style=margin-top:60px;>
	<div></div>
   <center><h1>Best Seller</h1></center>
   <nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">Best Seller</li>
		</ul>
	</nav>
   <div class="row" id="bookList">
      <c:forEach var="b" items="${bookList }">
         <div id="card" class="col-12 col-lg-2 col-lg-2">
            <div class="card mb-3">
               <a href="bookDetail.do?d_isbn=${b.isbn }">
                  <div class="img-wrapper">
                     <a href="bookDetail.do?d_isbn=${b.isbn}"><img style height="250"class="card-img-top" src="${b.image }" /></a><!--By 준영 임의 책이미지 클릭시 해당 책 isbn 값으로 검색되는 링크 -->
                  </div>
               </a>
               <div class="card-body">
               	  <p class="card-text"><strong>${b.title }</strong></p>
                  <p class="card-text"><strong>${b.author }</strong></p>
                   <p class="card-text">${b.price } 원</p>
                 
               </div>
            </div>
         </div>      
      </c:forEach>
   </div>
</div>
<script>
   
</script>
</body>
</html>

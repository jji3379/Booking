<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<jsp:include page="include/resource.jsp"></jsp:include>
<title>책과의 즉석만남 Booking</title>
<script src="../resources/js/imgLiquid.js"></script>

<link rel="stylesheet" href="resources/css/style.css"> <!-- by욱현. carousel 적용위한 외부css파일 로드_2021227 -->
<style>
   
   
   /* card 이미지 부모요소의 높이 지정 */
   .img-wrapper{
      height: 260px;
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
      text-align:center;
   }
   
   #card{
       position: relative;
       min-height: 1px;
       padding-right: 15px;
       padding-left: 15px;
       width: 100px;
       
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
   
   /* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 300px;
      height: 300px;
      border: 1px solid #cecece;
      border-radius: 50%;
      align:left;
   }
   
</style>
</head>
<body style="background-color:#white;">
<jsp:include page="include/navbar.jsp"></jsp:include>
<div  style="width:70%; margin:auto">
	<!-- 검색창 Start -->
   <div style="margin-top:30px">
      <nav class="navbar navbar-expand-lg justify-content-center" style="font-weight:bold; height:50px; color:#000000;">
         <form class="d-flex" action="${pageContext.request.contextPath }/bookList/conditionSearch.do" method="get">
              <input class="form-control" type="text" aria-label="Search" style="font-weight:bold; border-width:3px; border-radius:20px; border-color:#135fa1; height:45px; width:500px;"
                 name="keyword" value="${keyword }" />
              <input name="pageNum" value="1" hidden/>
              <input name="start" value="1" hidden/>
              <button type="submit" style="margin-left:20px; font-weight:bold; background-color:#135fa1; border:0; outline:0;">
                 <img src="${pageContext.request.contextPath }/resources/images/magnifier1.png" style="width:50px; margin-left:-10px;"/>
              </button>
          </form>
      </nav>
   </div>
   <!-- 검색창 END -->
   
   <div class="row" style="margin-top:30px;">
   <!-- 부킹  col-9 Start -->
   		<div class="col-9" style="border:3px solid black">
			<div class="booking col justify-content-center" style="width:auto; margin-bottom:10px;"><!-- by욱현.올랜덤 책추천 '부킹'기능_2021225 -->
               <center><h2><strong>나와 매칭되는 책은?</strong></h2></center>
               <div class="row justify-content-center align-items-center">
                  <span class="col-4"style="text-align: right;" >
                     <c:choose>
                     <c:when test="${empty dto.profile }">
                        <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                             <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                        </svg>
                     </c:when>
                     <c:otherwise>
                        <img id="profileImage" 
                           src="${pageContext.request.contextPath }${dto.profile}" />
                     </c:otherwise>
                  </c:choose>
               </span>
               <span class="col-4" style="text-align: center;"><!--by욱현. 부킹버튼(랜덤추천기능)_2021226 -->
                  <a id="bookingBtn" href="javascript:"><img style="margin-left:0px; width:300px; height:300px;" src="resources/images/bookingbutton.png"/></a> 
                 </span>
                 <span class="col-4" style="text-align: left; margin-left:0px;">   
                    <a href="bookDetail.do?d_isbn=" id="bookA"><img style="height:300px; width:300px;" class="card-img-top" id="bookimage" src="resources/images/BookingBox.png"/></a>
                 </span>
               </div>
            </div><!-- 부킹 ENd -->
   		</div>
   		<!-- 베스트 셀러 col-3 Start -->
   		<div class="col-3" style="border:3px solid black">
   		
   		</div>
   		<!-- 베스트 셀러 END -->
   </div>
   <!-- 캐러셀, 베스트 셀러 div row Start -->
   <div class="row" style="margin-top:30px;">
      <div class="col justify-content-center"><!-- by 준익, 메인 페이지 div_2021.02.28 -->
         <c:choose>
            <c:when test="${not empty sessionScope.id }">
                <center><h2><strong>${sessionScope.id }</strong>님을 위한 추천도서</h2></center>
            </c:when>
            <c:otherwise>
                <center ><h2><strong>추천도서</strong></h2></center>
            </c:otherwise>
         </c:choose>
         <!-- 캐러셀 Start -->
          <div class="container2"> <!-- by욱현. 추천도서에 carousel css 적용_2021227 -->
              <div class="button" onclick="shiftLeft()"><img src="https://image.ibb.co/mRsEb7/left_arrow.png" alt=""></div>
              <div class="cards-wrapper" style="width:50%">
                  <ul class="cards__container">
                       <li class="box">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[0].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[0].image }" />
		                          	</div>
		                      	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                          	<p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[0].title }</strong></p>
		                          	<small class="card-text" style="font-size:12px">${list[0].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[1].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[1].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[1].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[1].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box">
		                   <div class="card">
		                        <a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[2].isbn}" style="width:190px; height:260px;"id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[2].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[2].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[2].author }</small>
		                       	</div>
		                  	</div>
	                  </li>
	                  <li class="box">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[3].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[3].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[3].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[3].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[4].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[4].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[4].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[4].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box box--hide">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[5].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[5].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[5].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[5].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box box--hide">
		                   <div class="card">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[6].isbn}" id="isbn">
			                        <div class="img-wrapper">
			                            <img style="height:250px; width:12rem;"class="card-img-top" src="${list[6].image }" />
			                        </div>
		                      	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[6].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[6].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box box--hide">
		                   <div class="card mb-3">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[7].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[7].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[7].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[7].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box box--hide">
		                   <div class="card mb-3">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[8].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[8].image }" />
		                          	</div>
		                      	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[8].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[8].author }</small>
		                       	</div>
		                   </div>
	                  </li>
	                  <li class="box box--hide">
		                   <div class="card mb-3">
		                      	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[9].isbn}" id="isbn">
		                          	<div class="img-wrapper">
		                             	<img style="height:250px; width:12rem;"class="card-img-top" src="${list[9].image }" />
		                          	</div>
		                       	</a>
		                       	<div class="card-body" style="height:50px; padding:0px; padding-left:3px; text-align: center;">
		                            <p class="card-text" style="margin-bottom:0px; font-size:15px"><strong>${list[9].title }</strong></p>
		                           	<small class="card-text" style="font-size:12px">${list[9].author }</small>
		                       	</div>
		                   </div>
	                  </li>
                  </ul>
              </div>
              <div class="button" onclick="shiftRight()"><img src="https://image.ibb.co/dfPSw7/right_arrow.png" alt=""></div>
          </div>
      </div>
   </div><!-- row END -->
</div><!-- container END -->
<jsp:include page="include/footer.jsp"></jsp:include>
<script>
   //by욱현. booking서비스(랜덤 책 추천 기능) ajax요청처리_2021226
   $("#bookingBtn").on("click", function(){
      
      $.ajax({
         url:"${pageContext.request.contextPath }/booking.do",
         method:"POST",
         success:function(data){
            console.log(data);
            let map = data; //해쉬맵을 배열로 받기
            let image = map['image']; //배열에서 키값으로 값얻기
            let isbn = map['isbn'];
            //요소의 속성 변경
            $('#bookimage').attr("src", image);
            $('#bookA').attr("href", "detail/bookDetail.do?d_isbn="+isbn);
            
         }   
      })
      
   })
   
   // by욱현.추천도서에 carousel 적용위한 외부 자바스크립트 로드_2021227
   
   function shiftLeft() {
    const boxes = document.querySelectorAll(".box");
    const tmpNode = boxes[0];
    boxes[0].className = "box move-out-from-left";
    setTimeout(function() {
        if (boxes.length > 5) {
            tmpNode.classList.add("box--hide");
            boxes[5].className = "box move-to-position5-from-left";
        }
        boxes[1].className = "box move-to-position1-from-left";
        boxes[2].className = "box move-to-position2-from-left";
        boxes[3].className = "box move-to-position3-from-left";
        boxes[4].className = "box move-to-position4-from-left";
        boxes[0].remove();
        document.querySelector(".cards__container").appendChild(tmpNode);
    }, 500);
   }
   function shiftRight() {
       const boxes = document.querySelectorAll(".box");
       boxes[4].className = "box move-out-from-right";
       setTimeout(function() {
           const noOfCards = boxes.length;
           if (noOfCards > 4) {
               boxes[4].className = "box box--hide";
           }
   
           const tmpNode = boxes[noOfCards - 1];
           tmpNode.classList.remove("box--hide");
           boxes[noOfCards - 1].remove();
           let parentObj = document.querySelector(".cards__container");
           parentObj.insertBefore(tmpNode, parentObj.firstChild);
           tmpNode.className = "box move-to-position1-from-right";
           boxes[0].className = "box move-to-position2-from-right";
           boxes[1].className = "box move-to-position3-from-right";
           boxes[2].className = "box move-to-position4-from-right";
           boxes[3].className = "box move-to-position5-from-right";
       }, 500);
   
   }
</script>
</body>
</html>
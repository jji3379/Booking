<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="include/resource.jsp"></jsp:include>
<title>책과의 즉석만남 Booking</title>
	<link rel="stylesheet" href="resources/css/style.css">
    <style>
    
    body {
    	min-width: 992px !important;
    }	
    .container {
    	min-width: 992px !important;
    	border-left: 2px solid #989c9b;
    	border-right: 2px solid #989c9b;
    	background-color: #f0f8ff;
    	padding: 0px;
    }
    
    .container,
	.container-fluid,
	.container-sm,
	.container-md,
	.container-lg,
	.container-xl {
		width: 100%;
		margin-right: auto;
		margin-left: auto;
	}
	
	@media (min-width: 576px) {
		.container, .container-sm {
			max-width: 540px;
		}
	}
	
	@media (min-width: 768px) {
		.container, .container-sm, .container-md {		  
			max-width: 720px;
		}
	}
	
	@media (min-width: 992px) {
		.container, .container-sm, .container-md, .container-lg {
			max-width: 960px;
		}
	}
	
	@media (min-width: 1200px) {
		.container, .container-sm, .container-md, .container-lg, .container-xl {
			max-width: 1140px;
		}
	}
	.C-logo {
		font-family: '777Balsamtint';
		font-size: 35px;
		position: relative;
		top: 130px;
		left: 100px;
		width: 150px;
		
	}
	.top {
		display: flex;
	    justify-content: space-around;
	    align-items: center;
	    background-color: #D3EBFF;
	}
	.bottom {
		
	}
	.recommend {
	
		height: 550px;
		display: block;
		position: relative;
		background: #D3EBFF;
		
	}
	.booking {
		width: 80%;
		height: 450px;
		border: 2px solid #989c9b;
		margin: 75px auto;
	}
	
	.cards-wrapper {
		margin: 0 auto;
	}
	.button, .cards-wrapper {
		display: flex;
	}
	body {
		
	}
	.Lbutton {
		display: inline;
		vertical-align: center;
		margin-right:200px;
	}
	.Lbutton > img {
		
		margin-left: 30px;
		width: 2rem;
		height: 2rem;
		
	}
	.Rbutton {
		display: inline;
		vertical-align: center;
		margin-left:80px;
	}
	.Rbutton > img {
		margin-right: 30px;
		width: 2rem;
		height: 2rem;
	}
	.col-6{
		margin: auto;
	}
	.B-logo {
		font-family: '777Balsamtint';
		font-size: 25px;
		width: 180px;
		position: relative;
		top: -20px;
		left: 120px;
	}
	.row {
		text-align: center;
		vertical-align: middle;
		height: 100%;
	}
	.bookingBtn > img {
		
	}
	
	.bookA > img {
	
	}
	
	.rec-title {
		position: absolute;
		top: 75px;
		left: 150px;
	}

	
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }
      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
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
   .card-img-top{
   		height:260px; 
   		width:12rem;
   }
   
   #card{
       position: relative;
       min-height: 1px;
       padding-right: 15px;
       padding-left: 15px;
       width: 100px;
   }
   
   .card-body{
   		height:50px; 
   		padding:0px; 
   		padding-left:3px; 
   		text-align: center;
   }
   .card-text{
   		margin-bottom:0px; 
   		font-size:15px;
   }
   small{
   		font-size:12px;
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
      width: 200px;
      height: 200px;
      border: 1px solid #cecece;
      border-radius: 50%;
      align:left;
   }
   #bestSeller{
		text-overflow: ellipsis; 
		height:400px;
		width:350px;
   }
	a:link { color: black; text-decoration: none;}
	a:visited { color: black; text-decoration: none;}
	a:hover { color: blue; text-decoration: underline;}
	.border-layout{
	
		border-top:2px solid #989c9b; 
		border-left:2px solid #989c9b; 
		border-bottom:2px solid #989c9b; 
		width:700px
	}
	
	@font-face {
	    font-family: '777Balsamtint';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_nine_@1.1/777Balsamtint.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
</style>
</head>
<body>
	<div class="container"> <!-- container -->
		<c:choose>
		<c:when test="${not empty sessionScope.id }">
		<div class="C-logo"><strong>${sessionScope.id }</strong>님을 위한 추천도서</div>
		</c:when>
		<c:otherwise>
		<div class="C-logo">북킹이 엄선한 이달의 추천</div>
		</c:otherwise>
		</c:choose>
		<div class="top"> <!-- by욱현. 추천도서에 carousel css 적용_2021227 -->
			<div class="Lbutton" onclick="shiftLeft()" >
				<img src="https://image.ibb.co/mRsEb7/left_arrow.png" alt="">
			</div>
			<div class="cards-wrapper">
				<ul class="cards__container">
					<li class="box">
						<div class="card">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[0].isbn}" id="isbn">
								<div class="img-wrapper">
							  		<img class="card-img-top" src="${list[0].image }" />
							   	</div>
							</a>
							<div class="card-body">
								<p class="card-text"><strong>${list[0].title }</strong></p>
								<small class="card-text">${list[0].author }</small>
					      	</div>
				  		</div>
					</li>
					<li class="box">
						<div class="card">
							<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[1].isbn}" id="isbn">
								<div class="img-wrapper">
								  	<img class="card-img-top" src="${list[1].image }" />
								</div>
							</a>
							<div class="card-body">
								<p class="card-text"><strong>${list[1].title }</strong></p>
								<small class="card-text">${list[1].author }</small>
							</div>
						</div>
					</li>
					<li class="box">
						<div class="card">
						     <a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[2].isbn}" style="width:190px; height:260px;"id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[2].image }" />
						  		</div>
							</a>
							<div class="card-body">
								<p class="card-text"><strong>${list[2].title }</strong></p>
								<small class="card-text">${list[2].author }</small>
					      	</div>
					 	</div>
					</li>
					<li class="box box--hide">
						<div class="card">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[3].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[3].image }" />
					  			</div>
							</a>
							<div class="card-body">
								<p class="card-text" ><strong>${list[3].title }</strong></p>
								<small class="card-text" >${list[3].author }</small>
					    	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[4].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[4].image }" />
						  		</div>
							</a>
							<div class="card-body" >
								<p class="card-text" ><strong>${list[4].title }</strong></p>
								<small class="card-text" >${list[4].author }</small>
						   	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[5].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[5].image }" />
					  			</div>
							</a>
							<div class="card-body">
								<p class="card-text"><strong>${list[5].title }</strong></p>
								<small class="card-text" >${list[5].author }</small>
					    	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[6].isbn}" id="isbn">
								<div class="img-wrapper">
						    		<img class="card-img-top" src="${list[6].image }" />
						  		</div>
							</a>
							<div class="card-body" >
								<p class="card-text" ><strong>${list[6].title }</strong></p>
								<small class="card-text" >${list[6].author }</small>
					    	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card mb-3">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[7].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[7].image }" />
						  		</div>
							</a>
							<div class="card-body">
								<p class="card-text" ><strong>${list[7].title }</strong></p>
								<small class="card-text" >${list[7].author }</small>
					    	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card mb-3">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[8].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[8].image }" />
						   		</div>
							</a>
							<div class="card-body" >
								<p class="card-text" ><strong>${list[8].title }</strong></p>
								<small class="card-text" >${list[8].author }</small>
					    	</div>
						</div>
					</li>
					<li class="box box--hide">
						<div class="card mb-3">
						   	<a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${list[9].isbn}" id="isbn">
								<div class="img-wrapper">
						  			<img class="card-img-top" src="${list[9].image }" />
						  		</div>
							</a>
							<div class="card-body" >
								<p class="card-text" ><strong>${list[9].title }</strong></p>
								<small class="card-text" >${list[9].author }</small>
					      	</div>
						</div>
					</li>
				</ul>
			</div>  <!-- /cards-wrapper -->
			<div class="Rbutton" onclick="shiftRight()">
				<img src="https://image.ibb.co/dfPSw7/right_arrow.png" alt="">
			</div>        
		</div>  <!-- /top -->

		<div class="bottom">
			<!-- Example row of columns -->
			<div class="booking">
				<div class="row">
					<div class="col-6" >
					  	<div class="B-logo"><strong>낯선 책과의 즉석만남</strong> 하트를 눌러 만나보세요 </div>
					  	<a id="bookingBtn" href="javascript:">
					  		<img style="margin-left:0px; width:250px; height:200px;" src="resources/images/bookingBtn.svg"/>
					  	</a>
					</div>
					<div class="col-6" style="margin:auto">
						<a id="bookA">
							<img style="height:200px; width:250px;" id="bookimage" src="resources/images/message.svg"/>
						</a>
					</div>
				</div> <!-- /row -->
			</div> <!-- /booking -->
		</div> <!-- /bottom -->
	</div> <!-- /container -->
</body>
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
            if(isbn!=""){
            	$('#bookA').attr("href", "detail/bookDetail.do?d_isbn="+isbn);
            }            
         }   
      })
      
   })
   
   // by욱현.추천도서에 carousel 적용위한 외부 자바스크립트 로드_2021227
   
   function shiftLeft() {
    const boxes = document.querySelectorAll(".box");
    const tmpNode = boxes[0];
    boxes[0].className = "box move-out-from-left";
    setTimeout(function() {
        if (boxes.length > 3) {
            tmpNode.classList.add("box--hide");
            boxes[3].className = "box move-to-position3-from-left";
        }
        boxes[1].className = "box move-to-position1-from-left";
        boxes[2].className = "box move-to-position2-from-left";
       
        boxes[0].remove();
        document.querySelector(".cards__container").appendChild(tmpNode);
    }, 500);
   }
   function shiftRight() {
       const boxes = document.querySelectorAll(".box");
       boxes[2].className = "box move-out-from-right";
       setTimeout(function() {
           const noOfCards = boxes.length;
           if (noOfCards > 2) {
               boxes[2].className = "box box--hide";
           }
   
           const tmpNode = boxes[noOfCards - 1];
           tmpNode.classList.remove("box--hide");
           boxes[noOfCards - 1].remove();
           let parentObj = document.querySelector(".cards__container");
           parentObj.insertBefore(tmpNode, parentObj.firstChild);
           tmpNode.className = "box move-to-position1-from-right";
           boxes[0].className = "box move-to-position2-from-right";
           boxes[1].className = "box move-to-position3-from-right";
  
       }, 500);
   }
   
   $(document).ready(function() {
	    $('#searchForm').submit(function() {
	        if ($('#searchBook').val() == '') {
	            alert('검색어를 입력하세요.');
	            return false;
	        }
	    }); 
	}); 
	$(document).ready(function(){
	   $.ajax({
           url:"${pageContext.request.contextPath }/bookList/bestSeller.do?d_cont=1",
           method:"GET",
           data:"&sort=count",
           success:function(data){
              $("#bestSeller").html(data); //by 준영, 책 리뷰 리스트 페이지를 #reviewList div 에 html 로 추가_210226
           }
	   })
   })
</script>
</html>
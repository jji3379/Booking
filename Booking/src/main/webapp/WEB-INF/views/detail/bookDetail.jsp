<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>bookDetail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	#simList{
		
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
		height:300px;
	
	}
	/* 
	 *  Core Owl Carousel CSS File
	 */
	.owl-item > div {
	  height:fit-content;
	  cursor: pointer;
	  margin: 6% 8%;
	  transition: margin 0.4s ease;
	  pointer-events: auto !important;
	}
	.owl-item.center > div {
	  cursor: auto;
	  margin: 0;
	  z-index:1000;
	  diplay:block;
	}
	.owl-item:not(.center) > div:hover {
	  opacity: .75; 
	}
	.owl-nav{
		display:none;
	}
	/*
		Table CSS
	*/
	#isbn{
		display:none;
	}
	.table th, .table td{
		width:auto;
		vertical-align:middle;
	}

	#image{
		object-fit;
		text-align:center;
	}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" integrity="sha512-tS3S5qG0BlhnQROyJXvNjeEM4UpMXHrQfTGmbQ1gKmelCxlSEBUaxhRBj/EFTzpbP4RVSrpEikbmdJobCvhE3g==" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" integrity="sha512-sMXtMNL1zRzolHYKEujM2AqCLUR9F2C4/05cdbxjjLSRvMQIciEPCQZo++nk7go3BtSuK9kfa/s+a4f4i5pLkw==" crossorigin="anonymous" />
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
<div style=margin-top:60px; class="container" id="bookDetail">
   	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">Detail</li>
		</ul>
	</nav>
    <table class="table table-striped">
    <thead class="thead-dark">
    	<tr style height="50px">
	 		<th></th>
	 		<th></th>
	 		<th></th>
	 	</tr>
    </thead>
	    <tbody>
	    	<c:forEach var="b" items="${bookDetail }">
		 	<tr>
		 		<td rowspan="7"><div id="image"><a style :object-fit= contain; href="${b.link }"><img src="${b.image }"/></a></div></td>
		 	</tr>
		 	<tr>
		 		<td><strong>저자</strong></td>
		 		<td id="auth">${b.author }</td>
		 	</tr>
		 	<tr>
		 		<td><strong>제목</strong></td>
		 		<td>${b.title }</td>
		 	</tr>
		 	<tr>
		 		<td><strong>정가</strong></td>
		 		<td id="price">${b.price }</td>
		 	</tr>
		 	<tr>
		 		<td><strong>할인가</strong></td>
		 		<td><font id="d_price" color="red">${b.discount }</font></td>
		 	</tr>
		 	<tr>
		 		<td><strong>출판사</strong></td>
		 		<td>${b.publisher }</td>
		 	</tr>
		 	<tr>
		 		<td><strong>출간일</strong></td>
		 		<td>${b.pubdate }</td>
		 	</tr>
		 	<tr>
		 		<div><td colspan="3">${b.description }</td></div>
		 	</tr>
		 	<span id="isbn">${b.isbn }</span>	
	    </tbody>
    </table>
    <form id="cart" action="${pageContext.request.contextPath }/pay/middle.do" method="post">
    	<input id="idP" type="hidden" name="id" value="${id }"/>
	    <input id="imageP" type="hidden" name="image" value="${b.image }"/>
	    <input id="titleP" type="hidden" name="title" value="${b.title }" />
	    <input id="priceP" type="hidden" name="price" value="${b.price }"/>
	    <input id="d_priceP" type="hidden" name="d_price" value="${b.discount }"/>
	    <select id="countP" name="count">
	    	<option value="1">1</option>
	    	<option value="2">2</option>
	    	<option value="3">3</option>
	    	<option value="4">4</option>
	    	<option value="5">5</option>
	    	<option value="6">6</option>
	    	<option value="7">7</option>
	    	<option value="8">8</option>
	    	<option value="9">9</option>
	    	<option value="10">10</option>
	    </select>
	    <br />
    	<button id="insertBtn" type="sumit" >장바구니</button>
    </form>
    <script>
   		 /* onClick="insert()"	
    	//by준영, 장바구니 로그인 필터 기능_210311
		var id=$("#idP").val();
		var image = $("#imageP").val();
		var title = $("#titleP").val();
		var price = $("#priceP").val();
		var d_price = $("#d_priceP").val();
		var count = $("#countP option:selected").val();
		
		function insert(){
			var url ="${pageContext.request.contextPath }/pay/middle.do";
			var data = {
					'id': id,
					'image' : image,
					'title' : title,
					'price' : price,
					'd_price' : d_price,
					'count' : count
			};
			console.log(data);
			
			$.ajax({
				url:url,
				type:'post',
				traditional :true,
				data: data,
				success:function(data){
					var chk = confirm("북카트로 가시겠습니까?");
					if(chk){
						alert("담기 성공");
						location.replace("${pageContext.request.contextPath }/pay/middle.do");
					}
					alert("담기 성공");
				}
			
			})
		} */
    </script>
    </c:forEach>
	<div id="simList"></div>
	<div id="reviewList"></div>
</div>

<script type="text/javascript" >
	

	//by 준영, 이 저자의 책들을 불러오는 ajax 호출 함수_210222
	var inputAuth=$("#auth").text();
	
	function bookAuthor(){
		return new Promise((resolve, reject) => {
			$.ajax({ 
				url:"detailAjax.do?sort=sim",
			    method:"GET",
			    data:"d_auth="+inputAuth,
			    success:function(data){
			       resolve(data);
			       $("#simList").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
			    },
			    error:function(error){
			    	reject(error)
			    },
			})
		})
	}
	//by준영, 이 책의 리뷰페이지를 불러오는 ajax 호출 함수_210226
	var inputIsbn=$("#isbn").text();
	
	function bookReview(){
		return new Promise((resolve, reject) => {
			$.ajax({
		   		url:"${pageContext.request.contextPath }/review/list.do?condition=isbn",
		   		method:"GET",
		   		data:"&keyword="+inputIsbn,
		   		success:function(data){
		   			resolve(data);
		   			$("#reviewList").html(data); //by 준영, 책 리뷰 리스트 페이지를 #reviewList div 에 html 로 추가_210226
		   		},
			    error:function(error){
			    	reject(error)
			    },
			})
		})
	}
	//by준영, 2개의 ajax 호출을 위한 promise 비동기처리_210307
	bookAuthor()
		.then((data) => {
			bookReview()
		})
		.catch((error) => {
			console.log(error)
		})
	
	
	//by 준영,반응형 캐러셀 정의_210224
	var $owl = $('.owl-carousel');
	
	$owl.children().each( function( index ) {
	  $(this).attr( 'data-position', index ); 
	});
	
	$owl.owlCarousel({
	  navigation:true,
	  center: true,
	  loop: true,
	  mouseDrag:true,
      mouseDraggable:true,
      touchDrag: true,
	  responsiveClass: true,
	  responsive:{
		  0:{
	            items:1,
	            nav:true
	        },
	        600:{
	            items:3,
	            nav:false
	        },
	        1000:{
	            items:5,
	            nav:true,
	            loop:false
	  		}
	  }
	});
	
	//by 준영, 클릭 항목으로 이동하는 기능_210224
	$(document).on('click', '.owl-item>div', function() {
	  var $speed = 300;  // in ms
	  $owl.trigger('to.owl.carousel', [$(this).data( 'position' ), $speed] );
	});
	//by 준영 스크롤로 캐러셀 조정 기능_210224
	var owl = $('.owl-carousel');
	owl.on('mousewheel', '.owl-stage', function(e) {
	   if (e.deltaY > 0) {
	      owl.trigger('next.owl');
	   } else {
	      owl.trigger('prev.owl');
	   }
	   e.preventDefault();
	});
	
	
	
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.js" integrity="sha512-c5JDIvikBZ6tuz+OyaFsHKvuyg+tCug3hf41Vmmd5Yz9H5anj4vZOqlBV5PJoEbBJGFCgKoRT9YAgko4JS6/Qw==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw==" crossorigin="anonymous"></script>
</body>
</html>




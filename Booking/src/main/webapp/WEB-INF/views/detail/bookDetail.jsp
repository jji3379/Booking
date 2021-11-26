<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="resources/css/bookDetail.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" integrity="sha512-tS3S5qG0BlhnQROyJXvNjeEM4UpMXHrQfTGmbQ1gKmelCxlSEBUaxhRBj/EFTzpbP4RVSrpEikbmdJobCvhE3g==" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" integrity="sha512-sMXtMNL1zRzolHYKEujM2AqCLUR9F2C4/05cdbxjjLSRvMQIciEPCQZo++nk7go3BtSuK9kfa/s+a4f4i5pLkw==" crossorigin="anonymous" />
</head>
<body>
<div class="container">
	<c:forEach var="b" items="${bookDetail }">
		<div class="hori">
			<table class="tb">
		   		<tr>
		   			<td class="tdImg" rowspan='6'><a id="image" href="${b.link }"><img src="${b.image}"/></a></td>
		   			<td class="tdTitle">${b.title }</td>
		   		</tr>
		   		<tr>
		   			<td class="tdAuth"><span id="auth">${b.author }</span>| ${b.publisher } | ${b.pubdate }</td>
		   		</tr>
		   		<tr>
		   			<td class="tdPrice">정가 ${b.price} 원</td>
		   		</tr>
		   		<tr>
		   			<td class="tdDisc">판매가 <span>${b.discount } </span>원</td>
		   		</tr>
		   		<tr class="trCount">
		   			<td>
		   				<p>수량</p>
						<div class="quantity">
							<input id="countP" type="number" name="count" class="numBox" min="1" max="100" value="1" />
						</div>
		           	</td>
		   		</tr>
	   			<tr>
		           	<td>
		    	       	<input id="idP" type="hidden" name="id" value="${id }"/>
					    <input id="imageP" type="hidden" name="image" value="${b.image }"/>
					    <input id="titleP" type="hidden" name="title" value="${b.title }" />
					    <input id="priceP" type="hidden" name="price" value="${b.price }"/>
					    <input id="d_priceP" type="hidden" name="d_price" value="${b.discount }"/>
					    <input type="text" id="isbnP" name="isbn" value="${b.isbn }" hidden/>
				   		<button class="btn btn-outline-light" id="insertBtn" type="button" onclick="insert()">장바구니</button>
						<button class="btn btn-outline-light" id="directBtn" onclick="direct()">바로구매  </button>
				   		<a href="${pageContext.request.contextPath }/review/private/reviewInsertform.do?d_isbn=${b.isbn }" class="btn btn-outline-light" id="reviewBtn"> 리뷰쓰기</a>
				   	</td>
				</tr>
			</table>
			<div class="divR">
				<div class="Rtop">
					작가의 다른책
				</div>
				<div id="simList"></div>
				<div class="Rbot">
					<a id="plus" href="javascript:">
				   	<img src="http://img.echosting.cafe24.com/skin/base_ko_KR/layout/btn_recent_next.gif" alt="다음 제품" class="next" />
				   	</a>
				</div>
			</div>
		</div>
		<div class="description">
			${b.description}
		</div>
    	</c:forEach>
    	<!-- <div id="reviewList"></div>	 -->
	<script>
		//by준영, 장바구니 로그인 필터 기능_210311
		//by준영, 장바구니로 페이지이동없이 담고 바로 이동할지 묻는 컨펌 로직_210315
		var id=$("#idP").val();
		
		function insert(){
			var image = $("#imageP").val();
			var title = $("#titleP").val();
			var price = $("#priceP").val();
			var d_price = $("#d_priceP").val();
			var count = $("#countP").val();
			var isbn=$("#isbnP").val();
			
			var url ="${pageContext.request.contextPath }/pay/insert.do";
			var data = null;
			if(d_price == ""){
				data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : price ,'count' : count, 'isbn' : isbn };
			}else if(d_price != ""){
				data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : d_price ,'count' : count, 'isbn' : isbn };
			}
			console.log(data);
			if(id == ""){
				alert("로그인이 필요합니다");	
				location.href="${pageContext.request.contextPath }/users/login_form.do";
			}else{
				$.ajax({
					url:url,
					method:'post',
					data: data,
					success:function(data){
						var chk = confirm("상품을 담았습니다 북카트로 이동하시겠습니까?");
						if(chk){
							location.replace("${pageContext.request.contextPath }/pay/cart.do");
						}else{
							return false;
						}
					}
				})
			}	
		}
		
		function direct(){
			var image = $("#imageP").val();
			var title = $("#titleP").val();
			var price = $("#priceP").val();
			var d_price = $("#d_priceP").val();
			var count = $("#countP").val();
			var isbn=$("#isbnP").val();
			
			var url ="${pageContext.request.contextPath }/pay/insert.do";
			var data = null;
			if(d_price == ""){
				data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : price ,'count' : count, 'isbn' : isbn };
			}else if(d_price != ""){
				data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : d_price ,'count' : count, 'isbn' : isbn };
			}
			console.log(data);
			if(id == ""){
				alert("로그인이 필요합니다");	
				location.href="${pageContext.request.contextPath }/users/login_form.do";
			}else{
				$.ajax({
					url:url,
					method:'post',
					data: data,
					success:function(data){
						location.replace("${pageContext.request.contextPath }/pay/pay.do");
					}
				})
			}	
		}
	</script>

</div>
<script type="text/javascript">
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
             url:"${pageContext.request.contextPath }/review/reviewList.do?condition=isbn",
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
		
	/* //by 준영,반응형 캐러셀 정의_210224
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
		autoplay: true,
		autoplayTimeout: 2500,
		rewind:true,
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
	 */
	 jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');
	    jQuery('.quantity').each(function() {
	      var spinner = jQuery(this),
	        input = spinner.find('input[type="number"]'),
	        btnUp = spinner.find('.quantity-up'),
	        btnDown = spinner.find('.quantity-down'),
	        min = input.attr('min'),
	        max = input.attr('max');

	      btnUp.click(function() {
	        var oldValue = parseFloat(input.val());
	        if (oldValue >= max) {
	          var newVal = oldValue;
	        } else {
	          var newVal = oldValue + 1;
	        }
	        spinner.find("input").val(newVal);
	        spinner.find("input").trigger("change");
	      });

	      btnDown.click(function() {
	        var oldValue = parseFloat(input.val());
	        if (oldValue <= min) {
	          var newVal = oldValue;
	        } else {
	          var newVal = oldValue - 1;
	        }
	        spinner.find("input").val(newVal);
	        spinner.find("input").trigger("change");
	      });

	    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.js" integrity="sha512-c5JDIvikBZ6tuz+OyaFsHKvuyg+tCug3hf41Vmmd5Yz9H5anj4vZOqlBV5PJoEbBJGFCgKoRT9YAgko4JS6/Qw==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw==" crossorigin="anonymous"></script>
</body>
</html>
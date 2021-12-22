<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bookDetail.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.simAjax > li {
		margin-bottom: 10px;
	}
	.shipping {
		display: flex;
		width: 100%;
	}
	.ship-L {
		padding: 36px 114px 40px 43px;
	    width: 373px;
	    font-family: malgun, "Malgun Gothic", Dotum, 돋움, sans-serif;
	    color: #222;
	    font-size: 24px;
	}
	.ship-R {
	
	}
</style>
</head>
<body>
<div class="container">
	<c:forEach var="b" items="${bookDetail }">
		<div class="hori">
			<table class="tb">
				<div class="tb-head">
					<h2 class="head-title"> > ${b.title }</h2>
					<div class="head-star">
						<p>별점</p>
						<div class="star-value">★★★★★</div>
					</div>
				</div>
		   		<tr>
		   			<td class="tdImg" rowspan='6'><a id="image" href="${b.link }"><img src="${b.image}"/></a></td>
		   		</tr>
		   		<tr class="book-info">
		   			<td colspan="2" class="tdInfo">
			   			<ul class="info-list">
			   				<li>저자 : <span id="auth">${b.author }</span></li>
			   				<li>출판사 : ${b.publisher }</li>
			   				<li id="pubdate">발행 : ${b.pubdate }</li>
			   				<li>ISBN : ${b.isbn }</li>
			   			</ul>
		   			</td>
		   		</tr>
		   		<tr>
		   			<th >정가 </th>
		   			<td class="tdPrice">${b.price} 원</td>
		   		</tr>
		   		<tr>
		   			<th >판매가 </th>
		   			<td class="tdDisc"><span>${b.discount } </span>원</td>
		   		</tr>
		   		<tr class="trCount">
		   			<th>수량</th>
		           	<td class="quantity">
						<input id="countP" type="number" name="count" class="numBox" min="1" max="100" value="1" />
					</td>
		   		</tr>
	   			<tr>
		           	<td class="trButton" colspan="2">
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
		<div class="bottomWrap">
			<div class="bookIntro">
				<div class="Intro-L">책 소개</div>
				<div class="Intro-R">
					<div class="description">
						${b.description}
					</div>
					<div class="finishLine"/>
				</div>
			</div>
			<div class="shipping">
				<div class="ship-L">배송안내</div>
				<div class="ship-R">
					<ul class="ship-guide">
		                <li><p>북킹 상품은 택배로 배송되며, 출고완료 1~2일내 상품을 받아 보실 수 있습니다.</p></li>
		                <li><p>출고가능 시간이 서로 다른 상품을 함께 주문할 경우 출고가능 시간이 가장 긴 상품을 기준으로 배송됩니다.</p></li>
		                <li><p>군부대, 교도소 등 특정기관은 우체국 택배만 배송가능합니다.</p></li>
		                <li><p>배송비는 업체 배송비 정책에 따릅니다.<br></p></li>
		                <span style="display: block; margin-left: 10px; color: #777">- 도서 구매 시, 1만 원 이상 무료, 1만원 미만 2천 원</span>
		                <span style="display: block; margin-left: 10px; color: #777">- 상품별 배송비가 있는 경우, 상품별 배송비 정책 적용</span>
		            </ul>
				</div>
			</div>
		</div>
		
    	</c:forEach>
    	<!-- <div id="reviewList"></div>-->
   	</div>
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
				$('#modal-open').trigger('click');
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
				$('#modal-open').trigger('click');
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
	 //by준영, 수량 +- 동작
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

</body>
</html>
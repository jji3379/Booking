<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<center><h2>이 작가의 책들</h2></center>
<div id="owl-demo" class="owl-carousel">
<c:forEach var="b" items="${detailAjax }">
	<div><a id="Link" href="bookDetail.do?d_isbn=${b.isbn }"><img src="${b.image }"></a></div>
</c:forEach>
</div>
<script type="text/javascript">
	//by 준영,반응형 캐러셀 정의_210224
	var $owl = $('.owl-carousel');
	
	$owl.children().each( function( index ) {
	  $(this).attr( 'data-position', index ); // NB: .attr() instead of .data()
	});
	
	$owl.owlCarousel({
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
	$(document).on('click', '.owl-item>div', function(e) {
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


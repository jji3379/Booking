<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bestSeller.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
</style>
</head>
<body>
	<div class="layout">
		<div class="listWrap">
			<h1 class="page-title">
				Booking 종합 베스트셀러
			</h1>
			<div class="ranking">
				<ul>
					<li class="item"><a id="ranking1" class="rank-sort" href="#" onclick="topBestSeller(1)">1 위 <img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a id="ranking51" class="rank-sort" href="#" onclick="topBestSeller(51)">51 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a id="ranking101" class="rank-sort" href="#" onclick="topBestSeller(101)">101 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a id="ranking151" class="rank-sort" href="#" onclick="topBestSeller(151)">151 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<div class="date-box">
						<span id="date"></span>
					</div>
				</ul>
				
			</div>
			<form action="">
				 <div class="book-box">
				 	<table id="bestSellerList">
				 		<colgroup>
				 			<col style="width:90px;">
				 			<col style="width:150px;">
				 			<col style="width:570px;">
				 			<col style="width:105px;">
				 		</colgroup>
						<tbody id="bestSellerBody">
						</tbody>
				 		<!-- 
				 		<c:forEach var="b" items="${bestSeller}" varStatus="status">
				 			<tr>
					 			<td class="td-info">
					 				<div class="book-rank">${status.count}.</div>
					 			</td>
					 			<td >
					 				<div>
					 					<a href="${pageContext.request.contextPath }/bookDetail.do?d_isbn=${b.isbn}"><img src="${b.image}" class="book-img"></a>
					 				</div>
					 			</td>
					 			<td class="td-info" >
					 				<div class="infoWrap">
						 				<ul>
											<li class="grid-li bd-title">
												<span class="book-title">${b.title}</span>
											</li>
											<li class="grid-li bd-info">
												<div>
													<span class="book-info">${b.author}</span>
													<span class="book-info">${b.publisher}</span>
													<span class="book-info">${b.pubdate}</span>
													<span id="bookIsbn" hidden>${b.isbn }</span>
												</div>
												<span class="bestSeller">베스트셀러</span>
											</li>
											<li class="grid-li bd-price">
												<div >
													<span class="book-price">${b.price} 원</span> → <span class="discount">${b.discount} 원</span>
												</div> 
											</li>
											<li class="grid-li bd-review">
												 <div class="book-review">
												 	<div class="star-box">
														<div class="total-star">
															<div class="starValue star-fill" ></div>
															<div class="star-base">
																<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
															</div>
														</div>
														<span class="total-value"></span>
													</div>
										
													<div class="total-comment">(<a href="">163</a>)</div>
												 </div>
											</li> 
										</ul>
									</div>
					 			</td>
					 			<td class="td-info" >
					 				<div class="buttonWrap">
					 					<input id="idP" type="hidden" name="id" value="${id }"/>
										<input id="imageP" type="hidden" name="image" value="${b.image }"/>
										<input id="titleP" type="hidden" name="title" value="${b.title }" />
										<input id="priceP" type="hidden" name="price" value="${b.price }"/>
										<input id="d_priceP" type="hidden" name="d_price" value="${b.discount }"/>
										<input type="text" id="isbnP" name="isbn" value="${b.isbn }" hidden/>
					 					<div >
					 						<button class="cart btn" id="insertBtn" onclick="insert()">장바구니</button>
					 					</div>
					 					<div >
					 						<button class="buy btn" id="directBtn" onclick="direct()">바로구매</button>
					 					</div>
				 					</div>
					 			</td>
					 		</tr>
					 		<tr></tr>
				 		</c:forEach>
				 		<tr id="tr-load"></tr>
				 		 -->
				 	</table>
				 	<div class="bottom-bar">
				 		<span class="load-more">LOAD MORE</span>
				 	</div>
	 				<div id="topButton"><img id="topButtonImg" src="https://image.aladin.co.kr/img/bu/btn_top2.png" alt="맨위로"></div>
				 </div>
			</form>
		</div>
	</div>
<script>

	var scrollCount = 0;
	// 초기 호출 함수
	var start = 1;			
	$("#ranking1").on("click",function(){
		start = 1;		
		$('.load-more').show();
	})
	$("#ranking51").on("click",function(){
		start = 51;
		$('.load-more').show();
	})
	$("#ranking101").on("click",function(){
		start = 101;
		$('.load-more').show();
	})
	$("#ranking151").on("click",function(){
		start = 151;
		$('.load-more').show();
	})
	
	$(window).on("scroll", function(){
		if (scrollCount <= 3) {
			//위쪽으로 스크롤된 길이 구하기
			var scrollTop=$(window).scrollTop();
			//window 의 높이
			var windowHeight=$(window).height();
			//document(문서)의 높이
			var documentHeight=$(document).height();
			//바닥까지 스크롤 되었는지 여부
			var isBottom = scrollTop + windowHeight >= documentHeight;
			if(isBottom){//만일 바닥까지 스크롤 했다면...
				$('.load-more').attr('class','load-more-on');	
				setTimeout(() => {
					scrollCount++;
					topBestSeller(start+(10*scrollCount));
					$('.load-more-on').attr('class','load-more');
				}, 100);
			}
		}else{
			$('.load-more').hide();
		}
	});	
	
	function topBestSeller(start){
		if(start ==1 || start == 51 || start == 101 || start == 151){
			$("#bestSellerBody *").remove();			
			scrollCount = 0;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/bestSeller/"+start,
			method:"GET",
			dataType : "json",
			async: false,
			success:function(data) {
				
				var bestSellerList = "";
				for (var i = 0; i < data.length; i++) {
					bestSellerList += '<tr>'
						bestSellerList += '<td class="td-info">'
							if(start == 1) {
								bestSellerList += '<div class="book-rank">'+(i+1)+'.</div>'
							}else{
								bestSellerList += '<div class="book-rank">'+(i+start)+'.</div>'
							}
						bestSellerList += '</td>'
						
						bestSellerList += '<td>'
							bestSellerList += '<div>'
								bestSellerList += '<a href="${pageContext.request.contextPath }/book/'+data[i].isbn+'"><img src="'+data[i].image+'" class="book-img"></a>'
							bestSellerList += '</div>'
						bestSellerList += '</td>'
						
						bestSellerList += '<td class="td-info" >'
							bestSellerList += '<div class="infoWrap">'
								bestSellerList += '<ul>'
									bestSellerList += '<li class="grid-li bd-title">'
										bestSellerList += '<span class="book-title">'+data[i].title+'</span>'
									bestSellerList += '</li>'
									
									bestSellerList += '<li class="grid-li bd-info">'
										bestSellerList += '<div>'
											bestSellerList += '<span class="book-info">'+data[i].author+'</span>'
											bestSellerList += '<span class="book-info">'+data[i].publisher+'</span>'
											bestSellerList += '<span class="book-info">'+data[i].pubdate+'</span>'
											bestSellerList += '<span id="bookIsbn" hidden>'+data[i].isbn+'</span>'
										bestSellerList += '</div>'
										bestSellerList += '<span class="bestSeller">베스트셀러</span>'
									bestSellerList += '</li>'
									
									bestSellerList += '<li class="grid-li bd-price">'
										bestSellerList += '<div>'
											bestSellerList += '<span class="book-price">'+data[i].price+' 원</span>'
											if(data[i].discount != ""){
												bestSellerList += '→ <span class="discount">'+data[i].discount+' 원</span>'
											}
										bestSellerList += '</div>'
									bestSellerList += '</li>'
										
									bestSellerList += '<li class="grid-li bd-review">'
										bestSellerList += '<div class="book-review">'
											bestSellerList += '<div class="star-box">'
												bestSellerList += '<div class="total-star">'
													
														if(data[i].reviewRating == null || data[i].reviewRating == 0){
															var int_part = 0;
															var float_part = parseFloat(0).toFixed(1);
														}else{
															var int_part = Math.trunc(data[i].reviewRating);	
															var float_part = Number((data[i].reviewRating-int_part).toFixed(1));															
														}
													bestSellerList += '<div class="starValue star-fill'+(float_part*10)+'" >'
														
														//평점의 정수부분 +1개 만큼 별 생성하고
														switch(int_part) {
														case 0 :
															bestSellerList += ('<span>★</span>')
															break;
														case 1 :
															bestSellerList += ('<span>★</span><span>★</span>')
															break;
														case 2 :
															bestSellerList += ('<span>★</span><span>★</span><span>★</span>')
															break;
														case 3 :
															bestSellerList += ('<span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														case 4 :
															bestSellerList += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														case 5 :
															bestSellerList += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														}
														
													bestSellerList += '</div>'
													bestSellerList += '<div class="star-base">'
														bestSellerList += '<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>'
													bestSellerList += '</div>'
												bestSellerList += '</div>'
												bestSellerList += '<span class="total-value">'
													bestSellerList += '('
															if ( data[i].reviewRating == null ){
																bestSellerList += 0; 
															} else {
																bestSellerList += Math.round(data[i].reviewRating * 10)/10; 
															}
													bestSellerList += ')'
												bestSellerList += '</span>'
											bestSellerList += '</div>'
											
											bestSellerList += '<div class="total-comment">(<a href="">'
											if( data[i].reviewCount == null ) {
												bestSellerList += 0
											} else {
												bestSellerList += data[i].reviewCount
											}
											bestSellerList += '</a>)</div>'
										bestSellerList += '</div>'
									bestSellerList += '</li>'
								bestSellerList += '</ul>'
							bestSellerList += '</div>'
						bestSellerList += '</td>'
						
						bestSellerList += '<td class="td-info" >'
							bestSellerList += '<div class="buttonWrap">'
								bestSellerList += '<input id="idP'+i+'" type="hidden" name="id" value="${id }"/>'
								bestSellerList += '<input id="imageP'+i+'" type="hidden" name="image" value="'+data[i].image+'"/>'
								bestSellerList += '<input id="titleP'+i+'" type="hidden" name="title" value="'+data[i].title+'" />'
								bestSellerList += '<input id="priceP'+i+'" type="hidden" name="price" value="'+data[i].price+'"/>'
								bestSellerList += '<input id="d_priceP'+i+'" type="hidden" name="d_price" value="'+data[i].discount+'"/>'
								bestSellerList += '<input id="publisherP'+i+'" type="hidden"  name="publisher" value="'+data[i].publisher+'"/>'
								bestSellerList += '<input id="authorP'+i+'" type="hidden"  name="author" value="'+data[i].author+'" />'
								bestSellerList += '<input id="isbnP'+i+'" type="hidden"  name="isbn" value="'+data[i].isbn+'" />'
								bestSellerList += '<input id="countP'+i+'"  type="hidden"  name="count" value="1" />'

								bestSellerList += '<div>'
									bestSellerList += '<button class="cart btn" type="button" id="insertBtn" onclick="insert('+i+')">장바구니</button>'
								bestSellerList += '</div>'
								bestSellerList += '<div>'
									bestSellerList += '<button class="buy btn" type="button" id="directBtn" onclick="direct('+i+')">바로구매</button>'
								bestSellerList += '</div>'
							bestSellerList += '</div>'
						bestSellerList += '</td>'
					bestSellerList += '</tr>'
					bestSellerList += '<tr></tr>'
				}
					
				$("#bestSellerBody").append(bestSellerList);
					
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}
	
	topBestSeller(1);

	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString() + '&nbsp; 기준');
	
	//by준영, 맨위로 가기 버튼
	$(document).ready(function(){
		$(window).scroll(function(){
		    // top button controll
		    if ($(this).scrollTop() > 500) {
		        $('#topButton').fadeIn();
		    } else {
		        $('#topButton').fadeOut();
		    }
		});

		$("#topButtonImg").click(function(){
			$('html, body').animate({scrollTop:0}, '300');
		});
	});
	
	 //by준영, 장바구니 로그인 필터 기능_210311
    //by준영, 장바구니로 페이지이동없이 담고 바로 이동할지 묻는 컨펌 로직_210315
    
    function insert(i){
       var id = $("#idP"+i).val();
       var image = $('#'+'imageP'+i).val();
       var title = $('#'+'titleP'+i).val();
       var price = $('#'+'priceP'+i).val();
       var d_price = $('#'+'d_priceP'+i).val();
       var count = $('#'+'countP'+i).val();
       var isbn=$('#'+'isbnP'+i).val();
       var publisher = $('#publisherP'+i).val();
       var author = $('#authorP'+i).val(); 
     
       var data = null;
       if(d_price == ""){
    	   console.log(data);
          data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : price ,'count' : count, 'isbn' : isbn , 'publisher' : publisher , 'author' : author };
       }else if(d_price != ""){
    	   console.log(data);
          data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : d_price ,'count' : count, 'isbn' : isbn , 'publisher' : publisher , 'author' : author };
       }
       console.log(data);
       if(id == ""){
          $('#modal-open').trigger('click');
       }else{
          $.ajax({
             url:"${pageContext.request.contextPath }/v1/user/${sessionScope.id}/cart",
             method:'post',
             data: data,
             success:function(data){
                var chk = confirm("상품을 담았습니다 북카트로 이동하시겠습니까?");
                if(chk){
                   location.href = "${pageContext.request.contextPath }/pay/cart.do";
                }else{
                   return false;
                }
             }
          })
       }   
    }
    
    function direct(i){
       var id = $("#idP"+i).val();
       var image = $('#'+'imageP'+i).val();
       var title = $('#'+'titleP'+i).val();
       var price = $('#'+'priceP'+i).val();
       var d_price = $('#'+'d_priceP'+i).val();
       var count = $('#'+'countP'+i).val();
       var isbn=$('#'+'isbnP'+i).val();
       var publisher = $('#publisherP'+i).val();
       var author = $('#authorP'+i).val();
       
       var data = null;
       if(d_price == ""){
          data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : price ,'count' : count, 'isbn' : isbn , 'publisher' : publisher , 'author' : author };
       }else if(d_price != ""){
          data={'id' : id ,'image' : image ,'title' : title ,'price' : price ,'d_price' : d_price ,'count' : count, 'isbn' : isbn , 'publisher' : publisher , 'author' : author };
       }
       console.log(data);
       if(id == ""){
          $('#modal-open').trigger('click');
       }else{
          $.ajax({
        	 url:"${pageContext.request.contextPath }/v1/user/${sessionScope.id}/cart",
             method:'post',
             data: data,
             success:function(data){
                location.href = "${pageContext.request.contextPath }/user/${sessionScope.id}/pay";
             }
          })
       }   
    }

</script>
</body>
</html>
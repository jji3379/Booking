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
				> Booking 종합 베스트셀러 TOP 200
			</h1>
			<!-- <h2 class="notice-box">
				"<b id="keyword">keyword</b>" 에 대한 검색결과는 
				<b id="key-value">n</b>개의 상품이 검색되었습니다.
			</h2> -->
			<div class="ranking">
				<ul>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=1' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=1">1 위 <img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=51' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=51">51 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=101' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=101">101 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a class="rank-sort ${param.sort eq 'count&start=151' ? 'active' : ''}" href="${pageContext.request.contextPath }/bookList/bestSeller.do?sort=count&start=151">151 위<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<div class="date-box">
						<span id="date"></span>
					</div>
				</ul>
				
			</div>
			<form action="">
				 <div class="book-box">
				 	<table id="bestSellerList">
				 		<!-- 
				 		<colgroup>
				 			<col style="width:90px;">
				 			<col style="width:150px;">
				 			<col style="width:570px;">
				 			<col style="width:105px;">
				 		</colgroup>

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
				 		바닥
				 	</div>
				 </div>
			</form>
		</div>
		<div id="topButton"><img id="topButtonImg" src="https://image.aladin.co.kr/img/bu/btn_top2.png" alt="맨위로"></div>
		<svg id="loader" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
		  viewBox="0 0 100 100" enable-background="new 0 0 0 0" xml:space="preserve">
		  <circle fill="#fff" stroke="none" cx="6" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 15 ; 0 -15; 0 15" 
		       repeatCount="indefinite" 
		       begin="0.1"/>
		  </circle>
		  <circle fill="#fff" stroke="none" cx="30" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 10 ; 0 -10; 0 10" 
		       repeatCount="indefinite" 
		       begin="0.2"/>
		  </circle>
		  <circle fill="#fff" stroke="none" cx="54" cy="50" r="6">
		    <animateTransform 
		       attributeName="transform" 
		       dur="1s" 
		       type="translate" 
		       values="0 5 ; 0 -5; 0 5" 
		       repeatCount="indefinite" 
		       begin="0.3"/>
		  </circle>
		</svg>
	</div>
<script>

	$.ajax({
		url:"${pageContext.request.contextPath}/v1/bestSeller",
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			var bestSellerList = "";
				bestSellerList += '<colgroup>'
					bestSellerList += '<col style="width:90px;">'
					bestSellerList += '<col style="width:150px;">'
					bestSellerList += '<col style="width:570px;">'
					bestSellerList += '<col style="width:105px;">'
				bestSellerList += '</colgroup>'

			for (var i = 0; i < data.content.length; i++) {
				bestSellerList += '<tr>'
					bestSellerList += '<td class="td-info">'
						bestSellerList += '<div class="book-rank">'+(i+1)+'.</div>'
					bestSellerList += '</td>'
					
					bestSellerList += '<td>'
						bestSellerList += '<div>'
							bestSellerList += '<a href="${pageContext.request.contextPath }/bookDetail.do?d_isbn='+data.content[i].isbn+'"><img src="'+data.content[i].image+'" class="book-img"></a>'
						bestSellerList += '</div>'
					bestSellerList += '</td>'
					
					bestSellerList += '<td class="td-info" >'
						bestSellerList += '<div class="infoWrap">'
							bestSellerList += '<ul>'
								bestSellerList += '<li class="grid-li bd-title">'
									bestSellerList += '<span class="book-title">'+data.content[i].title+'</span>'
								bestSellerList += '</li>'
								
								bestSellerList += '<li class="grid-li bd-info">'
									bestSellerList += '<div>'
										bestSellerList += '<span class="book-info">'+data.content[i].author+'</span>'
										bestSellerList += '<span class="book-info">'+data.content[i].publisher+'</span>'
										bestSellerList += '<span class="book-info">'+data.content[i].pubdate+'</span>'
										bestSellerList += '<span id="bookIsbn" hidden>'+data.content[i].isbn+'</span>'
									bestSellerList += '</div>'
									bestSellerList += '<span class="bestSeller">베스트셀러</span>'
								bestSellerList += '</li>'
								
								bestSellerList += '<li class="grid-li bd-price">'
									bestSellerList += '<div>'
										bestSellerList += '<span class="book-price">'+data.content[i].price+' 원</span> → <span class="discount">'+data.content[i].discount+' 원</span>'
									bestSellerList += '</div>'
								bestSellerList += '</li>'
									
								bestSellerList += '<li class="grid-li bd-review">'
									bestSellerList += '<div class="book-review">'
										bestSellerList += '<div class="star-box">'
											bestSellerList += '<div class="total-star">'
												bestSellerList += '<div class="starValue star-fill" >'
												
													if (data.content[i].reviewRating == null) {
														var int_part = 0.0;
													} else {
														var int_part = Math.trunc(data.content[i].reviewRating);														
													}
													var float_part = Number(Number((data.content[i].reviewRating-int_part).toFixed(2)));
													
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
													
													switch(float_part) {
													case 0.0 :
														$('.star-fill').children().last().css({'width':'0%','overflow':'hidden'});
														break;
													case 0.1 :
														$('.star-fill').children().last().css({'width':'4%','overflow':'hidden'});
														break;
													case 0.2 :
														$('.star-fill').children().last().css({'width':'6%','overflow':'hidden'});
														break;
													case 0.3 :
														$('.star-fill').children().last().css({'width':'7.2%','overflow':'hidden'});
														break;
													case 0.4 :
														$('.star-fill').children().last().css({'width':'8.1%','overflow':'hidden'});
														break;
													case 0.5 :
														$('.star-fill').children().last().css({'width':'8.9%','overflow':'hidden'});
														break;
													case 0.6 :
														$('.star-fill').children().last().css({'width':'9.9%','overflow':'hidden'});
														break;
													case 0.7 :
														$('.star-fill').children().last().css({'width':'11.25%','overflow':'hidden'});
														break;
													case 0.8 :
														$('.star-fill').children().last().css({'width':'12.5%','overflow':'hidden'});
														break;
													case 0.9 :
														$('.star-fill').children().last().css({'width':'13.8%','overflow':'hidden'});
														break;
													}
												
												bestSellerList += '</div>'
												bestSellerList += '<div class="star-base">'
													bestSellerList += '<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>'
												bestSellerList += '</div>'
											bestSellerList += '</div>'
											bestSellerList += '<span class="total-value">'
												bestSellerList += '('+data.content[i].reviewRating+')' 
											bestSellerList += '</span>'
										bestSellerList += '</div>'
										
										bestSellerList += '<div class="total-comment">(<a href="">'
										if( data.content[i].reviewCount == null ) {
											bestSellerList += 0
										} else {
											bestSellerList += data.content[i].reviewCount
										}
										bestSellerList += '</a>)</div>'
									bestSellerList += '</div>'
								bestSellerList += '</li>'
							bestSellerList += '</ul>'
						bestSellerList += '</div>'
					bestSellerList += '</td>'
					
					bestSellerList += '<td class="td-info" >'
						bestSellerList += '<div class="buttonWrap">'
							bestSellerList += '<input id="idP" type="hidden" name="id" value="${id }"/>'
							bestSellerList += '<input id="imageP" type="hidden" name="image" value="'+data.content[i].image+'"/>'
							bestSellerList += '<input id="titleP" type="hidden" name="title" value="'+data.content[i].title+'" />'
							bestSellerList += '<input id="priceP" type="hidden" name="price" value="'+data.content[i].price+'"/>'
							bestSellerList += '<input id="d_priceP" type="hidden" name="d_price" value="'+data.content[i].discount+'"/>'
							bestSellerList += '<input type="text" id="isbnP" name="isbn" value="'+data.content[i].isbn+'" hidden/>'

							bestSellerList += '<div>'
								bestSellerList += '<button class="cart btn" id="insertBtn" onclick="insert()">장바구니</button>'
							bestSellerList += '</div>'
							bestSellerList += '<div>'
								bestSellerList += '<button class="buy btn" id="directBtn" onclick="direct()">바로구매</button>'
							bestSellerList += '</div>'
						bestSellerList += '</div>'
					bestSellerList += '</td>'
				bestSellerList += '</tr>'
				bestSellerList += '<tr></tr>'
			}
				bestSellerList += '<tr id="tr-load"></tr>'
				
			$("#bestSellerList").html(bestSellerList);
		},
		error : function(data) {
			console.log("오류");
		}
	});


	$("#insertBtn, #directBtn, #reviewBtn").click(function(){
		if("${sessionScope.id}" == '') {
			alert("로그인이 필요합니다.");
			document.getElementById('modal-open').click();
			return false;
		}	
	});

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
	
	var isbn = $('#bookIsbn').text();
	// by 준익, 리뷰 평균 평점 호출 api
	/*
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/review/rating/"+isbn,
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			var dataText = "("+data+")";
			var int_part = Math.trunc(data);
			var float_part = Number(Number((data-int_part).toFixed(2)));
			var intValue = "";
			//숫자형 평점을 total-value 에 출력
			$('.total-value').html(dataText);
			
			//평점의 정수부분 +1개 만큼 별 생성하고
			switch(int_part) {
			case 0 :
				intValue += ('<span>★</span>')
				break;
			case 1 :
				intValue += ('<span>★</span><span>★</span>')
				break;
			case 2 :
				intValue += ('<span>★</span><span>★</span><span>★</span>')
				break;
			case 3 :
				intValue += ('<span>★</span><span>★</span><span>★</span><span>★</span>')
				break;
			case 4 :
				intValue += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
				break;
			case 5 :
				intValue += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
				break;
			}
			$('.starValue').html(intValue);
			//평점의 소수부분 만큼 마지막 별점을 커스텀한다
			switch(float_part) {
			case 0.0 :
				$('.star-fill').children().last().css({'width':'0%','overflow':'hidden'});
				break;
			case 0.1 :
				$('.star-fill').children().last().css({'width':'4%','overflow':'hidden'});
				break;
			case 0.2 :
				$('.star-fill').children().last().css({'width':'6%','overflow':'hidden'});
				break;
			case 0.3 :
				$('.star-fill').children().last().css({'width':'7.2%','overflow':'hidden'});
				break;
			case 0.4 :
				$('.star-fill').children().last().css({'width':'8.1%','overflow':'hidden'});
				break;
			case 0.5 :
				$('.star-fill').children().last().css({'width':'8.9%','overflow':'hidden'});
				break;
			case 0.6 :
				$('.star-fill').children().last().css({'width':'9.9%','overflow':'hidden'});
				break;
			case 0.7 :
				$('.star-fill').children().last().css({'width':'11.25%','overflow':'hidden'});
				break;
			case 0.8 :
				$('.star-fill').children().last().css({'width':'12.5%','overflow':'hidden'});
				break;
			case 0.9 :
				$('.star-fill').children().last().css({'width':'13.8%','overflow':'hidden'});
				break;
			}
		},
		error : function(data) {
		}
	});
	*/
	
</script>
</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/conditionSearch.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
</style>
</head>	
<body>
	<div class="layout">
		<div class="listWrap">
			<h2 class="notice-box">
                  "<b id="keyword">${keyword }</b>" 에 대한 검색결과는 
				<b><span id="total"></span></b>개의 상품이 검색되었습니다.
			</h2>
			<div class="search-box">
				<ul class="sortBar">
					<li class="item"><a id="simSort" class="search-sort" href="#" onclick="bookSearchPaging(0, 'sim')">관련도 순<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a id="countSort" class="search-sort" href="#" onclick="bookSearchPaging(0, 'count')">판매량 순 <img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<li class="item"><a id="dateSort" class="search-sort" href="#" onclick="bookSearchPaging(0, 'date')">신상품 순<img src="//image.aladin.co.kr/img/megaseller/megaseller_rank_dw1.gif" alt="" align="absmiddle"></a></li>
					<div class="date-box">
						<span id="date"></span>
					</div>
				</ul>
			</div>
			<form action="">
				 <div class="book-box">
				 	<table id="bookSearchList">
				 		<colgroup>
				 			<col style="width:37px;">
				 			<col style="width:150px;">
				 			<col style="width:623px;">
				 			<col style="width:105px;">
				 		</colgroup>
						<tbody id="bookSearchBody">
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
				 	<div id="page" class="bottom-bar"></div>
	 				<div id="topButton"><img id="topButtonImg" src="https://image.aladin.co.kr/img/bu/btn_top2.png" alt="맨위로"></div>
				 </div>
			</form>
		</div>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>	
<script>
	// 선택한 정렬에 active 추가
	$(".sortBar").children().children().on("click", (event) => {
		$(".sortBar").children().children().removeClass('active');
		event.target.className += " active";
	});

	function bookSearchPaging(start, sort){
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/book-search?keyword=${keyword}&page="+start+"&sort="+sort,
			method:"GET",
			dataType : "json",
			async: false,
			success:function(data) {
				$("#total").html(data.totalElements);
				var bookSearchList = "";
				for (var i = 0; i < data.content.length; i++) {
					bookSearchList += '<tr>'
						bookSearchList += '<td class="td-info">'
							bookSearchList += '<div class="book-rank"></div>'
						bookSearchList += '</td>'
						
						bookSearchList += '<td>'
							bookSearchList += '<div>'
								bookSearchList += '<a href="${pageContext.request.contextPath }/bookDetail.do?d_isbn='+data.content[i].isbn+'"><img src="'+data.content[i].image+'" class="book-img"></a>'
							bookSearchList += '</div>'
						bookSearchList += '</td>'
						
						bookSearchList += '<td class="td-info" >'
							bookSearchList += '<div class="infoWrap">'
								bookSearchList += '<ul>'
									bookSearchList += '<li class="grid-li bd-title">'
										bookSearchList += '<span class="book-title">'+data.content[i].title+'</span>'
									bookSearchList += '</li>'
									
									bookSearchList += '<li class="grid-li bd-info">'
										bookSearchList += '<div>'
											bookSearchList += '<span class="book-info">'+data.content[i].author+'</span>'
											bookSearchList += '<span class="book-info">'+data.content[i].publisher+'</span>'
											bookSearchList += '<span class="book-info">'+data.content[i].pubdate+'</span>'
											bookSearchList += '<span id="bookIsbn" hidden>'+data.content[i].isbn+'</span>'
										bookSearchList += '</div>'
									bookSearchList += '</li>'
									
									bookSearchList += '<li class="grid-li bd-price">'
										bookSearchList += '<div>'
											bookSearchList += '<span class="book-price">'+data.content[i].price+' 원</span>'
											if(data.content[i].discount != ""){
												bookSearchList += '→ <span class="discount">'+data.content[i].discount+' 원</span>'
											}
										bookSearchList += '</div>'
									bookSearchList += '</li>'
										
									bookSearchList += '<li class="grid-li bd-review">'
										bookSearchList += '<div class="book-review">'
											bookSearchList += '<div class="star-box">'
												bookSearchList += '<div class="total-star">'
													
														if(data.content[i].reviewRating == null || data.content[i].reviewRating == 0){
															var int_part = 0;
															var float_part = parseFloat(0).toFixed(1);
														}else{
															var int_part = Math.trunc(data.content[i].reviewRating);	
															var float_part = Number((data.content[i].reviewRating-int_part).toFixed(1));															
														}
													bookSearchList += '<div class="starValue star-fill'+(float_part*10)+'" >'
														
														//평점의 정수부분 +1개 만큼 별 생성하고
														switch(int_part) {
														case 0 :
															bookSearchList += ('<span>★</span>')
															break;
														case 1 :
															bookSearchList += ('<span>★</span><span>★</span>')
															break;
														case 2 :
															bookSearchList += ('<span>★</span><span>★</span><span>★</span>')
															break;
														case 3 :
															bookSearchList += ('<span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														case 4 :
															bookSearchList += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														case 5 :
															bookSearchList += ('<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>')
															break;
														}
														
													bookSearchList += '</div>'
													bookSearchList += '<div class="star-base">'
														bookSearchList += '<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>'
													bookSearchList += '</div>'
												bookSearchList += '</div>'
												bookSearchList += '<span class="total-value">'
													bookSearchList += '('
															if ( data.content[i].reviewRating == null ){
																bookSearchList += 0; 
															} else {
																bookSearchList += Math.round(data.content[i].reviewRating * 10)/10; 
															}
													bookSearchList += ')'
												bookSearchList += '</span>'
											bookSearchList += '</div>'
											
											bookSearchList += '<div class="total-comment">(<a href="">'
											if( data.content[i].reviewCount == null ) {
												bookSearchList += 0
											} else {
												bookSearchList += data.content[i].reviewCount
											}
											bookSearchList += '</a>)</div>'
										bookSearchList += '</div>'
									bookSearchList += '</li>'
								bookSearchList += '</ul>'
							bookSearchList += '</div>'
						bookSearchList += '</td>'
						
						bookSearchList += '<td class="td-info" >'
							bookSearchList += '<div class="buttonWrap">'
								bookSearchList += '<input id="idP'+i+'" type="hidden" name="id" value="${id }"/>'
								bookSearchList += '<input id="imageP'+i+'" type="hidden" name="image" value="'+data.content[i].image+'"/>'
								bookSearchList += '<input id="titleP'+i+'" type="hidden" name="title" value="'+data.content[i].title+'" />'
								bookSearchList += '<input id="priceP'+i+'" type="hidden" name="price" value="'+data.content[i].price+'"/>'
								bookSearchList += '<input id="d_priceP'+i+'" type="hidden" name="d_price" value="'+data.content[i].discount+'"/>'
								bookSearchList += '<input id="publisherP'+i+'" type="hidden"  name="publisher" value="'+data.content[i].publisher+'" />'
								bookSearchList += '<input id="authorP'+i+'" type="hidden"  name="author" value="'+data.content[i].author+'" />'
								bookSearchList += '<input id="isbnP'+i+'" type="hidden"  name="isbn" value="'+data.content[i].isbn+'" />'
								bookSearchList += '<input id="countP'+i+'"  type="hidden"  name="count" value="1" />'

								bookSearchList += '<div>'
									bookSearchList += '<button class="cart btn" type="button" id="insertBtn" onclick="insert('+i+')">장바구니</button>'
								bookSearchList += '</div>'
								bookSearchList += '<div>'
									bookSearchList += '<button class="buy btn" type="button" id="directBtn" onclick="direct('+i+')">바로구매</button>'
								bookSearchList += '</div>'
							bookSearchList += '</div>'
						bookSearchList += '</td>'
					bookSearchList += '</tr>'
					bookSearchList += '<tr></tr>'
				}

				$("#bookSearchBody").html(bookSearchList);
				var pagingWrap = "";

				pagingWrap += '<nav id = "paging">'					
				pagingWrap += '</nav>'					
				
				$("#page").html(pagingWrap);
				
				var totalPages = 0;
				if(data.totalPages > 100) {
					totalPages = 100;
				} else {
					totalPages = data.totalPages;
				}
				
				window.pagObj = $('#paging').twbsPagination({ 
					totalPages: totalPages, // 호출한 api의 전체 페이지 수 
					startPage: data.number+1, 
					visiblePages: 5, 
					prev: "‹", 
					next: "›", 
					first: '«', 
					last: '»', 
					onPageClick: function (event, page) { 
					} 
				}).on('page', function (event, page) { 
					var sortValue = $(".sortBar").find(".active").attr('id');
					if(sortValue == null){
						sortValue = "sim";
					}
					bookSearchPaging(page-1, sortValue);
				});	
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}
	
	bookSearchPaging(0,"sim");

	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString() + '&nbsp; 기준');
	
	
	
	 //by준영, 장바구니 로그인 필터 기능_210311
    //by준영, 장바구니로 페이지이동없이 담고 바로 이동할지 묻는 컨펌 로직_210315
    
    console.log(id);
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
       
       var url ="${pageContext.request.contextPath }/pay/insert.do";
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
             url:url,
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
       
       var url ="${pageContext.request.contextPath }/pay/insert.do";
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
             url:url,
             method:'post',
             data: data,
             success:function(data){
                location.href = "${pageContext.request.contextPath }/pay/pay.do";
             }
          })
       }   
    }
</script>
</body>
</html>



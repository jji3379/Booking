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
                  <div class="total-star" id="starValue">★★★★★</div>
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
               <div class="finishLine"></div>
            </div>
         </div>
         <div class="shipping">
            <div class="ship-L">배송안내</div>
            <div class="ship-R">
               <ul class="ship-guide">
                      <li><p>북킹 상품은 택배로 배송되며, 출고완료 1~2일내 상품을 받아 보실 수 있습니다.</p></li>
                      <li><p>출고가능 시간이 서로 다른 상품을 함께 주문할 경우 출고가능 시간이 가장 긴 상품을 기준으로 배송됩니다.</p></li>
                      <li><p>군부대, 교도소 등 특정기관은 우체국 택배만 배송가능합니다.</p></li>
                      <li><p>배송비는 업체 배송비 정책에 따릅니다.</p></li>
                      <li><p>도서 구매 시, 1만 원 이상 무료, 1만원 미만 2천 원</p></li> 
                      <li><p>상품별 배송비가 있는 경우, 상품별 배송비 정책 적용</p></li> 
                  </ul>
                  <div class="finishLine"></div>
            </div>
         </div>
         <div class="reviewWrap">
            <div class="review-L">
               마이 리뷰
            </div>
            <div class="review-R">
               <div class="review-box">
                  <div class="head-star review-top">
                     <p>별점</p>
                     <div class="total-star">★★★★★</div>
                     <span class="total-value" id="total-value">3.5</span>
                     <p class="total-count"> ( 총 <span id="total-count">2</span> 건 )</p>
                  </div>
                  <ul class="sortWrap">
                     <li class="review-sort">
                        <a href="#" onclick="pagingList(0, 'regdate')">
                           최근순
                        </a>
                     </li>
                     <li class="review-sort">
                        <a href="#" onclick="pagingList(0, 'rating')">
                           별점순
                        </a>
                     </li>
                  </ul>
                  <ul class="reviewList">
                     <!-- 더미 2 -->
                     <li>    
                        <div class="title-box">        
                           <div class="star-box">            
                              <div class="star_off">
                                 <span class="star-value">★★★★☆</span>
                              </div>       
                           </div>           
                           <span class="reviewTitle-box">reviewTitle</span> 
                           <span class="spoCheck-box">스포일러</span>          
                           <div class="idDate-box">            
                              <span class="review-writer">catcat3</span>            
                              <span class="review_date">2021/12/25</span>        
                           </div>    
                        </div>    
                        <div class="content-box">        
                           <div id="content${tmp.id }" class="spoAlert">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas officiis quisquam corporis cupiditate dolore beatae unde vitae tempore dolores velit. Perferendis itaque debitis delectus asperiores expedita labore ea minus necessitatibus. </div>            
                           <div class="replyCount">        
                              댓글<span>(0)</span>  
                              <a data-num="${tmp.id }" href="javascript:" id="more">> 펼쳐보기</a> 
                              
                           </div>
                        </div>    
                     </li>
                  </ul>
                  <div class="review-paging">
                    <nav id = "paging">
                  	</nav>
                  </div>   
               </div>
            </div>
         </div>
      </div>
       </c:forEach>
       <!-- <div id="reviewList"></div>-->
      </div>
<script src="${pageContext.request.contextPath}/resources/js/jquery.twbsPagination.js"></script>
<script>
	// by 준익, 페이징 처리된 책에 대한 리뷰 리스트
	function pagingList(page, sort) {
		var isbn = $("#isbnP").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/bookReview/"+isbn+"?page="+page+"&sort="+sort,
			method:"GET",
			dataType : "json",
			async: false,
			success:function(data) {
				$("#total-count").html(data.totalElements);
				// item list
				var reviewList = "";
				for(var i=0; i<data.content.length; i++) {
					reviewList += '<li>'
						reviewList += '<div class="title-box">'
							reviewList += '<div class="star-box">'
								reviewList += '<div class="star_off">'
									reviewList += '<span class="star-value">'+data.content[i].rating+'</span>'
								reviewList += '</div>'
							reviewList += '</div>'
							reviewList += '<span class="reviewTitle-box">'+data.content[i].reviewTitle+'</span>'
							reviewList += '<div class="idDate-box">'
								reviewList += '<span class="review-writer">'+data.content[i].writer.loginId+'</span>'
								reviewList += '<span class="review_date">'+data.content[i].regdate+'</span>'
							reviewList += '</div>'
						reviewList += '</div>'
						reviewList += '<div class="content-box">'
							reviewList += '<div id="content${tmp.id }" class="moreTxt-off">'+data.content[i].content+'</div>'
								// 댓글 총 개수
								$.ajax({
									url:"${pageContext.request.contextPath}/v1/review/reply/"+data.content[i].id,
									method:"GET",
									dataType : "json",
									async: false,
									success:function(data) {
							reviewList += '<div class="replyCount">댓글<span>('+data+')</span>'
									},
									error : function(data) {
										console.log("오류");
									}
								});
							
							reviewList += '<a data-num="${tmp.id }" href="javascript:" id="more">> 펼쳐보기</a>'
							reviewList += '</div>'
						reviewList += '</div>'
					reviewList += '</li>'
					
				}
				$(".reviewList").html(reviewList);
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}
	// by 준익, 초기 리뷰 리스트 호출
	pagingList(0, 'regdate');
	var isbn = $("#isbnP").val();
	// by 준익, 페이징 스크립트 적용
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/bookReview/"+isbn,
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			window.pagObj = $('#paging').twbsPagination({ 
				totalPages: data.totalPages, // 호출한 api의 전체 페이지 수 
				startPage: data.number+1, 
				visiblePages: 5, 
				prev: "‹", 
				next: "›", 
				first: '«', 
				last: '»', 
				onPageClick: function (event, page) { 
					console.info("current page : " + page); 
				} 
			}).on('page', function (event, page) { 
				pagingList(page-1);
			});
		},
		error : function(data) {
			console.log("오류");
		}
	});
	// by 준익, 리뷰 평균 평점 호출 api
	$.ajax({
		url:"${pageContext.request.contextPath}/v1/review/rating/"+isbn,
		method:"GET",
		dataType : "json",
		async: false,
		success:function(data) {
			$("#total-value").html(data);
			$("#starValue").html(data);
		},
		error : function(data) {
			console.log("오류");
		}
	});

    //by 준영, 이 저자의 책들을 불러오는 ajax 호출 함수_210222
    var inputAuth=$("#auth").text();
    function bookAuthor(){
        $.ajax({ 
           url:"detailAjax.do?sort=sim",
            method:"GET",
            data:"d_auth="+inputAuth,
            success:function(data){
               $("#simList").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
            },
            
        })
    }
    bookAuthor();
    
    //by준영, 리뷰 폴드 기능
    /* $(document).on('click','#more', function(){
       var contents = '#content'+$(this).attr('data-num');

       if($(contents).hasClass('moreTxt-off') == true) {
          $(contents).attr('class','moreTxt-on');
       }else if($(contents).hasClass('moreTxt-off') == false){
          $(contents).removeClass('moreTxt-on');
          $(contents).attr('class', 'moreTxt-off');
       }
       if($(this).text("> 펼쳐보기")){
          if($(contents).hasClass('spoAlert') == true){
             var alert = confirm("스포가 포함된 리뷰입니다. 읽으시겠습니까?");
             if(alert == true){
             }else{
                event.preventDefault();
             }
          $(this).text("> 접기");
       }else if($(this).text("> 접기")){
          $(this).text("> 펼쳐보기"); 
       })   
    })
     */
 
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
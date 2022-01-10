<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css">
<style>

</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<h4>안녕하세요 ,</h4>
			<span>catacat3 </span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="my_review.do">
					<dl id="top-post" class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count">3</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="my_reply.do">
					<dl id="top-reply" class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count">3</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="${pageContext.request.contextPath }/pay/cart.do">
					<dl class="card">
						<dt class="label">
							<span>북카트 ></span>
						</dt>
						<dd class="value">
							<span class="count">0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="navigation">
			<div class="section">
				<div class="section-name">나의 쇼핑</div>
				<div class="linkList">
					<a id="side-order" class="link" href="my_order.do">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="updateform.do">계정정보 수정</a>
					<a id="side-pwd" class="link" href="pwd_updateform.do">비밀번호 수정</a>
					<a id="side-recent" class="link" href="recentSearch.do">최근 검색 기록</a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">북킹 소개</div>
			</div>
			<button class="logoutBtn">
				<div>로그아웃</div>
			</button>
		</div>
		<div class="content">
			<ul class="content-list">
				<li class="part">
					<div class="part-header">
						<span>최근 주문내역</span>
						<a href="">주문전체보기 ></a>
					</div>
					<div id="myOrder" class="part-body">
						<table>
							<colgroup>
								<col style="width:60%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div>총 1개 상품</div>
									</td>
									<td>
										<div>2021/10/10</div>
									</td>
									<td>
										<div class="order-num">1234567890</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
				<li class="part">
					<div class="part-header">
						<span>내 계정 정보</span>
						<a href="">변경하기 ></a>
					</div>
					<div class="part-body">
						<div class="info-account">
							<span>아이디</span>
							<input type="text" value="catcat3" disabled/>
							<br />
							<span>이메일</span>
							<input type="text" value="catcat3@naver.com" disabled/>
							<br />
							<span>관심사</span>
							<input type="text" value="고양이 ," disabled/>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
<script>
	//by준영, 현재시간 출력
	let today = new Date();
	
	$('#date').html(today.toLocaleString());
	

	$('#top-post').on('click',function(){
		function myPost(){
		    $.ajax({ 
		       	url:"my_review.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	$('#top-reply').on('click',function(){
		function myReply(){
		    $.ajax({ 
		       	url:"my_reply.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	$('#side-order').on('click',function(){
		function my_order(){
		    $.ajax({ 
		       	url:"${pageContext.request.contextPath}/v1/users/myOrder/${sessionScope.id}",
		        method:"GET",
		        success:function(data){
		        	var orderList = "";
			        	orderList += '<div class="content">'
				        	orderList += '<div class="order-box">'
					        	orderList += '<h2>주문 내역</h2>'
					        	orderList += '<div class="myOrder-dateSort">'
					        		orderList += '<div class="myOrder-dateSort-main">'
						        		orderList += '<a href="javascript:">1주일</a>'
					        			orderList += '<a href="javascript:">1개월</a>'
				        				orderList += '<a href="javascript:">3개월</a>'
				        				orderList += '<a href="javascript:">전체기간</a>'
					  				orderList += '</div>'
					  				orderList += '<div class="datepicker-div">'
					  					orderList += '<input type="text" class="datepicker" id="datepicker1" placeholder="-"/>'
					        			orderList += '<img class="datepickerBtn" src="${pageContext.request.contextPath}/resources/images/calendar.svg" alt="날짜 선택" title="날짜 선택">'
					  				orderList += '</div>'
					  				orderList += '<div class="datepicker-div">'
					  					orderList += '<input type="text" class="datepicker" id="datepicker2" placeholder="-"/>'
					        			orderList += '<img class="datepickerBtn" src="${pageContext.request.contextPath}/resources/images/calendar.svg" alt="날짜 선택" title="날짜 선택">'
					  				orderList += '</div>'
					        		orderList += '<button type="button" class="dateBtn">조회</button>'
					        	orderList += '</div>'
					        	orderList += '<div class="order-th">'
					        		orderList += '<div class="order-th-L">주문번호 / 일자</div>'
			        				orderList += '<div class="order-th-R">주문금액(수량)</div>'
					        	orderList += '</div>'
					        	orderList += '<ul class="order-list">'
					        	
					        	for (var i=0; i<data.length; i++) {
						        	orderList += '<li class="order">'
							        	orderList += '<a id="orderDetail'+[i]+'" href="javascript:">'
								        	orderList += '<div class="order-td-L">'
									        	orderList += '<div class="myOrder-num">'+data[i].o_date.replace('-','').replace('-','').slice(0,8)+(data[i].id+"").padStart(8,'0')+'</div>'
									        	orderList += '<div class="myOrder-date">'+data[i].o_date+'</div>'	
									        orderList += '</div>'
									        orderList += '<div class="order-td-R">'
									        	orderList += '<div class="myOrder-price">'+data[i].o_price+'</div>'
									        	orderList += '<div class="myOrder-count">'+data[i].o_count+'</div>'				
									        orderList += '</div>'
								        	orderList += '<span class="detailBtn">></span>'
							        	orderList += '</a>'
						        	orderList += '</li>'
					        	}
					        	orderList += '</ul>'
					        orderList += '</div>'
					        orderList += '<nav id="paging">'
					        orderList += '<ul class="pagination justify-content-center">'
					        	orderList += '<li class="page-item disabled">'
					        		orderList += '<a class="page-link" href="</a>'
					        	orderList += '</li>'
				        		orderList += '<li class="page-item">'
					        		orderList += '<a class="page-link" href="reviewList.do?pageNum=0&amp;condition=&amp;keyword=">0</a>'
					        	orderList += '</li>'
				        		orderList += '<li class="page-item disabled">'
					        		orderList += '<a class="page-link" href="javascript:">&gt;</a>'
					        	orderList += '</li>'
					        orderList += '</ul>'
					    orderList += '</nav>'
					        	
			        	orderList += '</div>'
		            $(".content").html(orderList); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
	            
		        },
		        
		    })
		}
	})
	
	//sidebar ajax
	$('#side-profile').on('click',function(){
		function updateProfile(){
		    $.ajax({ 
		       	url:"updateform.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	$('#side-pwd').on('click',function(){
		function updatePwd(){
		    $.ajax({ 
		       	url:"pwd_updateform.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	$('#side-recent').on('click',function(){
		function recentSearch(){
		    $.ajax({ 
		       	url:"recentSearch.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
	})
	
	
	
	//회원탈퇴묻기
	function deleteConfirm(){
		let isDelete=confirm(" 회원님 정말로 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath}/users/private/delete.do";
		} else {
			location.reload();
		}
	}
	
</script>
</body>
</html>
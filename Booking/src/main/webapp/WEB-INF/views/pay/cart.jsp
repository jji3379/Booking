<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	button.btn{
      background-color:#135fa1;
      color:white;
   }
   button.plus{
   		 width: 30px;
	    height: 30px;
	    text-align: center;
	    padding: 6px 0;
	    font-size: 12px;
	    line-height: 1.428571429;
	    border-radius: 15px;
   }
    button.minus{
   		 width: 30px;
	    height: 30px;
	    text-align: center;
	    padding: 6px 0;
	    font-size: 12px;
	    line-height: 1.428571429;
	    border-radius: 15px;
   }
   .pay{
   		text-align:center;
   		width:100%;
    	height:100%;
   }
	table.type09 {
		border-collapse: collapse;
		text-align: left;
		line-height: 1.5;
		border-collapse:collapse; border:3px #0f4c81 solid;
		margin-bottom:50px;
		width:800px;
		height:100px;
		margin:0 auto;
		margin-bottom:20px;
	}
	table.type09 thead th {
	  padding: 10px;
	  font-weight: bold;
	  vertical-align: top;
	  color: #135fa1;
	  border-bottom: 1px solid #036;
	}
	table.type09 tbody th {
	  width: 150px;
	  padding: 10px;
	  font-weight: bold;
	  vertical-align: top;
	  border-bottom: 1px solid #ccc;
	  background: #f3f6f7;
	}
	table.type09 td {
	  width: 350px;
	  padding: 10px;
	  vertical-align: top;
	  border-bottom: 1px solid #ccc;
	}
	#selectDeleteBtn{
		margin-bottom:5px;
		margin-left:10px;
		
		
	}
	 
  
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body  style="font-size:18px; font-family: 'Roboto', sans-serif;">
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
	<div class="jumbotron">
	    
	    <hr class="my-4">
	    <h2>북카트  &nbsp;<span class="badge badge-warning">쇼핑중</span></h2>
	</div>
	
	
	<span class="deleteBtn">
		<button id="selectDeleteBtn" type="submit" class="btn" class="selectDelete_btn" onClick="deleteChk(this)" >선택 삭제</button> 
	</span>
	<script>
		//by준영, 체크박스 선택한 값을 읽어서 삭제한는 ajax로직_210311
		function deleteChk(){
			var url ="deleteCart.do";
			var valueArr = new Array();
			var list =$("input[name='chBox']");
			for(var i=0; i< list.length; i++){
				if(list[i].checked){//선택되어 있으면 배열에 값을 저장
					valueArr.push(list[i].value);	
				}
			}
			if(valueArr.length == 0){
				alert("선택된 항목이 없습니다.");
			}else{
				var chk = confirm("정말 삭제하시겠습니까");
				$.ajax({
					url:url,
					type:'post',
					traditional :true,
					data:{'valueArr' : valueArr},
					success:function(){
						if(chk){
							location.replace("cart.do");	
						}else{
							return false;
						}
						
					}
				})
			}
		}
		
	</script>
	<table class="table" style=border-bottm-style:dotted;>
	    <thead class="thead-light">
	    <tr>
	      <th>
		  	<span class="allCheck">
				<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">&nbsp; #</label> 
			</span>
			<script>
			//by준영, 체크박스 전체선택,전체해제 기능_210307
				$("#allCheck").click(function(){
					var chk = $("#allCheck").prop("checked");
					if(chk) {
						$(".chBox").prop("checked", true);
					} else {
						$(".chBox").prop("checked", false);
					}
				});
			</script>
		  </th>
	      <th></th>
	      <th>도서명</th>
	      <th>가격</th>
	      <th>할인가</th>
	      <th>수량</th>
	      <th>금액</th>
	      <th></th>
	      <th></th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="c" items="${list}" varStatus="status">
	        <tr>
	        	<c:if test="${fn:length(list) eq 0}">
	        		<td align="center">북카트가 비었습니다</td>
	        	</c:if>
	        		<td>
        				<div class="checkBox">
							<input type="checkbox" name="chBox" class="chBox" value="${c.c_id }"/>
						</div>
		        	</td>
		            <td><img src="${c.image}"/></td>
		            <td>${c.title}</td>
		            <td>${c.price }</td>
		            <td><font color="red">${c.d_price }</font></td>
		            <td>
			            <form action="update.do" method="post">
			            	<input type="hidden" name="c_id" value="${c.c_id }" />
			            	<button type="button" class="minus" class="btn btn-secondary" >-</button>
			            	<input type="number" name="count" class="numBox" class="btn"  min="1" max="100" value="${c.count }" readonly="readonly"/>
			            	<button type="button" class="plus" class="btn btn-secondary" >+</button>
			            	<button id="updateBtn" class="btn btn-secondary" type="submit" onClick="submit(this)" >변경</button>
			            </form>
		            </td>
		            <td>${c.price * c.count}</td>
		            <!-- 갯수*물품가 의 배열의 합 -->
		            <c:set var= "sum" value="${sum + (c.price * c.count)}"/>
		            <form action="delete.do" method="post">
		            	<input name="c_id" type="hidden" value="${c.c_id}" />
		            	<td><button type="submit" class="btn" class="deleteBtn"   onClick="submit(this)" >삭제</button></td>
		            </form>
	        </tr>
	        
	    </c:forEach>
	  </tbody>
	</table>
	<div class="pay">
		<table class="type09" >
			<thead>
				<th>상품 가격</th>
				<th>배송비&nbsp;(2만원 이상 무료배송)</th>
				<th><strong>총 결제금액</strong></th>
			</thead>
			<tbody>
				<td id="price" ><c:out value="${sum }"></c:out><span>원</span></td>
				<td id="shipFee"></td>
				<td id="total"></td>
			</tbody>
		</table>
		<button id="check_module" type="button"  class="btn btn-lg " >주문하기</button>
		<button href="home.do" type="button"  class="btn btn-lg" style=background-color:#484848; >쇼핑 계속하기</button>
	</div>
</body>
<script>
	//by준영, 결제api 세팅_210311
	//by준영, 배송비 책정로직_210317
	var price=$("#price").text();//물품가격
	var shipFee=null;
	var total=null;
	if(price == "원"){
		$("#shipFee").text("원");
		$("#total").text("원");
	}else{
		if(parseInt(price) >= 20000){
			shipFee=0;
			$("#shipFee").text(shipFee+"원");
		}else{
			shipFee=2500;
			$("#shipFee").text(shipFee+"원");
		}
		total=parseInt(price)+shipFee;
		$("#total").text(total+"원");
	}
		
	
	$("#check_module").click(function () {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp02317087');
		// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
		IMP.request_pay({
			pg: 'inicis', // version 1.1.0부터 지원.
				/*
					'kakao':카카오페이,
					html5_inicis':이니시스(웹표준결제)
					'nice':나이스페이
					'jtnet':제이티넷
					'uplus':LG유플러스
					'danal':다날
					'payco':페이코
					'syrup':시럽페이
					'paypal':페이팔
				*/
			pay_method: 'card',
				/*
					'samsung':삼성페이,
					'card':신용카드,
					'trans':실시간계좌이체,
					'vbank':가상계좌,
					'phone':휴대폰소액결제
				*/
			merchant_uid: 'merchant_' + new Date().getTime(),
				/*
					merchant_uid에 경우
					https://docs.iamport.kr/implementation/payment
					위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
					참고하세요.
					나중에 포스팅 해볼게요.
				*/
			name: '도서',
				//결제창에서 보여질 이름
			amount: total,
				
			buyer_email: 'iamport@siot.do',
			buyer_name: '구매자이름',
			buyer_tel: '010-1234-5678',
			buyer_addr: '서울특별시 강남구 삼성동',
			buyer_postcode: '123-456',
			m_redirect_url: 'https://www.yourdomain.com/payments/complete'
				/*
					모바일 결제시,
					결제가 끝나고 랜딩되는 URL을 지정
					(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
				*/
		}, function (rsp) {
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
				location.href="order_insertform.do";
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});
	});

	
	//by준영 수량 +- 기능_210311-----------------------------
	$('.plus').click(function(){ 
		//증가버튼에 인접한 input type="number" 선택
		var  $input = $(this).parent().find("input[type=number]");
		//현재 숫자값
		var currentNumber = parseInt( $input.val() );
		if(currentNumber >= 100){
			currentNumber;
		}else{
			currentNumber++;//1 증가 시키기
			//증가 시킨값 다시 넣어주기
			$input.val( currentNumber );
		}
	});
	$('.minus').click(function(){ 
	//감소버튼에 인접한 input type="number" 선택
		var  $input = $(this).parent().find("input[type=number]");
		//현재 숫자값
		var currentNumber = parseInt( $input.val() );
		if(currentNumber <= 1){
			currentNumber;
		}else{
			currentNumber--;//1 감소시키기
			//감소 시킨값 다시 넣어주기
			$input.val( currentNumber );
		}
	});
	
	//by준영, 클릭한 항목 을 제출하는 기능_210314
	function submit(elClickedObj){
		elClickedObj.form.submit();
	}
	
	
	
</script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</html>
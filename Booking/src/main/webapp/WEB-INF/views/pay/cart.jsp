<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	 
</style>
<meta charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<script src="https://kit.fontawesome.com/df193849aa.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/cart.css">
</head>
<body>
<div class="layout">
	<div class="jumbotron">
	    <div class="breadcrumb">
			<ul class="steps">
		  		<li class="location">
	 		 		<span>BookCart</span> 주문하실 상품을 선택해 주세요.
		  		</li>
				<li class="active">
				  	<a >북카트</a>
				</li>
				<li class="step">
				  	<a>주문 / 결제</a>
				</li>
				<li class="step">
				  	<a>주문 완료</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="allCheckWrap">
		<span>
			<span class="allCheck">
				<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">전체선택</label> 
			</span>
			전체선택
			<button id="selectDeleteBtn" type="submit" class="selectDelete_btn" onClick="deleteChk(this)" >선택 삭제</button> 
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
	</div>	
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
	<table class="tb">
		<colgroup>
			<col style="width:10px"/>
			<col style="width:120px"/>
			<col style="width:560px"/>
			<col style="width:90px"/>
			<col style="width:90px"/>
			<col style="width:230px"/>
			<col style="width:100px"/>
			<col style="width:100px"/>
		</colgroup>
	    <thead>
	    <tr class="tr-th">
	      <th></th>
	      <th></th>
	      <th>도서명</th>
	      <th>가격</th>
	      <th>할인가</th>
	      <th>수량</th>
	      <th>금액</th>
	      <th></th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="c" items="${list}" varStatus="status">
	        <tr class="tr-td">
	        	<c:if test="${fn:length(list) == 0}">
	        		<td align="center">북카트가 비었습니다</td>
	        	</c:if>
	        		<td>
        				<div class="checkBox">
							<input type="checkbox" name="chBox" class="chBox" value="${c.id }"/>
						</div>
		        	</td>
		            <td><img class="bookImg" src="${c.image}"/></td>
		            <td class="td-title">${c.title}</td>
		            <td class="td-public">${c.price} 원</td>
		            <td class="td-public"><font color="red">${c.d_price}</font> 원</td>
		            <td class="td-public">
			            <form action="update.do" method="post">
			            	<input type="hidden" name="id" value="${c.id }" />
			            	<button type="button" class="minus btn">-</button>
							<input type="number" name="count" class="numBox" min="1" max="100" value="${c.count }" readonly="readonly" style="width:25px"/>
			            	<button type="button" class="plus btn">+</button>
			            	<button type="submit" class="updateBtn btn" onClick="submit(this)" >변경</button>
			            </form>
		            </td>
		            <td class="td-public">${c.d_price * c.count} 원</td>
		            <!-- 갯수*물품가 의 배열의 합 -->
		            <c:set var= "sum" value="${sum + (c.d_price * c.count)}"/>
				<td class="td-public">
					<form action="delete.do" method="post">
		            	<input name="id" type="hidden" value="${c.id}" />
		            	<button type="submit" class="btn deleteBtn"   onClick="submit(this)" >삭제</button>
					</form>
				</td>	
	        </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<div class="pay">
		<table class="pay-box" >
			<thead>
				<th>상품 가격</th>
				<th>배송비&nbsp;(2만원 이상 무료배송)</th>
				<th><strong>총 결제 예상금액</strong></th>
			</thead>
			<tbody>
				<td id="price" ><c:out value="${sum }"></c:out><span> 원</span></td>
				<td id="shipFee"></td>
				<td id="total"></td>
			</tbody>
		</table>
		<a id="home" type="button" class="btn homeBtn" href="${pageContext.request.contextPath }">계속 쇼핑하기</a>
		<a id="pay" type="button" class="btn payBtn" href="pay.do">주문하기</a>
	</div>
</div>
</body>
<script>
	//by준영, 배송비 책정로직_210317
	var price = $("#price").text();//물품가격
	var shipFee = null;
	var total = null;
	if(price == " 원"){
		$("#price").text("0 원");
		$("#shipFee").text("0 원");
		$("#total").text("0 원");
		$("a[id='pay']").click(function(){
			alert("1개 이상의 상품을 담아야 주문이 가능합니다");
			return false;
		});
	}else{
		if(parseInt(price) >= 20000){
			shipFee = 0;
			$("#shipFee").text(shipFee+" 원");
		}else{
			shipFee = 2500;
			$("#shipFee").text(shipFee+" 원");			
		}
		total=parseInt(price)+shipFee;
		$("#total").text(total+" 원");
	}
	
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
</html>
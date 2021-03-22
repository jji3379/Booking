<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	button.btn{
      background-color:#135fa1;
      color:white;
   }
   #pay{
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
	#home{
		background-color:#484848;
		color:white;
	}
	#title{
		max-width: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	 
  
</style>
<meta charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body  style="font-size:18px; font-family: 'Roboto', sans-serif;">
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="BS" name="thisPage"/>
</jsp:include>
<div style="width:70%; margin:auto">
		<div class="jumbotron" style="margin-top:30px">
	    
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
				<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label> 
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
	      
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="c" items="${list}" varStatus="status">
	        <tr>
	        	<c:if test="${fn:length(list) == 0}">
	        		<td align="center">북카트가 비었습니다</td>
	        	</c:if>
	        		<td style=width:3%;>
        				<div class="checkBox">
							<input type="checkbox" name="chBox" class="chBox" value="${c.c_id }"/>
						</div>
		        	</td>
		            <td style=width:10%;><img src="${c.image}"/></td>
		            <td id="title" style=width:40%;>${c.title}</td>
		            <td style=width:7%;>${c.price }</td>
		            <td style=width:7%;><font color="red">${c.d_price }</font></td>
		            <td style=width:20%;>
			            <form action="update.do" method="post">
			            	<input type="hidden" name="c_id" value="${c.c_id }" />
			            	<button type="button" class="minus" class="btn btn-secondary" >-</button>
			            	<input type="number" name="count" class="numBox" class="btn"  min="1" max="100" value="${c.count }" readonly="readonly"/>
			            	<button type="button" class="plus" class="btn btn-secondary" >+</button>
			            	<button id="updateBtn" class="btn btn-secondary" type="submit" onClick="submit(this)" >변경</button>
			            </form>
		            </td>
		            <td style=width:5%;>${c.d_price * c.count}</td>
		            <!-- 갯수*물품가 의 배열의 합 -->
		            <c:set var= "sum" value="${sum + (c.d_price * c.count)}"/>
				<td style=width:8%;>
					<form action="delete.do" method="post">
		            	<input name="c_id" type="hidden" value="${c.c_id}" />
		            	<button type="submit" class="btn" class="deleteBtn"   onClick="submit(this)" >삭제</button>
					</form>
				</td>	            
	            
	        </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<div class="pay">
		<table class="type09" >
			<thead>
				<th>상품 가격</th>
				<th>배송비&nbsp;(2만원 이상 무료배송)</th>
				<th><strong>총 결제 예상금액</strong></th>
			</thead>
			<tbody>
				<td id="price" ><c:out value="${sum }"></c:out><span>원</span></td>
				<td id="shipFee"></td>
				<td id="total"></td>
			</tbody>
		</table>
		<a id="pay" type="button"  class="btn btn-lg" href="pay.do">주문하기</a>
		<a  id="home" type="button"  class="btn btn-lg"	href="${pageContext.request.contextPath }/home.do">계속 쇼핑하기</a>
	</div>
</div>
</body>
<script>
	//by준영, 배송비 책정로직_210317
	var price=$("#price").text();//물품가격
	var shipFee=null;
	var total=null;
	if(price == "원"){
		$("#shipFee").text("원");
		$("#total").text("원");
		$("a[id='pay']").click(function(){
			alert("1개 이상의 상품을 담아야 주문이 가능합니다");
			return false;
		});
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
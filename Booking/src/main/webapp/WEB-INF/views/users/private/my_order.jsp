<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="content">
	<div class="order-box">
		<h2>주문 내역</h2>
		<ul class="order-list">
			<li class="order">
				<a class="" href="">
					<div>
						<div class="myOrder-num">123456890</div>
						<div class="myOrder-date">2022/01/02</div>
					</div>
					<span class="detailBtn">></span>	
				</a>
			</li>
			<li class="order">
				<a class="" href="">
					<div>
						<div class="myOrder-num">123456889</div>
						<div class="myOrder-date">2022/01/01</div>
					</div>
					<span class="detailBtn">></span>	
				</a>
			</li>
			<li class="order">
				<a class="" href="">
					<div>
						<div class="myOrder-num">123456888</div>
						<div class="myOrder-date">2021/12/31</div>
					</div>
					<span class="detailBtn">></span>	
				</a>
			</li>
		</ul>
	</div>
</div> 
<script>
	// by욱현. 주문내역 주문금액 표기법_2021322
 	let totalnum = $('#status').text(); 
	for(let i=1;i<=totalnum; i++) {
		
		let value = $('#totalPayment'+i).text();
		
		let result = addComma(value);
		
		$('#commaplusPayment'+i).text(result + "원");
		
	}
	
	function addComma(num){
		let regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	//회원탈퇴묻기
	function deleteConfirm(){
			let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
			if(isDelete){
				location.href="${pageContext.request.contextPath }/users/private/delete.do";
			} else {
				location.reload();
			}
	}
</script>
</body>
</html>
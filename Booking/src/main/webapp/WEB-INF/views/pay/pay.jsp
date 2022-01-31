<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/pay.css">
</head>
<body>
<div class="orderContainer">
	<div class="breadcrumb">
		<ul class="steps">
	  		<li class="location">
 		 		<span>주문서 작성</span> 배송/결제 정보를 정확히 입력해 주세요.
	  		</li>
			<li class="step">
			  	<a >북카트</a>
			</li>
			<li class="active">
			  	<a>주문 / 결제</a>
			</li>
			<li class="step">
			  	<a>주문 완료</a>
			</li>
		</ul>
	</div>
	<div class="orderContents">
		<div class="orderHead">
		<h2>주문 상품</h2>
		<span class="count">
		<c:forEach var="p" items="${list }">
		<c:set var= "sum" value="${sum + (p.count)}"/>
		</c:forEach>
		(총<em><font color="#135fa1"><c:out value="${sum + p.count}"></c:out></font></em>개)
		</span>
		</div>
		<div class="orderList">
			<div class="allCheckBox">
				<dt class="allCheck">
					<input type="checkbox" name="allCheck" id="allCheck" />
					<label for="allCheck">전체 선택</label>
				</dt>
				<dd class="deleteBtn">
					<button id="selectDeleteBtn" type="submit" class="btn" onClick="deleteChk(this)" >선택 삭제</button> 
				</dd> 
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
									location.replace("pay.do");	
								}else{
									return false;
								}
								
							}
						})
					}
				}
			</script>
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
			<c:forEach var="p" items="${list }" varStatus="status">
			<ul>
				<li>
					<div class="checkBox valign">
						<input type="checkbox" name="chBox" class="chBox" value="${p.id }"/>
					</div>
					<div class="orderImage valign"><img id="Bimg"src="${p.image }"/></div>
					<div class="orderSubject valign">${p.title}</div>
					<div class="orderQuantity valign">${p.count} 개</div>
					<div class="orderPrice valign">${p.d_price * p.count} 원</div>
				</li>
			</ul>	
			</c:forEach>
		</div>
		
		
		<div class="orderHead">
			<h2>배송정보</h2>
		</div>
		<div class="newAddressFormWrapper" >
			<div id="divNomalDelv" class="newAddressForm domesticDelivery current">
				<div class="addressWrap">
					<dl class="addressWrapDl">
						<dt class="addressName">수령인</dt>
						<dd class="addressName">
							<input type="iText" class="inputBg" name="normalRecipientNm" id="normalRecipientNm" />
						</dd>
						<dt class="addressDetail">주소</dt>
						<dd class="addressDetail">
							<ul id="addressDetailUl">
								<li class="postNumber">
									<input type="text" id="postCode" class="inputBg" name="postCode" id="postCode" placeholder="우편번호" readonly/>
									<button class="postBtn" type="button" value="우편번호 찾기&nbsp;" onClick="execDaumPostCode()">우편번호</button>
								</li>
								<li class="address1">
									<input type="text" class="inputBg" id="roadAddress" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly/>
								</li>
								<li class="address2">
									<input type="text"  class="inputBg" id="detailAddress" name="detailAddress" id="detailAddress" placeholder="상세주소"/>
								</li>
							</ul>
						</dd>
						<dt class="cellNumber">휴대폰 번호</dt>
						<dd class="cellNumber">
							<div class="customSelect">
								<select id="normalReciptientMpno1" style="color:#666;">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<ul class="options">
									<li class="option" data-option="010"></li>
									<li class="option" data-option="011"></li>
									<li class="option" data-option="016"></li>
									<li class="option" data-option="017"></li>
									<li class="option" data-option="018"></li>
									<li class="option" data-option="019"></li>
								</ul>
							</div>
							<span class="divide">-</span>
								<input type="text" class="iText inputBg" name="normalRecipientMpno2" id="normalRecipientMpno2" maxlength="4" numberonly="true"/>
								<span class="divide">-</span>
								<input type="text" class="iText inputBg" name="normalRecipientMpno3" id="normalRecipientMpno3" maxlength="4" numberonly="true"/>
						</dd>	
						<dt class="phoneNumber">전화번호</dt>
						<dd class="phoneNumber">
							<input type="text" class="iText inputBg" name="normalRecipientTelno1" id="normalRecipientTelno1" maxlength="3" numberonly="true"/>
							<span class="devide">-</span>
							<input type="text" class="iText inputBg" name="normalRecipientTelno2" id="normalRecipientTelno2" maxlength="4" numberonly="true"/>
							<span class="devide">-</span>
							<input type="text" class="iText inputBg" name="normalRecipientTelno3" id="normalRecipientTelno3" maxlength="4" numberonly="true"/>
						</dd>
						<div id="divGiftInfoNew">
							<dt class="presentCover">선물포장</dt>
							<dd class="presentCover">
								<label>
									<input type="checkbox" class="presentChk" name="chkGiftYn" value="Y" />
									<span>선물 신청하기</span>
								</label>
							</dd>
						</div>
						<dt class="addressMemo">배송 요청사항</dt>
						<dd class="addressMemo">
							<div class="selectStyle">
								<a href="#" class="viewPoint">
					
								</a>
								<div class="optionList">
									<select id="selbox" name="selbox">
										<option value="#" selected disabled hidden >배송요청 사항을 선택해 주세요</option>
										<option value="1">부재시 휴대폰으로 연락바랍니다</option>
										<option value="2">부재시 경비실에 맡겨주세요</option>
										<option value="3">경비실이 없습니다. 배송 전 연락바랍니다</option>
										<option value="direct">직접 입력</option>
									</select>
								</div>
							</div>
							<div class="customInput">
								<label class="labelPlaceholder">
									<input type="text" class="inputBg" id="selboxDirect" name="selboxDirect" maxlength="50" placeholder="최대 50자까지 입력가능"/>
								</label>
								<script>
								$(function(){
								//직접입력 인풋박스 기존에는 숨어있다가
								$("#selboxDirect").hide();
	
								$("#selbox").change(function() {
								                //직접입력을 누를 때 나타남
										if($("#selbox").val() == "direct") {
											$("#selboxDirect").show();
										}  else {
											$("#selboxDirect").hide();
										}
									}) 
								});
								</script>
							</div>
						</dd>
					</dl>
				</div>	
			</div>
		</div>
		<div class="addressNotice">
			<h4 id="noticeLogo">NOTICE</h4>
			<div class="addressNoticeList">
				<ul>
					<li>
						<strong>
						"당일배송은 늦은 시간 배송/수령이 가능한 주소로 변경해주세요."
						<br />
						"(회사/사무실/상가 밀집지역은 늦은 시간에 수령이 불가하여 배송이 지연될 수 있습니다.)"
						</strong>
					</li>
					<li>당일/하루배송은 직배송 상품에 한해 서비스 가능합니다.</li>
					<li>선택배송 신청 시 한 ID당 하루 1회만 적립 가능합니다.</li>
					<li>eBook, 교육상품권 등 무형상품은 배송되지 않습니다. 주문 시 마이페이지에서 다운로드가 가능합니다.</li>
					<li>중고도서 1개 이상 포함 주문 시, 제휴상품권 사용이 제한됩니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="orderAside">
		<div class="orderBox">
			<div class="topBox">
				<div class="priceBox">
					<c:forEach var="p" items="${list }">
						<c:set var= "sumP" value="${sumP + (p.count * p.d_price)}"/>
					</c:forEach>
					<dt class="itemPriceL">상품 가격</dt>
					<dd>
						<div class="itemSum itemPriceR"><c:out value="${sumP }"></c:out> 원</div>
					</dd>
					<dt class="shipFeeL">배송비</dt>
					<dd>
						<div class="shipFeeR">
						<!-- 배송비 -->
						</div>
					</dd>
					<dt class="totalL">총 결제금액</dt>
					<dd>
						<div class="totalR">
						<!-- 총 결제액 -->
						</div>
					</dd>
				</div>
			</div>
			<div class="bottomBox">
				<p class="myPageInfo">
					주문 완료 후 주문확인은 마이페이지 > 주문내역에서 확인할 수 있습니다.
				</p>
			</div>
			<div class="orderBtn">
				<button id="check_module" type="button" class="btn btn-lg">결제하기</button>
			</div>
		</div>
	</div>
</div>
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer" style="display:none; position:fixed; overflow:hidden; z-index:1; -webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</body>
<script>

	<!--도로명 주소 API-->
	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');
	
	function closeDaumPostcode() {
	    // iframe을 넣은 element를 안보이게 한다.
	    element_layer.style.display = 'none';
	}
	
	function execDaumPostCode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = data.address; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수
	
	            // 기본 주소가 도로명 타입일때 조합한다.
	            if(data.addressType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postCode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('roadAddress').value = fullAddr;
	            
	            document.getElementById('detailAddress').focus();
	            // iframe을 넣은 element를 안보이게 한다.
	            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%'
	    }).embed(element_layer);
	
	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';
	
	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    initLayerPosition();
	}
	
	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition(){
	    var width = 300; //우편번호 서비스가 들어갈 element의 width
	    var height = 460; //우편번호 서비스가 들어갈 element의 height
	    var borderWidth = 5; //샘플에서 사용하는 border의 두께
	
	    // 위에서 선언한 값들을 실제 element에 넣는다.
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}
	
	
	//by준영, 결제api 세팅_210311
	//by준영, 배송비 책정로직_210317
	var price=$(".itemSum").text();//물품가격
	var shipFee=null;
	var total=null;
	if(price != "원"){
		if(parseInt(price) >= 20000){
			shipFee=0;
			$(".shipFeeR").text(shipFee+" 원");
		}else{
			shipFee=2500;
			$(".shipFeeR").text(shipFee+" 원");
		}
		total=parseInt(price)+shipFee;
		$(".totalR").text(total+" 원");
	}
	if($('font').text() == 0){
		alert("상품을 최소 한 개 이상 담아주세요");	
		location.replace("${pageContext.request.contextPath }/");
	}
	
	
	
	$("#check_module").click(function () {
		//by준영, 항목 필수기입처리_210321
		var buyer = $("#normalRecipientNm").val();
		var post = $("#postCode").val();
		var detail =$("#detailAddress").val();
		var phone = $("#normalRecipientMpno2").val();
		var phone2 = $("#normalRecipientMpno3").val();
		var selbox = $("#selbox").val();
		
		if(buyer == ""){
			alert("수령인을 입력해주세요");
			$("#normalRecipientNm").focus();
			return;
		}else if(post == ""){
			alert("우편번호를 입력해주세요");
			return;
		}else if(detail == ""){
			alert("상세주소를 입력해주세요");
			return;
		}else if(phone == ""){
			alert("휴대폰 번호를 입력해주세요");
			$("#normalRecipientMpno2").focus();
			return;
		}else if(phone2 == ""){
			alert("휴대폰 번호를 입력해주세요");
			$("#normalRecipientMpno3").focus();
			return;
		}else if(selbox == null){
			alert("배송 요청사항을 입력해주세요");
			return;
		}
		
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
	
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</html>
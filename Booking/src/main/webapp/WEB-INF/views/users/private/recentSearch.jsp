<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="recent-box">
	<h2>검색 기록<span class="recent-sysdate">오늘 - <span id="date"></span></span></h2>
	<div class="recent-list">
		<div class="recent-listheader">
			<div class="allCheckWrap">
				<div class="allCheck">
					<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck"></label> 
					<span>전체선택</span>
				</div>
				<button id="selectDeleteBtn" type="submit" class="selectDelete_btn" onClick="deleteChk(this)" >선택 삭제</button> 
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
		</div>
		<div class="recent-listbody">
			<div class="recent-li">
				<div class="recent-Chk">
					<input class="chBox" name="chBox" type="checkbox"/>
				</div>
				<div class="recent-date">2022/01/03</div>
				<div class="recent-word">김치</div>
				<div class="recent-delete">
					<button class="recent-btn">삭제</button>
				</div>
			</div>
			<div class="recent-li">
				<div class="recent-Chk">
					<input class="chBox" name="chBox" type="checkbox"/>
				</div>
				<div class="recent-date">2022/01/02</div>
				<div class="recent-word">딸기</div>
				<div class="recent-delete">
					<button class="recent-btn">삭제</button>
				</div>
			</div>
			<div class="recent-li">
				<div class="recent-Chk">
					<input class="chBox" name="chBox" type="checkbox"/>
				</div>
				<div class="recent-date">2022/01/01</div>
				<div class="recent-word">초코</div>
				<div class="recent-delete">
					<button class="recent-btn">삭제</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
let time = new Date();

$('#date').html(time.toLocaleString());
</script>
</body>
</html>
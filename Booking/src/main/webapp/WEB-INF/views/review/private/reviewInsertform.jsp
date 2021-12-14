<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewInsertform.css">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	#star a{ 
		text-decoration: none; color: gray; 
		font-size:20px;
		font-family: emoji;
	} 
	#star a.on{ 
		color: red; 
	}
	
	
   	#insertBtn{
   		display: block;
		margin: 40px auto 0;
	    padding-left: 0px !important;
	    padding-right: 0px !important;
	    width: 585px;
	    height: 40px;
	    text-align: center;
	    font-size: 14px;
	    padding: 13px 30px;
	    background-color: black;
	    border: 1px solid black;
	    color: white;
	    line-height: 1;
	    cursor: pointer;
   	}
   	.layout{
   		width:1200px; 
		margin:auto;
   	}
   	.card{
   		background: url(${pageContext.request.contextPath }/resources/imgages/searchBook.svg) no-repeat top left;
   		background-position: center;
		background-size: contain;
   		margin-right: 24px;
   		height: 170px;
		width: 150px;
		border-radius: 15px;
		display: inline-block;
		position: relative;
		box-shadow:rgb(60 64 67 / 30%) 0px 1px 2px 0px, rgb(60 64 67 / 15%) 0px 2px 6px 2px;
   	}
   	.writeForm{
   		font-family: '777Balsamtint';
	    width: 950px;
	    text-align: left;
	    padding: 45px 28px 50px;
	    border: 2px solid #bbbbbbde;
	    margin: 0 auto;
   	}
   	.selectBook{
   		padding: 20px;
   	}
   	.selectBook > h2{
   		font-size: 26px;
   		padding-bottom: 10px;
   		border-bottom: 3px solid #41495c;
   		margin-top: 0;
   		margin-bottom: 40px;
   	}
   	.form-header{
   		display: flex;
   	}
   	.bookDesc {
		border: 5px solid #e5e5e5;
    	padding: 4px;
   		width: 100%;
   	}
   	.bookDesc > table {
   		margin: 5px 10px;
   	}
   	.bookDesc > table, td {
   	}
   	.td-title, .td-isbn{
   		padding: 25px 15px; 
   		font-size: 22px;
   	}
   	.td-title{
   		border-bottom: 2px solid #e5e5e5;
   	}
   	.form-body > table {
   		width: 100%;
   		border: 1px solid #e5e5e5;
   	}
   	.td-Rtitle ,.td-star ,.td-content {
   		padding: 12px 15px; 
   		font-size: 20px;
   		border-bottom: 1px solid #e5e5e5;
   	}
   	.td-spoCheck{
   		padding: 5px 15px; 
   		font-size: 16px;
   	}
   	.td-star > p {
   		margin: 0;
   	}
   	#reviewTitle {
   		width: 100%;
	    height: 40px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
   	}
   	#content {
   		width: 100%;
	    height: 400px;
	    border: 1px solid #e5e5e5;
	    border-radius: 2px;
	    padding: 9px 12px;
	    outline: none;
	    box-sizing: border-box;
   	}
   	
   	.td-bg{
   		background-color: #fbf9fa;
   	}
</style>
<script type="text/javascript" src="${ctx }/resource/js/smartEditor/js/service/HuskyEZCreator.js"></script>

</head>
<body>
<div class="layout">
	<div class="writeForm">
		<div class="selectBook">
			<h2>● 리뷰 작성</h2>
			<div class="form-header">
				<div class="bookDesc">
					<table>
						<colgroup>
							<col style="width:20%">
							<col style="width:10%"> 
							<col style="width:70%">
						</colgroup>
						<tr>
							<td rowspan="3">
								<a id="bookSearch" class="card" href="${pageContext.request.contextPath }/review/reviewBookList.do?"></a>
							</td>
							<td class="td-title"> > 제목</td>
							<td class="td-title">달러구트의 꿈백화점</td>
						</tr>
						<tr>
							<td class="td-isbn">> isbn</td>
							<td class="td-isbn">123456789a</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- by남기, 북 리스트로 이동해서 책을 검색하고 정보를 가져온다_210303 -->
		<div class="form-body">
			<table>
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tr>
					<td class="td-Rtitle td-bg"><label for="reviewTitle"> >  리뷰 제목</label></td>
					<td class="td-Rtitle"><input class="form-control" type="text" name="reviewTitle" id="reviewTitle"/></td>
				</tr>
				<tr>
					<td class="td-star td-bg"> > 별점</td>
					<td class="td-star">
						<p id="star">
							<a href="#" value="1">★</a>
							<a href="#" value="2">★</a> 
							<a href="#" value="3">★</a> 
							<a href="#" value="4">★</a> 
							<a href="#" value="5">★</a>
						<p>
					</td>
				</tr>
				<tr>
					<td class="td-content td-bg"><label for="content"> >  리뷰 내용</label></td>
					<td class="td-content"><textarea class="form-control" name="content" id="content"></textarea></td>
				</tr>
				<tr>
					<td class="td-spoCheck td-bg"><strong style="color:#41495c";>※ 스포일러 유무</strong></td>
					<td class="td-spoCheck">
						<div class="form-group " >
							<!--by채영_스포일러 포함 체크박스  -->
							<label for ="spoCheck" ></label>
							<input type="checkbox" id="spoCheck" name="spoCheck">
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		<form id="insertForm">
			<div class="form-group">
				<c:forEach var="b" items="${reviewBook }">
					<img name="image" src="${b.image }"/>				
					<input type="hidden" name="writer" id="writer" value="${sessionScope.id}" /><br />
					<input type="hidden" name="imagePath" id="imagePath" value="${b.image }" /><br />
					<input id="isbn" type="hidden" name="isbn" value="${b.isbn }" /><br />
					<label for="bookTitle">책 제목</label>
					<input class="form-control" type="text" name="bookTitle" id="bookTitle" value="${b.title }"/>
					<label for="reviewTitle">리뷰 제목</label>
					<input class="form-control" type="text" name="reviewTitle" id="reviewTitle"/>
					<input type="hidden" name="rating" id="rating"/>
				</c:forEach>
			</div>
			
			
			<button id="insertBtn" class="" type="submit" onclick="postAjax();">저장</button>
		</form>
	</div>
</div>

<!-- by남기, SmartEditor 에서 필요한 javascript 로딩 _210303 -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>

	function postAjax(){
		var data = {
			isbn : $("#isbn").val(),
			reviewTitle : $("#reviewTitle").val(),
			rating : $("#rating").val(),
			content : $("#content").val(),
			spoCheck : $("#spoCheck").val(),
			bookTitle : $("#bookTitle").val(),
			imagePath : $("#imagePath").val(),
			//writer : $("#writer").val()eksk
		};
		console.log(data);
		
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/review",
			method:"post",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success:function(data) {
				console.log("성공");
			},
			error : function(data) {
				console.log("오류");
			}
		});
	}

	// by남기, 별점을 클릭할 때 별점 갯수가 증가하거나 감소_210310
	$('#star a').click(function(){ 
	      $(this).parent().children("a").removeClass("on");
	      $(this).addClass("on").prevAll("a").addClass("on");
	      let starval=$(this).attr("value");
	      $("#rating").val(starval);
	});
	
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}

	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		//by준영, 빈값을 제출 못하게 하는 기능_210305
		var isbn=$("#isbn").val();
		var reviewTitle=$("#reviewTitle").val();
		var rating=$("#rating").val();
		var content=$("#content").val();
		
		if(selectBook == null){
			alert("책 선택은 필수기입항목 입니다");
			return;
		}else if(reviewTitle == ""){
			alert("리뷰 제목은 필수기입항목 입니다");
			$("#reviewTitle").focus();
			return;
		}else if(rating == ""){
			alert("별점은 필수기입항목 입니다");
			return;
		}else if( content == ""  || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>'){
			alert("리뷰 내용은 필수기입항목 입니다");
			return;
		}
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	/*
	$("#insertBtn").on("click",function(){
		return false;
	})
	*/
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
	//by채영_스포일러 체크 여부 
	var spoCheck = null;
	var spo = $("input:checkbox[name='spoCheck']").is(':checked');
	if(spo == true){
		spoCheck = "yes";
	}else{
		spoCheck = "no";
	}
</script>
</body>
</html>

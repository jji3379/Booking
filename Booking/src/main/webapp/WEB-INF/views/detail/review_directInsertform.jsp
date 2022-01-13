<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewUpdateform.css">
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
</style>
</head>
<body>
<div class="layout">
	<div class="writeForm">
	<form id="insertForm">
		<div class="form-group">
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
							<c:forEach var="r" items="${reviewDirect }">
							<tr>
								<td rowspan="3">
									<div id="bookSearch" class="card"><img id="selected" src='<c:out value="${r.image }"></c:out>' alt=""/></div>
								</td>
								<td class="td-title"> > 제목</td>
								<td class="td-title" ><input type="text" name="bookTitle" id="bookTitle" value="<c:out value="${r.title }"></c:out>" disabled/></td>
							</tr>
							<tr>
								<td class="td-isbn">> isbn</td>
								<td class="td-isbn" ><input type="text" name="isbn" id="isbn"  value="<c:out value="${r.isbn }"></c:out>" disabled/></td>
							</tr>
							</c:forEach>
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
			<input type="hidden" name="writer" id="writer" value="${sessionScope.id}" />
			<input type="hidden" name="imagePath" id="imagePath" value="" />
			<input type="hidden" name="rating" id="rating"/>
		</div>
		<button id="insertBtn" type="button" onclick="postAjax();">저장</button>
	</form>
	</div>
</div>

<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	
	
	//by 준영, 책선택 팝업창 띄우기
	$('#bookSearch').click(function(){ 
		var popUrl = "${pageContext.request.contextPath }/review/reviewBookList.do?";
		//screen.width : 현재 운영체제의 너비
		//screen.height : 현재 운영체제의 높이
		w = 700; //팝업창의 너비
		h = 550; //팝업창의 높이

		//중앙위치 구해오기
		LeftPosition=(screen.width-w)/2;
		TopPosition=(screen.height-h)/2;

		window.open(
		popUrl,
		"책 선택",
		"width="+w+",height="+h+",top="+TopPosition+",left="+LeftPosition+", scrollbars=no");
                   
	});
	
	function postAjax(){
		var spoCheckYn = $('input:checkbox[id="spoCheck"]').is(":checked");
		var spoCheckData = (spoCheckYn ? "Y" : "N");
		
		var data = {
			isbn : $("#isbn").val(),
			reviewTitle : $("#reviewTitle").val(),
			rating : $("#rating").val(),
			content : $("#content").val(),
			spoCheck : spoCheckData,
			bookTitle : $("#bookTitle").val(),
			imagePath : $("#selected").attr('src')
		};
		
		$.ajax({
			url:"${pageContext.request.contextPath}/v1/review",
			method:"post",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success:function(data) {
				location.href="${pageContext.request.contextPath }/review";
			},
			error : function(data) {
				alert('저장 실패');
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
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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

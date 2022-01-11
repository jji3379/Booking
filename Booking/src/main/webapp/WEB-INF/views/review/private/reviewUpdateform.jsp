<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewUpdateform.css">
<jsp:include page="../../include/resource.jsp"></jsp:include>

</head>
<body>
<div class="layout">
	<div class="writeForm">
	<form id="insertForm">
		<div class="form-group">
			<div class="selectBook">
				<h2>● 리뷰 수정</h2>
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
									<div id="bookSearch" class="card"><img id="selected" src="${dto.imagePath }" alt=""/></div>
								</td>
								<td class="td-title"> > 제목</td>
								<td class="td-title" ><input type="text" name="bookTitle" id="bookTitle" value="${dto.bookTitle }" disabled/></td>
							</tr>
							<tr>
								<td class="td-isbn">> isbn</td>
								<td class="td-isbn" ><input type="text" name="isbn" id="isbn"  value="${dto.isbn }" disabled/></td>
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
						<td class="td-Rtitle"><input class="form-control" type="text" name="reviewTitle" id="reviewTitle" value="${dto.reviewTitle }"/></td>
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
						<td class="td-content"><textarea class="form-control" name="content" id="content">${dto.content }</textarea></td>
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
			<input type="hidden" name="imagePath" id="imagePath" value="${dto.imagePath }" />
			<input type="hidden" name="rating" id="rating"/>
		</div>
		<button id="insertBtn" type="button" onclick="updateAjax();">저장</button>
	</form>
	</div>
</div>

<script>
	// by남기, 별점을 클릭할 때 별점 갯수가 증가하거나 감소_210310
	$('#star a').click(function(){ 
	      $(this).parent().children("a").removeClass("on");
	      $(this).addClass("on").prevAll("a").addClass("on");
	      let starval=$(this).attr("value");
	      $("#rating").val(starval);
	});
</script>
<!-- by남기, SmartEditor 에서 필요한 javascript 로딩 _210303 -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	//
	function updateAjax(){
		var spoCheckYn = $('input:checkbox[id="spoCheck"]').is(":checked");
		var spoCheckData = (spoCheckYn ? "Y" : "N");
		
		var data = {
			isbn : $("#isbn").val(),
			reviewTitle : $("#reviewTitle").val(),
			rating : $("#rating").val(),
			content : $("#content").val(),
			spoCheck : spoCheckData,
			bookTitle : $("#bookTitle").val(),
			imagePath : $("#imagePath").val(),
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
	
	// by남기. _210303
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
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>

</body>
</html>
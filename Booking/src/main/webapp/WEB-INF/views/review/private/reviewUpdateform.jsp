<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/private/updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	#star a{ 
		text-decoration: none; color: gray; 
	} 
	#star a.on{ 
		color: red; 
	}
	div.container{
		font-size:18px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="review" name="thisPage"/>
</jsp:include>
<div style="margin-top:-13px"></div>
<nav>
	<ul class="breadcrumb" style="border: 2px solid #135fa1; background-color:white; font-size: 18px; font-weight:bold; height:50px;">
		<li class="breadcrumb-item" style="margin-left:95px;">
			<a href="${pageContext.request.contextPath }/">Home</a>
		</li>
		<li class="breadcrumb-item">
			<a href="${pageContext.request.contextPath }/review/reviewList.do">리뷰 목록</a>
		</li>
		<li class="breadcrumb-item active">리뷰 수정 폼</li>
	</ul>
</nav>
<div class="container">
	<center><h1>리뷰 수정 폼</h1></center>
	<form action="reviewUpdate.do" method="post">
		<input type="hidden" name="num" value="${dto.num }"/>
		<div class="form-group">
			<label for="imagePath">이미지</label><br />
			<img src="${dto.imagePath }"/>
		</div>
		<div class="form-group">
			<label>작성자</label>
			<input class="form-control" type="text" value="${dto.writer }" disabled/>
		</div>
		<div class="form-group">
			<label for="reviewTitle">제목</label>
			<input class="form-control" type="text" name="reviewTitle" id="reviewTitle" value="${dto.reviewTitle }"/>
		</div>
		<div class="form-group">
			<label for="rating">별점</label>
			<input class="form-control" type="hidden" name="rating" id="rating" value="${dto.rating }"/>
			<!-- by남기, 평점 선택창_210310 -->
			<p id="star">
				<a href="#" value="1">★</a>
				<a href="#" value="2">★</a> 
				<a href="#" value="3">★</a> 
				<a href="#" value="4">★</a> 
				<a href="#" value="5">★</a>
			<p>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content">${dto.content }</textarea>
		</div>
		<button class="btn btn-primary" type="submit" onclick="submitContents(this);">수정확인</button>
	</form>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/review/private/insertform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div style="margin-top:100px"></div>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/review/reviewList.do">리뷰 목록</a>
			</li>
			<li class="breadcrumb-item active">리뷰 작성 폼</li>
		</ul>
	</nav>
	<h1>리뷰 작성 폼 입니다.</h1>
	<!-- by남기, 북 리스트로 이동해서 책을 검색하고 정보를 가져온다_210303 -->
	<a href="${pageContext.request.contextPath }/review/reviewBookList.do">책 검색</a>
	<form id="form" action="reviewInsert.do" method="post">
		<div class="form-group">
			<c:forEach var="b" items="${reviewBook }">
				<img name="image" src="${b.image }"/>				
				<input type="hidden" name="imagePath" value="${b.image }" />
				<input id="selectedBook" type="hidden" name="isbn" value="${b.isbn }" />
				<label for="reviewTitle">리뷰 제목</label>
				<input class="form-control" type="text" name="reviewTitle" id="reviewTitle" value="${b.title }"/>
			</c:forEach>
		</div>
		<div class="form-group">
			<label for="content">리뷰 내용</label>
			<textarea class="form-control" name="content" id="content"></textarea>
		</div>
		<button class="btn btn-primary" type="submit" onclick="submitContents(this);">저장</button>
	</form>
</div>
<!-- by남기, SmartEditor 에서 필요한 javascript 로딩 _210303 -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
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
		var length_bk=$("#selectedBook").val();
		var cont=$("#content").val();
		
		  if( length_bk == 0 ){
			  alert("책 선택은 필수항목 입니다");
		      return;//함수를 여기서 끝내서 폼 전송막기
		  }else if(  cont == ""  || cont == null || cont == '&nbsp;' || cont == '<p>&nbsp;</p>'){
			  alert("리뷰 내용은 필수기입항목 입니다");
			  return;
		  }
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	$("#form button").on("click",function(){
		return false;
	})
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>

</body>
</html>
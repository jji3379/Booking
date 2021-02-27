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
				<a href="${pageContext.request.contextPath }/review/list.do">리뷰 목록</a>
			</li>
			<li class="breadcrumb-item active">리뷰 작성 폼</li>
		</ul>
	</nav>
	<h1>리뷰 작성 폼 입니다.</h1>
	<!-- 북 리스트로 이동해서 책을 검색하고 정보를 가져온다. -->
	<a href="${pageContext.request.contextPath }/review/bookList.do">책 검색</a>
	<form action="insert.do" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<c:forEach var="b" items="${reviewBook }">
				<img src="${b.image }"/>
				<input type="hidden" name="isbn" value="${b.isbn }" />
			</c:forEach>
		</div>
		<div class="form-group">
			<label for="image">이미지</label>
			<input type="file" name="image" id="image"
				accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		</div>
		<div class="form-group">
			<label for="reviewTitle">리뷰 제목</label>
			<input class="form-control" type="text" name="reviewTitle" id="reviewTitle"/>
		</div>
		<div class="form-group">
			<label for="content">리뷰 내용</label>
			<textarea class="form-control" name="content" id="content"></textarea>
		</div>
		<button class="btn btn-primary" type="submit" onclick="submitContents(this);">저장</button>
	</form>
</div>
<%--
	[ SmartEditor 를 사용하기 위한 설정 ]
	
	1. WebContent 에 SmartEditor  폴더를 복사해서 붙여 넣기
	2. WebContent 에 upload 폴더 만들어 두기
	3. WebContent/WEB-INF/lib 폴더에 
	   commons-io.jar 파일과 commons-fileupload.jar 파일 붙여 넣기
	4. <textarea id="content" name="content"> 
	   content 가 아래의 javascript 에서 사용 되기때문에 다른 이름으로 바꾸고 
	      싶으면 javascript 에서  content 를 찾아서 모두 다른 이름으로 바꿔주면 된다. 
	5. textarea 의 크기가 SmartEditor  의 크기가 된다.
	6. 폼을 제출하고 싶으면  submitContents(this) 라는 javascript 가 
	      폼 안에 있는 버튼에서 실행되면 된다.
 --%>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
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
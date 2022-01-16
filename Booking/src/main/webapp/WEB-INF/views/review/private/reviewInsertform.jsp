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
<script src="http://code.jquery.com/jquery-1.3.2.min.js" ></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js" ></script>

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
							<tr>
								<td rowspan="3">
									<button id="bookSearch" class="card"><span>책 검색</span><img id="selected" src="${pageContext.request.contextPath }/resources/images/searchBook.svg" alt=""/></button>
								</td>
								<td class="td-title"> > 제목</td>
								<td class="td-title" ><input type="text" name="bookTitle" id="bookTitle" value="" disabled/></td>
							</tr>
							<tr>
								<td class="td-isbn">> isbn</td>
								<td class="td-isbn" ><input type="text" name="isbn" id="isbn"  value="" disabled/></td>
							</tr>
						</table>
						<input type="checkbox" name="bookSelect" id="bookSelect" value=""    />
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
								<input type="checkbox" name="star_Chk" id="star-chk"/>
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
			<input type="hidden" name="rating" id="rating"/>
		</div>
		<button id="insertBtn" type="submit">저장</button>
	</form>
	</div>
</div>

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
	$("#isbn").change(function(){
		alert('ㅇㅇ');
		//by 준영, 책 선택하게하는 validation
		var info = $('#isbn').val();
		var bookChk = $('input[id=bookSelect]');
		if(info != ''){
			bookChk.click();
		}else{
			if(bookChk.is(":checked") == true){
				bookChk.click();	
			}
		}
	});
	
	
	
	// by남기, 별점을 클릭할 때 별점 갯수가 증가하거나 감소_210310
	$('#star a').click(function(){ 
    	$(this).parent().children("a").removeClass("on");
	    $(this).addClass("on").prevAll("a").addClass("on");
	    let starval=$(this).attr("value");
	    $("#rating").val(starval);
	});
	//by 준영, Validate.js 라이브러리 
	$(document).ready(function () { 
		
	    // validate signup form on keyup and submit
	    $('#insertForm').validate({
	        errorPlacement: function(error, element) {
	        	if(element.is("#star_Chk")){
	        		element.parent().after(error);
	        	}else{
	        		element.after(error);
	        	}
	        },
	    	rules: {
	    		bookSelect:{
	    			required: true
	    		},
	            reviewTitle: {
	                required: true
	            },
				star_Chk: {
	                required: true
	            },               
	            content: {
	                required: true
	            }
	        },
	        messages: {
	        	bookTitle: "gg",
	            isbn: "gg",
	            reviewTitle: "gg",
	            star_Chk: "gg",
	            content: "gg"
	        }
	//여기부터
	,
			
	        submitHandler: function (frm){
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
	        },
	        success: function(e){
	            //
	        }
	//여기까지는 생략 가능           
	    });
	    
	});
	
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

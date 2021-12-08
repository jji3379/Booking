<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* example 로그인 폼을 만들기 위한 css */
	html,
	body {
	  height: 100%;
	}
	
	body {
	  display: -ms-flexbox;
	  display: flex;
	  -ms-flex-align: center;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
	}
	
	.form-signin {
	  width: 100%;
	  max-width: 330px;
	  padding: 15px;
	  margin: auto;
	}
	.form-signin .checkbox {
	  font-weight: 400;
	}
	.form-signin .form-control {
	  position: relative;
	  box-sizing: border-box;
	  height: auto;
	  padding: 10px;
	  font-size: 16px;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="email"] {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
		
</style>
</head>
<body class="text-center">
<!--  체크박스 선택 개수 제한  -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>체크박스 선택 갯수 제한 예제</title>
</head>
<body>
	
		<input onclick="CountChecked(this)" type="checkbox" name="choice" value="apple" />사과
		<input onclick="CountChecked(this)" type="checkbox" name="choice" value="banana" />바나나
		<input onclick="CountChecked(this)" type="checkbox" name="choice" value="tomato" />토마토
	
</body>

<script type="text/javascript">
var maxCount = 2;								// 카운트 최대값은 2
var count = 0;   								// 카운트, 0으로 초기화 설정

function CountChecked(field){ 					// field객체를 인자로 하는 CountChecked 함수 정의
	if (field.checked) {						// 만약 field의 속성이 checked 라면(사용자가 클릭해서 체크상태가 된다면)
		count += 1;								// count 1 증가
	}
	else {										// 아니라면 (field의 속성이 checked가 아니라면)
		count -= 1;								// count 1 감소
	}
	
	if (count > maxCount) {						// 만약 count 값이 maxCount 값보다 큰 경우라면
		alert("최대 2개까지만 선택가능합니다!");	// alert 창을 띄움
	field.checked = false;						// (마지막 onclick한)field 객체의 checked를 false(checked가 아닌 상태)로 만든다.
	count -= 1;									// 이때 올라갔던 카운트를 취소처리해야 하므로 count를 1 감소시킨다.
	}
}
</script>

</html>
</body>
</html>
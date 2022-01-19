<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Untitled</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <div class="footer-basic">
        <footer>
            <div class="social"><a href="#"><i class="icon ion-social-instagram"></i></a><a href="#"><i class="icon ion-social-snapchat"></i></a><a href="#"><i class="icon ion-social-twitter"></i></a><a href="#"><i class="icon ion-social-facebook"></i></a></div>
            <div class="footer-body">
	            <ul class="list-inline">
	                <li class="list-inline-item"><a href="#">Home</a></li>
	                <li class="list-inline-item"><a href="#">Services</a></li>
	                <li class="list-inline-item"><a href="#">About</a></li>
	                <li class="list-inline-item"><a href="#">Terms</a></li>
	                <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
	            </ul>
	            <p class="copyright">Booking © 2022</p>            
            </div>
        </footer>
    </div>
</body>
</html>
<script>
//by 준영 리뷰리스트 로딩끝나고 푸터호출
$('#footer').hide();
$('#main').ready(function(){
	$('#footer').show();
})
</script>
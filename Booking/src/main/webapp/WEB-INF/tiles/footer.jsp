<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="footer-basic">
        <footer>
       		<div class="footer-main">Contact</div>
        	<div class="footer-body">
   	            <ul class="list-inline">
	                <li class="list-inline-item">Front-End Developer</li>
	                <li class="list-inline-item">Back-End Developer</li>
	            </ul>     
            </div>
            <div class="footer-icon">
	            <div class="social contact-jjy">
		            <a href="https://github.com/jjy321501/"><i class="icon ion-social-github"></i></a>
		            <a href="https://mail.naver.com/write/popup?srvid=note&to=jjy321501@naver.com"><i class="iconify" data-icon="ion:mail-outline"></i></a>
	            </div>
	            <div class="social contact-jji">
	            	<a href="https://github.com/jji3379/"><i class="icon ion-social-github"></i></a>
		            <a href="https://mail.naver.com/write/popup?srvid=note&to=jji3379@naver.com"><i class="iconify" data-icon="ion:mail-outline"></i></a>
	            </div>
	        </div>
            <p class="copyright">Booking © 2022</p> 
        </footer>
    </div>
<script>
//by 준영 리뷰리스트 로딩끝나고 푸터호출
$('#footer').hide();
$('#main').ready(function(){
	$('#footer').show();
})
</script>
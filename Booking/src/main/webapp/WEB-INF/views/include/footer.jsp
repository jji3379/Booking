<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');//구글폰트
	body {
	    background: #fbfbfd;
	}
	
	.new_footer_area {
	    background: #fbfbfd;
	}
	
	
	.new_footer_top {
		background-color:#0f4c81;
	    padding: 40px 0px 270px;
	    position: relative;
	      overflow-x: hidden;
	}
	.new_footer_area .footer_bottom {
	    padding-top: 5px;
	    padding-bottom: 25px;
	}
	.footer_bottom {
		background-color:#0f4c81;
	    font-size: 14px;
	    font-weight: 300;
	    line-height: 20px;
	    color: #7f88a6;
	    padding: 27px 0px;
	}
	.new_footer_top .company_widget p {
	    font-size: 16px;
	    font-weight: 300;
	    line-height: 28px;
	    color: white;
	    margin-bottom: 20px;
	}
	.new_footer_top .company_widget .f_subscribe_two .btn_get {
	    border-width: 1px;
	    margin-top: 20px;
	}
	.btn_get_two:hover {
	    background: transparent;
	    color: #5e2ced;
	}
	.btn_get:hover {
	    color: #fff;
	    background: #0f4c81;
	    border-color: #6754e2;
	    -webkit-box-shadow: none;
	    box-shadow: none;
	}
	a:hover, a:focus, .btn:hover, .btn:focus, button:hover, button:focus {
	    text-decoration: none;
	    outline: none;
	}
	
	
	
	.new_footer_top .f_widget.about-widget .f_list li a:hover {
	    color: #5e2ced;
	}
	.new_footer_top .f_widget.about-widget .f_list li {
	    margin-bottom: 11px;
	}
	.f_widget.about-widget .f_list li:last-child {
	    margin-bottom: 0px;
	}
	.f_widget.about-widget .f_list li {
	    margin-bottom: 15px;
	}
	.f_widget.about-widget .f_list {
	    margin-bottom: 0px;
	}
	.new_footer_top .f_social_icon a {
	    width: 44px;
	    height: 44px;
	    line-height: 43px;
	    background: transparent;
	    border: 1px solid #e2e2eb;
	    font-size: 24px;
	}
	.f_social_icon a {
	    width: 46px;
	    height: 46px;
	    border-radius: 50%;
	    font-size: 14px;
	    line-height: 45px;
	    color: #858da8;
	    display: inline-block;
	    background: #ebeef5;
	    text-align: center;
	    -webkit-transition: all 0.2s linear;
	    -o-transition: all 0.2s linear;
	    transition: all 0.2s linear;
	}
	.ti-facebook:before {
	    content: "\e741";
	}
	.ti-twitter-alt:before {
	    content: "\e74b";
	}
	.ti-vimeo-alt:before {
	    content: "\e74a";
	}
	.ti-pinterest:before {
	    content: "\e731";
	}
	
	.btn_get_two {
	    -webkit-box-shadow: none;
	    box-shadow: none;
	    background: #5e2ced;
	    border-color: #5e2ced;
	    color: #fff;
	}
	
	.btn_get_two:hover {
	    background: transparent;
	    color: #5e2ced;
	}
	
	.new_footer_top .f_social_icon a:hover {
	    background: #5e2ced;
	    border-color: #5e2ced;
	  color:white;
	}
	.new_footer_top .f_social_icon a + a {
	    margin-left: 4px;
	}
	.new_footer_top .f-title {
	    margin-bottom: 30px;
	    color: #f5e9dd;
	}
	.f_600 {
	    font-weight: 600;
	}
	.f_size_18 {
	    font-size: 18px;
	}
	.new_footer_top .f_widget.about-widget .f_list li a {
	    color: white;
	}
	
	
	.new_footer_top .footer_bg {
	    position: absolute;
	    bottom: 0;
	    background: url("http://droitthemes.com/html/saasland/img/seo/footer_bg.png") no-repeat scroll center 0;
	    background-color:#0f4c81;
	    width: 100%;
	    height: 266px;
	}
	
	.new_footer_top .footer_bg .footer_bg_one {
	    background: url("https://1.bp.blogspot.com/-mvKUJFGEc-k/XclCOUSvCnI/AAAAAAAAUAE/jnBSf6Fe5_8tjjlKrunLBXwceSNvPcp3wCLcBGAsYHQ/s1600/volks.gif") no-repeat center center;
	    width: 330px;
	    height: 105px;
	  background-size:100%;
	    position: absolute;
	    bottom: 0;
	    left: 30%;
	    -webkit-animation: myfirst 22s linear infinite;
	    animation: myfirst 22s linear infinite;
	}
	
	.new_footer_top .footer_bg .footer_bg_two {
	    background: url("https://1.bp.blogspot.com/-hjgfxUW1o1g/Xck--XOdlxI/AAAAAAAAT_4/JWYFJl83usgRFMvRfoKkSDGd--_Sv04UQCLcBGAsYHQ/s1600/cyclist.gif") no-repeat center center;
	    width: 88px;
	    height: 100px;
	  background-size:100%;
	    bottom: 0;
	    left: 38%;
	    position: absolute;
	    -webkit-animation: myfirst 30s linear infinite;
	    animation: myfirst 30s linear infinite;
	}
	
	
	
	@-moz-keyframes myfirst {
	  0% {
	    left: -25%;
	  }
	  100% {
	    left: 100%;
	  }
	}
	
	@-webkit-keyframes myfirst {
	  0% {
	    left: -25%;
	  }
	  100% {
	    left: 100%;
	  }
	}
	
	@keyframes myfirst {
	  0% {
	    left: -25%;
	  }
	  100% {
	    left: 100%;
	  }
	}
	.logo{
		width:100px;
	}
	.footerLogo{
		font-family: 'Gugi', cursive;
	}
	/*************footer End*****************/
	
</style>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
</head>
<body >


<footer class="new_footer_area bg_color">
    <div class="new_footer_top">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="f_widget company_widget wow fadeInLeft" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeInLeft;">
                        <h3 class="footerLogo" style="color:#f5e9dd;">책과의 즉석만남</h3>
                     
                        <h1 class="footerLogo" style="color:#f5e9dd;" class="f-title f_600 t_color f_size_18">Booking <img class="logo" src="${pageContext.request.contextPath }/resources/images/Booking_logo.png" /></h1>
                        <p>
                        
                        	
                        </p>
                        <form action="#" class="f_subscribe_two mailchimp" method="post" novalidate="true" _lpchecked="1">
                            <input type="text" name="EMAIL" class="form-control memail" placeholder="Email">
                            <button style: background-color=#135fa1; class="btn btn_get btn_get_two" type="submit">Subscribe</button>
                            <p class="mchimp-errmessage" style="display: none;"></p>
                            <p class="mchimp-sucmessage" style="display: none;"></p>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInLeft;">
                        <h3 class="f-title f_600 t_color f_size_18">Contact</h3>
                        <ul class="list-unstyled f_list">
                            <li><a href="http://www.acornacademy.co.kr/">Acorn academy</a></li>
                            <li><a href="https://github.com/jji3379/Booking">Git hub</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.6s" style="visibility: visible; animation-delay: 0.6s; animation-name: fadeInLeft;">
                        <h3 class="f-title f_600 t_color f_size_18">Developers</h3>
                        <ul class="list-unstyled f_list">
                            <li><a href="#">jjy321501@naver.com</a></li>
                            <li><a href="#">jji3379@naver.com</a></li>
                            <li><a href="#">dkdkdkdk555@naver.com</a></li>
                            <li><a href="#">karufuci@gmail.com</a></li>
                            <li><a href="#">violin977@naver.com</a></li>
                            <li><a href="#">cathyshim222@gmail.com</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                	<!-- partners  -->
	<strong class="f-title f_600 t_color f_size_18">Partners</strong> <br />  
	<a href="http://www.kyobobook.co.kr/"><img style=width:80px; class="partners" src="${pageContext.request.contextPath }/resources/images/kyobo.png" /></a>
	&nbsp; |&nbsp; <a href="http://www.yes24.com/"><img style=width:80px; class="partners" src="${pageContext.request.contextPath }/resources/images/yes24.png" /></a>
	&nbsp; &nbsp; <a href="https://www.aladin.co.kr"><img style=width:80px; class="partners" src="${pageContext.request.contextPath }/resources/images/aladin.png" /></a>
	&nbsp; |&nbsp; <a href="https://www.ypbooks.co.kr"><img style=width:80px; class="partners" src="${pageContext.request.contextPath }/resources/images/ypbooks.png" /></a>
                	<br />
                	<br />
                	<br />
                    <div class="f_widget social-widget pl_70 wow fadeInLeft" data-wow-delay="0.8s" style="visibility: visible; animation-delay: 0.8s; animation-name: fadeInLeft;">
                        <h3 class="f-title f_600 t_color f_size_18">Follow us</h3>
                        <div class="f_social_icon">
                            <a href="https://github.com/jji3379/Booking/" ><i class="fa fa-github"></i></a>
                            <a href="https://www.facebook.com/" ><i class="fa fa-facebook"></i></a>
                            <a href="https://twitter.com/" ><i class="fa fa-twitter"></i></a>
                            <a href="https://www.instagram.com/" ><i class="fa fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer_bg">
            <div class="footer_bg_one"></div>
            <div class="footer_bg_two"></div>
        </div>
    </div>
    <div class="footer_bottom">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-sm-7">
                    <p class="mb-0 f_400">© Booking.. 2021 All rights reserved.</p>
                </div>
                
            </div>
        </div>
    </div>
</footer>
 </body>
</html>
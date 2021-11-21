<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<style>
		.bookT {
			margin-top: 2px;
			margin-bottom: 2px;
			text-align: center;
			font-size: 17px;
			display: -webkit-box;
			-webkit-line-clamp: 1;
			-webkit-box-orient: vertical;
			overflow: hidden;
    		text-overflow: ellipsis;
		}
	</style>
   	
    <c:forEach var="b" items="${detailAjax }">
    <ul style="list-style: none; ">
        <li>
            <a style="color:black;" href="bookDetail.do?d_isbn=${b.isbn }"><img style="box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;" src="${b.image}" alt="" />
            	<p class="bookT">${b.title }</p>
            </a>
        </li>
    </ul>
    </c:forEach>
   	

<script>
	var sim = document.getElementById("simList");
	$("#plus").on("click", function(){
		sim.style.overflow = "scroll";
	});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.js" integrity="sha512-c5JDIvikBZ6tuz+OyaFsHKvuyg+tCug3hf41Vmmd5Yz9H5anj4vZOqlBV5PJoEbBJGFCgKoRT9YAgko4JS6/Qw==" crossorigin="anonymous"></script>

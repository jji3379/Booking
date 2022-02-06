<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

	
    <c:forEach var="b" items="${detailAjax }" varStatus="status">
    <ul class="simAjax">
        <li>
            <a href="${pageContext.request.contextPath }/book/${b.isbn }">
            	<img src="${b.image}" alt="" />
            	<p class="bookT">${b.title }</p>
        		<p class="bookT down"  data-num="${fn:length(detailAjax)}"></p>
            </a>        	
        </li>
    </ul>
    
    </c:forEach>
   
<script>
	//simList hover시 overflow = scroll;
	var sim = document.getElementById("simList");
	$("#simList").hover(function(){
		sim.style.overflowY = "scroll";
	});
	//plus 버튼 클릭시 스크롤 다운 구현
	$(document).ready(function($) {
		var down = 145;
		var px = 'px';
		var i = 1;
		var maxDown = $('.down').attr('data-num'); //최대 책 개수

		$('#plus').on('click', function(event){
			event.preventDefault();
			sim.style.overflowY = "scroll";
			if( maxDown != null && i < maxDown){
				i++;	
   				$('#simList').animate({
   			 		scrollTop: down*i+px
   			 	},100);	
			}
		})
	})
	
</script>

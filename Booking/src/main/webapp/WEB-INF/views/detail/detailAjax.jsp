<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

	
    <c:forEach var="b" items="${detailAjax }">
    <ul class="simAjax">
        <li>
            <a href="book/${b.isbn }">
            	<img src="${b.image}" alt="" />
            	<p class="bookT">${b.title }</p>
            </a>        	
        </li>
    </ul>
    </c:forEach>
   
<script>
	var sim = document.getElementById("simList");
	$("#simList").hover(function(){
		sim.style.overflowY = "scroll";
	});
	$('#plus').on('click', function(event){
		sim.style.overflowY = "scroll";
		var e = $.Event("keydown");
		e.which = 13;
		e.keyCode = 115;
		$(document).trigger(e); 
	});
</script>

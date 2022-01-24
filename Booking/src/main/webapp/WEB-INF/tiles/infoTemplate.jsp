<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제목</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
    <div>
	    <div id="header"><tiles:insertAttribute name="header" /></div>
	    <div id="main">
		    <div id="menu">
		    	<tiles:insertAttribute name="menu" />		
		    </div>
	    </div>
	   	<div id="footer"><tiles:insertAttribute name="footer" /></div>   
    </div>
        
    <script type="text/javascript">
        $(function() {
                  
        });    
    </script>    
</body>
</html>

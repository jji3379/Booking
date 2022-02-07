<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제목</title>
    <style>
    	
        #header{    
        	position: relative;
			width: 100%;
			height: 138px;
	    }
        #main{
            padding:-138px 0 -177px 0; 
            width:100%;
            min-height: calc( 100vh - 177px);
        }
        #footer{
			width: 100%;
			height: 0; 
        	clear: both;
        }
    </style>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
    <div id="Wrapper">
	    <div id="header"><tiles:insertAttribute name="header" /></div>
	    <div id="main">
	    	<tiles:insertAttribute name="body" />
	    </div>
	   	<div id="footer"><tiles:insertAttribute name="footer" /></div>   
    </div>
 
    <script type="text/javascript">
        $(function() {
 
        });    
    </script>    
</body>
</html>
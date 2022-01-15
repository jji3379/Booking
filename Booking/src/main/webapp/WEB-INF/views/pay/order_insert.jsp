<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	    <div id="header"><tiles:insertAttribute name="header" /></div>
	    <div id="main">
	    	<tiles:insertAttribute name="body" />
	    </div>
	   	<div id="footer"><tiles:insertAttribute name="footer" /></div>   
    </div>
</body>
</html>
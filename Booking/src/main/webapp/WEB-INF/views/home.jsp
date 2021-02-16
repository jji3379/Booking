<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<jsp:include page="include/resource.jsp"></jsp:include>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>

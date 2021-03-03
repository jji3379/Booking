<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>/review/reviewBookList.jsp</title>
</head>
<body>
    <center>
        <form action="reviewBookList.do">
            <input type="text" name="keyword" >
            <input type="submit" value="검색">
        </form>
    </center>
    <table>
        <tr>
            <td colspan="7" width="100%" bgcolor="pink"></td>
        </tr>
        <c:forEach items="${reviewBookList}" var ="b">
            <tr>
                <td rowspan="2"><img src="${b.image}"></td>
                <td rowspan="4" width="800">"${b.title}"</td>
                <td width="200">${b.author}</td>
            </tr>
            <tr>
                <td width="200">${b.price }</td>
                <td width="200">${b.discount }</td>
                <td width="200">${b.publisher }</td>
                <td width="200">${b.pubdate }</td>
                <td width="200">${b.isbn }
               		<a href="${pageContext.request.contextPath }/review/private/reviewInsertform.do?d_isbn=${b.isbn }" >선택</a>
                </td>
            </tr>
            <tr>
                <td colspan="7">${b.description}</td>
            </tr>
            <tr>
                <td colspan="7" width="80%" bgcolor="pink"></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
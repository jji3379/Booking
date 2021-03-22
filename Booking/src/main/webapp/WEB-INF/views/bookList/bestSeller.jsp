<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bookList.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	
	.wrapper {
		font-family: 'Lato', Arial, sans-serif;
		color: #989c9b;
		line-height: 1.5em;
		margin: 0 auto;
		width: 100%;
	}
	
	table {
	    border-collapse: collapse;
	    width: 100%;
	    height:100%;
	    background: #fff;
	}
	
	th {
	    background-color: #326295;
	    font-weight: bold;
	    color: #fff;
	}
	
	th {
	    text-align: center;
	}
	td {
	    text-align: left;
	}

	
	tbody th {
		background-color: #2ea879;
	}
	tbody tr:nth-child(2n-1) {
	    background-color: #f5f5f5;
	    transition: all .125s ease-in-out;
	}
	tbody tr:hover {
	    background-color: rgba(50,98,149,.3);
	}
	
	td.rank {
		text-align:center;
		text-transform: capitalize;
		width:17%;
	}
	.Hrow{
		height:44px;
	}
	.Brow{
		height:35px
	}
	.title{
		width:83%;
		max-width: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	
</style>
</head>
<body>
<div class="wrapper">
	<table>
		<thead>
			<tr class="Hrow">
				<th>Rank</th>
				<th>Title</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="b" items="${bestSeller}" varStatus="status">
				<tr class="Brow" >
					<td class="rank">${status.count }</td>
					<td class="title" ><a href="${pageContext.request.contextPath }/detail/bookDetail.do?d_isbn=${b.isbn }">${b.title }</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>



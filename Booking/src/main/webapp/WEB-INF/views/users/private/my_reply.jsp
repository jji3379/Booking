<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="myReply">
	<h1>작성 댓글 보기</h1>
	<table class="myReply-tb">
		<caption>Total : 3</caption>
		<colgroup>						
			<col style="width:8%"/>
			<col style="width:57%"/>
			<col style="width:15%"/>
			<col style="width:20%"/>
		</colgroup>
		<thead>
			<tr class="myReply-tr">
				<th>번호</th>
				<th>댓글</th>
				<th>날짜</th>
				<th>원문</th>
			</tr>
		</thead>
		<tbody>
			<tr class="myReply-tr">
				<td>3</td>
				<td class="myReply-tdReply">달러구트 별로던데..</td>
				<td>2022/01/03 11:31</td>
				<td class="myReply-tdTitle">달러구트를 읽고...</td>
			</tr>
			<tr class="myReply-tr">
				<td>2</td>
				<td class="myReply-tdReply">달러구트2는 내지말았어야함</td>
				<td>2022/01/02 11:12</td>
				<td class="myReply-tdTitle">달러구트2를 읽고...</td>
			</tr>
			<tr class="myReply-tr">
				<td>1</td>
				<td class="myReply-tdReply">아몬드브리즈 맛있어</td>
				<td>2022/01/01 11:11</td>
				<td class="myReply-tdTitle">아몬드를 읽고</td>
			</tr>
		</tbody>
	</table>
	<nav id = "paging">
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="">
					<li class="page-item">
						<a class="page-link" href="reviewList.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">&lt;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&lt;</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="" end="">
				<c:choose>
					<c:when test="">
						<li class="page-item active">
							<a class="page-link" href="reviewList.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="reviewList.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="">
					<li class="page-item">
						<a class="page-link" href="reviewList.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">&gt;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&gt;</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
</div>
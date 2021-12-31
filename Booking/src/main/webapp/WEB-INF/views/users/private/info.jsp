<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<style>
	a {
		text-decoration: none;
	}
	.layout{
	    width: 100%;
		display: flex;
		flex-direction: column;
		flex: 1 1 0%;
		max-width: 1200px;
		margin: 0px auto;
		padding: 0px 65px;
		min-height: 446px;
	}	
	.header{
		width: 100%;
	    display: flex;
	    flex-flow: row nowrap;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    -webkit-box-align: center;
	    align-items: center;
	    padding: 32px 0px 12px;
	    box-sizing: border-box;
	}
	.primary{
		width: 155px;
    	margin-right: 65px;
	}
	.secondary{
	    flex: 1 1 0%;
    	height: 100%;
	}
	.top3{
		display: flex;
	    height: 100%;
	    background-color: #eee;
	    border-radius: 4px;
	    padding: 16px 0px;
	}
	.bd-card {
	    border-right: 1px solid #bbb;
    	flex: 1 1 0%;
   		color: #333;
	}
	.last {
		border: none;
    	flex: 1 1 0%;
   		color: #333;
	}
	dl.card{
		margin: 0px;
	    display: flex;
	    flex-flow: column nowrap;
	    -webkit-box-pack: justify;
	    justify-content: space-between;
	    height: 100%;
	    padding: 0px 28px;
	}
	dd.value{
		margin: 0;
	}
	.body{
		width: 100%;
    	display: flex;
    	box-sizing: border-box;
	}
</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<h4>안녕하세요,</h4>
			<span>catacat3</span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="">
					<dl class="card">
						<dt class="label">
							<span>작성글</span>
						</dt>
						<dd class="value">
							<span>0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="">
					<dl class="card">
						<dt class="label">
							<span>작성 댓글</span>
						</dt>
						<dd class="value">
							<span>0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="">
					<dl class="card">
						<dt class="label">
							<span>???</span>
						</dt>
						<dd class="value">
							<span>???</span>
							<span></span>
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</div>
	<div class="body">
		
	</div>
</div>
<script>
//회원탈퇴묻기
function deleteConfirm(){
		let isDelete=confirm(" 회원님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		} else {
			location.reload();
		}
}
</script>
</body>
</html>
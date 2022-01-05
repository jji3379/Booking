<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책과의 즉석만남 Booking</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/info.css">
</head>
<style>
</style>
<body >
<div class="layout">
	<div class="header">
		<div class="primary">
			<h4>안녕하세요 ,</h4>
			<span>catacat3 </span>님!
		</div>
		<div class="secondary">
			<div class="top3">
				<a class="bd-card" href="">
					<dl class="card">
						<dt class="label">
							<span>작성글 ></span>
						</dt>
						<dd class="value">
							<span class="count">0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card" href="">
					<dl class="card">
						<dt class="label">
							<span>작성 댓글 ></span>
						</dt>
						<dd class="value">
							<span class="count">0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
				<a class="bd-card last" href="">
					<dl class="card">
						<dt class="label">
							<span>북카트 ></span>
						</dt>
						<dd class="value">
							<span class="count">0</span>
							<span>개</span>
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</div>
	<div class="body">
		<div class="navigation">
			<div class="section">
				<div class="section-name">나의 쇼핑</div>
				<div class="linkList">
					<a id="side-order" class="link" href="javascript:">주문 내역</a>
					<a class="link" href=""></a>
					<a class="link" href=""></a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">계정 관리</div>
				<div class="linkList">
					<a id="side-profile" class="link" href="javascript:">계정정보 수정</a>
					<a id="side-pwd" class="link" href="javascript:">비밀번호 수정</a>
					<a class="link" href="">최근 검색 기록</a>
				</div>
			</div>
			<div class="section">
				<div class="section-name">북킹 소개</div>
			</div>
			<button class="logoutBtn">
				<div>로그아웃</div>
			</button>
		</div>
		<div class="content">
			<ul class="content-list">
				<li class="part">
					<div class="part-header">
						최근 주문내역
						<a href="">주문전체보기 ></a>
					</div>
					<div id="myOrder" class="part-body">
						<table>
							<colgroup>
								<col style="width:60%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div>총 1개 상품</div>
									</td>
									<td>
										<div>2021/10/10</div>
									</td>
									<td>
										<div class="order-num">1234567890</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</li>
				<li class="part">
					<div class="part-header">
						내 계정 정보
						<a href="">변경하기 ></a>
					</div>
					<div class="part-body">
						<div class="info-account">
							catcat3
							<br />
							catcat3@naver.com
							<br />
							<span>고양이</span>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
			
	
<script>
	$('#side-order').on('click',function(){
		function updateInfo(){
		    $.ajax({ 
		       	url:"my_order.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
		updateInfo();
	})
	
	//sidebar ajax
	$('#side-profile').on('click',function(){
		function updateProfile(){
		    $.ajax({ 
		       	url:"updateform.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
		updateProfile();
	})
	$('#side-pwd').on('click',function(){
		function updatePwd(){
		    $.ajax({ 
		       	url:"pwd_updateform.do",
		        method:"GET",
		        success:function(data){
		           $(".content").html(data); //by 준영, 해당 문자열을 #simList div 에 html 로 추가_210222
		        },
		        
		    })
		}
		updatePwd();
	})
	
	
	
	
	//회원탈퇴묻기
	function deleteConfirm(){
		let isDelete=confirm(" 회원님 정말로 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		} else {
			location.reload();
		}
	}
</script>
</body>
</html>
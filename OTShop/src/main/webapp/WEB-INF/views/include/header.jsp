<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OTShop</title>

<!-- <link rel="stylesheet" href="/css/otshop.css"> -->
<link rel="stylesheet" href="/css/common.css">
<script type="text/javascript" src="/script/product.js"></script>
<script type="text/javascript" src="/script/cart.js"></script>
<script type="text/javascript" src="/script/member.js"></script>
<script type="text/javascript" src="/script/customer.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

<div class="wrap">
	<header>
	<div id="category">
		<img src="/images/logo.png" width="180" height="80" onclick="location.href='/'">
		<form action="searchProduct" method="get">
			<input type="search" id="mainSearch" placeholder="상품명을 입력하세요" value="${keyword}" name="keyword">
			<button type="submit"><img src="/images/search.png" ></button>
		</form>
		<nav id="category_menu">
			<ul>
				<li><a href="">랭킹</a></li>
				<li><a href="">업데이트</a></li>
				<li><a href="">세일</a></li>
				<li><a href="faqList">FAQ</a></li>
				<li><a href="qnaList">고객센터</a></li>
			</ul>
		</nav>	
	</div>
	
	<div id="top_menu">
				<c:choose>
					<c:when test="${empty loginUser}">
						<input type="button" value="로그인" onclick="location.href='loginForm';">
						<nav>
							<ul>
								<li><a href="contract">회원가입</a></li>
								<li><a href="myPage">마이페이지</a><li>
								<li><a href="cartList">장바구니</a></li>
							</ul>
						</li>
					</c:when>
					
					<c:otherwise>
						<a href="logout">
							<input type="button" value="로그아웃">
						</a>
						<nav>
							<ul>
								<!-- 사용자 계정 클릭 : 사용자 정보 수정으로 이동 -->
								<li><a href="medit">${loginUser.NAME} (${loginUser.USERID})</li>
								<!-- 마이페이지 클릭 : 사용자 주문 정보 조회로 이동 -->
								<li><a href="myPage">마이페이지</a><li>
								<li><a href="cartList">장바구니</a></li>
							</ul>
						</nav>
					</c:otherwise>
				</c:choose>
	</div>
	</header>
	
	<div class="body_wrap">
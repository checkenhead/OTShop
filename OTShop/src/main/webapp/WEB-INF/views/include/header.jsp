<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/css/otshop.css">
<script type="text/javascript" src="/script/member.js"></script>

</head>
<body>

<header>

<div id="category">
	<img src="/images/logo.png" width="180" height="80" onclick="location.href='/'">
	<form action="/mainSearch" method="get">
		<input type="search" id="mainSearch" placeholder="상품명을 입력하세요">
		<button type="submit"><img src="/images/search.png"></button>
	</form>
	<nav id="category_menu">
		<ul>
			<li><a href="">랭킹</a></li>
			<li><a href="">업데이트</a></li>
			<li><a href="">세일</a></li>
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
							<li><a href="mypage">마이페이지</a><li>
							<li><a href="cartList">장바구니</a></li>
							<li><a href="customer">고객센터</a></li>
						</ul>
					</li>
				</c:when>
				
				<c:otherwise>
					<a href="logout">
						<input type="button" value="로그아웃">
					</a>
					<nav>
						<ul>
							<li><a href="memberEditForm">${loginUser.NAME} (${loginUser.USERID})</li>
							<li><a href="mypage">마이페이지</a><li>
							<li><a href="cartList">장바구니</a></li>
							<li><a href="customer">고객센터</a></li>
						</ul>
					</nav>
				</c:otherwise>
			</c:choose>
</div>


</header>
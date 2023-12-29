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

</head>
<body>

<header>

<div id="logo">
	<a href="/"><img src="/images/logo.png" width="180" height="80" style="border:1px solid white;"></a>
	<nav id="top_menu">
		<ul>
			<li><a href="">랭킹</a></li>
			<li><a href="">업데이트</a></li>
			<li><a href="">세일</a></li>
			<c:choose>
				<c:when test="${empty loginUser}">
					
				</c:when>
			</c:choose>
			
		</ul>
	</nav>	
</div>


</header>
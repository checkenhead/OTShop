<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OT Shop Admin Page</title>

<link rel="stylesheet" type="text/css" href="admin/css/admin.css">
<script type="text/javascript" src="admin/script/admin.js"></script>

</head>
<body>

<header>

	<div class="logo"><a href="adminMain"><img src="admin/images/logo_admin.png"></a></div>
	<div class="adminLogin">
	<c:choose>
		<c:when test="${empty loginAdmin}"><a href="adminLoginForm">Login</a></c:when>
		<c:otherwise>
			${loginAdmin.NAME}(${loginAdmin.ADMINID})<a href="adminLogout">Logout</a>
		</c:otherwise>
	</c:choose>
	</div>
	<div class="top_menu">
		<ul>
			<li>상품</li><li>주문</li><li>회원</li><li>Q&amp;A</li><li>FAQ</li><li>배너</li><li>통계</li>
		</ul>
	</div>
</header>

<div id="wrap">
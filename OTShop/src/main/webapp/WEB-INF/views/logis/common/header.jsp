<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OT Shop Logis Page</title>

<link rel="stylesheet" type="text/css" href="logis/css/logis.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="logis/script/logis.js"></script>

</head>
<body>
<div class="header_wrap">
<header>

	<div class="logo"><a href="logisMain"><img src="logis/images/logisLogo.png"></a></div>
	<div class="adminLogin">
	<c:choose>
		<c:when test="${empty loginLogis}"><a href="logisLoginForm">Login</a></c:when>
		<c:otherwise>
			${loginLogis.NAME}(${loginLogis.LOGISID})<a href="logisLogout">Logout</a>
		</c:otherwise>
	</c:choose>
	</div>
	<div class="top_menu">
		<ul>
			<li><a href="">신규</a></li>
			<li><a href="">진행중</a></li>
			<li><a href="">배송 내역</a></li>
		</ul>
	</div>
	<div class="clear"></div>
		


</header>
</div>

<div class="main_wrap">

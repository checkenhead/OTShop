<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/css/otshop.css">
<script type="text/javascript" src="/script/member.js"></script>

</head>
<body>

<h1>아이디 중복확인</h1>
<form method="get" name="idCheckFrm" action="idCheckForm">
	아이디 <input type="text" name="userid" value="${userid}">
	<input type=submit value="조회">
	<div>
		<c:if test="${result == 1}">
			<script type="text/javascript">opener.document.joinFrm.userid.value="";</script>
			${userid}는 이미 사용중입니다.<br>
			다른 아이디를 사용하세요.
		</c:if>
		<c:if test="${result == -1}">
			${userid}는 사용 가능합니다.<br>
			<input type="button" value="사용" onclick="idok('${userid}')">
		</c:if>
	</div>

</form>

</body>
</html>
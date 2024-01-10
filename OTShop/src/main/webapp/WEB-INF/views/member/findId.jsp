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
<body id="idcheck">

<span id="title">아이디 찾기</span>
<hr>
<form method="get" name="findIdFrm" action="findId">
	<div>
		<c:if test="${result eq 1}">
			${name}님의 아이디는 [  ${userid}  ]입니다.
			<input type="button" value="확인" onclick="findClose()">
		</c:if>
		<c:if test="${result eq -1}">
			가입 이력이 없습니다. 회원 가입 후 이용바랍니다.<br>
			<input type="button" value="확인" onclick="findClose()">
		</c:if>
	</div>

</form>

</body>
</html>
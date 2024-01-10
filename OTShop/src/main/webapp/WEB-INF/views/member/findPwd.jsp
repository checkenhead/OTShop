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

<span id="title">비밀번호 찾기</span>
<hr>
<form method="post" name="findPwdFrm" action="findPwd">
	<div>
		<c:if test="${result eq 1}">
			${userid}님의 비밀번호는 [  ${pwd}  ]입니다.
			<input type="button" value="확인" onclick="findClose()">
		</c:if>
		<c:if test="${result eq -1 || result == '0'}">
			가입 이력이 없습니다. 회원 가입 후 이용바랍니다.<br>
			<input type="button" value="확인" onclick="findClose()">
		</c:if>
		<c:if test="${result eq 2 }">
			비밀번호 답변이 맞지 않습니다.
			<input type="button" value="확인" onclick="findClose()">
		</c:if>
	</div>

</form>

</body>
</html>
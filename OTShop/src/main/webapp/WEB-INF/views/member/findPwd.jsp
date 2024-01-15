<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/otshop.css">
<script type="text/javascript" src="/script/member.js"></script>

<html id=loginHtml>
<body id=loginBody>
<article id=login>


<form method="post" name="findIdFrm" id="findAccForm">
	<div id="loginTop">
		<img src="/images/back.png" onclick="history.go(-1);">
		<span class="findAccTop">ID / PW 찾기</span>
	</div>
	
	<div  id="loginBottom">
	<span class="findTitle">비밀번호 찾기</span>
	<hr>
		<c:if test="${result == 1}">
			<span class="result" >${userid}님의 비밀번호는 [  ${pwd}  ]입니다.</span>
			<input type="button" class="gofind" value="확인" onclick="history.go(-1);">
		</c:if>
		<c:if test="${result == -1}">
			<span class="result" >가입 이력이 없습니다. <br> 회원 가입 후 이용바랍니다.<br></span>
			<input type="button" class="gofind" value="확인" onclick="history.go(-1);">
		</c:if>
		<c:if test="${result == 2 }">
			<span class="result" >질문 선택이 맞지 않습니다.</span>
			<input type="button" class="gofind" value="확인" onclick="history.go(-1);">
		</c:if>
		<c:if test="${result == 3 }">
			<span class="result" >답변이 맞지 않습니다.</span>
			<input type="button" class="gofind" value="확인" onclick="history.go(-1);">
		</c:if>
	</div>

</form>


</article>
</body>
</html>
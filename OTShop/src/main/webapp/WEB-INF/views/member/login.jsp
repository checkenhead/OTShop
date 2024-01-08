<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">

<html id=loginHtml>
<body id=loginBody>
<article id=login>

<form method="post" action="login" name="loginFrom">
	<div id="loginTop">
		<img src="/images/back.png" onclick="history.go(-1);">
		<span>로그인</span>
	</div>
	<div id="loginBottom">
	<span>가입 회원</span>
	<hr>
	<input type="text" name="userid" class="loginData" value="${empty dto.userid ? '아이디' : dto.userid}"><br>
	<input type="password" name="pwd" class="loginData" value="패스워드"><br>
	<span id="statueText">${message}</span><br>
	<input type="submit" value="로그인"><br>
	<input type="button" id="joinBtn" value="회원가입" onclick="location.href='contract'">
	<input type="button" id="findBtn" value="아이디 | 비밀번호 찾기"><br>
	<a href="kakaostart" ><img src="/images/kakao.png" id="kakaoBtn"></a><br>
	<img src="/images/apple.png" id="appleBtn" ><br>
	<span id="joinText">가입 즉시 20% 할인 쿠폰 지급!</span>
	
	
	
	</div>
		
	
</form>

</article>

</body>
</html>



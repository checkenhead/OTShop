<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">


<article>

<form method="post" action="login" name="loginFrom">
	<div id="loginTop">
		<img src="/images/back.png" onclick="history.go(-1);">
		<span>로그인</span>
	</div><br>
	<fieldset id="loginBottom">
	<span>가입 회원</span>
	<hr>
	<input type="text" name="userid" class="loginData" value="${dto.userid}"><br>
	<input type="password" name="pwd" class="loginData">
	<span>${message }</span>
	<input type="submit" id="loginBtn" value="로그인"><br>
	<input type="button" id="findBtn" value="아이디 | 비밀번호 찾기"><br>
	<a href="kakaostart" ><img src="/images/kakao.png"  style="width:300px;"></a><br>
	<img src="/images/apple.png"    style="width:300px;"><br>
	가입 즉시 20% 할인 쿠폰 지급 <input type="button" value="회원가입" onclick="location.href='contract'">
	
	</fieldset>
		
	
</form>

</article>




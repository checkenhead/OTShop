<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">

<html id=loginHtml>
<body id=loginBody>
<article id=login>

<form method="post" action="findId" name="loginFrom">
	<div id="loginTop">
		<img src="/images/back.png" onclick="history.go(-1);">
		<span>ID / PW 찾기</span>
	</div>
	<div id="loginBottom">
	<span>아이디 찾기</span>
	<hr>
	<input type="text" name="userid"  placeholder="이름" value="${dto.userid}" ><br>
	<input type="text" name="email" placeholder="이메일" value="${dto.email}"><br>
	<input type="submit" value="findId"><br>
	
	<span>비밀번호 찾기</span>
	<hr>
	<input type="text" name="userid" placeholder="아이디" value="${dto.userid}"><br>
	<select id="pwdAsk" name="pwdAsk">
		<option value="nonoption" selected>---- 질문을 선택하세요 ----</option>
		<option value="1" >기억에 남는 추억의 장소는?</option>
		<option value="2">가장 기억에 남는 선생님 성함은?</option>
		<option value="3">유년시절 가장 생각나는 친구 이름은?</option>
	</select><br>
	<input type="text" name="pwdAskCheck" placeholder="질문에 대한 답변을 입력하세요"><br>
	<input type="submit" value="findPwd"><br>
	
	<span id="statueText">${message}</span><br>
	<input type="button" id="joinBtn" value="로그인 하러 가기" onclick="location.href='loginForm'"><br>
	<input type="button" id="joinBtn" value="회원가입 하러 가기" onclick="location.href='contract'">
	
	
	</div>
		
	
</form>

</article>

</body>
</html>




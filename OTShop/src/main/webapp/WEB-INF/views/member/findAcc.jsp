<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">
<script type="text/javascript" src="/script/member.js"></script>

<html id=loginHtml>
<body id=loginBody>
<article id=login>

<form method="get" action="findId" id="findAccForm" name="findAccFrm">
	<div id="loginTop">
		<img src="/images/back.png" onclick="history.go(-1);">
		<span>ID / PW 찾기</span>
	</div>
	<div id="loginBottom">
	<span class="findTitle">아이디 찾기</span>
	<hr>
	<input type="text" name="name"  placeholder="이름"  ><br>
	<input type="text" name="email" placeholder="이메일" ><br>
	<input type="submit" value="아이디 찾기"><br><br><br><br>
</form>

<form method="post" action="findPwd" id="findAccForm" name="findAccFrm">	
	<span class="findTitle">비밀번호 찾기</span>
	<hr>
	<input type="text" name="userid" placeholder="아이디" ><br>
	<select name="kind">
		<option value="0" selected>---- 질문을 선택하세요 ----</option>
		<option value="1" >기억에 남는 추억의 장소는?</option>
		<option value="2">가장 기억에 남는 선생님 성함은?</option>
		<option value="3">유년시절 가장 생각나는 친구 이름은?</option>
	</select><br>
	<input type="text" name="answer" placeholder="답변 입력"><br>
	<input type="submit" value="비밀번호 찾기"><br>
</form>
	<span id="statueText">${message}</span><br>
	<input type="button" id="joinBtn" value="로그인 하러 가기" onclick="location.href='loginForm'"><br>
	<input type="button" id="joinBtn" value="회원가입 하러 가기" onclick="location.href='contract'">
	
	
	</div>
		
	


</article>

</body>
</html>




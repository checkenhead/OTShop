<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/member.css">
<script type="text/javascript" src="/script/member.js"></script>

<html>
<body class="loginBody">
<article class="login">
	<form id="contract" action="joinForm" method="post" name="contractFrm">
		<div class="loginTop">
			<img src="/images/back.png" onclick="history.go(-1);">
			<span id="contractTitle">OTSHOP</span>
		</div>
		<div class="loginBottom">
		<span id="welcome">
		환영합니다!<br>
		옷샵에 가입하시려면<br>
		약관에 동의해 주세요😊<br>
		</span><br><br><br>
			<div id="agreebox">
				<span><input type="checkbox" id="allAgree" onclick="checkAll()">약관 전체 동의하기</span><br><br>
				<input type="checkbox" id="ageAgree" >[필수] 만 14세 이상입니다.<br>
				<input type="checkbox" id="useAgree">[필수] 옷샵, 옷샵스토어 이용 약관
					<input type="button" value="자세히" onclick="javascript:useContract()"><br>
				<input type="checkbox" id="infoAgree">[필수] 개인정보 수집 및 이용 동의
					<input type="button" value="자세히" onclick="javascript:infoContract()"><br>
				<input type="checkbox" id="advertAgree1">[선택] 광고성 정보 수집 동의<br>
				<input type="checkbox" id="advertAgree2">[선택] 개인정보 수집 및 이용 동의<br>
			</div>
			<br>
			<input type="button" id="joinGo" value="동의하고 회원가입하기" onclick="goNext()">
			<a href="kakaostart" ><img src="/images/kakao.png" id="kakaoGo"></a><br> 
			
			
	
		
		</div>
	</form>
</article>

</body>
</html>

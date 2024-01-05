<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
	<h3>회원 탈퇴</h3>
	<form method="post" name="mdeleteFrm">
		<fieldset>
		회원 탈퇴시 보유 중인 쿠폰과 주문 내역이 모두 삭제됩니다.<br><br>
		
		정말로 탈퇴하시겠습니까?<br><br>
		
		<input type="button" name="deletey" value="예" onclick="yesDelete('${userid}')">
		<input type="button" name="deleten" value="아니오" onclick="noDelete()">
		
		</fieldset>
	</form>

</article>


<%@ include file="../include/footer.jsp" %>
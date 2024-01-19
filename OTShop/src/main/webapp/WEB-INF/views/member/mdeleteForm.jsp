<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="mdeleteWrap">
<article>
	
	<form method="post" name="mdeleteFrm" class="mupdateFrm">
		<div class="mupdateBanner">
			<span class="bannerTitle">회원탈퇴</span>
		</div><br>
	
		<fieldset id="mtitle2">
		회원 탈퇴시 보유 중인 쿠폰과 주문 내역이 모두 삭제됩니다.<br><br>
		
		정말로 탈퇴하시겠습니까?<br><br>
		
		<input type="button" id="mdeleteY" name="deletey" value="예" onclick="yesDelete('${userid}')">
		<input type="button" id="mdeleteN" name="deleten" value="아니오" onclick="noDelete()">
		
		</fieldset>
	</form>


</article>
</div>

<%@ include file="../include/footer.jsp" %>
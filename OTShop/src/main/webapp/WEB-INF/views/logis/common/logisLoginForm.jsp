<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div style="margin:0 auto;">
<form name="frm" method="post" action="logisLogin">
	<br>
	<input type="text" name="logisid" placeholder="아이디" value="${logisid}"><br>
	<input type="password" name="pwd" placeholder="비밀번호"><br>
	<input type="submit" value="로그인"><br>
	<br>
	${message}
</form>
</div>

<%@ include file="footer.jsp" %>
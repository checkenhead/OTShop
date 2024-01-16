<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userCheckForm.jsp</title>


</head>
<body>

</body>

<div>
	<span>확인 버튼을 눌러 작성자임을 확인하세요</span>
</div><br>
<form method="post" action="userCheckSucc" name="userCkFrm">
<input type="hidden" name="qseq" value="${param.qseq}">
<input type="hidden" name="userid" value="${param.userid}">
<input type="submit" value="확인">
</form>

</html>
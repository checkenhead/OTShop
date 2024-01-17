<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userCheckForm.jsp</title>
<link rel="stylesheet" href="/css/otshop.css">

</head>
<body>
<form method="post" action="userCheckSucc" name="userCkFrm">
	<div class="userCheck">
		<span>확인 버튼을 눌러 작성자임을 확인하세요.</span><br>
		<input type="hidden" name="qseq" value="${param.qseq}">
		<input type="hidden" name="userid" value="${param.userid}"><br>
		<input type="submit" value="확인">
	</div>
</form>


</body>
</html>
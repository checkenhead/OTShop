<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>

<%@ include file="../include/mypageSub.jsp" %>


<article id="wrap2">
<%@ include file="../include/categorySub.jsp" %>

	<form method="post" name="qnaListFrm" id="qnaList">
		<fieldset><legend>1 : 1 문의 내용</legend>
			<table width="600">
				<tr><th width="150" align="center">등록일</th><td style="text-align:left;">${qnaVO.REGDATE}</td></tr>
				<tr><th align="center">구분</th><td style="text-align:left;">${qnaCAT.NAME}</td></tr>
				<tr><th align="center">제목</th><td style="text-align:left;  font-size:120%">${qnaVO.TITLE}</td></tr>
				<tr><th align="center">질문</th><td style="text-align:left;"><pre>${qnaVO.CONTENT}</pre></td></tr>
				<tr><th align="center">답변</th><td style="text-align:left;">${qnaVO.REPLY}</td></tr>
			</table>
		</fieldset>
		<div>
			<input type="button" value="이전으로" onclick="history.go(-1)">
			<input type="button" value="메인으로" onclick="location.href='/'">
		</div>
    </form>
    
</article>
<%@ include file="../include/footer.jsp" %>
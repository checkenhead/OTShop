<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>

<%@ include file="../include/mypageSub.jsp" %>


<article id="wrap2">
<%@ include file="../include/categorySub.jsp" %>

	<form method="post" name="qnaListFrm" id="qnaList">
		<fieldset><legend>1 : 1 상담</legend>
			<table width="600">
				<tr>
					<th>등록일</th><th>구분</th><th>제목</th><th>질문</th><th>답변</th>
				</tr>
				
				<tr>
					<td>${qnaVO.REGDATE}</td><td>${qnaCAT.NAME}</td><td>${qnaVO.TITLE}</td>
					<td>${qnaVO.CONTENT}</td><td>${qnaVO.REPLY}</td>
				</tr>
			</table>
		</fieldset>
		<div>
			<input type="button" value="이전으로" onclick="history.go(-1)">
			<input type="button" value="메인으로" onclick="location.href='/'">
		</div>
    </form>
    
</article>
<%@ include file="../include/footer.jsp" %>
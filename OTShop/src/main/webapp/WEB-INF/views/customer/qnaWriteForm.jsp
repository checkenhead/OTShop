<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>

<article id="wrap2">
    <%@ include file="../include/categorySub.jsp" %>
    
    <form method="post" action="qnaWrite" name="qnaWriteFrm">
    
    	<fieldset><legend>1 : 1 문의하기</legend>
    		<label>제목</label> <input type="text" name="title"><br>
    		<label>구분</label>
    			<select name="qnaname" id="qnaName">
 	               <c:forEach items="${qnaCat}" var="qnaCAT">
	                	<option value="${qnaCAT.QCSEQ}" >${qnaCAT.NAME}</option>
	               </c:forEach>
           		</select>
    		<label>작성자</label> <input type="text" name="userid" value="${userid}" readonly>
    		<label>비밀글</label>
    		<input name="secret" type="checkbox" value="Y"><br>
    		<label>문의 내용</label><textarea rows="8" cols="65" name="content"></textarea><br>
		</fieldset>
		
		<div>
			<span>${message}</span><br>
			<input type="submit" value="저장">
			<input type="button" value="이전으로" onclick="history.go(-1)">
		</div>
    
    </form>
</article>
<%@ include file="../include/footer.jsp" %>
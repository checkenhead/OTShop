<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin qna management</h1>
<br>

<form name="qnaManForm" method="post">
<table class="tblAdminQna">
	<tr><th>번호</th><th>Q&amp;A 분류</th><th>작성자</th><th>제목</th><th>등록일</th><th>답변</th></tr>
	<c:forEach items="${qnaList}" var="qnaVO" varStatus="status">
	<tr>
		<td>${status.count}<input type="hidden" id="qseq_${qnaVO.QSEQ}" value="${qnaVO.QSEQ}"></td>
		<td>
			${qnaVO.NAME}
		</td>
		<td>
			${qnaVO.USERID}
		</td>
		<td>
			<a href="adminViewQna?qseq=${qnaVO.QSEQ}&pseq=${qnaVO.PSEQ}">
				${qnaVO.TITLE}
				<c:if test="${qnaVO.SECRET == 'Y'}"><img src="images/secret.png" style="width:20px;height:20px;"></c:if>
			</a>
		</td>
		<td>
			<fmt:formatDate value="${qnaVO.REGDATE}"/>
		</td>
		<td>
			<c:if test="${empty qnaVO.REPLY}"><span style="color:red;">미완료</span></c:if>
			<c:if test="${not empty qnaVO.REPLY}"><span style="color:blue;">완료</span></c:if>
		</td>
	</tr>
	</c:forEach>
	
</table>
</form>

</div>

<%@ include file="../common/footer.jsp" %>
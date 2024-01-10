<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin qna view</h1>
<br>

<form name="adminViewQnaForm" method="post">
<input type="hidden" name="qseq" value="${qnaVO.QSEQ}">
<input type="hidden" name="pseq" value="${productVO.PSEQ}">
<table class="tblAdminQna">
	<tr>
		<th>분류</th><td>${qnaVO.NAME}</td>
		<th>작성자</th><td>${qnaVO.USERID}</td>
		<th>작성일</th><td><fmt:formatDate value="${qnaVO.REGDATE}"/></td>
	</tr>
	<tr><th>제목</th><td colspan="5">${qnaVO.TITLE}</td></tr>
	<tr><th>내용</th><td colspan="5"><pre>${qnaVO.CONTENT}</pre></td></tr>
	<tr>
		<th>문의상품</th>
		<td colspan="5">
			<c:if test="${empty productVO}">상품이 없습니다.</c:if>
			<c:if test="${not empty productVO.PSEQ}">
				브랜드 : ${productVO.BRAND}<br>
				상품명 : ${productVO.NAME}<br>
				<img src="images/product/${productVO.IMAGE}" height="150">
			</c:if>
		</td>
	</tr>
	<tr>
		<th>답변</th>
		<td colspan="4">
			<textarea name="reply" style="width:98%;" rows="5">${qnaVO.REPLY}</textarea>
		</td>
		<td>
			<c:if test="${empty qnaVO.REPLY}"><div class="btn"><input type="button" value="등록" onClick="reply_to('insert');"></div></c:if>
			<c:if test="${not empty qnaVO.REPLY}"><div class="btn"><input type="button" value="수정" onClick="reply_to('update');"></div></c:if>
		</td>
	</tr>
</table>
<br>
<div class="btn"><input type="button" value="삭제" onClick="go_delete_qna();"></div>
<div class="btn"><input type="button" value="목록으로" onClick="location.href='qnaManagement'"></div>
</form>
</div>

<%@ include file="../common/footer.jsp" %>
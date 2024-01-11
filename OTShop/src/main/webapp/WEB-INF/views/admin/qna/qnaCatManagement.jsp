<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin qna category management</h1>
<br>

<form name="qnaCatForm" method="post">
	<table class="tblAdminQnaCat">
		<tr><th>번호</th><th>Q&amp;A 분류명</th><th>등록된 Q&amp;A 수</th><th>커맨드</th></tr>
		<c:forEach items="${qnaCatList}" var="qnaCat" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>
				<input type="text" id="name_${qnaCat.QCSEQ}" value="${qnaCat.NAME}" readonly>
				<input type="hidden" id="oldName_${qnaCat.QCSEQ}" value="${qnaCat.NAME}">
			</td>
			<td>${qnaCat.COUNT}</td>
			<td>
				<c:choose>
				<c:when test="${qnaCat.COUNT != 0}">
					<div class="btn">
						<input type="button" id="edit_${qnaCat.QCSEQ}" value="수정" onClick="go_edit_cat('${qnaCat.QCSEQ}');">
					</div>
					<div class="btn">
						<input type="button" id="cancel_${qnaCat.QCSEQ}" value="취소" onClick="go_cancel_cat('${qnaCat.QCSEQ}');" style="display:none;">
					</div>
					<div class="btn">
						<input type="button" id="save_${qnaCat.QCSEQ}" value="저장" onClick="go_save_cat('${qnaCat.COUNT}', '${qnaCat.QCSEQ}', 'updateQnaCat');" style="display:none;">
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn">
						<input type="button" value="삭제" onClick="go_delete_cat('${qnaCat.NAME}', '${qnaCat.QCSEQ}', 'deleteQnaCat');">
					</div>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
				<input type="text" id="inputName" name="inputName" style="width:90%;">
				<input type="hidden" id="name" name="name">
				<input type="hidden" id="index" name="qcseq">
			</td>
			<td><div class="btn"><input type="button" value="추가" onClick="go_add_cat('insertQnaCat');"></div></td>
		</tr>
	</table>
</form>

</div>

<%@ include file="../common/footer.jsp" %>
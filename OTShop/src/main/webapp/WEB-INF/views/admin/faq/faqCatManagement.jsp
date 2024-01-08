<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin faq category management</h1>
<br>
<form name="faqCatForm" method="post">
	<table class="tblAdminFaqCat">
		<tr><th>번호</th><th>FAQ 분류명</th><th>등록된 FAQ 수</th><th>커맨드</th></tr>
		<c:forEach items="${faqCatList}" var="faqCat" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>
				<input type="text" id="name_${faqCat.FCSEQ}" value="${faqCat.NAME}" readonly>
				<input type="hidden" id="oldName_${faqCat.FCSEQ}" value="${faqCat.NAME}">
			</td>
			<td>${faqCat.COUNT}</td>
			<td>
				<c:choose>
				<c:when test="${faqCat.COUNT != 0}">
					<div class="btn">
						<input type="button" id="edit_${faqCat.FCSEQ}" value="수정" onClick="go_edit_cat('${faqCat.FCSEQ}');">
					</div>
					<div class="btn">
						<input type="button" id="cancel_${faqCat.FCSEQ}" value="취소" onClick="go_cancel_cat('${faqCat.FCSEQ}');" style="display:none;">
					</div>
					<div class="btn">
						<input type="button" id="save_${faqCat.FCSEQ}" value="저장" onClick="go_save_cat('${faqCat.COUNT}', '${faqCat.FCSEQ}', 'updateFaqCat');" style="display:none;">
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn">
						<input type="button" value="삭제" onClick="go_delete_cat('${faqCat.NAME}', '${faqCat.FCSEQ}', 'deleteFaqCat');">
					</div>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
				<input type="text" id="name" name="name" style="width:90%;">
				<input type="hidden" id="index" name="fcseq">
			</td>
			<td><div class="btn"><input type="button" value="추가" onClick="go_add_cat('insertFaqCat');"></div></td>
		</tr>
	</table>
</form>
</div>

<%@ include file="../common/footer.jsp" %>
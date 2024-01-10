<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin faq management</h1>
<br>

<form name="faqManForm" method="post">
<table class="tblAdminFaq">
	<tr><th>번호</th><th>FAQ 분류</th><th>질문</th><th>답변</th><th>커맨드</th></tr>
	<c:forEach items="${faqList}" var="faqVO" varStatus="status">
	<tr>
		<td>${status.count}<input type="hidden" id="fseq_${faqVO.FSEQ}" value="${faqVO.FSEQ}"></td>
		<td>
			<select id="fcseq_${faqVO.FSEQ}" disabled>
			<c:forEach items="${faqCatList}" var="faqCatVO">
				<c:choose>
				<c:when test="${faqVO.FCSEQ != faqCatVO.FCSEQ}"><option value="${faqCatVO.FCSEQ}">${faqCatVO.NAME}</option></c:when>
				<c:otherwise><option value="${faqCatVO.FCSEQ}" selected>${faqCatVO.NAME}</option></c:otherwise>
				</c:choose>
			</c:forEach>
			</select>
			<input type="hidden" id="oldFcseq_${faqVO.FSEQ}" value="${faqVO.FCSEQ}">
		</td>
		<td>
			<textarea id="title_${faqVO.FSEQ}" style="width:98%;" rows="5" readonly>${faqVO.TITLE}</textarea>
			<textarea id="oldTitle_${faqVO.FSEQ}" style="display:none;">${faqVO.TITLE}</textarea>
		</td>
		<td>
			<textarea id="content_${faqVO.FSEQ}" style="width:98%;" rows="5" readonly>${faqVO.CONTENT}</textarea>
			<textarea id="oldContent_${faqVO.FSEQ}" style="display:none;">${faqVO.CONTENT}</textarea>
		</td>
		<td>
			<div class="btn"><input type="button" id="edit_${faqVO.FSEQ}" value="수정" onClick="faq_edit('${faqVO.FSEQ}');"></div>
			<div class="btn"><input type="button" id="delete_${faqVO.FSEQ}" value="삭제" onClick="faq_delete('${faqVO.FSEQ}');"></div>
			<div class="btn"><input type="button" id="save_${faqVO.FSEQ}" value="저장" onClick="faq_save('${faqVO.FSEQ}');" style="display:none;"></div>
			<div class="btn"><input type="button" id="cancel_${faqVO.FSEQ}" value="취소" onClick="faq_cancel('${faqVO.FSEQ}');" style="display:none;"></div>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<th>신규 등록</th>
		<td>
			<select name="inputFcseq">
			<option value="0" selected>선택</option>
			<c:forEach items="${faqCatList}" var="faqCatVO">
			<option value="${faqCatVO.FCSEQ}">${faqCatVO.NAME}</option>
			</c:forEach>
			</select>
			<input type="hidden" name="fseq">
			<input type="hidden" name="fcseq">
		</td>
		<td>
			<textarea name="inputTitle" style="width:98%;" rows="5"></textarea>
			<textarea name="title" style="display:none;"></textarea>
		</td>
		<td>
			<textarea name="inputContent" style="width:98%;" rows="5"></textarea>
			<textarea name="content" style="display:none;"></textarea>
		</td>
		<td><div class="btn"><input type="button" value="추가" onClick="go_add_faq();"></div></td>
	</tr>
	
</table>
</form>

</div>

<%@ include file="../common/footer.jsp" %>
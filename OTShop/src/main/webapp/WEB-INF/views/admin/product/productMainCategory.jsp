<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin product main category</h1>
<br>

<form name="productCatForm" method="post">
	<input type="hidden" name="categoryClass" value="main">
	<input type="hidden" id="index" name="index">
	<table class="tblAdminProductCat">
	<tr><th>번호</th><th>등록된 상품 수</th><th>메인 카테고리명</th><th>커먼드</th></tr>
	<c:forEach items="${mainCatList}" var="categoryVO" varStatus="status">
	<tr>
		<td>${status.count}</td>
		<td>${categoryVO.COUNT}</td>
		<td>
			<input type="text" id="name_${categoryVO.PMCSEQ}" value="${categoryVO.NAME}" readonly>
			<input type="hidden" id="oldName_${categoryVO.PMCSEQ}" value="${categoryVO.NAME}">
		</td>
		<td>
		<c:choose>
		<c:when test="${categoryVO.COUNT != 0}">
			<div class="btn">
				<input type="button" id="edit_${categoryVO.PMCSEQ}" value="수정" onClick="go_edit_cat('${categoryVO.PMCSEQ}');">
			</div>
			<div class="btn">
				<input type="button" id="cancel_${categoryVO.PMCSEQ}" value="취소" onClick="go_cancel_cat('${categoryVO.PMCSEQ}');" style="display:none;">
			</div>
			<div class="btn">
				<input type="button" id="save_${categoryVO.PMCSEQ}" value="저장" onClick="go_save_cat('${categoryVO.COUNT}', '${categoryVO.PMCSEQ}', 'updateProductCat');" style="display:none;">
			</div>
		</c:when>
		<c:otherwise>
			<div class="btn">
				<input type="button" value="삭제" onClick="go_delete_cat('${categoryVO.NAME}', '${categoryVO.PMCSEQ}', 'deleteProductCat');">
			</div>
		</c:otherwise>
		</c:choose>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<th colspan="2">메인 카테고리 추가</th>
		<td>
			<input type="text" id="inputName" name="inputName">
			<input type="hidden" id="name" name="name">
		</td>
		<td><div class="btn"><input type="button" value="추가" onClick="go_add_cat('insertProductCat');"></div></td>
	</tr>
	</table>
</form>




</div>

<%@ include file="../common/footer.jsp" %>
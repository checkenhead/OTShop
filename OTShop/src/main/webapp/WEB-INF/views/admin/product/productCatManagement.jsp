<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin product category management</h1>
<br>
<form name="productCatForm" method="post">
	<table class="tblAdminProductCat">
		<tr><th>번호</th><th>상품 분류명</th><th>등록된 상품</th><th>커맨드</th></tr>
		<c:forEach items="${productCatList}" var="productCat" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>
				<input type="text" id="name_${productCat.PCSEQ}" value="${productCat.NAME}" readonly>
				<input type="hidden" id="oldName_${productCat.PCSEQ}" value="${productCat.NAME}">
			</td>
			<td>${productCat.COUNT}</td>
			<td>
				<c:choose>
				<c:when test="${productCat.COUNT != 0}">
					<div class="btn">
						<input type="button" id="edit_${productCat.PCSEQ}" value="수정" onClick="go_edit_cat('${productCat.PCSEQ}');">
					</div>
					<div class="btn">
						<input type="button" id="cancel_${productCat.PCSEQ}" value="취소" onClick="go_cancel_cat('${productCat.PCSEQ}');" style="display:none;">
					</div>
					<div class="btn">
						<input type="button" id="save_${productCat.PCSEQ}" value="저장" onClick="go_save_cat('${productCat.COUNT}', '${productCat.PCSEQ}', 'updateProductCat');" style="display:none;">
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn">
						<input type="button" value="삭제" onClick="go_delete_cat('${productCat.NAME}', '${productCat.PCSEQ}', 'deleteProductCat');">
					</div>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
				<input type="text" id="name" name="name" style="width:90%;">
				<input type="hidden" id="index" name="pcseq">
			</td>
			<td><div class="btn"><input type="button" value="추가" onClick="go_add_cat('insertProductCat');"></div></td>
		</tr>
	</table>
</form>
</div>

<%@ include file="../common/footer.jsp" %>
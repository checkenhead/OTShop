<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin product category management</h1>
<br>
<!--
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
-->

<form name="productCatForm" method="post">

	<table class="tblAdminProductCat">
	<!--
	<tr>
		<th>설정</th>
		<td colspan="1">
			<select name="inputMainCategory">
			<option value="0">선택</option>
			<c:forEach items="${mainCatList}" var="mainCatVO" varStatus="status">
				<option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
			</c:forEach>
			</select>
			<input type="hidden" name="mainCategory">
		</td>
		<td colspan="1">
			<select name="inputSubCategory">
			<option value="0">선택</option>
			<c:forEach items="${subCatList}" var="subCatVO" varStatus="status">
				<option value="${subCatVO.PMCSEQ}">${subCatVO.NAME}</option>
			</c:forEach>
			</select>
			<input type="hidden" name="subCategory">
		</td>
		<td>div class="btn"><input type="button" value="저장" onClick="add_product_cat_set();"></div></td>
	</tr>
	-->
	<tr><th>번호</th><th colspan="2">카테고리</th><th>커맨드</th></tr>
	<tbody id="tmp">
		<tr id="emptyMessage"><td colspan="4">등록된 카테고리가 없습니다.</td></tr>
		
		<tr id="tmp_1">
			<th rowspan="2">tmp</th>
			<td id="" colspan="2">
				<select id="inputMainCat_1">
				<c:forEach items="${mainCatList}" var="mainCatVO">
					<option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
				</c:forEach>
				</select>
			</td>
			<td><div class="btn"><input type="button" value="삭제" onClick="remove_main_cat_set('row');"></div></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<select id="inputSubCat_1">
				<option value="0">선택</option>
				<c:forEach items="${subCatList}" var="subCatVO">
					<option value="${subCatVO.PSCSEQ}">${subCatVO.NAME}</option>
				</c:forEach>
				</select>
			</td>
			<td><div class="btn"><input type="button" value="삭제" onClick="remove_sub_cat_set('row');"></div></td>
		</tr>
		
	</tbody>
	
	<tr>
		<th rowspan="2">신규설정</th>
		<td colspan="2">
			<select id="inputMainCat">
				<option value="0">선택</option>
				<c:forEach items="${mainCatList}" var="mainCatVO">
					<option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
				</c:forEach>
			</select>
			<div style="display:none;">
				<select id="inputSubCat">
					<option value="0">선택</option>
					<c:forEach items="${subCatList}" var="subCatVO">
						<option value="${subCatVO.PSCSEQ}">${subCatVO.NAME}</option>
					</c:forEach>
				</select>
			</div>
		</td>
		<td><div class="btn"><input type="button" value="추가" onClick="add_main_cat_set();"></div></td>
	</tr>
	
	<!--
	<tr>
		<th>신규생성</th>
		<td>
			<select name="inputCategoryClass">
				<option value="">선택</option>
				<option value="main">메인 카테고리</option>
				<option value="sub">서브 카테고리</option>
			</select>
			<input type="hidden" name="categoryClass">
		</td>
		<td>
			<input type="text" name="inputName">
			<input type="hidden" name="name">
		</td>
		<td><div class="btn"><input type="button" value="추가" onClick="add_product_cat();"></div></td>
	</tr>
	-->
	</table>
</form>




</div>

<%@ include file="../common/footer.jsp" %>
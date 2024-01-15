<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin view product</h1>
<br>


<form name="adminViewProductForm" method="post">
<input type="hidden" name="formName" value="adminViewProductForm">
<input type="hidden" id="pseq" name="pseq" value="${productVO.PSEQ}">
	<table class="tblAdminProduct">
	<tr>
		<th>메인 카테고리</th>
		<td colspan="10">
		<div id="mainView" style="display:flex;">
			<c:if test="${empty mainSelectedCatList}"><span id="mainCatEmptyMessage">카테고리를 추가하세요.</span></c:if>
			<c:if test="${not empty mainSelectedCatList}"><span id="mainCatEmptyMessage" style="display:none;">카테고리를 추가하세요.</span></c:if>
			<c:forEach items="${mainSelectedCatList}" var="mainCat" varStatus="stauts">
				<div id="mainCat_${mainCat.PMCSEQ}" style="display:flex; margin-left:5px; margin-right:5px;">
					<div style="line-height:25px;">
						<c:forEach items="${mainCatList}" var="Cat"><c:if test="${Cat.PMCSEQ == mainCat.PMCSEQ}">${Cat.NAME}</c:if></c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
		</td>
	</tr>
	<tr>
		<th>서브 카테고리</th>
		<td colspan="10">
		<div id="subView" style="display:flex;">
			<c:if test="${empty subSelectedCatList}"><span id="subCatEmptyMessage">카테고리를 추가하세요.</span></c:if>
			<c:if test="${not empty subSelectedCatList}"><span id="subCatEmptyMessage" style="display:none;">카테고리를 추가하세요.</span></c:if>
			<c:forEach items="${subSelectedCatList}" var="subCat" varStatus="stauts">
				<div id="subCat_${subCat.PSCSEQ}" style="display:flex; margin-left:5px; margin-right:5px;">
					<div style="line-height:25px;">
						<c:forEach items="${subCatList}" var="Cat"><c:if test="${Cat.PSCSEQ == subCat.PSCSEQ}">${Cat.NAME}</c:if></c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
		</td>
	</tr>
	
	<tr>
		<th>브랜드</th><td colspan="3">${productVO.BRAND}</td>
		<th>상품명</th><td colspan="3">${productVO.NAME}</td>
		<th>성별</th>
		<td colspan="2">
			<c:if test="${productVO.GENDER == 'N'}">남여공용</c:if>
			<c:if test="${productVO.GENDER == 'M'}">남성용</c:if>
			<c:if test="${productVO.GENDER == 'F'}">여성용</c:if>
		</td>
	</tr>
	<tr>
		<th>등록일</th><td colspan="2"><fmt:formatDate value="${productVO.REGDATE}"/></td>
		<th>Best상품</th>
		<td colspan="2">
			<c:choose>
				<c:when test="${productVO.BESTYN == 'Y'}">예</c:when>
				<c:otherwise>아니오</c:otherwise>
			</c:choose>
		</td>
		<th>판매허용</th>
		<td colspan="2">
			<c:choose>
				<c:when test="${productVO.USEYN == 'Y'}">예</c:when>
				<c:otherwise>아니오</c:otherwise>
			</c:choose>
		</td>
		<th>조회수</th><td>${productVO.VIEWCOUNT}</td>
	</tr>
	<tr>
		<th>설명</th><td colspan="10"><pre>${productVO.DESCRIPTION}</pre></td>
	</tr>
	<c:choose>
		<c:when test="${empty productVO.optionList || fn:length(productVO.optionList) == 0}">
			<tr><th rowspan="2">옵션</th></tr>
		</c:when>
		<c:otherwise><tr><th rowspan="${(fn:length(productVO.optionList) * 2) + 1}">옵션</th></tr></c:otherwise>
	</c:choose>
		
	<c:choose>
		<c:when test="${empty productVO.optionList || fn:length(productVO.optionList) == 0}"><tr><td colspan="7">등록된 옵션이 없습니다.</td></tr></c:when>
		<c:otherwise>
			<c:forEach items="${productVO.optionList}" var="opt" varStatus="status">
				<tr>
				<th rowspan="2">${status.count}</th>
				<th>옵션명</th><td colspan="2">${opt.OPTNAME}</td>
				<th>재고</th><td colspan="2">${opt.STOCK}</td>
				<th>판매허용</th>
				<td colspan="2">
					<c:choose>
						<c:when test="${opt.USEYN == 'Y'}">예</c:when>
						<c:otherwise>아니오</c:otherwise>
					</c:choose>
				</td>
				</tr>
				<tr>
				<th>원가</th><td colspan="2"><fmt:formatNumber type="currency" value="${opt.PRICE1}"/></td>
				<th>판매가</th><td colspan="2"><fmt:formatNumber type="currency" value="${opt.PRICE2}"/></td>
				<th>마진</th><td colspan="2"><fmt:formatNumber type="currency" value="${opt.PRICE3}"/></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<th>사진</th>
		<td colspan="10">
			<div id="filename">${productVO.IMAGE}</div>
			<input type="hidden" id="image" name="image" value="${productVO.IMAGE}">
			<input type="hidden" id="previewFilename" name="previewFilename" value="${previewFilename}">
			<div id="preview"><c:if test="${not empty productVO.IMAGE}"><img src="images/product/${productVO.IMAGE}" height="150"></c:if></div>
			<!-- <input class="btn" type="button" value="사진선택" onClick="upload_click();"> -->
		</td>
	</tr>
	</table>
	<br>
	<div>
		<div class="btn"><input type="button" value="수정" onClick="go_edit_product('${productVO.PSEQ}');"></div>
		<div class="btn"><input type="button" value="목록으로" onClick="location.href='productManagement'"></div>
	</div>
</form>
<div class="message">${message}</div>
<div style="display:none;">
<form id="fileup" name="fileup" method="post" enctype="multipart/form-data">
	<input type="file" name="upload" onChange="copy_filename();">
</form>
</div>

</div>

<%@ include file="../common/footer.jsp" %>
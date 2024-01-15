<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin update product</h1>
<br>


<form name="updateProductForm" method="post">
<input type="hidden" name="formName" value="updateProductForm">
<input type="hidden" name="pseq" value="${productVO.PSEQ}">
<input type="hidden" name="delIndex">

<div id="template" style="display:none;">
	<div id="#categoryClassCat_#index" style="display:flex; margin-left:5px; margin-right:5px;">
		<div style="line-height:25px;">#name</div>
		<img src="admin/images/remove.png" width="25" height="25" onClick="remove_category('#categoryClass', '#index');">
		<input type="hidden" name="#categoryClassCat" value="#index">
	</div>
</div>

	<table class="tblAdminProduct">
	<tr>
		<th>메인 카테고리</th>
		<td colspan="3">
			<select id="mainCat" onChange="add_category('main');">
				<option value="0">선택</option>
				<c:forEach items="${mainCatList}" var="mainCatVO">
					<option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
				</c:forEach>
			</select>
		</td>
		<td colspan="7">
		<div id="mainView" style="display:flex;">
			<c:if test="${empty mainSelectedCatList}"><span id="mainCatEmptyMessage">카테고리를 추가하세요.</span></c:if>
			<c:if test="${not empty mainSelectedCatList}"><span id="mainCatEmptyMessage" style="display:none;">카테고리를 추가하세요.</span></c:if>
			<c:forEach items="${mainSelectedCatList}" var="mainCat" varStatus="stauts">
				<div id="mainCat_${mainCat.PMCSEQ}" style="display:flex; margin-left:5px; margin-right:5px;">
					<div style="line-height:25px;">
						<c:forEach items="${mainCatList}" var="Cat"><c:if test="${Cat.PMCSEQ == mainCat.PMCSEQ}">${Cat.NAME}</c:if></c:forEach>
					</div>
					<img src="admin/images/remove.png" width="25" height="25" onClick="remove_category('main', '${mainCat.PMCSEQ}');">
					<input type="hidden" name="mainCat" value="${mainCat.PMCSEQ}">
				</div>
			</c:forEach>
		</div>
		</td>
	</tr>
	<tr>
		<th>서브 카테고리</th>
		<td colspan="3">
			<select id="subCat" onChange="add_category('sub');">
				<option value="0">선택</option>
				<c:forEach items="${subCatList}" var="subCatVO">
					<option value="${subCatVO.PSCSEQ}">${subCatVO.NAME}</option>
				</c:forEach>
			</select>
		</td>
		<td colspan="7">
		<div id="subView" style="display:flex;">
			<c:if test="${empty subSelectedCatList}"><span id="subCatEmptyMessage">카테고리를 추가하세요.</span></c:if>
			<c:if test="${not empty subSelectedCatList}"><span id="subCatEmptyMessage" style="display:none;">카테고리를 추가하세요.</span></c:if>
			<c:forEach items="${subSelectedCatList}" var="subCat" varStatus="stauts">
				<div id="subCat_${subCat.PSCSEQ}" style="display:flex; margin-left:5px; margin-right:5px;">
					<div style="line-height:25px;">
						<c:forEach items="${subCatList}" var="Cat"><c:if test="${Cat.PSCSEQ == subCat.PSCSEQ}">${Cat.NAME}</c:if></c:forEach>
					</div>
					<img src="admin/images/remove.png" width="25" height="25" onClick="remove_category('sub', '${subCat.PSCSEQ}');">
					<input type="hidden" name="subCat" value="${subCat.PSCSEQ}">
				</div>
			</c:forEach>
		</div>
		</td>
	</tr>
	
	<tr>
		<th>브랜드</th><td colspan="3"><input type="text" name="brand" size="10" value="${productVO.BRAND}" onFocus="this.select();"></td>
		<th>상품명</th><td colspan="3"><input type="text" name="name" size="10" value="${productVO.NAME}" onFocus="this.select();"></td>
		<th>성별</th>
		<td colspan="2">
			<select name="gender">
				<c:if test="${productVO.GENDER == 'N'}"><option value="N" selected>남여공용</option></c:if>
				<c:if test="${productVO.GENDER != 'N'}"><option value="N">남여공용</option></c:if>
				<c:if test="${productVO.GENDER == 'M'}"><option value="M" selected>남성용</option></c:if>
				<c:if test="${productVO.GENDER != 'M'}"><option value="M">남성용</option></c:if>
				<c:if test="${productVO.GENDER == 'F'}"><option value="F" selected>여성용</option></c:if>
				<c:if test="${productVO.GENDER != 'F'}"><option value="F">여성용</option></c:if>
			</select>
		</td>
	</tr>
	<tr>
		<th>등록일</th><td colspan="2"><fmt:formatDate value="${productVO.REGDATE}"/><input type="hidden" name="regdate" value="${productVO.REGDATE}"></td>
		<th>Best상품</th>
		<td colspan="2">
			<c:choose>
			<c:when test="${productVO.BESTYN == 'Y'}">
				예<input type="radio" name="bestyn" value="Y" checked>&nbsp;
				아니오<input type="radio" name="bestyn" value="N">
			</c:when>
			<c:otherwise>
				예<input type="radio" name="bestyn" value="Y">&nbsp;
				아니오<input type="radio" name="bestyn" value="N" checked>
			</c:otherwise>
			</c:choose>
		</td>
		<th>판매허용</th>
		<td colspan="2">
			<c:choose>
			<c:when test="${productVO.USEYN == 'Y'}">
				예<input type="radio" name="useyn" value="Y" checked>&nbsp;
				아니오<input type="radio" name="useyn" value="N">
			</c:when>
			<c:otherwise>
				예<input type="radio" name="useyn" value="Y">&nbsp;
				아니오<input type="radio" name="useyn" value="N" checked>
			</c:otherwise>
			</c:choose>
		</td>
		<th>조회수</th><td>${productVO.VIEWCOUNT}</td>
	</tr>
	<tr>
		<th>설명</th><td colspan="10"><textarea name="description" rows="10" style="width:98%;">${productVO.DESCRIPTION}</textarea></td>
	</tr>
	<c:choose>
		<c:when test="${empty productVO.optionList || fn:length(productVO.optionList) == 0}">
			<tr><th rowspan="3">옵션</th></tr>
		</c:when>
		<c:otherwise><tr><th rowspan="${(fn:length(productVO.optionList) * 2) + 2}">옵션</th></tr></c:otherwise>
	</c:choose>
		
	<c:choose>
		<c:when test="${empty productVO.optionList || fn:length(productVO.optionList) == 0}"><tr><td colspan="7">등록된 옵션이 없습니다.</td></tr></c:when>
		<c:otherwise>
			<c:forEach items="${productVO.optionList}" var="opt" varStatus="status">
				<tr>
				<th rowspan="2">${status.count}<input type="hidden" name="pdseq" value="${opt.PDSEQ}"></th>
				<th>옵션명</th><td><input type="text" name="optname" value="${opt.OPTNAME}" title="수정할 수 없습니다." readonly></td>
				<th>재고</th>
				<td>
					<c:choose>
					<c:when test="${opt.PDSEQ == 0}"><input type="text" name="stock" size="10" value="${opt.STOCK}" onFocus="this.select();"></c:when>
					<c:otherwise><input type="text" name="stock" size="10" value="${opt.STOCK}" title="수정할 수 없습니다." readonly></c:otherwise>
					</c:choose>
				</td>
				
				<th>추가재고</th>
				<td>
					<c:choose>
					<c:when test="${opt.PDSEQ != 0}"><input type="text" name="store" size="10" value="0" onFocus="this.select();"></c:when>
					<c:otherwise><input type="text" name="store" size="10" value="0" title="수정할 수 없습니다." readonly></c:otherwise>
					</c:choose>
				</td>
				<th>판매허용</th>
				<td colspan="2">
					<c:choose>
					<c:when test="${opt.USEYN == 'Y'}">
						<input type="hidden" id="optUseyn_${status.count}" name="optUseyn" value="Y">
						예<input type="radio" class="optRadio_${status.count}" name="optUseyn_${status.count}" value="Y" onClick="change_opt_useyn('${status.count}');" checked>&nbsp;
						아니오<input type="radio" class="optRadio_${status.count}" name="optUseyn_${status.count}" value="N" onClick="change_opt_useyn('${status.count}');">
					</c:when>
					<c:otherwise>
						<input type="hidden" id="optUseyn_${status.count}" name="optUseyn" value="N">
						예<input type="radio" class="optRadio_${status.count}" name="optUseyn_${status.count}" value="Y" onClick="change_opt_useyn('${status.count}');">&nbsp;
						아니오<input type="radio" class="optRadio_${status.count}" name="optUseyn_${status.count}" value="N" onClick="change_opt_useyn('${status.count}');" checked>
					</c:otherwise>
					</c:choose>
				</td>
				</tr>
				<tr>
				<th>원가</th>
				<td>
					<c:choose>
					<c:when test="${opt.PDSEQ == 0}">
						<input type="text" name="price1" size="10" value="${opt.PRICE1}" onKeyup="cal_price('${status.index}');" onFocus="this.select();">
					</c:when>
					<c:otherwise>
						<input type="text" name="price1" size="10" value="${opt.PRICE1}" title="수정할 수 없습니다." readonly>
					</c:otherwise>
					</c:choose>
				</td>
				<th>판매가</th>
				<td>
					<c:choose>
					<c:when test="${opt.PDSEQ == 0}">
						<input type="text" name="price2" size="10" value="${opt.PRICE2}" onKeyup="cal_price('${status.index}');" onFocus="this.select();">
					</c:when>
					<c:otherwise>
						<input type="text" name="price2" size="10" value="${opt.PRICE2}" title="수정할 수 없습니다." readonly>
					</c:otherwise>
					</c:choose>
				</td>
				<th>마진</th>
				<td><input type="text" name="price3" size="10" value="${opt.PRICE3}" title="수정할 수 없습니다." readonly></td>
				<td colspan="3">
					<c:if test="${opt.PDSEQ == 0}">
						<input type="button" value="삭제" onClick="go_delete_option('${status.count}');">
					</c:if>
				</td>
				</tr>
	
				

			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="9"><input type="text" id="input_option" name="optname" placeholder="옵션 이름을 입력하세요." style="width:85%;"></td>
		<td><div class="btn"><input type="button" value="옵션 추가" onClick="go_add_option();"></div></td>
	</tr>

	<tr>
		<th>사진</th>
		<td colspan="10">
			<div id="filename">${productVO.IMAGE}</div>
			<input type="hidden" id="image" name="image" value="${productVO.IMAGE}">
			<input type="hidden" id="previewFilename" name="previewFilename" value="${previewFilename}">
			<div id="preview">
			<c:if test="${not empty productVO.IMAGE}"><img src="images/product/${productVO.IMAGE}" height="150"></c:if>
			</div>
			<input class="btn" type="button" value="사진선택" onClick="upload_click();">
		</td>
	</tr>
	</table>
	<br>
	<div>
		<div class="btn"><input type="button" value="수정" onClick="go_save_product();"></div>
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
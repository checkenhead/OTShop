<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<br>
<h1>admin insert product</h1>
<br>


<form name="insertProductForm" method="post">
	<table class="tblAdminProduct">
	<tr>
		<th>상품분류</th>
		<td>
			<select name="productCategory">
				<option value="0">선택</option>
				<c:forEach items="${productCatList}" var="productCat" varStatus="status">
					<c:choose>
					<c:when test="${productCategory == productCat.PCSEQ}">
						<option value="${productCat.PCSEQ}" selected>${productCat.NAME}</option>
					</c:when>
					<c:otherwise><option value="${productCat.PCSEQ}">${productCat.NAME}</option></c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</td>
		<th>브랜드</th><td><input type="text" name="brand" size="10" value="${brand}"></td>
		<th>상품명</th><td><input type="text" name="name" size="10" value="${name}"></td>
		<th>성별</th>
		<td>
			<select name="gender">
				<c:if test="${gender == 'N'}"><option value="N" selected>남여공용</option></c:if>
				<c:if test="${gender != 'N'}"><option value="N">남여공용</option></c:if>
				<c:if test="${gender == 'M'}"><option value="M" selected>남성용</option></c:if>
				<c:if test="${gender != 'M'}"><option value="M">남성용</option></c:if>
				<c:if test="${gender == 'F'}"><option value="F" selected>여성용</option></c:if>
				<c:if test="${gender != 'F'}"><option value="F">여성용</option></c:if>
			</select>
		</td>
	<tr>
		<th>설명</th><td colspan="7"><textarea name="description" rows="10" style="width:98%;">${description}</textarea></td>
	</tr>
	<c:choose>
		<c:when test="${empty optionList || fn:length(optionList) == 0}">
			<tr><th rowspan="4">옵션</th></tr>
		</c:when>
		<c:otherwise><tr><th rowspan="${fn:length(optionList) + 3}">옵션</th></tr></c:otherwise>
	</c:choose>
		
	<tr><th colspan="2">옵션명<input type="hidden" name="delIndex"></th><th>원가</th><th>판매가</th><th>마진</th><th>재고</th><th></th></tr>
	<c:choose>
		<c:when test="${empty optionList || fn:length(optionList) == 0}"><tr><td colspan="7">등록된 옵션이 없습니다.</td></tr></c:when>
		<c:otherwise>
			<c:forEach items="${optionList}" var="opt" varStatus="status">
				<tr>
				<td colspan="2"><input type="text" name="optname" value="${opt.optname}" readonly></td>
				<td><input type="text" name="price1" size="10" value="${opt.price1}" onKeyup="cal_price('${status.index}');"></td>
				<td><input type="text" name="price2" size="10" value="${opt.price2}" onKeyup="cal_price('${status.index}');"></td>
				<td><input type="text" name="price3" size="10" value="${opt.price3}" readonly></td>
				<td><input type="text" name="stock" size="10" value="${opt.stock}"></td>
				<td><input type="button" value="삭제" onClick="go_delete_option('${status.count}');"></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="6"><input type="text" id="input_option" name="optname" placeholder="옵션 이름을 입력하세요." style="width:85%;"></td>
		<td><div class="btn"><input type="button" value="옵션 추가" onClick="go_add_option();"></div></td>
	</tr>

	<tr>
		<th>사진</th>
		<td colspan="7">
			<div id="filename">
				<input type="hidden" id="image" name="image" value="${image}">
				<input type="hidden" id="previewFilename" name="previewFilename" value="${previewFilename}">
			</div>
			<div id="preview"><c:if test="${not empty image}"><img src="images/product/${image}" height="150"></c:if></div>
			<input class="btn" type="button" value="사진선택" onClick="upload_click();">
		</td>
	</tr>
	</table>
	<br>
	<div>
		<div class="btn"><input type="button" value="등록" onClick="go_reg_product();"></div>
		<div class="btn"><input type="button" value="목록으로" onClick="location.href='productManagement'"></div>
	</div>
</form>
<div class="message">${message}</div>
<div style="display:none;">
<form id="fileup" name="fileup" method="post" enctype="multipart/form-data">
	<input type="file" name="upload" onChange="copy_filename();">
</form>
</div>


<%@ include file="../common/footer.jsp" %>
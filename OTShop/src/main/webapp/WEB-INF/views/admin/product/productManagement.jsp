<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin product management</h1>
<br>

<div style="float:right;">
	<form name="productManSearchForm" method="post" action="searchProduct">
		<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="${keyword}" onFocus="this.select();">
		<div class="btn"><input type="submit" value="검색"></div>
		<div class="btn"><input type="button" value="상품 등록" onClick="reg_new_product();"></div>
	</form>
</div>

<br>
<form name="productManForm" method="get">
<input type="hidden" id="pseq" name="pseq">
<table class="tblAdminProduct" style="width:100%;">
	<tr><th>More</th><th>번호</th><th>브랜드</th><th>상품명</th><th>등록일</th><th>성별</th><th>Best상품</th><th>판매허용</th><th>커맨드</th></tr>
	<c:forEach items="${productList}" var="productVO" varStatus="status">
		<tr>
			<td id="imgCell_${status.index}" rowspan="1">
				<img src="admin/images/bottom.png" width="20" height="20" id="img_${status.index}" onClick="toggle_options('${status.index}', '${fn:length(productVO.optionList) + 2}');">
			</td>
			<td id="indexCell_${status.index}" rowspan="1">${status.count}</td>
			<td>${productVO.BRAND}</td>
			<td>${productVO.NAME}</td>
			<td><fmt:formatDate value="${productVO.REGDATE}"/></td>
			<td>
				<c:if test="${productVO.GENDER == 'N'}">남여공용</c:if>
				<c:if test="${productVO.GENDER == 'M'}">남성</c:if>
				<c:if test="${productVO.GENDER == 'F'}">여성</c:if>
			</td>
			<td>
				<c:if test="${productVO.BESTYN == 'Y'}">예</c:if>
				<c:if test="${productVO.BESTYN == 'N'}">아니오</c:if>
			</td>
			<td>
				<c:if test="${productVO.USEYN == 'Y'}">예</c:if>
				<c:if test="${productVO.USEYN == 'N'}">아니오</c:if>
			</td>
			<td id="commandCell_${status.index}" rowspan="1">
				<input type="button" value="상세" onClick="go_view_product('${productVO.PSEQ}')">
				<input type="button" value="수정" onClick="go_edit_product('${productVO.PSEQ}')">
			</td>
		</tr>
		<tr id="optionHead_${status.index}" style="display:none;font-size:80%;">
			<th rowspan="${fn:length(productVO.optionList) + 1}">상품 옵션</th><th>이름</th><th>원가</th><th>판매가</th><th>마진</th><th>재고</th>
		</tr>
		<c:forEach items="${productVO.optionList}" var="optionVO">
		<tr class="optionContent_${status.index}" style="display:none;font-size:80%;">
			<td>${optionVO.OPTNAME}</td>
			<td><fmt:formatNumber type="currency" value="${optionVO.PRICE1}"/></td>
			<td><fmt:formatNumber type="currency" value="${optionVO.PRICE2}"/></td>
			<td><fmt:formatNumber type="currency" value="${optionVO.PRICE3}"/></td>
			<td>${optionVO.STOCK}</td>
		</tr>
		</c:forEach>
	</c:forEach>
</table>
</form>
</div>

<%@ include file="../common/footer.jsp" %>
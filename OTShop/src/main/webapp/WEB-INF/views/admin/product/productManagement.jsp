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
<c:forEach items="${productList}" var="productVO" varStatus="status">
	<table class="tblAdminProduct" cellpadding="5" border="1" style="width:100%;">
		<tr>
			<th rowspan="2"><img src="admin/images/bottom.png" width="20" height="20" id="img_${productVO.PSEQ}" onClick="toggle_options('${productVO.PSEQ}');"></th>
			<th rowspan="2">${status.count}</th>
			<th>브랜드</th><th>상품명</th><th>등록일</th><th>성별</th><th>베스트</th><th>등록중</th>
			<th rowspan="2">
				<input type="button" value="상세" onClick="go_view_product('${productVO.PSEQ}')">
				<input type="button" value="수정" onClick="go_edit_product('${productVO.PSEQ}')">
			</th>
			
		</tr>
		<tr>
			<td>${productVO.BRAND}</td>
			<td>${productVO.NAME}</td>
			<td><fmt:formatDate value="${productVO.REGDATE}"/></td>
			<td>${productVO.GENDER}</td>
			<td>${productVO.BESTYN}</td>
			<td>${productVO.USEYN}</td>
		</tr>
		
	</table>
	
	<div id="option_${productVO.PSEQ}" style="display:none;">
		<table class="options" cellpadding="5">
			<tr><td colspan="2" style="border:none;"></td><th>옵션</th><th>원가</th><th>판매가</th><th>마진</th><th>재고</th></tr>
			<c:forEach items="${productVO.optionList}" var="optionVO">
				<tr>
					<td colspan="2" style="border:none; text-align:right;">┕&nbsp;</td>
					<td>${optionVO.OPTNAME}</td>
					<td><fmt:formatNumber type="currency" value="${optionVO.PRICE1}"/></td>
					<td><fmt:formatNumber type="currency" value="${optionVO.PRICE2}"/></td>
					<td><fmt:formatNumber type="currency" value="${optionVO.PRICE3}"/></td>
					<td>${optionVO.STOCK}</td>
				</tr>
			</c:forEach>
		</table>
		<br>
	</div>
</c:forEach>
</form>
</div>

<%@ include file="../common/footer.jsp" %>
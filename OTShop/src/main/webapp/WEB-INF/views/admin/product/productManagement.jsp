<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<br>
<h1>admin product management</h1>
<br>
<div style="float:right;">
	<input type="text" name="keyword" placeholder="검색어를 입력하세요.">
	<div class="btn"><input type="button" value="검색" onClick="go_search();"></div>
	<div class="btn"><input type="button" value="상품 등록" onClick="reg_new_product();"></div>
</div>
<br>
<c:forEach items="${productList}" var="productVO" varStatus="status">
	<table class="tblAdminProduct" cellpadding="5" border="1" style="width:100%;">
		<tr>
			<th rowspan="2"><img src="admin/images/bottom.png" width="15" height="15" id="img_option1" onClick="toggle_options('option_${productVO.PSEQ}');"></th>
			<th rowspan="2">${status.count}</th>
			<th>브랜드</th><th>상품명</th><th>등록일</th><th>성별</th><th>베스트</th><th>등록중</th>
			<th rowspan="2"><a>수정</a></th>
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



<%@ include file="../common/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/categorySub.jsp" %>


<div class="main_wrap">
	<form class="product_list_form" name=productListForm method="get">
		<input type="hidden" name="pseq">
	
		<c:forEach items="${productList}" var="productVO">
		<div class="item">
			<div class="item_img" onClick="view_product('${productVO.PSEQ}');"><img src="images/product/${productVO.IMAGE}"></div>
			<div class="item_brand">${productVO.BRAND}</div>
			<div class="item_name" title="${productVO.NAME}" onClick="view_product('${productVO.PSEQ}');">${productVO.NAME}</div>
			<div class="item_price"><fmt:formatNumber type="number" value="${productVO.price}"/>원</div>
			<div class="item_options" onClick="toggle_options('${productVO.PSEQ}');">options<img src="images/bottom.png"></div>
			<div class="options_wrap" id="options_wrap_${productVO.PSEQ}" style="display: none;">
				<div class="options">
				<c:forEach items="${productVO.optionList}" var="optionVO">
				<div class="option">
					<div style="margin-left:5px;margin-right:5px;">${optionVO.OPTNAME}</div>
					<div>
						<c:if test="${optionVO.STOCK == 0}"><div style="margin-left:5px;margin-right:5px;">X</div></c:if>
						<c:if test="${optionVO.STOCK != 0}"><div style="margin-left:5px;margin-right:5px;">O</div></c:if>
					</div>
				</div>
				</c:forEach>
				</div>
			</div>
		</div>
		</c:forEach>
		<div class="blank"></div>
		<div class="blank"></div>
		<div class="blank"></div>
		<div class="blank"></div>
		<div class="blank"></div>
	</form>
</div>
<%@ include file="../include/footer.jsp" %>
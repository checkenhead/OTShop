<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/categorySub.jsp" %>

<style type="text/css">
	
</style>


<div class="main_wrap">
	<form class="view_product_form" name="viewProductForm" method="post">
		<div class="view_head_info">
			<div class="head_info view_brand">${productVO.BRAND}</div>
			<div class="head_info view_name">${productVO.NAME}</div>
			<div class="head_info" style="display:flex;"> 
				<c:forEach items="${productVO.mainCategoryList}" var="mainCategoryVO">
				<div class="btn" style="display:flex;" onClick="searchProduct('main', '${mainCategoryVO.PMCSEQ}');">
					<div class="category_tag" style="width:3px;height:20px;background:url(images/tag_head.png) no-repeat;background-size:3px 20px;"></div>
					<div class="category_tag" style="height:20px;background:url(images/tag_body.png) repeat-x;background-size:7px 20px;font-size:90%;">${mainCategoryVO.NAME}</div>
					<div class="category_tag" style="width:20px;height:20px;background:url(images/tag_tail.png) no-repeat;background-size:20px 20px;"></div>
				</div>
				&nbsp;
				</c:forEach>
				
				<c:forEach items="${productVO.subCategoryList}" var="subCategoryVO">
				<div class="btn" style="display:flex;" onClick="searchProduct('sub', '${subCategoryVO.PSCSEQ}');">
					<div class="category_tag" style="width:3px;height:20px;background:url(images/tag_head.png) no-repeat;background-size:3px 20px;"></div>
					<div class="category_tag" style="height:20px;background:url(images/tag_body.png) repeat-x;background-size:7px 20px;font-size:90%;">${subCategoryVO.NAME}</div>
					<div class="category_tag" style="width:20px;height:20px;background:url(images/tag_tail.png) no-repeat;background-size:20px 20px;"></div>
				</div>
				&nbsp;
				</c:forEach>
			</div>
		</div>
	
		<div class="main_info">
			<div class="main_img">
				<img src="images/product/${productVO.IMAGE}">
			</div>
			<div class="info">
				<div class="title">Product Info</div>
				<div class="content">Brand : ${productVO.BRAND}</div>
				<div class="content">
					Gender : 
					<c:if test="${productVO.GENDER == 'N'}">남여공용</c:if>
					<c:if test="${productVO.GENDER == 'M'}">남성</c:if>
					<c:if test="${productVO.GENDER == 'F'}">여성</c:if>
				</div>
				<div class="title">ViewCount</div>
				<div class="title">Price Info</div>
				<div class="content"><fmt:formatNumber type="number" value="${productVO.price}"/>원</div>
				<div class="title" style="margin-top:10px;">Options</div>
				<div class="content">
					<select id="optionSelection" onChange="add_option();">
						<option value="0">선택</option>
						<c:forEach items="${productVO.optionList}" var="optionVO">
							<option value="${optionVO.PDSEQ}">${optionVO.OPTNAME} &nbsp;&nbsp;&nbsp; 
								<c:if test="${productVO.price - optionVO.PRICE2 < 0}">
									+&nbsp;<fmt:formatNumber type="number" value="${optionVO.PRICE2 - productVO.price}"/>원
								</c:if>
								<c:if test="${productVO.price - optionVO.PRICE2 >= 0}">
									-&nbsp;<fmt:formatNumber type="number" value="${productVO.price - optionVO.PRICE2}"/>원
								</c:if>
							</option>
						</c:forEach>
					</select>
				</div>
				<div id="selected_options" class="selected_options">
					<c:forEach items="${productVO.optionList}" var="optionVO">
					
					<div class="selected_option_row" id="option_${optionVO.PDSEQ}" style="display:none;">
						<input type="hidden" id="pdseq_${optionVO.PDSEQ}" name="pdseq" value="${optionVO.PDSEQ}" disabled>
						<input type="hidden" id="qty_${optionVO.PDSEQ}" name="qty" value="1" disabled>
						<input type="hidden" id="price_${optionVO.PDSEQ}" value="${optionVO.PRICE2}">
						<input type="hidden" id="selected_price_${optionVO.PDSEQ}" name="selected_price" value="0" disabled>
						<div class="opt_element_group">
							<div class="opt_name">${optionVO.OPTNAME}</div>
							<div class="opt_qty">
								<div id="btn_sub_qty_${optionVO.PDSEQ}" class="btn" style="opacity:0.2;" onClick="sub_qty('${optionVO.PDSEQ}');"><img src="images/sub.png" width="20" height="20"></div>
								<div id="display_qty_${optionVO.PDSEQ}" style="display:inline;width:20px;text-align:center;">1</div>
								<div id="btn_add_qty_${optionVO.PDSEQ}" class="btn" onClick="add_qty('${optionVO.PDSEQ}');"><img src="images/add.png" width="20" height="20"></div>
							</div>
							<div class="opt_price" id="display_price_${optionVO.PDSEQ}">
								<fmt:formatNumber type="number" value="${optionVO.PRICE2}"/>원
							</div>
						</div>
						<div class="opt_btn" style="width:25px;" onClick="remove_option('${optionVO.PDSEQ}');"><img src="images/remove.png" width="25" height="25"></div>
					</div>
					
					</c:forEach>
				</div>
				<div class="title">
					<span>총 상품 금액</span>
					<div id="totalPrice">0원</div>
				</div>
				<div class="buttons">
					<input type="button" id="goCart" value="장바구니에 담기" onClick="go_add_cart();">
					<input type="button" id="goBuy" value="구매하기">
				</div>
			</div>
		</div>
	
		<div class="description">
			<div class="title">Description</div>
			<div class="content"><pre style="font-size:16px;">${productVO.DESCRIPTION}</pre>... ... ...</div>
		</div>
	
		<div class="qna">
			<div class="title">Q&amp;A</div>
			<div class="content"></div>
		</div>
	
	</form>
</div>

<%@ include file="../include/footer.jsp" %>
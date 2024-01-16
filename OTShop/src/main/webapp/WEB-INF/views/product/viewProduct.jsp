<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/categorySub.jsp" %>

<style type="text/css">
	.selected_options{
		display: flex;
		flex-direction: column;
		margin-top: 20px;
	}
	.selected_option_row{
		width: 450px;
		border-bottom: 1px solid silver;
		margin-top: 5px;
		display: flex;
		justify-content: space-between;
	}
	.selected_option_row > div{
		position: relative;
		display: inline-block;
	}
	.btn:hover{
		cursor: pointer;
	}
</style>


<div class="content_wrap">
<form name="viewProductForm" method="post">
<div class="head_info">
<div class="head_info_element" style="font-weight:bold;">${productVO.BRAND}</div>

<div class="head_info_element" style="font-weight:bold;">${productVO.NAME}</div>
<div class="head_info_element" style="display:flex;"> 
	<c:forEach items="${productVO.mainCategoryList}" var="mainCategoryVO">
	<div style="display:flex;" class="btn" onClick="searchProduct('main', '${mainCategoryVO.PMCSEQ}');">
		<div class="category_tag" style="width:3px;height:20px;background:url(images/tag_head.png) no-repeat;background-size:3px 20px;"></div>
		<div class="category_tag" style="height:20px;background:url(images/tag_body.png) repeat-x;background-size:7px 20px;font-size:90%;">${mainCategoryVO.NAME}</div>
		<div class="category_tag" style="width:20px;height:20px;background:url(images/tag_tail.png) no-repeat;background-size:20px 20px;"></div>
	</div>
	&nbsp;
	</c:forEach>
	
	<c:forEach items="${productVO.subCategoryList}" var="subCategoryVO">
	<div style="display:flex;" class="btn" onClick="searchProduct('sub', '${subCategoryVO.PSCSEQ}');">
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
		<h2>Product Info</h2>
		Brand : ${productVO.BRAND}<br>
		Gender : 
		<c:if test="${productVO.GENDER == 'N'}">남여공용</c:if>
		<c:if test="${productVO.GENDER == 'M'}">남성</c:if>
		<c:if test="${productVO.GENDER == 'F'}">여성</c:if>
		<br>
		ViewCount<br>
		<h2>Price Info</h2>
		<fmt:formatNumber type="number" value="${productVO.price}"/>원
		<h2>Options</h2>
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
		<br>
		<div id="selected_options" class="selected_options">
			<c:forEach items="${productVO.optionList}" var="optionVO">
			
			<div class="selected_option_row" id="option_${optionVO.PDSEQ}" style="display:none;">
				<input type="hidden" id="pdseq_${optionVO.PDSEQ}" name="pdseq" value="${optionVO.PDSEQ}" disabled>
				<input type="hidden" id="qty_${optionVO.PDSEQ}" name="qty" value="1" disabled>
				<input type="hidden" id="price_${optionVO.PDSEQ}" value="${optionVO.PRICE2}">
				<input type="hidden" id="selected_price_${optionVO.PDSEQ}" name="selected_price" value="0" disabled>
				<div style="width:80px;">${optionVO.OPTNAME}</div>
				<div style="width:80px;display:flex;">
					<div id="btn_sub_qty_${optionVO.PDSEQ}" class="btn" style="opacity:0.2;" onClick="sub_qty('${optionVO.PDSEQ}');"><img src="images/sub.png" width="20" height="20"></div>
					<div id="display_qty_${optionVO.PDSEQ}" style="display:inline;width:40px;text-align:center;">1</div>
					<div id="btn_add_qty_${optionVO.PDSEQ}" class="btn" onClick="add_qty('${optionVO.PDSEQ}');"><img src="images/add.png" width="20" height="20"></div>
				</div>
				<div id="display_price_${optionVO.PDSEQ}" style="width:120px;text-align:right;">
					<fmt:formatNumber type="number" value="${optionVO.PRICE2}"/>원
				</div>
				<div class="btn" style="width:25px;" onClick="remove_option('${optionVO.PDSEQ}');"><img src="images/remove.png" width="25" height="25"></div>
			</div>
			
			</c:forEach>
		</div>
		<div class="totalPrice_box" style="margin-top:30px;">
			<span style="font-weight:bold;">총 상품 금액</span>
			<div id="totalPrice" style="font-weight:bold;">0원</div>
		</div>
		<br><br><br><br><br>
		<div class="btn"><input type="button" value="장바구니에 담기" onClick="go_add_cart();"></div>
		<div class="btn"><input type="button" value="구매하기"></div>
	</div>
</div>

<div class="main_info">
	<div class="description">
		<h2>Description</h2>
		<pre>${productVO.DESCRIPTION}</pre>... ... ...
		<br><br><br><br><br>
	</div>
</div>

<div class="main_info">
	<div class="qna">
		<h2>Q&amp;A</h2>
		<br><br><br><br><br>
	</div>
</div>

</form>
</div>

<%@ include file="../include/footer.jsp" %>
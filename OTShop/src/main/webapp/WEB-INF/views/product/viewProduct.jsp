<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/categorySub.jsp" %>

<div class="content_wrap">
	<h1>product brand : ${productVO.BRAND}</h1>
	<h1>product name : ${productVO.NAME}</h1>
	<h1>product gender : ${productVO.GENDER}</h1>
	<h1>product price : ${productVO.price}</h1>
	
	<c:forEach items="${productVO.optionList}" var="option" varStatus="status">
		<h2>option_${status.count} name : ${option.OPTNAME}</h2>
		<h2>option_${status.count} stock : ${option.STOCK}</h2>
		<h2>option_${status.count} price : ${option.PRICE2}</h2>
	</c:forEach>
	
</div>

<%@ include file="../include/footer.jsp" %>
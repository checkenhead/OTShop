<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">

<div class="sub_wrap">
	<div class="containerCry">
	<c:forEach items="${mainCategorySetList}" var="mainCategorySet">
	<div class="bigcry" id="outer"><img src="images/plus.png">
		<div style="display:inline-block;"onClick="searchProduct('main', '${mainCategorySet.PMCSEQ}');">${mainCategorySet.NAME}</div>
		<c:forEach items="${mainCategorySet.subCategorySetList}" var="subCategorySet">
			<div class="smallcry" id="halfTshirt">
				<div onClick="searchProduct('sub', '${subCategorySet.PSCSEQ}');">${subCategorySet.NAME}</div>
			</div>
		</c:forEach>
	</div>
	</c:forEach>
	</div>
</div>
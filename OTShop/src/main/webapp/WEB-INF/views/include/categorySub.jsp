<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/otshop.css">

<!--
<div class="containerCry">
	<div class="bigcry" id="outer"><img src="images/plus.png">아우터</div>
	<div class="bigcry" id="top"><img src="images/plus.png">상의
		<div class="smallcry" id="halfTshirt">반소매 티셔츠</div>
		<div class="smallcry" id="knit">니트/스웨터</div>
		<div class="smallcry" id="hoodie">후드 티셔츠</div>
	</div>
	<div class="bigcry" id="bottom"><img src="images/plus.png">하의</div>
	<div class="bigcry" id="acc"><img src="images/plus.png">ACC</div>
</div>
-->
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
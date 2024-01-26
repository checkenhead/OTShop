<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/css/otshop.css"> -->

<div class="sub_wrap">
	<div class="category_list">
		<c:forEach items="${mainCategorySetList}" var="mainCategorySet">
			<div class="main_category" onClick="searchProduct('main', '${mainCategorySet.PMCSEQ}');">
				<div><img src="images/plus.png">${mainCategorySet.NAME}</div>
				<c:forEach items="${mainCategorySet.subCategorySetList}" var="subCategorySet">
					<div class="sub_category" onClick="searchProduct('sub', '${subCategorySet.PSCSEQ}');">${subCategorySet.NAME}</div>
				</c:forEach>
			</div>
		</c:forEach>
	</div>
</div>
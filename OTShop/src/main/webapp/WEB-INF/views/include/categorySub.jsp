<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/css/otshop.css"> -->

<div class="sub_wrap">
	<div class="category_list">
		<c:forEach items="${mainCategorySetList}" var="mainCategorySet">
			<div class="main_category" onClick="category_menu_action('${mainCategorySet.PMCSEQ}');"><!-- onClick="searchProduct('main', '${mainCategorySet.PMCSEQ}');" -->
				<div><img src="images/plus.png">${mainCategorySet.NAME}</div>
				<div class="sub_category_wrap" id="sub_category_wrap_${mainCategorySet.PMCSEQ}">
					<c:forEach items="${mainCategorySet.subCategorySetList}" var="subCategorySet">
						<div class="sub_category" onClick="searchProduct('sub', '${subCategorySet.PSCSEQ}');">${subCategorySet.NAME}</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/categorySub.jsp" %>
<script>
	function view_product(index){
		document.productListForm.pseq.value = index;
		document.productListForm.action = "viewProduct";
		document.productListForm.submit();
	}
	
	function toggle_options(index){
		if(document.getElementById("options_wrap_" + index).style.display == "none"){
			document.getElementById("options_wrap_" + index).style.display = "";
		} else {
			document.getElementById("options_wrap_" + index).style.display = "none";
		}
	}
</script>

<h2>회사소개 페이지 입니다.</h2>


<%@ include file="../include/footer.jsp" %>
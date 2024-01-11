<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>


<article id="wrap">
<%@ include file="../include/categorySub.jsp" %>

<form method="post" name="faqTemplate">

<div id="faqBanner">
	<span>FAQ</span><span>고객님들께서 자주 묻는 질문입니다</span>
</div>



<div id="ListHead">
	<div id="faqnum">NO</div>
	<div id="faqcry">구분</div>
	<div id="faqtitle">제목</div>
</div>

<div id="ListBody">
	<c:forEach items="${faqList}" var="faqVO">
		<div>${faqVO.FSEQ}</div>
		<div>${faqVO.NAME}
			<input type="hidden" name="fcseq" value="${faqVO.FCSEQ}">
		</div>
		<div>${faqVO.TITLE}</div>
		<div>${faqVO.CONTENT}</div>
	</c:forEach>
</div>



</form>
</article>
    
<%@ include file="../include/footer.jsp" %>
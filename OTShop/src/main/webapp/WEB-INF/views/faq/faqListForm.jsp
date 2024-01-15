<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>


<article id="wrap2">
<%@ include file="../include/categorySub.jsp" %>

<form method="get" name="faqListFrm">

<div class="faqBanner">
	<span class="bannerTitle">FAQ</span><span class="bannerSub">고객님들께서 자주 묻는 질문입니다</span>
</div>



<div class="listHead">
	<div class="faqnum">NO</div>
	<div class="faqcry">구분</div>
	<div class="faqtitle">제목</div>
</div>

<div class="listBody" >
	<c:forEach items="${faqList}" var="faqVO"  varStatus="loop">
		<div class="listWrap">
			<div class="faqnum2">${faqVO.FSEQ}</div>
			<div class="faqcry2">${faqVO.NAME}
				<input type="hidden" name="fcseq" value="${faqVO.FCSEQ}">
			</div>
			<div class="faqtitle2" id="faqTitle_${loop.index}">${faqVO.TITLE}</div>
		</div>
		<div class="faqcontent" id="faqContent_${loop.index}" style="display:none;">
				<span>${faqVO.CONTENT}</span></div>
	</c:forEach><br>
</div>


</form>
</article>


    
<%@ include file="../include/footer.jsp" %>
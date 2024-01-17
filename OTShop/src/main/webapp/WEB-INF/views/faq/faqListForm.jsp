<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>

<div class="faqWrap">
<article>
	<form method="get" name="faqListFrm" class="faqFrm">
	
	<div class="faqBanner">
		<span class="bannerTitle">FAQ</span><span class="bannerSub">고객님들께서 자주 묻는 질문입니다</span>
	</div><br>
	
	
	
	<div class="listHead">
		<div id="faqnum">NO</div>
		<div id="faqcry">구분</div>
		<div id="faqtitle">제목</div>
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
</div>


    
<%@ include file="../include/footer.jsp" %>
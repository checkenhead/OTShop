<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>


<article id="wrap2">
<%@ include file="../include/categorySub.jsp" %>

<form method="post" name="qnaListFrm">

<div class="faqBanner">
	<span class="bannerTitle">QNA</span><span class="bannerSub">1 : 1 문의하기</span>
	<select name="qnaName">
		<option>회원정보/계정</option>
		<option>상품</option>
		<option>주문/결제</option>
	</select>
</div>

<div class="listHead">
	<div class="faqnum">NO</div>
	<div class="faqcry">구분</div>
	<div class="faqtitle">제목</div>
	<div class="qnadate">등록일</div>
	<div class="reply">답변</div>
</div>

<div class="listBody">

</div>


</form>
</article>


<%@ include file="../include/footer.jsp" %>
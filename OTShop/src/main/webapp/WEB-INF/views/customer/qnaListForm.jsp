<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>

<article id="wrap2">
    <%@ include file="../include/categorySub.jsp" %>

    <form method="post" name="qnaListFrm" id="qnaList">

        <div class="faqBanner">
            <span class="bannerTitle">QNA</span><span class="bannerSub">1 : 1 문의하기</span>
            <select name="qnaname" id="qnaName" onChange="getselect();">
                <option value="all" selected>전체</option>
                <c:forEach items="${qnaCat}" var="qnaCAT">
                	<option value="${qnaCAT.QCSEQ}">${qnaCAT.NAME}</option>
                </c:forEach>
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
        	
				<c:forEach items="${qnaList}" var="qnaVO" varStatus="status">
					<div class="qna" id="qna_${status.index}" >
						<input type="hidden" value="${qnaVO.QCSEQ}" class="qcseq">
						<div class="faqnum2">${qnaVO.QSEQ}</div>
			            <div class="faqcry2">${qnaVO.NAME}</div>
			            <div class="faqtitle2">${qnaVO.TITLE}</div>
			            <div class="qnadate2">${qnaVO.REGDATE}</div>
			            <div class="reply2">${qnaVO.REPLY}</div>
					</div>
				</c:forEach>
			
           
        </div>
    </form>
</article>
<%@ include file="../include/footer.jsp" %>
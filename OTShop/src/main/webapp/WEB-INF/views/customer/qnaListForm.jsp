<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypageSub.jsp" %>

<div class="faqWrap">
<article id="wrap2">
    <form method="post" name="qnaListFrm" id="qnaList" class="faqFrm">

        <div class="faqBanner">
            <span class="bannerTitle">QNA</span><span class="bannerSub">1 : 1 문의하기</span>
            <select name="qnaname" class="qnaCry" id="qnaName" onChange="getselect();">
                <option value="all" selected>전체</option>
                <c:forEach items="${qnaCat}" var="qnaCAT">
                	<option value="${qnaCAT.QCSEQ}">${qnaCAT.NAME}</option>
                </c:forEach>
            </select>
        </div>

        <div class="listHead">
            <div class="qnanum">NO</div>
            <div class="qnacry">구분</div>
            <div class="qnauserid">작성자</div>
            <div class="qnatitle">제목</div>
            <div class="qnadate">등록일</div>
            <div class="reply">답변</div>
        </div>

        <div class="listBody">
				<c:forEach items="${qnaList}" var="qnaVO" varStatus="status">
					<div class="qna" id="qna_${status.index}" >
						<input type="hidden" value="${qnaVO.QCSEQ}" class="qcseq">
						<div class="qnanum2">${status.count}</div>
			            <div class="qnacry2">${qnaVO.NAME}</div>
			            <div class="qnauserid2" name="userid">${qnaVO.USERID}</div>
			            <c:choose>
			            	<c:when test="${qnaVO.SECRET == 'Y'}">
			            		<a href='#' onclick="userCheckForm('${qnaVO.QSEQ}', '${qnaVO.USERID}')">
			            			<div class="qnatitle2">${qnaVO.TITLE}<img src="/images/key.png" style="width:20px;"></div>
			            		</a>
			            	</c:when>
			            	<c:otherwise>
			            		<a href="qnaView?qseq=${qnaVO.QSEQ}">
			            			<div class="qnatitle2">${qnaVO.TITLE}</div>
			            		</a>
			            	</c:otherwise>
			            </c:choose>
			            <div class="qnadate2">${qnaVO.REGDATE}</div>
			            <c:choose>
			            	<c:when test="${empty qnaVO.REPLY}">
			            		<div class="reply2"> - </div></c:when>
			            	<c:otherwise>
			            		<div class="reply2"> 답변 완료 </div></c:otherwise>
			            </c:choose>
					</div>
				</c:forEach>
        </div>
        <div>
        	<a href="qnaWriteForm"><input type="button" id="goqnaWrite" value="문의하기"></a>
        </div>
    </form>
</article>
</div>
<%@ include file="../include/footer.jsp" %>
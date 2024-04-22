<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>

<div class="faqWrap">

	<form method="post" name="qnaListFrm" id="qnaList" class="faqFrm">

		<%@ include file="../include/mypageSub.jsp"%>

		<div class="qnaViewCnt">
			<div class="qnaViewTitle">1 : 1 문의 내용</div>
			<div class="qnaViewSubs">
				<div class="SubsTitle">
					<div>등록일</div>
					<br>
					<div>구분</div>
					<br>
					<div>제목</div>
					<br>
					<div>질문</div>
					<br>
					<div>답변</div>
					<br>
				</div>
				<div class="SubsSubs">
					<div>${qnaVO.REGDATE}</div>
					<br>
					<div>${qnaCAT.NAME}</div>
					<br>
					<div>${qnaVO.TITLE}</div>
					<br>
					<div>${qnaVO.CONTENT}</div>
					<br>
					<div>
						<pre>${qnaVO.REPLY}</pre>
					</div>
					<br>
				</div>
			</div>
		</div>

		<div class="qnaViewButtons">
			<input type="button" id="goBack" value="이전으로" onclick="history.go(-1)">
			<input type="button" id="goMain" value="메인으로" onclick="location.href='/'">
		</div>
	</form>


</div>
<%@ include file="../include/footer.jsp"%>
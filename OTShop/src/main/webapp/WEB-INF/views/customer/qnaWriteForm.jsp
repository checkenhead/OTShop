<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>

<div class="faqWrap">

	<form method="post" action="qnaWrite" name="qnaWriteFrm" class="faqFrm">

		<%@ include file="../include/mypageSub.jsp"%>

		<div class="qnaViewCnt">
			<div class="qnaViewTitle">1 : 1 문의하기</div>
			<div class="qnaViewSubs">
				<div class="SubsTitle">
					<div>제목</div>
					<br>
					<div>구분</div>
					<br>
					<div>작성자</div>
					<br>
					<div>비밀글</div>
					<br>
					<div>문의내용</div>
					<br>
				</div>

				<div class="SubsSubs">
					<div>
						<input type="text" name="title" id="qnaTitle">
					</div>
					<br>
					<div>
						<select name="qnaname" id="qnaName">
							<c:forEach items="${qnaCat}" var="qnaCAT">
								<option value="${qnaCAT.QCSEQ}">${qnaCAT.NAME}</option>
							</c:forEach>
						</select>
					</div>
					<br>
					<div>
						<input type="text" id="qnaUserid" name="userid" value="${userid}"
							readonly>
					</div>
					<br>
					<div>
						<input name="secret" type="checkbox" value="Y">비밀글로 하기
					</div>
					<br>
					<div>
						<textarea rows="8" cols="65" name="content"></textarea>
					</div>
					<br>
				</div>
			</div>
		</div>
		<br>
		<br>

		<div class="qnaWriteStatue">
			<span>${message}</span>
		</div>
		<br>

		<div class="qnaViewButtons">
			<input type="button" id="goBack" value="이전으로" onclick="history.go(-1)">
			<input type="submit" id="goMain" value="저장">
		</div>

	</form>
</div>

<%@ include file="../include/footer.jsp"%>
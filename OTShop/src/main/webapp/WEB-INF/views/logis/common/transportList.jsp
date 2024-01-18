<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<h2>logis transport</h2>
<form name="transportListForm" method="post">
<input type="hidden" name="iseq">
<table class="tblTransportList">
	<tr><th>송장번호</th><th>주문번호</th><th>보내는이</th><th>받는이</th><th>주소</th><th>전화</th><th>상태</th></tr>
	<c:forEach items="${invoiceList}" var="invoiceVO" varStatus="invoiceStatus">
		<tr>
			<td>${invoiceVO.ISEQ}</td>
			<td>${invoiceVO.ORDERNUM}</td>
			<td>${invoiceVO.CLIENTID}</td>
			<td>${invoiceVO.RECIPIENT}</td>
			<td>(${invoiceVO.ZIPNUM})&nbsp;${invoiceVO.ADDRESS1}&nbsp;${invoiceVO.ADDRESS3}&nbsp;${invoiceVO.ADDRESS2}</td>
			<td>${invoiceVO.TEL}</td>
			<td>
				<c:if test="${invoiceVO.STATE == '1'}">
					<div>대기 중</div>
				</c:if>
				<c:if test="${invoiceVO.STATE == '2'}">
					<div>집화 중</div>
				</c:if>
				<c:if test="${invoiceVO.STATE == '3'}">
					<div>집화 완료</div>
				</c:if>
				<c:if test="${invoiceVO.STATE == '4'}">
					<div>배송 중</div>
				</c:if>
				<c:if test="${invoiceVO.STATE == '9'}">
					<div>배송 완료</div>
				</c:if>
			</td>
		</tr>
		<c:forEach items="${invoiceVO.transportList}" var="transportVO" varStatus="transportStatus">
		<tr>
			<td></td><td></td><td>${transportVO.REGDATE}</td><td>${transportVO.DESCRIPTION}</td><td>${transportVO.STATE}</td><td></td><td></td>
		</tr>
		</c:forEach>
	</c:forEach>
</table>
</form>
<%@ include file="footer.jsp" %>
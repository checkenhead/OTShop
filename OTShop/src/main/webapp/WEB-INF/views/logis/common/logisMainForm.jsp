<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<h2>logisMain 페이지입니다</h2>
<form name="invoiceListForm" method="post">
<input type="hidden" name="iseq">
<input type="hidden" name="command">
<table class="tblInvoiceList">
	<tr><th>송장번호</th><th>주문번호</th><th>보내는이</th><th>받는이</th><th>주소</th><th>전화</th><th>상태</th></tr>
	<c:forEach items="${invoiceList}" var="invoiceVO" varStatus="status">
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
					<div><input type="button" value="진행" onClick="change_invoice_state('${invoiceVO.ISEQ}','startTransport')"></div>
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
	</c:forEach>
</table>
</form>
<%@ include file="footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<div class="content_wrap" style="width:100%;">

<br>
<h1>admin order management</h1>
<br>

<form name="orderManForm" method="post">
<input type="hidden" name="oseq">
<input type="hidden" name="command">

<table class="tblAdminOrder">
	<tr><th>More</th><th>번호</th><th>아이디</th><th>이메일</th><th>주문일</th><th>송장번호</th><th>결제금액/수량</th><th>상태</th></tr>
	<c:forEach items="${orderList}" var="orderVO" varStatus="mainStatus">
	<tr id="main_row_${mainStatus.index}" class="main_row">
		<td id="btn_row_${mainStatus.index}" rowspan="1">
			<div onClick="toggle_detail('${mainStatus.index}', '${fn:length(orderVO.orderDetailList) + 3}');">
				<img src="admin/images/bottom.png" width="20" height="20" id="img_${mainStatus.index}">
			</div>
		</td>
		<td id="count_row_${mainStatus.index}" rowspan="1">
			${mainStatus.count}
			<input type="hidden" id="row_size_${mainStatus.index}" value="${fn:length(orderVO.orderDetailList)}">
		</td>
		<td>${orderVO.USERID}</td>
		<td>${orderVO.EMAIL}</td>
		<td><fmt:formatDate type="date" value="${orderVO.REGDATE}"/></td>
		<td>
			<c:choose>
			<c:when test="${orderVO.logisState == '0'}">-</c:when>
			<c:when test="${orderVO.INVOICENUM == 0}">집화 요청 중</c:when>
			<c:otherwise>${orderVO.INVOICENUM}</c:otherwise>
			</c:choose>
		</td>
		<td id="amount_row_${mainStatus.index}" rowspan="1"><fmt:formatNumber type="number" value="${orderVO.amount}"/>원</td>
		<td id="state_row_${mainStatus.index}" rowspan="1">
			<c:if test="${orderVO.STATE == '0'}">
				<div>최소</div>
			</c:if>
			<c:if test="${orderVO.STATE == '1'}">
				<div>결제 완료</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="배송 준비 중으로 전환" onClick="change_order_state('${orderVO.OSEQ}', 'preparing');">
				</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="주문 취소" onClick="change_order_state('${orderVO.OSEQ}', 'cancel');">
				</div>
			</c:if>
			<c:if test="${orderVO.STATE == '2'}">
				<div>배송 준비 중<br></div>
				<c:if test="${not empty orderVO.recievedInvoicenum}">
					<input type="text" name="invoicenum" value="${orderVO.recievedInvoicenum}">
				</c:if>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<c:if test="${orderVO.logisState == 0}">
						<input type="hidden" name="recipient" value="${orderVO.NAME}">
						<input type="hidden" name="tel" value="${orderVO.TEL}">
						<input type="hidden" name="zipnum" value="${orderVO.ZIPNUM}">
						<input type="hidden" name="address1" value="${orderVO.ADDRESS1}">
						<input type="hidden" name="address2" value="${orderVO.ADDRESS2}">
						<input type="hidden" name="address3" value="${orderVO.ADDRESS3}">
						<input type="button" value="집화 요청" onClick="request_collect('${orderVO.OSEQ}');">
					</c:if>
					<c:if test="${orderVO.logisState >= 1 and orderVO.logisState <= 3}">
						<input type="button" value="송장번호 입력" onClick="save_order_invoicenum('${orderVO.OSEQ}');">
					</c:if>
				</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="주문 취소" onClick="change_order_state('${orderVO.OSEQ}', 'cancel');">
				</div>
			</c:if>
			<c:if test="${orderVO.STATE == '3'}">
				<div>배송 중</div>
			</c:if>
			<c:if test="${orderVO.STATE == '4'}">
				<div>배송 완료</div>
			</c:if>
			<c:if test="${orderVO.STATE == '5'}">
				<div>구매 확정</div>
			</c:if>
			<c:if test="${orderVO.STATE == '6'}">
				<div>반품 중</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="반품 완료로 전환" onClick="change_order_state('${orderVO.OSEQ}', 'returnCompleted');">
				</div>
			</c:if>
			<c:if test="${orderVO.STATE == '7'}">
				<div>반품 완료</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="확인 중으로 전환" onClick="change_order_state('${orderVO.OSEQ}', 'checking');">
				</div>
			</c:if>
			<c:if test="${orderVO.STATE == '8'}">
				<div>확인 중</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="배송 준비 중으로 전환" onClick="change_order_state('${orderVO.OSEQ}', 'preparing');">
				</div>
				<div class="hidden_element_${mainStatus.index}" style="display:none;">
					<input type="button" value="환불" onClick="change_order_state('${orderVO.OSEQ}', 'RefundCompleted');">
				</div>
			</c:if>
			<c:if test="${orderVO.STATE == '9'}">
				<div>환불 완료</div>
			</c:if>
		</td>
	</tr>
	<tr class="hidden_element_${mainStatus.index}" style="display:none;"><th>이름</th><th colspan="2">주소</th><th>전화번호</th></tr>
	<tr class="hidden_element_${mainStatus.index}" style="display:none;">
		<td>${orderVO.NAME}</td>
		<td colspan="2">(${orderVO.ZIPNUM})&nbsp;${orderVO.ADDRESS1}&nbsp;${orderVO.ADDRESS3}&nbsp;${orderVO.ADDRESS2}</td>
		<td>${orderVO.TEL}</td>
	</tr>
	<c:forEach items="${orderVO.orderDetailList}" var="orderDetailVO" varStatus="detailStatus">
		<tr class="hidden_element_${mainStatus.index}" style="display:none;">
			<c:if test="${detailStatus.first}"><th rowspan="${fn:length(orderVO.orderDetailList)}">주문상품</th></c:if>
			<td colspan="2">${orderDetailVO.BRAND}&nbsp;${orderDetailVO.NAME}</td>
			<td>${orderDetailVO.OPTNAME}</td>
			<td>${orderDetailVO.QTY}개</td>
		</tr>
	</c:forEach>
	</c:forEach>
</table>

</form>
<br><span style="font-weight:bold;color:red;">${message}</span>
</div>

<%@ include file="../common/footer.jsp" %>
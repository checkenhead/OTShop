<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<div class="content_wrap" style="width:100%;">

<br>
<h1>admin member management</h1>
<br>

<form name="memberManForm" method="post">
<input type="hidden" id="userid" name="userid">
<input type="hidden" id="useyn" name="useyn">
<table class="tblAdminMember">
	<tr>
		<th>More</th><th>번호</th><th>아이디(이름)</th><th>이메일</th><th>가입일</th><th>가입경로</th><th>상태</th><th>삭제</th>
	</tr>
	<c:forEach items="${memberList}" var="memberVO" varStatus="status">

	<tr>
		<td id="imgCell_${status.index}" rowspan="1">
			<img src="admin/images/bottom.png" width="20" height="20" id="img_${status.index}" onClick="toggle_memberDetail('${status.index}');">
		</td>
		<td id="indexCell_${status.index}" rowspan="1">${status.count}<%-- <input type="hidden" id="fseq_${faqVO.FSEQ}" value="${faqVO.FSEQ}"> --%></td>
		<td>${memberVO.USERID}(${memberVO.NAME})</td>
		<td>${memberVO.EMAIL}</td>
		<td><fmt:formatDate value="${memberVO.REGDATE}"/></td>
		<td>
			<c:if test="${memberVO.PROVIDER == 'ot'}">OTShop</c:if>
			<c:if test="${memberVO.PROVIDER != 'ot'}">${memberVO.PROVIDER}</c:if>
		</td>
		<td>
			<c:if test="${memberVO.USEYN == 'Y'}">
				<span style="color:blue;">활동 중</span>&nbsp;<div class="btn"><input type="button" value="정지" onClick="toggle_memberUseyn('${memberVO.USERID}', '${memberVO.USEYN}');"></div>
			</c:if>
			<c:if test="${memberVO.USEYN == 'N'}">
				<span style="color:red;">정지됨</span>&nbsp;<div class="btn"><input type="button" value="해제" onClick="toggle_memberUseyn('${memberVO.USERID}', '${memberVO.USEYN}');"></div>
			</c:if>
		</td>
		<td><div class="btn"><input type="button" value="삭제" onClick=""></div></td>
	</tr>

	<tr id="memberDetailHead_${status.index}" style="display:none;font-size:80%;">
		<th>성별</th><th>생년월일</th><th>전화번호</th><th colspan="3">주소</th>
	</tr>
	<tr id="memberDetailContent_${status.index}" style="display:none;font-size:80%;">
		<td>
			<c:if test="${memberVO.GENDER == 'M'}">남성</c:if>
			<c:if test="${memberVO.GENDER == 'F'}">여성</c:if>
		</td>
		<td>${memberVO.BIRTHDATE}</td>
		<td>${memberVO.TEL}</td>
		<td colspan="3">
			<c:if test="${empty memberVO.ZIPNUM}">-</c:if>
			<c:if test="${not empty memberVO.ZIPNUM}">
				(${memberVO.ZIPNUM})&nbsp;${memberVO.ADDRESS1}&nbsp;${memberVO.ADDRESS3}&nbsp;${memberVO.ADDRESS1}
			</c:if>
		</td>
	</tr>
	</tbody>
	</c:forEach>
</table>
</form>

</div>

<%@ include file="../common/footer.jsp" %>
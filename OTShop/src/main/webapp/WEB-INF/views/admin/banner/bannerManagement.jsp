<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin banner management</h1>
<br>

<form id="bannerManForm" name="bannerManForm" method="post">
<input type="hidden" name="bseq">
<input type="hidden" name="priority">
<table class="tblAdminBanner">
	<tr><th>순서</th><th>사용유무</th><th>이미지</th><th>이름</th><th>URI</th><th>삭제</th></tr>
	<c:forEach items="${bannerList}" var="bannerVO" varStatus="status">
	<tr>
		<td>
			<c:if test="${bannerVO.PRIORITY == 0}">사용안함</c:if>
			<c:if test="${bannerVO.PRIORITY != 0}">
				<c:if test="${bannerVO.PRIORITY > 1 }">
					<div><img src="admin/images/top.png" width="25" height="25" onClick="raise_priority('${bannerVO.PRIORITY}');"></div>
				</c:if>
				${bannerVO.PRIORITY}
				<c:if test="${bannerVO.PRIORITY < maxPriority}">
					<div><img src="admin/images/bottom.png" width="25" height="25" onClick="lower_priority('${bannerVO.PRIORITY}');"></div>
				</c:if>
			</c:if>
		</td>
		<td>
			<c:if test="${bannerVO.USEYN == 'Y'}">
				<input type="radio" class="inputUseyn_${bannerVO.BSEQ}" name="inputUseyn_${bannerVO.BSEQ}" value="Y" disabled checked>예&nbsp;
				<input type="radio" class="inputUseyn_${bannerVO.BSEQ}" name="inputUseyn_${bannerVO.BSEQ}" value="N" disabled>아니오
			</c:if>
			<c:if test="${bannerVO.USEYN == 'N'}">
				<input type="radio" class="inputUseyn_${bannerVO.BSEQ}" name="inputUseyn_${bannerVO.BSEQ}" value="Y" disabled>예&nbsp;
				<input type="radio" class="inputUseyn_${bannerVO.BSEQ}" name="inputUseyn_${bannerVO.BSEQ}" value="N" disabled checked>아니오
			</c:if>
			<input type="hidden" id="oldUseyn_${bannerVO.BSEQ}" value="${bannerVO.USEYN}">
		</td>
		<td>
			<img src="images/banner/${bannerVO.IMAGE}" height="150">
		</td>
		<td>
			${bannerVO.NAME}
		</td>
		<td>
			<input type="text" id="inputUri_${bannerVO.BSEQ}" value="${bannerVO.URI}" readonly>
			<input type="hidden" id="oldUri_${bannerVO.BSEQ}" value="${bannerVO.URI}">
		</td>
		<td>
			<input type="button" id="edit_${bannerVO.BSEQ}" value="수정" onClick="go_edit_banner('${bannerVO.BSEQ}');">
			<input type="button" id="delete_${bannerVO.BSEQ}" value="삭제" onClick="go_delete_banner('${bannerVO.BSEQ}');">
			<input type="button" id="save_${bannerVO.BSEQ}" value="저장" onClick="go_save_banner('${bannerVO.BSEQ}', '${bannerVO.PRIORITY}');" style="display:none;">
			<input type="button" id="cancel_${bannerVO.BSEQ}" value="취소" onClick="go_cancel_banner('${bannerVO.BSEQ}');" style="display:none;">
			
		</td>
	</tr>
	</c:forEach>
	<tr>
		<th>신규등록</th>
		<td>
			<input type="radio" name="inputUseyn" value="Y">예&nbsp;
			<input type="radio" name="inputUseyn" value="N" checked>아니오
			<input type="hidden" name="useyn">
		</td>
		<td>
			<select name="biseq" onChange="refresh_preview();">
			<option value="0">선택</option>
			<c:forEach items="${bannerImageList}" var="imageVO">
				<option value="${imageVO.BISEQ}">${imageVO.NAME}</option>
			</c:forEach>
			</select>
			<br>
			<div id="preview"></div>
		</td>
		<td>
			<div id="name">선택된 이미지 없음</div>
		</td>
		<td>
			<input type="text" id="inputUri" name="inputUri">
			<input type="hidden" name="uri">
		</td>
		<td><input type="button" value="추가" onClick="go_add_banner();"></td>
	</tr>
	
</table>
</form>

</div>

<%@ include file="../common/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin banner image pool</h1>
<br>

<form name="bannerImageForm" method="post">
<table class="tblAdminBanner">
	<tr><th>번호</th><th>사용유무</th><th>이미지</th><th>이름</th><th>커맨드</th></tr>
	<c:forEach items="${bannerImageList}" var="imageVO" varStatus="status">
	<tr>
		<td>${status.count}</td>
		<td>
			<c:if test="${imageVO.COUNT != 0}">사용 중</c:if>
			<c:if test="${imageVO.COUNT == 0}">미사용</c:if>
		</td>
		<td><img src="images/banner/${imageVO.IMAGE}" height="150"></td>
		<td>
			<input type="text" id="name_${imageVO.BISEQ}" value="${imageVO.NAME}" readonly>
			<input type="hidden" id="oldName_${imageVO.BISEQ}" value="${imageVO.NAME}">
		</td>
		<td>
			<c:choose>
			<c:when test="${imageVO.COUNT != 0}">
				<div class="btn">
					<input type="button" id="edit_${imageVO.BISEQ}" value="수정" onClick="go_edit_banner_image('${imageVO.BISEQ}');">
				</div>
				<div class="btn">
					<input type="button" id="cancel_${imageVO.BISEQ}" value="취소" onClick="go_cancel_banner_image('${imageVO.BISEQ}');" style="display:none;">
				</div>
				<div class="btn">
					<input type="button" id="save_${imageVO.BISEQ}" value="저장" onClick="go_save_banner_image('${imageVO.BISEQ}');" style="display:none;">
				</div>
			</c:when>
			<c:otherwise>
				<div class="btn">
					<input type="button" value="삭제" onClick="go_delete_banner_image('${imageVO.BISEQ}');">
				</div>
			</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<th colspan="2">신규등록</th>
		<td>
			<div id="filename">${imageVO.IMAGE}</div>
			<input type="hidden" id="image" name="image" value="${imageVO.IMAGE}">
			<%-- <input type="hidden" id="previewFilename" name="previewFilename" value="${previewFilename}"> --%>
			<div id="preview"><%-- <c:if test="${not empty imageVO.IMAGE}"><img src="images/banner/${imageVO.IMAGE}" height="150"></c:if>--%></div>
			<input class="btn" type="button" value="사진선택" onClick="banner_upload_click();">
		</td>
		<td>
			<input type="text" id="inputName" name="inputName" style="width:90%;">
			<input type="hidden" id="name" name="name">
			<input type="hidden" id="index" name="biseq">
		</td>
		<td><div class="btn"><input type="button" value="추가" onClick="go_add_banner_image();"></div></td>
	</tr>
	
</table>
</form>

<div style="display:none;">
<form id="fileup" name="fileup" method="post" enctype="multipart/form-data">
	<input type="hidden" id="path" name="path">
	<input type="file" name="upload" onChange="copy_filename();">
</form>
</div>

</div>

<%@ include file="../common/footer.jsp" %>
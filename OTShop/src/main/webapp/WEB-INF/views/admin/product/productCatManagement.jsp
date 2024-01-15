<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="submenu.jsp" %>

<div class="content_wrap">

<br>
<h1>admin product category management</h1>
<br>

<form name="productCatForm" method="post">
   <input type="hidden" id="categoryClass" name="categoryClass">
   <input type="hidden" id="index" name="index">
   <input type="hidden" id="value" name="value">
   
   <table class="tblAdminProductCat">
   <tr><th colspan="2">번호</th><th colspan="2">카테고리</th><th>커맨드</th></tr>
   <tbody>
   <!-- 저장된 카테고리 셋 -->
   <c:forEach items="${categorySetList}" var="mainCatSetVO" varStatus="mainStatus">
   <tr>
      <td colspan="2">${mainStatus.count}</td>
      <td colspan="2">
         <select id="select_${mainCatSetVO.PMCSSEQ}" disabled>
         <c:forEach items="${mainCatList}" var="mainCatVO">
            <c:if test="${mainCatSetVO.PMCSEQ == mainCatVO.PMCSEQ}">
               <option value="${mainCatVO.PMCSEQ}" selected>${mainCatVO.NAME}</option>
            </c:if>
            <c:if test="${mainCatSetVO.PMCSEQ != mainCatVO.PMCSEQ}">
               <option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
            </c:if>
         </c:forEach>
         </select>
         <input type="hidden" id="oldValue_${mainCatSetVO.PMCSSEQ}" value="${mainCatSetVO.PMCSEQ}">
      </td>
      <td>
         <div class="btn">
            <input type="button" id="btnEdit_${mainCatSetVO.PMCSSEQ}"
            value="수정" onClick="btn_action('edit', '${mainCatSetVO.PMCSSEQ}', '0')">
         </div>
         <div class="btn">
            <input type="button" id="btnDelete_${mainCatSetVO.PMCSSEQ}"
            value="삭제" onClick="btn_action('delete', '${mainCatSetVO.PMCSSEQ}', '0')">
         </div>
         <div class="btn">
            <input type="button" id="btnSave_${mainCatSetVO.PMCSSEQ}"
            value="저장" onClick="btn_action('save', '${mainCatSetVO.PMCSSEQ}', '0')" style="display:none;">
         </div>
         <div class="btn">
            <input type="button" id="btnCancel_${mainCatSetVO.PMCSSEQ}"
            value="취소" onClick="btn_action('cancel', '${mainCatSetVO.PMCSSEQ}', '0')" style="display:none;">
         </div>
      </td>
   </tr>
      <c:forEach items="${mainCatSetVO.subCatSetList}" var="subCatSetVO" varStatus="subStatus">
      <tr>
         <td></td>
         <td>${mainStatus.count}-${subStatus.count}</td>
         <td colspan="2">
            <select id="select_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}" disabled>
            <c:forEach items="${subCatList}" var="subCatVO">
               <c:if test="${subCatSetVO.PSCSEQ == subCatVO.PSCSEQ}">
                  <option value="${subCatVO.PSCSEQ}" selected>${subCatVO.NAME}</option>
               </c:if>
               <c:if test="${subCatSetVO.PSCSEQ != subCatVO.PSCSEQ}">
                  <option value="${subCatVO.PSCSEQ}">${subCatVO.NAME}</option>
               </c:if>
            </c:forEach>
            </select>
            <input type="hidden" id="oldValue_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}" value="${subCatSetVO.PSCSEQ}">
         </td>
         <td>
            <div class="btn">
               <input type="button" id="btnEdit_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}"
               value="수정" onClick="btn_action('edit', '${mainCatSetVO.PMCSSEQ}', '${subCatSetVO.PSCSSEQ}')">
            </div>
            <div class="btn">
               <input type="button" id="btnDelete_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}"
               value="삭제" onClick="btn_action('delete', '${mainCatSetVO.PMCSSEQ}', '${subCatSetVO.PSCSSEQ}')">
            </div>
            <div class="btn">
               <input type="button" id="btnSave_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}"
               value="저장" onClick="btn_action('save', '${mainCatSetVO.PMCSSEQ}', '${subCatSetVO.PSCSSEQ}')" style="display:none;">
            </div>
            <div class="btn">
               <input type="button" id="btnCancel_${mainCatSetVO.PMCSSEQ}_${subCatSetVO.PSCSSEQ}"
               value="취소" onClick="btn_action('cancel', '${mainCatSetVO.PMCSSEQ}', '${subCatSetVO.PSCSSEQ}')" style="display:none;">
            </div>
         </td>
      </tr>
      </c:forEach>
   </c:forEach>
   </tbody>
   
   <tbody id="view"></tbody>
   
   <tbody id="main_template" style="display:none;">
      <tr id="main_row#origin">
         <th id="main_head#origin" rowspan="3" colspan="2">설정</th>
         <td colspan="2">
            <select id="mainRow_input#origin" onChange="main_changed();">
            <c:forEach items="${mainCatList}" var="mainCatVO">
               <option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
            </c:forEach>
            </select>
            <input type="hidden" id="pmcseq" name="pmcseq#origin">
         </td>
         <td>
            <div class="btn"><input type="button" value="저장" onClick="save_product_cat_set();"></div>
            <div class="btn"><input type="button" value="삭제" onClick="remove_main_cat_set();"></div>
         </td>
      </tr>
      <tr id="btn_row#origin">
         <td colspan="4"><div class="btn"><input type="button" value="추가" title="해당 메인 카테고리에 서브 카테고리를 추가합니다." onClick="add_sub_cat_set();"></div></td>
      </tr>
   </tbody>
   
   <tbody id="sub_template" style="display:none;">
      <tr id="sub_row_#index" class="sub_rows#origin">
         <td>Sub_#index</td>
         <td>
            <select id="subRow_input_#index" onChange="sub_changed('#index');">
            <option value="0">선택</option>
            <c:forEach items="${subCatList}" var="subCatVO">
               <option value="${subCatVO.PSCSEQ}">${subCatVO.NAME}</option>
            </c:forEach>
            </select>
            <input type="hidden" id="pscseq_#index" class="pscseq" name="pscseq#origin">
         </td>
         <td>
            <div class="btn"><input type="button" value="삭제" onClick="remove_sub_cat_set('#index');"></div>
         </td>
      </tr>
   </tbody>
   
   <tr>
      <th rowspan="2" colspan="2">추가</th>
      <td colspan="2">
         <select id="inputMainCat">
            <option value="0">선택</option>
            <c:forEach items="${mainCatList}" var="mainCatVO">
               <option value="${mainCatVO.PMCSEQ}">${mainCatVO.NAME}</option>
            </c:forEach>
         </select>
      </td>
      <td><div class="btn"><input type="button" value="추가" onClick="add_main_cat_set();"></div></td>
   </tr>
   
   </table>
</form>




</div>

<%@ include file="../common/footer.jsp" %>
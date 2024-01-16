<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>
<%-- <%@ include file="../include/mypageSub.jsp" %> --%>

<style type="text/css">
	
	#cart_list{
		border-collapse: collapse;
		
		/* cellpadding: 10px; */
	}
	#cart_list th, #cart_list td{
		empty-cells: hide;
		height: 30px;
		/* background: skyblue; */
		text-align: center;
		/* border-left: 1px solid silver;
		border-right: 1px solid silver; */
		border: 1px solid silver;
	}
	
	#cart_list th:first-child,
	#cart_list td:first-child{
		border-left: 0;
	}
	
	#cart_list th:last-child,
	#cart_list td:last-child{
		border-right: 0;
	}

	
</style>

<div class="content_wrap">
<%-- <%@ include file="../include/categorySub.jsp" %> --%>
<form>

<h2>cart list</h2>
<table id="cart_list">
	<tr class="head_row">
		<th width="50">번호</th>
		<th width="50"><input type="checkbox" checked></th>
		<th width="350" colspan="2">상품</th>
		<th width="100">수량</th>
		<th width="150">가격</th>
		<th width="50"></th>
	</tr>
	<c:forEach items="${cartList}" var="cartVO" varStatus="status">
	<tr class="content_row">
		<td>${status.count}</td>
		<td><input type="checkbox" checked></td>
		<td>
			<div style="width:200px;display:flex;">
				<div style="width:65px;height:65px;overflow:hidden;">
					<img src="images/product/${cartVO.IMAGE}" style="width:100%;height:auto;">
				</div>
				<div>
					<div style="text-align:left;font-weight:bold;">${cartVO.BRAND}</div>
					<div style="text-align:left;">${cartVO.NAME}</div>
				</div>
			</div>
		</td>
		<td><div style="width:150px;">${cartVO.OPTNAME}</div></td>
		<td>
			<div style="width:80px;margin-left:10px;margin-right:10px;display:flex;">
				<div id="btn_sub_qty_#index" class="btn" style="opacity:0.2;" onClick="sub_qty('#index');"><img src="images/sub.png" width="20" height="20"></div>
				<div id="display_qty_#index" style="display:inline;width:40px;text-align:center;">${cartVO.QTY}</div>
				<div id="btn_add_qty_#index" class="btn" onClick="add_qty('#index');"><img src="images/add.png" width="20" height="20"></div>
			</div>
		</td>
		<td>
			<div><fmt:formatNumber type="number" value="${cartVO.PRICE2 *  cartVO.QTY}"/>원</div>
		</td>
		<td><img src="images/delete.png" width="25" height="25"></td>
	</tr>
	</c:forEach>
</table>

</form>
</div>
    
<%@ include file="../include/footer.jsp" %>
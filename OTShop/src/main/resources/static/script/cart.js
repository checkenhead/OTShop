function go_add_cart(){
	//선택된 옵션이 있는지 확인
	var selected_price = document.getElementsByName("selected_price");
	var sum = 0;
	
	for(var i = 0; i < selected_price.length; i++){
		sum += Number(selected_price[i].value);
	}
	
	if(sum == 0){
		alert("옵션을 선택하세요.");
	} else {
		document.viewProductForm.action = "insertCart";
		document.viewProductForm.submit();	
	}
}

function delete_cart(cseq){
	if(confirm("장바구니에서 삭제하시겠습니까?")){
		document.cartListForm.cseq.value = cseq;
		document.cartListForm.action = "deleteCart";
		document.cartListForm.submit();
	}
}

function toggle_checkbox(){
	var toggle = document.getElementById("check_box_toggle");
	var check_boxs = document.getElementsByName("check_box");
	
	for(var i = 0; i < check_boxs.length; i++){
		check_boxs[i].checked = toggle.checked;
	}
}

function delete_cart_selected(){
	var check_boxs = document.getElementsByName("check_box");
	var count = 0;
	
	for(var i = 0; i < check_boxs.length; i++){
		if(check_boxs[i].checked)
			count++;
	}
	if(count == 0){
		alert("선택된 항목이 없습니다.");
	} else {
		if(confirm(count + "개의 항목을 장바구니에서 삭제하시겠습니까?")){
			document.cartListForm.action = "deleteCartByCheckbox";
			document.cartListForm.submit();
		}
	}
}
/*
function cart_sub_qty(index) {
	var max_qty = 10;
	var btn_sub = document.getElementById("btn_sub_qty_" + index);
	var btn_add = document.getElementById("btn_add_qty_" + index);
	var display_qty = document.getElementById("display_qty_" + index);
	var qty = document.getElementById("qty_" + index);
	var selected_price = document.getElementById("selected_price_" + index);
	var display_price = document.getElementById("display_price_" + index);
	var price = document.getElementById("price_" + index);

	if (qty.value > 1) {
		qty.value = Number(qty.value) - 1;
		display_qty.innerHTML = qty.value;
		selected_price.value = Number(qty.value) * Number(price.value);
		display_price.innerHTML = Number(selected_price.value).toLocaleString("ko-KR") + "원";
		btn_add.style.opacity = "1";
		refresh_total_price();
	}

	if (qty.value == 1) {
		btn_sub.style.opacity = "0.2";
	}
}

function cart_add_qty(index) {
	var max_qty = 10;
	var btn_sub = document.getElementById("btn_sub_qty_" + index);
	var btn_add = document.getElementById("btn_add_qty_" + index);
	var display_qty = document.getElementById("display_qty_" + index);
	var qty = document.getElementById("qty_" + index);
	var selected_price = document.getElementById("selected_price_" + index);
	var display_price = document.getElementById("display_price_" + index);
	var price = document.getElementById("price_" + index);

	if (qty.value < max_qty) {
		qty.value = Number(qty.value) + 1;
		display_qty.innerHTML = qty.value;
		selected_price.value = Number(qty.value) * Number(price.value);
		display_price.innerHTML = Number(selected_price.value).toLocaleString("ko-KR") + "원";
		btn_sub.style.opacity = "1";
		refresh_total_price();
	}

	if (qty.value == max_qty) {
		btn_add.style.opacity = "0.2";
	}
}
*/
function insert_order_cart(){
	var check_boxs = document.getElementsByName("check_box");
	var count = 0;
	
	for(var i = 0; i < check_boxs.length; i++){
		if(check_boxs[i].checked)
			count++;
	}
	if(count == 0){
		alert("선택된 항목이 없습니다.");
	} else {
		if(confirm(count + "개의 항목을 구매하시겠습니까?")){
			document.cartListForm.action = "insertOrderByCart";
			document.cartListForm.submit();
		}
	}
}
function searchProduct(cat, index) {
	var param = "";

	if (cat == "main")
		param = "pmcseq";
	else if (cat == "sub")
		param = "pscseq";

	location.href = "searchProduct?" + param + "=" + index;
}

function add_option() {
	var selector = document.getElementById("optionSelection");
	var target_element = document.getElementById("option_" + selector.value);
	var price = document.getElementById("price_" + selector.value);
	var selected_price = document.getElementById("selected_price_" + selector.value);

	//이미 추가된 항목인 경우 메시지 출력
	if (target_element.style.display != "none") {
		alert("이미 선택된 항목입니다.");
	} else {
		//가격 정보 저장
		selected_price.value = price.value;

		//선택된 요소 display = flex 지정, outerHTML 저장
		target_element.style.display = "flex";
		var content = target_element.outerHTML;

		//뷰 지점의 마자막으로 이동
		target_element.outerHTML = "";
		document.getElementById("selected_options").insertAdjacentHTML("beforeend", content);

		//form data disalbed 해제
		var pdseq = document.getElementById("pdseq_" + selector.value);
		var qty = document.getElementById("qty_" + selector.value);

		pdseq.disabled = false;
		qty.disabled = false;

		refresh_total_price();
	}
	//select 초기화
	selector.value = "0";
}

function sub_qty(index) {
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

function add_qty(index) {
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

function remove_option(index) {
	var target_element = document.getElementById("option_" + index);
	var btn_sub = document.getElementById("btn_sub_qty_" + index);
	var btn_add = document.getElementById("btn_add_qty_" + index);
	var display_qty = document.getElementById("display_qty_" + index);
	var qty = document.getElementById("qty_" + index);
	var selected_price = document.getElementById("selected_price_" + index);
	var display_price = document.getElementById("display_price_" + index);
	var price = document.getElementById("price_" + index);

	//display none
	target_element.style.display = "none";

	//qty, display_qty 초기화
	qty.value = 1;
	display_qty.innerHTML = qty.value;

	//가격 정보 초기화
	selected_price.value = "0";

	//display_price 초기화
	display_price.innerHTML = Number(price.value).toLocaleString("ko-KR") + "원";

	//버튼초기화
	btn_sub.style.opacity = "0.2";
	btn_add.style.opacity = "1";

	//form data 초기화
	var pdseq = document.getElementById("pdseq_" + index);
	var qty = document.getElementById("qty_" + index);

	pdseq.disabled = true;
	qty.disabled = true;

	refresh_total_price();
}

function refresh_total_price() {
	var totalPrice = document.getElementById("totalPrice");
	var selected_price = document.getElementsByName("selected_price");
	var sum = 0;

	for (var i = 0; i < selected_price.length; i++) {
		sum += Number(selected_price[i].value);
	}

	totalPrice.innerHTML = sum.toLocaleString("ko-KR") + "원";
}
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
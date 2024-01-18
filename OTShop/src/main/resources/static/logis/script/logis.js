function save_description(iseq){
	if(document.getElementById("description_" + iseq).value == ""){
		alert("내용을 입력하세요.");
	} else if(confirm("진행상황을 저장하시겠습니까?")){
		document.transportListForm.iseq.value = iseq;
		document.transportListForm.description.value = document.getElementById("description_" + iseq).value;
		document.transportListForm.action = "insertTransportHistory";
		document.transportListForm.submit();
	}
}

function change_invoice_state(iseq, command){
	var targetForm = document.invoiceListForm == undefined ? document.transportListForm : document.invoiceListForm;
	var confirm_message = "";
	
	if(command == "startTransport")
		confirm_message = "해당 건을 진행하시겠습니까?";
	else if(command == "collectgCompleted")
		confirm_message = "집하 완료로 전환하시겠습니까?";
	else if(command == "delivering")
		confirm_message = "배송 중으로 전환하시겠습니까?";
	else if(command == "deliverCompleted")
		confirm_message = "배송 완료로 전환하시겠습니까?";

	
	if(confirm(confirm_message)){
		targetForm.iseq.value = iseq;
		targetForm.command.value = command;
		targetForm.action = "updateInvoiceState";
		targetForm.submit();
	}
}
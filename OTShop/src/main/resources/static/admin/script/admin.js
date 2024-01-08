function toggle_options(pseq) {
	if (document.getElementById("option_" + pseq).style.display == "none") {
		document.getElementById("option_" + pseq).style.display = "block";
		document.getElementById("img_" + pseq).src = "admin/images/top.png";
	}
	else {
		document.getElementById("option_" + pseq).style.display = "none";
		document.getElementById("img_" + pseq).src = "admin/images/bottom.png";
	}
}

function reg_new_product() {
	location.href = "insertProductForm";
}

function go_add_option() {
	var targetForm = document.insertProductForm == undefined ? document.updateProductForm : document.insertProductForm;
	if (document.getElementById("input_option").value == "") {
		alert("옵션명을 입력하세요.");
		document.getElementById("input_option").focus();
		return;
	}
	else {
		targetForm.action = "changeOption";
		targetForm.submit();
	}
}

function go_delete_option(delIndex) {
	var targetForm = document.insertProductForm == undefined ? document.updateProductForm : document.insertProductForm;
	targetForm.delIndex.value = delIndex;
	targetForm.action = "changeOption";
	targetForm.submit();
}

function cal_price(index) {
	var targetForm = document.insertProductForm == undefined ? document.updateProductForm : document.insertProductForm;
	var price1 = targetForm.price1;
	var price2 = targetForm.price2;
	var price3 = targetForm.price3;
	
	if (price1.length == undefined) {
		//option이 1개인 경우
		if (isNaN(price1.value) || isNaN(price2.value)) {
			price3.value = 0;
		} else {
			price3.value = price2.value - price1.value;
		}
	} else {
		//option이 2개 이상인 경우
		if (isNaN(price1[index].value) || isNaN(price2[index].value)) {
			price3[index].value = 0;
		} else {
			price3[index].value = price2[index].value - price1[index].value;
		}
	}
}

function upload_click() {
	document.fileup.upload.click();
}

function copy_filename() {
	document.getElementById("filename").innerHTML = document.fileup.upload.value.replace("C:\\fakepath\\", "");
	//document.insertProductForm.previewFilename.value = document.fileup.upload.value.replace("C:\\fakepath\\", "");

	fileup();
}

function fileup() {
	var formselect = $("#fileup")[0];   // 지정된 폼을 변수에 저장
	var formdata = new FormData(formselect);   // 전송용 폼객에 다시 저장
	var host = window.location.origin;

	$.ajax({    // 웹페이지 이동 또는 새로고침이 필요없는 request요청
		// 현재주소의 fileup 리퀘스트로 요청  http://localhost:8070/fileup
		//<%=request.getContextPath() %>/fileup
		url: host + "/fileup",
		type: "POST",
		enctype: "multipart/form-data",
		async: false,
		data: formdata,
		timeout: 10000,
		contentType: false,
		processData: false,

		success: function(data) {    // controller 에서 린턴된 해시맵이  data 로 전달됩니다
			if (data.STATUS == 1) {  	// 동적으로 div태그 달아주기.
				//$("#filename").append("<div>" + data.FILENAME + "</div>");
				$("#image").val(data.FILENAME);
				$("#preview").html("<img src='images/product/" + data.FILENAME + "' height='150'/>");
			}
		},
		error: function() { alert("실패"); }
	});
}

function go_reg_product() {
	document.insertProductForm.action = "insertProduct";
	document.insertProductForm.submit();
}

function go_edit_cat(index){
	document.getElementById("name_" + index).readOnly = false;
	document.getElementById("name_" + index).focus();
	document.getElementById("name_" + index).select();
	document.getElementById("edit_" + index).style.display = "none";
	document.getElementById("cancel_" + index).style.display = "block";
	document.getElementById("save_" + index).style.display = "block";
}

function go_cancel_cat(index){
	document.getElementById("name_" + index).readOnly = true;
	document.getElementById("name_" + index).value = document.getElementById("oldName_" + index).value;
	document.getElementById("edit_" + index).style.display = "block";
	document.getElementById("edit_" + index).focus();
	document.getElementById("cancel_" + index).style.display = "none";
	document.getElementById("save_" + index).style.display = "none";
}

function go_delete_cat(name, index, action){
	var targetForm = document.productCatForm == undefined ? document.faqCatForm : document.productCatForm;
	
	if(confirm("등록된 카테고리 [" + name + "]이 삭제됩니다. 진행하시겠습니까?")){
		document.getElementById("index").value = index;
		//targetForm.action = "deleteProductCat";
		//targetForm.action = "deleteFaqCat";
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_save_cat(count, index, action){
	var targetForm = document.productCatForm == undefined ? document.faqCatForm : document.productCatForm;
	var answer = true;
	
	if(count != null)
		answer = confirm("이미 사용 중인 " + count + "건의 카테고리 명이 변경됩니다. 진행하시겠습니까?");
		
	if(answer){
		document.getElementById("index").value = index;
		document.getElementById("name").value = document.getElementById("name_" + index).value;
		//targetForm.action = "updateProductCat";
		//targetForm.action = "updateFaqCat";
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_add_cat(action){
	var targetForm = document.productCatForm == undefined ? document.faqCatForm : document.productCatForm;
	
	if(targetForm.name.value == ""){
		alert("카테고리를 입력하세요.");
	}else{
		//targetForm.action = "insertProductCat";
		//targetForm.action = "insertFaqCat";
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_view_product(pseq){
	document.getElementById("pseq").value = pseq;
	document.productManForm.action = "adminViewProduct";
	document.productManForm.submit();
}

function go_edit_product(pseq){
	var targetForm = document.productManForm == undefined ? document.adminViewProductForm : document.productManForm;
	document.getElementById("pseq").value = pseq;
	targetForm.method = "post";
	targetForm.action = "updateProductForm";
	targetForm.submit();
}

function change_opt_useyn(index){
	if(document.getElementsByClassName("optRadio_" + index)[0].checked){
		document.getElementById("optUseyn_" + index).value = "Y";
	} else {
		document.getElementById("optUseyn_" + index).value = "N";
	}
}

function go_save_product(){
	document.updateProductForm.action = "updateProduct";
	document.updateProductForm.submit();
}

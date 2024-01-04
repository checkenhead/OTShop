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
	if (document.getElementById("input_option").value == "") {
		alert("옵션명을 입력하세요.");
		document.getElementById("input_option").focus();
		return;
	}
	else {
		document.insertProductForm.action = "changeOption";
		document.insertProductForm.submit();
	}
}

function go_delete_option(delIndex) {
	document.insertProductForm.delIndex.value = delIndex;
	document.insertProductForm.action = "changeOption";
	document.insertProductForm.submit();
}

function cal_price(index) {
	var price1 = document.insertProductForm.price1;
	var price2 = document.insertProductForm.price2;
	var price3 = document.insertProductForm.price3;

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
	document.getElementById("filename").innerHTML += document.fileup.upload.value.replace("C:\\fakepath\\", "");
	document.insertProductForm.previewFilename.value = document.fileup.upload.value.replace("C:\\fakepath\\", "");

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
				$("#preview").append("<img src='images/product/" + data.FILENAME + "' height='150'/>");
			}
		},
		error: function() { alert("실패"); }
	});
}

function go_reg_product() {
	document.insertProductForm.action = "insertProduct";
	document.insertProductForm.submit();
}

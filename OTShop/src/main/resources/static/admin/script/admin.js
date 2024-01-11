function toggle_options(index, mergeSize) {
	if (document.getElementById("optionHead_" + index).style.display == "none") {
		document.getElementById("optionHead_" + index).style.display = "";

		for (var i = 0; i < document.getElementsByClassName("optionContent_" + index).length; i++)
			document.getElementsByClassName("optionContent_" + index)[i].style.display = "";

		document.getElementById("imgCell_" + index).rowSpan = mergeSize;
		document.getElementById("indexCell_" + index).rowSpan = mergeSize;
		document.getElementById("commandCell_" + index).rowSpan = mergeSize;
		document.getElementById("img_" + index).src = "admin/images/top.png";
	}
	else {
		document.getElementById("optionHead_" + index).style.display = "none";

		for (var i = 0; i < document.getElementsByClassName("optionContent_" + index).length; i++)
			document.getElementsByClassName("optionContent_" + index)[i].style.display = "none";

		document.getElementById("imgCell_" + index).rowSpan = "1";
		document.getElementById("indexCell_" + index).rowSpan = "1";
		document.getElementById("commandCell_" + index).rowSpan = "1";
		document.getElementById("img_" + index).src = "admin/images/bottom.png";
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

function product_upload_click() {
	document.getElementById("path").value = "images/product/";
	document.fileup.upload.click();
}

function copy_filename() {
	document.getElementById("filename").innerHTML = document.fileup.upload.value.replace("C:\\fakepath\\", "");

	fileup();
}

function fileup() {
	var formselect = $("#fileup")[0];
	var formdata = new FormData(formselect);
	var host = window.location.origin;
	var path = document.getElementById("path").value;

	$.ajax({
		url: host + "/fileup",
		type: "POST",
		enctype: "multipart/form-data",
		async: false,
		data: formdata,
		timeout: 10000,
		contentType: false,
		processData: false,

		success: function(data) {
			if (data.STATUS == 1) {
				//$("#filename").append("<div>" + data.FILENAME + "</div>");
				$("#image").val(data.FILENAME);
				$("#preview").html("<img src='" + path + data.FILENAME + "' height='150'/>");
			}
		},
		error: function() { alert("실패"); }
	});
}

function go_reg_product() {
	document.insertProductForm.action = "insertProduct";
	document.insertProductForm.submit();
}

function go_edit_cat(index) {
	document.getElementById("name_" + index).readOnly = false;
	document.getElementById("name_" + index).focus();
	document.getElementById("name_" + index).select();
	document.getElementById("edit_" + index).style.display = "none";
	document.getElementById("cancel_" + index).style.display = "block";
	document.getElementById("save_" + index).style.display = "block";
}

function go_cancel_cat(index) {
	document.getElementById("name_" + index).readOnly = true;
	document.getElementById("name_" + index).value = document.getElementById("oldName_" + index).value;
	document.getElementById("edit_" + index).style.display = "block";
	document.getElementById("edit_" + index).focus();
	document.getElementById("cancel_" + index).style.display = "none";
	document.getElementById("save_" + index).style.display = "none";
}

function go_delete_cat(name, index, action) {
	var targetForm;

	if (document.faqCatForm != undefined){
		targetForm = document.faqCatForm;
	} else if (document.qnaCatForm != undefined){
		targetForm = document.qnaCatForm;		
	} else if (document.productCatForm != undefined){
		targetForm = document.productCatForm;
	} else {
		alert("targetForm 설정 오류");
		return;
	}

	if (confirm("등록된 카테고리 [" + name + "]이 삭제됩니다. 진행하시겠습니까?")) {
		document.getElementById("index").value = index;
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_save_cat(count, index, action) {
	var targetForm;

	if (document.faqCatForm != undefined){
		targetForm = document.faqCatForm;		
	} else if (document.qnaCatForm != undefined){
		targetForm = document.qnaCatForm;		
	} else if (document.productCatForm != undefined){
		targetForm = document.productCatForm;
	} else {
		alert("targetForm 설정 오류");
		return;
	}

	var answer = true;

	if (count != null)
		answer = confirm("이미 사용 중인 " + count + "건의 카테고리 명이 변경됩니다. 진행하시겠습니까?");

	if (answer) {
		document.getElementById("index").value = index;
		document.getElementById("name").value = document.getElementById("name_" + index).value;
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_add_cat(action) {
	var targetForm;

	if (document.faqCatForm != undefined){
		targetForm = document.faqCatForm;
	} else if (document.qnaCatForm != undefined){
		targetForm = document.qnaCatForm;
	} else if (document.productCatForm != undefined){
		targetForm = document.productCatForm;
	} else {
		alert("targetForm 설정 오류");
		return;
	}

	if (targetForm.inputName.value == "") {
		alert("카테고리를 입력하세요.");
	} else {
		document.getElementById("name").value = document.getElementById("inputName").value;
		targetForm.action = action;
		targetForm.submit();
	}
}

function go_view_product(pseq) {
	document.getElementById("pseq").value = pseq;
	document.productManForm.action = "adminViewProduct";
	document.productManForm.submit();
}

function go_edit_product(pseq) {
	var targetForm = document.productManForm == undefined ? document.adminViewProductForm : document.productManForm;
	document.getElementById("pseq").value = pseq;
	targetForm.method = "post";
	targetForm.action = "updateProductForm";
	targetForm.submit();
}

function change_opt_useyn(index) {
	if (document.getElementsByClassName("optRadio_" + index)[0].checked) {
		document.getElementById("optUseyn_" + index).value = "Y";
	} else {
		document.getElementById("optUseyn_" + index).value = "N";
	}
}

function go_save_product() {
	document.updateProductForm.action = "updateProduct";
	document.updateProductForm.submit();
}

function go_add_faq() {
	if (document.faqManForm.inputFcseq.value == 0) {
		alert("FAQ 분류를 선택하세요.");
		document.faqManForm.inputFcseq.focus();
		return;
	} else if (document.faqManForm.inputTitle.value == 0) {
		alert("FAQ 질문을 입력하세요.");
		document.faqManForm.inputTitle.focus();
		return;
	} else if (document.faqManForm.inputContent.value == 0) {
		alert("FAQ 답변을 입력하세요.");
		document.faqManForm.inputContent.focus();
		return;
	} else {
		document.faqManForm.fcseq.value = document.faqManForm.inputFcseq.value;
		document.faqManForm.title.value = document.faqManForm.inputTitle.value;
		document.faqManForm.content.value = document.faqManForm.inputContent.value;
		document.faqManForm.action = "insertFaq";
		document.faqManForm.submit();
	}
}

function faq_edit(index) {
	document.getElementById("save_" + index).style.display = "block";
	document.getElementById("cancel_" + index).style.display = "block";
	document.getElementById("delete_" + index).style.display = "none";
	document.getElementById("edit_" + index).style.display = "none";
	document.getElementById("fcseq_" + index).disabled = false;
	document.getElementById("title_" + index).readOnly = false;
	document.getElementById("content_" + index).readOnly = false;
}
function faq_delete(index) {
	if (confirm("선택한 FAQ가 삭제됩니다. 진행하시겠습니까?")) {
		document.faqManForm.fseq.value = index;
		document.faqManForm.action = "deleteFaq";
		document.faqManForm.submit();
	}
}
function faq_save(index) {
	if (document.getElementById("fcseq_" + index).value == 0) {
		alert("FAQ 분류를 선택하세요.");
		document.getElementById("fcseq_" + index).focus();
		return;
	} else if (document.getElementById("title_" + index).value == 0) {
		alert("FAQ 질문을 입력하세요.");
		document.getElementById("title_" + index).focus();
		return;
	} else if (document.getElementById("content_" + index).value == 0) {
		alert("FAQ 답변을 입력하세요.");
		document.getElementById("content_" + index).focus();
		return;
	} else {
		document.faqManForm.fseq.value = index;
		document.faqManForm.fcseq.value = document.getElementById("fcseq_" + index).value;
		document.faqManForm.title.value = document.getElementById("title_" + index).value;
		document.faqManForm.content.value = document.getElementById("content_" + index).value;
		document.faqManForm.action = "updateFaq";
		document.faqManForm.submit();
	}
}
function faq_cancel(index) {
	document.getElementById("save_" + index).style.display = "none";
	document.getElementById("cancel_" + index).style.display = "none";
	document.getElementById("delete_" + index).style.display = "block";
	document.getElementById("edit_" + index).style.display = "block";
	document.getElementById("fcseq_" + index).disabled = true;
	document.getElementById("title_" + index).readOnly = true;
	document.getElementById("content_" + index).readOnly = true;

	document.getElementById("fcseq_" + index).value = document.getElementById("oldFcseq_" + index).value;
	document.getElementById("title_" + index).value = document.getElementById("oldTitle_" + index).value;
	document.getElementById("content_" + index).value = document.getElementById("oldContent_" + index).value;
}

function toggle_memberDetail(index) {
	if (document.getElementById("memberDetailHead_" + index).style.display == "none") {
		document.getElementById("memberDetailHead_" + index).style.display = "";
		document.getElementById("memberDetailContent_" + index).style.display = "";
		document.getElementById("imgCell_" + index).rowSpan = "3";
		document.getElementById("indexCell_" + index).rowSpan = "3";
		document.getElementById("img_" + index).src = "admin/images/top.png";
	}
	else {
		document.getElementById("memberDetailHead_" + index).style.display = "none";
		document.getElementById("memberDetailContent_" + index).style.display = "none";
		document.getElementById("imgCell_" + index).rowSpan = "1";
		document.getElementById("indexCell_" + index).rowSpan = "1";
		document.getElementById("img_" + index).src = "admin/images/bottom.png";
	}
}

function toggle_memberUseyn(userid, useyn) {
	if (useyn == "Y" || useyn == "N") {
		document.getElementById("userid").value = userid;
		document.getElementById("useyn").value = useyn;
		document.memberManForm.action = "changeMemberUseyn";
		document.memberManForm.submit();
	} else {
		return;
	}
}

function reply_to(action) {
	var answer = true;

	if (action == "update")
		answer = confirm("답변을 변경하시겠습니까?");

	if (answer) {
		document.adminViewQnaForm.action = "updateQnaReply";
		document.adminViewQnaForm.submit();
	}
}

function go_delete_qna() {
	if (confirm("이 Q&A를 삭제하시겠습니까?")) {
		document.adminViewQnaForm.action = "deleteQna";
		document.adminViewQnaForm.submit();
	}
}

function banner_upload_click() {
	document.getElementById("path").value = "images/banner/";
	document.fileup.upload.click();
}

function go_add_banner_image() {
	if (document.bannerImageForm.inputName.value == "") {
		alert("이름을 입력하세요.");
		return;
	} else if (document.bannerImageForm.image.value == "") {
		alert("이미지를 추가하세요.");
		return;
	} else {
		document.bannerImageForm.name.value = document.bannerImageForm.inputName.value;
		document.bannerImageForm.action = "insertBannerImage";
		document.bannerImageForm.submit();
	}
}

function go_delete_banner_image(index) {
	if (confirm("이 이미지를 삭제하시겠습니까?")) {
		document.getElementById("index").value = index;
		document.bannerImageForm.action = "deleteBannerImage";
		document.bannerImageForm.submit();
	}
}

function refresh_preview() {
	if (document.bannerManForm.biseq.value == 0) {
		document.getElementById("preview").innerHTML = "";
		document.getElementById("name").innerHTML = "선택된 이미지 없음";
	} else {
		var formselect = $("#bannerManForm")[0];
		var formdata = new FormData(formselect);
		var host = window.location.origin;
		var path = "images/banner/";
		
		document.getElementById("name").innerText = document.querySelector('select[name="biseq"] > option:checked').innerText;
		
		$.ajax({
			url: host + "/getImageByBiseq",
			type: "POST",
			enctype: "application/x-www-form-urlencoded",
			async: false,
			data: formdata,
			timeout: 10000,
			contentType: false,
			processData: false,

			success: function(data) {
				if (data.STATUS == 1) {
					//$("#filename").append("<div>" + data.FILENAME + "</div>");
					//$("#image").val(data.FILENAME);
					$("#preview").html("<img src='" + path + data.FILENAME + "' height='150'/>");
				}
			},
			error: function() { alert("실패"); }
		});
	}
}

function go_add_banner(){
	document.bannerManForm.useyn.value = document.bannerManForm.inputUseyn.value;
	document.bannerManForm.uri.value = document.bannerManForm.inputUri.value;
	document.bannerManForm.action = "insertBanner";
	document.bannerManForm.submit();
}

function go_delete_banner(index){
	if(confirm("이 이미지를 배너에서 삭제하시겠습니까?")){
		document.bannerManForm.bseq.value = index;
		document.bannerManForm.action = "deleteBanner";
		document.bannerManForm.submit();
	}
}

function go_edit_banner(index){
	document.getElementsByClassName("inputUseyn_" + index)[0].disabled = false;
	document.getElementsByClassName("inputUseyn_" + index)[1].disabled = false;
	document.getElementById("inputUri_" + index).readOnly = false;
	document.getElementById("edit_" + index).style.display = "none";
	document.getElementById("delete_" + index).style.display = "none";
	document.getElementById("save_" + index).style.display = "";
	document.getElementById("cancel_" + index).style.display = "";
}

function go_cancel_banner(index){
	//document.bannerManForm.reset();
	if(document.getElementById("oldUseyn_" + index).value == "Y"){
		document.getElementsByClassName("inputUseyn_" + index)[0].checked = true;
		document.getElementsByClassName("inputUseyn_" + index)[1].checked = false;
	} else {
		document.getElementsByClassName("inputUseyn_" + index)[0].checked = false;
		document.getElementsByClassName("inputUseyn_" + index)[1].checked = true;
	}
	document.getElementById("inputUri_" + index).value = document.getElementById("oldUri_" + index).value;
	document.getElementsByClassName("inputUseyn_" + index)[0].disabled = true;
	document.getElementsByClassName("inputUseyn_" + index)[1].disabled = true;
	document.getElementById("inputUri_" + index).readOnly = true;
	document.getElementById("edit_" + index).style.display = "";
	document.getElementById("delete_" + index).style.display = "";
	document.getElementById("save_" + index).style.display = "none";
	document.getElementById("cancel_" + index).style.display = "none";
}

function go_save_banner(index, priority){
	if(confirm("변경사항을 저장하시겠습니까?")){
		document.bannerManForm.bseq.value = index;
		document.bannerManForm.priority.value = priority;
		document.bannerManForm.useyn.value = document.getElementsByClassName("inputUseyn_" + index)[0].checked ? "Y" : "N";
		document.bannerManForm.uri.value = document.getElementById("inputUri_" + index).value;
		document.bannerManForm.action = "updateBanner";
		document.bannerManForm.submit();
	}
}

function raise_priority(priority){
	document.bannerManForm.priority.value = priority;
	document.bannerManForm.action = "raiseBannerPriority";
	document.bannerManForm.submit();
}

function lower_priority(priority){
	document.bannerManForm.priority.value = priority;
	document.bannerManForm.action = "lowerBannerPriority";
	document.bannerManForm.submit();
}
/*
function add_product_cat(){
	if(document.productCatForm.inputCategoryClass.value == ""){
		alert("카테고리의 상/하위 분류를 선택하세요.");
		document.productCatForm.inputCategoryClass.focus();
		return;
	} else if(document.productCatForm.inputName.value == ""){
		alert("카테고리 이름을 입력하세요.");
		document.productCatForm.inputName.focus();
		return;
	} else {
		document.productCatForm.categoryClass.value = document.productCatForm.inputCategoryClass.value;
		document.productCatForm.name.value = document.productCatForm.inputName.value;
		document.productCatForm.action = "insertProductCat";
		document.productCatForm.submit();
	}
}
*/

function add_main_cat_set(){
	if(document.getElementById("inputMainCat").value == "0"){
		alert("메인 카테고리를 선택하세요.");
		document.getElementById("inputMainCat").focus();
		return;
	} else {
		document.getElementById("emptyMessage").style.display = "none";
		
		var rows = document.getElementsByClassName("mainrow");
		var cur_rows = rows == undefined ? 0 : rows.length;
		
		var content = "<tr class=\"mainrow\" id=\"mainrow_" + (cur_rows + 1) + "\"><th>tmp</th><td id=\"insertPoint_" + (cur_rows + 1) + "\" colspan=\"2\"></td></tr>";
		
		document.getElementById("tmp").insertAdjacentHTML("beforeend", content);
		
		content = document.getElementById("inputMainCat").outerHTML;
		content = content.replace("\"inputMainCat\"", "\"inputMainCat_" + (cur_rows + 1) + "\" name=\"inputMainCat\"");
		content = content.replace("<option value=\"0\">선택</option>", "");
		
		document.getElementById("insertPoint_" + (cur_rows + 1)).insertAdjacentHTML("beforeend", content);
		document.getElementById("inputMainCat_" + (cur_rows + 1)).value = document.getElementById("inputMainCat").value;
		
		content = "<td><div class=\"btn\"><input type=\"button\" value=\"삭제\" onClick=\"remove_product_cat_set('" + (cur_rows + 1) + "');\"></div></td>";
		document.getElementById("mainrow_" + (cur_rows + 1)).insertAdjacentHTML("beforeend", content);
	}
}

function remove_main_cat_set(index){
	document.getElementById("mainrow_" + index).outerHTML = "";
}

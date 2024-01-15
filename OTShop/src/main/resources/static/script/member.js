function checkAll() {
    var allAgree = document.getElementById("allAgree");
    var checkboxes = document.querySelectorAll("#ageAgree, #useAgree, #infoAgree, #advertAgree1, #advertAgree2");

    checkboxes.forEach(function (checkbox) {
        checkbox.checked = allAgree.checked;
    });
}


function useContract(){
	var opt = "toolbar=no, menubar=no, resizable=no, width=400, height=600, scrollbars=yes";
	window.open("/useContract", "UseContract", opt);
}


function infoContract(){
	var opt = "toolbar=no, menubar=no, resizable=no, width=400, height=600, scrollbars=yes";
	window.open("/infoContract", "InfoContract", opt);
}


function goNext(){
	if(document.contractFrm.ageAgree.checked == false){
		alert('연령 확인에 동의하지 않으셨습니다.')
	}else if(document.contractFrm.useAgree.checked == false ){
		alert('이용악관에 미동의하셨습니다.');
	}else if(document.contractFrm.infoAgree.checked == false){
		alert('개인정보 수집 약관에 미동의하셨습니다.');
	}else{
		document.contractFrm.action = "joinForm";
		document.contractFrm.submit();
	}
}


function idcheck(){
	if(document.joinFrm.userid.value==""){
		alert("아이디 입력 후 중복확인을 해주세요.")
		document.joinFrm.userid.focus();
		return;
	}
	var url = "idCheckForm?userid=" + document.joinFrm.userid.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=350, height=500, scrollbars=no";
	window.open(url, "IdCheck", opt);
}


function gofindId(){
	if(document.findIdFrm.name.value==""){
		alert("이름을 입력하세요.")
		document.findIdFrm.name.focus();
	}else if(document.findIdFrm.email.value==""){
		alert("이메일을 입력하세요.")
		document.findIdFrm.email.focus();
	}else{
		document.findIdFrm.action = "findId";
		document.findIdFrm.submit();
	}
}


function gofindPwd(){
	if(document.findPwdFrm.userid.value==""){
		alert("아이디를 입력하세요.");
		document.findIdFrm.userid.focus();
	}else if(document.findPwdFrm.kind.value==""
				|| document.findPwdFrm.kind.value=="0"){
		alert("질문을 선택하세요.");
		document.findIdFrm.kind.focus();
	}else if(document.findPwdFrm.answer.value==""){
		alert("답변을 입력하세요.");
		document.findIdFrm.kind.focus();
	}else{
		document.findPwdFrm.action = "findPwd";
		document.findPwdFrm.submit();
	}
}



function idok(userid){
	opener.joinFrm.userid.value = userid;
	// 부모창(opener)의 해당 폼(joinFrm)의 userid 값을 전달인수로 받은 userid로 설정
	opener.joinFrm.reid.value = userid;
	self.close();
}


function noDelete(){
	alert("회원탈퇴가 취소되었습니다. 메인 화면으로 돌아갑니다.");
	window.location.href="/";
}


function yesDelete(userid){
	document.mdeleteFrm.action = "mdelete";
	document.mdeleteFrm.submit();
}
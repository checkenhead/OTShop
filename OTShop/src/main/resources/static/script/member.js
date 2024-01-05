function checkAll(){
	var allAgree = document.getElementById("allAgree");
	var ageAgree = document.getElementById("ageAgree");
	var useAgree = document.getElementById("useAgree");
	var infoAgree = document.getElementById("infoAgree");
	var advertAgree1 = document.getElementById("advertAgree1");
	var advertAgree2 = document.getElementById("advertAgree2");
	
	if(allAgree.checked){
		ageAgree.checked = true;
		useAgree.checked = true;
		infoAgree.checked = true;
		advertAgree1.checked = true;
		advertAgree2.checked = true;
	} else{
		ageAgree.checked = false;
		useAgree.checked = false;
		infoAgree.checked = false;
		advertAgree1.checked = false;
		advertAgree2.checked = false;
	}
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
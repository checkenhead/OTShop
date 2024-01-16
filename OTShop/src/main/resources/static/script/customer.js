document.addEventListener("DOMContentLoaded", function () {
  // 페이지의 DOM 구조가 완전히 로드되면 실행

  var faqTitles = document.querySelectorAll(".faqtitle2");
  // faqtitle2 클래스를 가진 모든 요소를 선택하여 가져옴

  faqTitles.forEach(function (title) {
    // 가져온 요소에 forEach 함수를 사용하여 각각의 FAQ 제목에 대해 아래의 동작을 수행

    title.addEventListener("click", function () {
      // FAQ 제목을 클릭했을 때 실행되는 함수

      var contentId = "faqContent_" + this.id.split("_")[1];
      // FAQ 내용의 ID를 동적으로 생성. 예: "faqContent_1", "faqContent_2"

      var contentDiv = document.getElementById(contentId);
      // 생성된 ID를 사용하여 해당 FAQ 내용의 요소를 가져옴

      if (contentDiv) {
        // 해당 FAQ 내용의 요소가 존재하는 경우에만 다음 동작 수행

        contentDiv.style.display = (contentDiv.style.display === "none") ? "block" : "none";
        // FAQ 내용의 화면에 보이거나 감추기. 토글(Toggle) 동작을 수행
      }
    });
  });
});


function getselect(){
	var qnaName = document.getElementById("qnaName").value;
	// 배열이므로 .value는 X(=.value는 하나의 값으로 가져오는 것)
	var qnaAll = document.getElementsByClassName("qna");
	
	for(var i=0; i<document.getElementsByClassName("qcseq").length; i++){
		var qcseqValue = document.getElementsByClassName("qcseq")[i].value;
		
		if(qnaName == "all"){
			qnaAll[i].style.display = '';
		} else if(qnaName == qcseqValue){
			document.getElementById("qna_"+ i).style.display='';
		} else {
			document.getElementById("qna_"+ i).style.display='none';
		}		
	}
}


function userCheckForm(qseq, userid){
	var url = "userCheckForm?qseq=" + qseq + "&userid=" + userid;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "userCheck", opt);
}
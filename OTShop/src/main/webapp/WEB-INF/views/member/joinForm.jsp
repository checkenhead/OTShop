<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<article id="jwrap">
<form id="join" action="join" method="post" name="joinFrm">
	<fieldset id="joinCover"><legend><img src="images/user.png">회원 정보 입력</legend>
		
			<fieldset id="mtitle1"><legend>필수 입력 사항</legend>
				<div id="mspec">
					<label>아이디</label><input type="text" name="userid" value="${mdto.userid}">
					<input type="hidden" name="reid" value="${reid}">
					<input type="button" id="idcheckBtn" value="중복 확인" onclick="idcheck()"><br>
					<label>비밀번호</label><input type="password" name="pwd" value="${mdto.pwd}"><br>
					<label>비밀번호 확인</label><input type="password" name="repwd" value="${repwd}"><br>
					<label>비밀번호 찾기 질문 선택</label>
						<select name="kind" id="pwdAsk">
							<option value="0" selected>---- 질문을 선택하세요 ----</option>
							<option value="1">기억에 남는 추억의 장소는?</option>
							<option value="2">가장 기억에 남는 선생님 성함은?</option>
							<option value="3">유년시절 가장 생각나는 친구 이름은?</option>
						</select><br>
					<label>답변</label><input type="text" name="answer" placeholder="답변 입력"><br>
					<label>이름</label><input type="text" name="name" value="${mdto.name}"><br>
					<label>성별</label><input type="radio" name="gender" value="M">남자	<input type="radio" name="gender" value="F">여자<br>
					<!-- input의 date 타입은 yyyy-mm-dd 포맷으로 String 데이터가 저장된다 -->
					<label>생년월일</label>
					<input type="date" name="birthdate" value="${mdto.birthdate}"><br>
					<label>전화번호</label><input type="text" name="tel" value="${mdto.tel}"><br>
					<label>이메일</label><input type="text" name="email" value="${mdto.email}"><br>
				</div>	
			</fieldset><br>
		
			<fieldset id="mtitle2"><legend>배송지 정보</legend>
				<div id="mspec">
					<label>우편번호</label>
			        <input type="text" id="sample6_postcode" name="zipnum" readonly>
					<input type="button" onclick="sample6_execDaumPostcode()" class="dup" 
						value="우편번호 찾기"><br>
					<label>주&nbsp;소</label>
					<input type="text" id="sample6_address" size="50" name="address1" 
						value="${mdto.address1}" readonly><br>
					<label>상세주소</label>
					<input type="text" id="sample6_detailAddress" name="address2" 
						value="${mdto.address2}" size="50"><br>
					<label>추가주소</label>
					<input type="text" id="sample6_extraAddress" name="address3" 
						value="${mdto.address3}" readonly><br>
					
					
					
					 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					
					<script>
					    function sample6_execDaumPostcode() {
					        new daum.Postcode( {
					            oncomplete: function(data) {
					                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var addr = ''; // 주소 변수
					                var extraAddr = ''; // 참고항목 변수
					
					                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					                    addr = data.roadAddress;
					                } else { // 사용자가 지번 주소를 선택했을 경우(J)
					                    addr = data.jibunAddress;
					                }
					
					                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					                if(data.userSelectedType === 'R'){
					                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                        extraAddr += data.bname;
					                    }
					                    // 건물명이 있고, 공동주택일 경우 추가한다.
					                    if(data.buildingName !== '' && data.apartment === 'Y'){
					                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                    }
					                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                    if(extraAddr !== ''){
					                        extraAddr = ' (' + extraAddr + ')';
					                    }
					                    // 조합된 참고항목을 해당 필드에 넣는다.
					                    document.getElementById("sample6_extraAddress").value = extraAddr;
					                
					                } else {
					                    document.getElementById("sample6_extraAddress").value = '';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('sample6_postcode').value = data.zonecode;
					                document.getElementById("sample6_address").value = addr;
					                // 커서를 상세주소 필드로 이동한다.
					                document.getElementById("sample6_detailAddress").focus();
					            }
					        }).open();
					    }
					</script><br>
					
					
					<input type="hidden" name="provider" value="ot">
				</div>
			</fieldset>
			
		</fieldset>
	<br>
	<span>${message}</span><br>
	<input type="submit" value="가입하기">
	<input type="button" id="goBack" value="돌아가기" onclick="history.go(-1)">	
</form>
</article>



<%@ include file="../include/footer.jsp" %>
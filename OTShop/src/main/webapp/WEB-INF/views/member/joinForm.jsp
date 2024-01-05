<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<article>
<form id="join" action="join" method="post" name="joinFrm">
	<fieldset>
		<div id="mtitle">필수 입력 사항</div>
		<div id="mspec">
			<label>아이디</label><input type="text" name="userid" value="${dto.userid}">
			<input type="hidden" name="reid" value="${reid}">
			<input type="button" value="중복 확인" onclick="idcheck()"><br>
			<label>비밀번호</label><input type="password" name="pwd" value="${dto.pwd}"><br>
			<label>비밀번호 확인</label><input type="password" name="repwd" value="${repwd}"><br>
			<label>이름</label><input type="text" name="name" value="${dto.name}"><br>
			<label>성별</label><input type="radio" name="gender" value="M">남자	<input type="radio" name="gender" value="F">여자<br>
			<!-- input의 date 타입은 yyyy-mm-dd 포맷으로 String 데이터가 저장된다 -->
			<label>생년월일</label>
			<input type="date" name="birthdate" value="${dto.birthdate}"><br>
			<label>전화번호</label><input type="text" name="tel" value="${dto.tel}"><br>
			<label>이메일</label><input type="text" name="email" value="${dto.email}"><br>
		</div>	
	</fieldset>
	
	<fieldset>
		<div id="mtitle">배송지 정보</div>
		<div id="mspec">
			<label>우편번호</label>
	        <input type="text" id="sample6_postcode" name="zipnum" readonly>
			<input type="button" onclick="sample6_execDaumPostcode()" class="dup" 
				value="우편번호 찾기"><br>
			<label>주&nbsp;소</label>
			<input type="text" id="sample6_address" size="50" name="address1" 
				value="${dto.address1}" readonly><br>
			<label>상세주소</label>
			<input type="text" id="sample6_detailAddress" name="address2" 
				value="${dto.address2}" size="50"><br>
			<label>추가주소</label>
			<input type="text" id="sample6_extraAddress" name="address3" 
				value="${dto.address3}" readonly><br>
			
			
			
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
			<span>${message}</span><br>
		</fieldset>
	</div>
	<input type="submit" value="가입하기"><br>
	<input type="button" value="이전으로" onclick="history.go(-1)">	
</form>
</article>



<%@ include file="../include/footer.jsp" %>
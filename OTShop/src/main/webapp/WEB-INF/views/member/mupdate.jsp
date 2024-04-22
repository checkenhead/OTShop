<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>


<div class="mupdateWrap">

	<form method="post" name="mupdateFrm" action="mupdate" class="mupdateFrm">

		<%@ include file="../include/mypageSub.jsp"%>

		<div class="mupdateBanner">
			<span class="bannerTitle">정보 수정</span>
			<span class="bannerSub">내 정보를 수정할 수 있습니다.</span>
		</div><br>

		<div class="listHead">
			<img src="images/mustCheck.png">
			<div class="mupdateTitle">기본정보</div>
		</div>
		<br>


		<fieldset id="mtitle1">
			<c:choose>
				<c:when test="${dto.provider=='kakao'}">
					<span> 카카오 회원은 카카오 계정에서 내 정보를 수정할 수 있습니다. <a
						href="https://www.kakaocorp.com/page/">카카오 홈페이지로 이동</a>
					</span>
					<br>
					<div class="mspecTitle">
						<div>
							<img src="images/infoCheck.png">아이디
						</div>
						<div>
							<img src="images/infoCheck.png">비밀번호
						</div>
						<div>
							<img src="images/infoCheck.png">비밀번호 확인
						</div>
						<div>
							<img src="images/infoCheck.png">이름
						</div>
						<div>
							<img src="images/infoCheck.png">성별
						</div>
						<div>
							<img src="images/infoCheck.png">생년월일
						</div>
					</div>

					<div class="mspecSubs">
						<input type="text" name="userid" disabled> <input
							type="password" name="pwd" disabled> <input
							type="password" name="repwd" disabled> <input type="text"
							name="name" disabled> <input type="radio" name="gender"
							value="M" disabled>남자 <input type="radio" name="gender"
							value="F" disabled>여자
						<!-- input의 date 타입은 yyyy-mm-dd 포맷으로 String 데이터가 저장된다 -->
						<input type="text" name="birthdate" disabled>
					</div>
				</c:when>
				<c:otherwise>
					<div class="mspecTitle">
						<div>
							<img src="images/infoCheck.png">아이디
						</div>
						<div>
							<img src="images/infoCheck.png">비밀번호
						</div>
						<div>
							<img src="images/infoCheck.png">비밀번호 확인
						</div>
						<div>
							<img src="images/infoCheck.png">이름
						</div>
						<div>
							<img src="images/infoCheck.png">성별
						</div>
						<div>
							<img src="images/infoCheck.png">생년월일
						</div>
						<div>
							<img src="images/infoCheck.png">전화번호
						</div>
						<div>
							<img src="images/infoCheck.png">이메일
						</div>
					</div>

					<div class="mspecSubs">
						<input type="text" name="huserid" value="${dto.userid}" disabled><br>
						<input type="hidden" name="userid" value="${dto.userid}">
						<input type="password" name="pwd" placeholder="비밀번호"><br>
						<input type="password" name="repwd" placeholder="비밀번호 다시 입력"><br>
						<input type="text" name="name" value="${dto.name}"><br>
						<input type="radio" name="gender" value="M">남자 <input
							type="radio" name="gender" value="F">여자<br> <input
							type="text" name="hbirthdate" value="${dto.birthdate}" disabled><br>
						<input type="hidden" name="birthdate" value="${dto.birthdate}">
						<input type="text" name="tel" value="${dto.tel}"><br>
						<input type="text" name="email" value="${dto.email}"><br>
						<input type="hidden" name="provider" value="ot">
					</div>
					<br>
					<a href="mdeleteForm">
						<input type="button" value="회원탈퇴" class="mdeleteBtn">
					</a>
				</c:otherwise>
			</c:choose>
		</fieldset>
		<br> <br> <br>

		<div class="listHead">
			<img src="images/deliveryInfo.png">
			<div class="mupdateTitle">배송지 정보</div>
		</div>
		<br>

		<fieldset id="mtitle2">

			<div class="mwrap2">
				<div class="mspecTitle2">
					<div>
						<img src="images/infoCheck.png">우편번호
					</div>
					<div>
						<img src="images/infoCheck.png">주&nbsp;소
					</div>
					<div>
						<img src="images/infoCheck.png">상세주소
					</div>
					<div>
						<img src="images/infoCheck.png">추가주소
					</div>
				</div>

				<div class="mspecSubs2">
					<input type="text" id="sample6_postcode" name="zipnum" readonly>
					<input type="button" onclick="sample6_execDaumPostcode()"
						class="dup" value="찾기" ><br> <input type="text"
						id="sample6_address" size="50" name="address1"
						value="${dto.address1}" readonly><br> <input
						type="text" id="sample6_detailAddress" name="address2"
						value="${dto.address2}" size="50"><br> <input
						type="text" id="sample6_extraAddress" name="address3"
						value="${dto.address3}" readonly><br>
				</div>
				<br>
			</div>

			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

			<script>
				function sample6_execDaumPostcode() {
					new daum.Postcode(
							{
								oncomplete : function(data) {
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
									if (data.userSelectedType === 'R') {
										// 법정동명이 있을 경우 추가한다. (법정리는 제외)
										// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
										if (data.bname !== ''
												&& /[동|로|가]$/g.test(data.bname)) {
											extraAddr += data.bname;
										}
										// 건물명이 있고, 공동주택일 경우 추가한다.
										if (data.buildingName !== ''
												&& data.apartment === 'Y') {
											extraAddr += (extraAddr !== '' ? ', '
													+ data.buildingName
													: data.buildingName);
										}
										// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
										if (extraAddr !== '') {
											extraAddr = ' (' + extraAddr + ')';
										}
										// 조합된 참고항목을 해당 필드에 넣는다.
										document
												.getElementById("sample6_extraAddress").value = extraAddr;

									} else {
										document
												.getElementById("sample6_extraAddress").value = '';
									}

									// 우편번호와 주소 정보를 해당 필드에 넣는다.
									document.getElementById('sample6_postcode').value = data.zonecode;
									document.getElementById("sample6_address").value = addr;
									// 커서를 상세주소 필드로 이동한다.
									document.getElementById(
											"sample6_detailAddress").focus();
								}
							}).open();
				}
			</script>
		
			<br>

			<div class="jMessage">${message}</div>
			<br>
		</fieldset>
			<div class="mupdateBtn">
				<input type="submit" value="저장하기">
				<input type="button" id="goBack" value="돌아가기" onclick="history.go(-1)">
			</div>
	</form>	
</div>


<%@ include file="../include/footer.jsp"%>
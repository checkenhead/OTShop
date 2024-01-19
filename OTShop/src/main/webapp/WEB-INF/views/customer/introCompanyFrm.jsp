<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/introSub.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=460b902d624b97dd59686611e337cc74"></script>

<div class="faqWrap">
<article>

	<div class="faqBanner">
		<span class="bannerTitle">About Us</span>
	</div><br>

<div class="listHead">
	<div id="introTitle">회사 소개</div>
</div>
<div class="listBody">
		<br><br>
		<h3>인사말</h3><br>
		저희 쇼핑몰을 방문해 주셔서 감사드립니다. 저희 쇼핑몰은 회원제를 실시하고 있습니다.<br>
		처음 오신 분은 먼저 회원가입을 하신 후 이용하시길 바랍니다.<br><br>
		<h3>배송 방법은 택배입니다.</h3><br>
		주문하신 날로부터 3 ~ 6일 안에 받을 수 있습니다.<br>
			- 온라인 입금 시 입금 확인 후 3 ~ 6일<br>
			- 신용카드 결제 시 주문 후 3 ~ 6일<br>
		<a href="shopMap">오프라인 매장</a>도 운영하고 있으니 많은 관심 부탁드립니다.<br><br>
		<h3>BANK ACCOUNT</h3><br>
		예금주 : ㈜옷샵<br><br>

		신한은행 1005-601-776813<br>
		하나은행 351-0286-8129-53<br>
</div><br><br>


<div class="faqBanner">
	<span class="bannerTitle">본사 위치</span>
</div><br><br>

<div class="listBody">
	<fieldset class="introMap"><legend>지 도</legend>
			<div id="map" style="width: 600px; height: 500px;"></div> 
			
			
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=460b902d624b97dd59686611e337cc74"></script>
			<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.545990, 127.061773), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(37.545990, 127.061773); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			var iwContent = '<div style="padding:5px;">OTSHOP <br><a href="https://map.kakao.com/link/map/OTSHOP,37.545990, 127.061773" style="color:blue" target="_blank" font-size="90%">큰지도보기</a> <a href="https://map.kakao.com/link/to/OTSHOP,37.545990, 127.061773" style="color:blue" target="_blank" font-size="90%">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(37.545990, 127.061773); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			</script>
			
			
			<div class="introMapSubs">🚎 지하철 : 성수역 2번 출구에서 도보 15분</div>
</fieldset>
</div>
<br><br>



</article>
</div>
<%@ include file="../include/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/introSub.jsp" %>

<div class="faqWrap">
<article>

<div class="faqBanner">
	<span class="bannerTitle">오프라인 매장</span>
</div><br><br>

<div class="listBody">
	<fieldset class="introMap"><legend>홍대점</legend>
			<div id="map" style="width: 600px; height: 500px;"></div> 
			
			
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=460b902d624b97dd59686611e337cc74"></script>
			<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.555306, 126.922369), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(37.555306, 126.922369); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			var iwContent = '<div style="padding:5px;">OTSHOP<br><a href="https://map.kakao.com/link/map/OTSHOP,37.555306, 126.922369" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/OTSHOP,37.555306, 126.922369" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(37.555306, 126.922369); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			</script>
			
			
			<div class="introMapSubs">
			🚎 지하철 : 홍대입구역 9번 출구에서 도보 5분<br><br>
			🚍 버&nbsp;스 : 271번, 273번, 301번 외 다수</div>
</fieldset>
</div><br><br>

<div class="listBody">
	<fieldset class="introMap"><legend>부산점</legend>
			<div id="map2" style="width: 600px; height: 500px;"></div> 
			
			
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=460b902d624b97dd59686611e337cc75"></script>
			<script>
			var mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div 
			    mapOption2 = { 
			        center: new kakao.maps.LatLng(35.154646, 129.059390), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			var map2 = new kakao.maps.Map(mapContainer2, mapOption2);
			
			// 마커가 표시될 위치입니다 
			var markerPosition2  = new kakao.maps.LatLng(35.154646, 129.059390); 
			
			// 마커를 생성합니다
			var marker2 = new kakao.maps.Marker({
			    position: markerPosition2
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker2.setMap(map2);
			
			var iwContent2 = '<div style="padding:5px;">OTSHOP<br><a href="https://map.kakao.com/link/map/OTSHOP,35.154646, 129.059390" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/OTSHOP,35.154646, 129.059390" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(35.154646, 129.059390); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow2 = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow2.open(map2, marker2); 
			</script><br>
			
			
			<div class="introMapSubs">
			🚎 지하철 : 서면역 2번 출구에서 도보 10분<br><br>
			🚍 버&nbsp;스 : 169-1번, 33번, 133번 외 다수</div>
</fieldset>
</div>



</article>
</div>
<%@ include file="../include/footer.jsp" %>
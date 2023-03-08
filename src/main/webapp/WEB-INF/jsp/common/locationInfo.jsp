<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=043717a34c598c6dbd1ba75432eb866d&libraries=services"></script>
<div class="mt-5" style="width:100%">
	<!--회의실리스트-->
	<div class="col-md-12">
		<div class="row section-t3">
			<div class="col-sm-12">
				<hr class="hr_2border">
				<div class="title-box-d">
					<h3 class="title-d">라운지 회의실 리스트</h3>
				</div>
			</div>
		</div>
	
		<div class="row">
			<section class="news-grid grid">
				<div class="container">
					<div class="row">
						<!-- 회의실 표출 -->
						<c:forEach items="${roomList}" var="room">
							<div class="col-md-4">
								<div class="card-box-b card-shadow news-box ">
									<div class="img-box-b ">
										<img src="/store/${room.filePath1}" alt="" class="img-b img-fluid img-fit" onerror="this.src='/img/no_image.png';" />
									</div>
									<div class="card-overlay">
										<div class="card-header-b">
											<div class="card-category-b">
												<!-- 회의실타입 -->
												<a href="#" class="category-b">${room.cmnNm}</a>
											</div>
											<div class="card-title-b">
												<h2 class="title-2">
													<!-- 회의실명 -->
													<a>${room.name}<br></a>
												</h2>
											</div>
											<div class="card-date">
												<a href="javascript:showDetail(${room.roomSeq})" class="link-a">자세히보기 <i class="fa-solid fa-angle-right"></i>
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
	
						<c:if test="${fn:length(roomList) == 0}">
							<div class="col-md-12">등록된 회의실이 없습니다.</div>
						</c:if>
	
						<!-- ┌────────────────── 회의실 자세히보기 팝업창 ──────────────────┐ -->
						<div class="modal fade bs-example-modal-lg" id="popModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content"></div>
							</div>
						</div>
						<!-- └────────────────── 회의실 자세히보기 팝업창 ──────────────────┘ -->
	
					</div>
				</div>
			</section>
	
	
			<!--탭로드-->
			<div id="spec_yeouido" class="col-md-12">
	
				<!-- 요금표 / 오시는길 / 영상 / 평면도-->
				<div class="" id="payment">
					<ul class="nav nav-pills-a nav-pills mb-3 section-t3" id="pills-tab" role="tablist" style="border-bottom: 1px solid #d7d7d7;">
						<!-- 요금표 -->
						<li class="nav-item">
						   <a class="nav-link active" id="pills-pay-tab" data-id="#pills-pay" >요금표</a>
						</li>
						
						<!-- 오시는길 -->
						<li class="nav-item">
						   <a class="nav-link " id="pills-map-tab" data-id="#pills-map" >오시는길</a>
						</li>
						<!-- 평면도 -->
						<li class="nav-item">
						   <a class="nav-link" id="pills-plans-tab" data-id="#pills-plans"  >평면도</a>
						</li>
					</ul>
	
					<!--탭시작-->
					<div class="tab-content" id="pills-tabContent">
						<!-- 오시는길 -->
						
						<div class="div-tab" id="pills-map" >
							<h4 class="mt-3 mb-3">주소: ${loc.addr}</h4>
							<div id="map" style="width: 100%; height: 460px;"></div>
						</div>
	
						<!-- 평면도 -->
						<div class="div-tab" id="pills-plans"  style="display:none;">
							<img src="/store/${flrPlan.filePath1}" alt=""class="img-fluid">
						</div>
	
						<!-- 요금표 -->
						<div class="div-tab" id="pills-pay" >
							<div class="">
								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th scope="col">회의실</th>
											<th scope="col">수용인원</th>
											<th scope="col">주간(9~18)</th> 
											<th scope="col">야간(18~22)</th>
										</tr>
									</thead>
									<tbody>
										<!-- 요금 표출 -->
										<c:forEach items="${feeList}" var="fee">
											<tr>
												<th scope="row">${fee.roomNm}</th>
												<td>${fee.capacity}명</td>
												<td><fmt:formatNumber value="${fee.basicFee}" pattern="#,###" />원</td>
												<td>
													<c:choose> 
													<c:when test="${fee.nightFee > 0}">
														<fmt:formatNumber value="${fee.nightFee}" pattern="#,###" />원
													</c:when> 
													<c:otherwise>
														
													</c:otherwise> 
													</c:choose> 
												</td>
											</tr>
										</c:forEach>
										<c:if test="${fn:length(feeList) == 0}">
										    <tr>
										        <td colspan="6">등록된 요금정보가 없습니다.</td>
										    </tr>
				                        </c:if>
										
									</tbody>
								</table>
	
								<hr />
	
								<div class="title-box-d">
									<h3 class="title-d">예약안내</h3>
								</div>
								<p>${loc.bookGuide}</p>
	
								<div class="title-box-d mt-4">
									<h3 class="title-d">취소 및 환불규정</h3>
								</div>
								<p>${loc.cnclGuide}</p>
	
							</div>
						</div>
						<!--//요금-->
					</div>
	
				</div>
				<!--//탭종료-->
	
			</div>
			<!--//탭로드-->
		</div>
	</div>
</div>
<input type="hidden" id="lati" value="${loc.lati}" />
<input type="hidden" id="longi" value="${loc.longi}" />

<script>

//lati 또는 longi값이 없으면 주소로 검색
var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
var mapOption = { 
        center: new kakao.maps.LatLng($('#lati').val(), $('#longi').val()), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
if($('#lati').val() == ''  || $('#longi').val() == ''){
	var geocoder = new kakao.maps.services.Geocoder();
	geocoder.addressSearch('${loc.addr}', function(result, status) {
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	    	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    	setMarker(map, coords);	    	
	    } 
	});    
} else {
	var coords = new kakao.maps.LatLng($('#lati').val(), $('#longi').val());
	setMarker(map, coords);
}
    
//지점 마커표시   
function setMarker(map, coords){
	var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:200px;text-align:center;padding:6px 0;">${loc.name}</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
    
    //map 생성전 해당 div영역이 hidden시키면 지도가 깨짐. 지도 생성후 map영역 hidden
    $('#pills-map').hide();
}

//회의실 자세히보기
function showDetail(seq) {
	$(".modal-content").load('/room/popDetail/'+seq).fadeIn("fast");
	$('#popModal').modal('show');  
}

$('.nav-link').on('click', function(){
	$('.nav-link').removeClass('active');
	$(this).addClass('active');
	var activeId = $(this).data('id');
	/*$('.tab-content div').removeClass('active').removeClass('show');
	$(activeId).addClass('active').addClass('show');*/
	$('.div-tab').hide();
    $(activeId).show();
});

</script>
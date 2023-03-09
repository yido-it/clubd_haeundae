<!-- 
모든지점
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/kakaomap.jsp"/> 
  
  
<body>
<!-- 상단 메뉴 -->
<jsp:include page="../common/navigation.jsp" />
 
<main id="main">
	<!-- 상단 이미지 및 설명 -->
	<jsp:include page="../common/top.jsp" />

	<!-- =======지점 location ======= -->
	<section class="section-property section-t4" style="overflow:hidden">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title-wrap d-flex justify-content-between">
						<div class="title-box">
							<h2 class="title-a">GRAPE 지점선택</h2>
						</div>
						<!-- 
						<div class="title-link">
							<a href="property-grid.html">전체보기
							<span class="ion-ios-arrow-forward"></span>
							</a>
						</div> 
						-->
					</div>
				</div>
			</div>  
	
			<!--pc지점-->
			<div id="property-carousel" class="owl-carousel owl-theme overflow aos-init aos-animate pc_location" data-aos="fade-up" data-aos-delay>
			    <c:forEach items="${locs}" var="list">
			        <div class="carousel-item-b">
	                    <div class="card-box-a card-shadow" data-seq="${list.locSeq}">
	                        <div class="img-box-a">
	                            <img src="/store/${list.filePath1}" onerror="this.src='/img/no_image.png';"  alt="" class="img-a img-fluid img-loc-list">
	                        </div>
	                        <div class="card-overlay location">
	                            <div class="card-overlay-a-content">
	                                <div class="card-header-a">
	                                    <h2 class="card-title-a">
	                                    <a href="/loc/locDetail/${list.locSeq}">${list.name}
	                                    </a>
	                                    </h2>
	                                    <h5> ${list.addr}</h4>
	                                </div>
	                                <div class="card-body-a">
	                                    <div class="price-box d-flex" >
	                                        <span class="price-a"  onclick="location.href='/book/bookMain/${list.locSeq}/0'">예약하기</span>
	                                        <span class="price-a ml-2"  onclick="location.href='/loc/locDetail/${list.locSeq}'">자세히보기</span>
	                                    </div> 
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
			    </c:forEach>
			</div>
			<br>
		</div>
	
	</section><!-- //pc지점 End -->
	
	
	<!--모바일전용 지점선택-모바일만보임-->
	<div class="container mobile_location">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
	                <c:forEach items="${locs}" var="list">
	                   <div class="col-md-4">
	                        <div class="card-box-a card-shadow" data-seq="${list.locSeq}">
	                            <div class="img-box-a">
	                                <img src="/store/${list.filePath1}" onerror="this.src='/img/no_image.png';"  alt="" class="img-a img-fluid img-loc-list-mb">
	                            </div>
	                            <div class="card-overlay">
	                                <div class="card-overlay-a-content">
	                                    <div class="card-header-a">
	                                        <h2 class="card-title-a">
	                                        <a href="/loc/locDetail/${list.locSeq}">${list.name }
	                                        </a>
	                                        </h2>
	                                        <h5> ${list.addr }</h4>
	                                    </div>
	                                    <div class="card-body-a">
	                                        <div class="price-box d-flex" >
	                                            <span class="price-a"  onclick="location.href='/book/bookMain/${list.locSeq}/0'">예약하기</span>
	                                            <span class="price-a ml-2"  onclick="location.href='/loc/locDetail/${list.locSeq}'">자세히보기</span>
	                                        </div> 
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </c:forEach>
				</div>
			</div>
		</div>
	</div>
	<!--//모바일용 지점-->
	  
	<!--지도-->
	<div class="container div_map">
		<div class="row">
			<div class="col-md-12">
				<div class="d-flex justify-content-between">
					<div class="title-box mt-5">
						<h2 class="title-a">MAP</h2>
					</div> 
				</div>
				<div class="">
					<div id="map" style="height:500px;">
					</div>
				</div>
			</div>
		</div>  
	</div>
	<!--//지도-->
	
	 <!-- <div class="spot">여의도점</div>  
		 <ul class="po_photo">
			<li><img src="/store/4/loc/202208/1661488459243.jpg"></li>
			<li>
				 <p class="portfolio-item-paragraph">그레이프 이대점  </p>
				 <button type="button" class="btn btn-primary"onclick="location.href='locDetail/4' ">바로가기 </button> 	
			</li>
		</ul>  -->
	 
 
	       
</main><!-- End #main -->
 
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
.img-loc-list {
    width: 350px;
    height: 448px;
    object-fit: contain;
}

.img-loc-list-mb {
    min-width: 45vh;
    /*height: 50vh;*/
    object-fit: contain;
}
</style>
<script>

//lati 또는 longi값이 없으면 주소로 검색
var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
var mapOption = { 
        center: new kakao.maps.LatLng(127.0000, 37.0000), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var mapList;

$(document).ready(function() {
	$.ajax({
        url: "/loc/listWithImg",
        type: "post",
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
        	mapList = data.locs;
            data.locs.forEach(function(item, idx){
            	getLatLng(item, idx);
            });         
        },
        error: function(data) {
           alert('[error] 예약중 오류가 발생하였습니다..');
        }
    });
	

});

//지점 카드박스 mouseover 시 해당 지점 지도이동
$('.card-box-a').on('mouseover', function(){
    var locmap = mapList.find(i => i.locSeq===$(this).data('seq'))
    var coords = new kakao.maps.LatLng(locmap.lati, locmap.longi);
    map.setCenter(coords);
    
});

//lati, longi확인 , 없으면 주소로 검색
function getLatLng(item, idx){
	if(item.lati != null && item.longi != null){
		setMarker(map, item);
	} else {
		var geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(item.addr, function(result, status) {
            // 정상적으로 검색이 완료됐으면 
             if (status === kakao.maps.services.Status.OK) {
                //var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                item.lati = result[0].y;
                item.longi = result[0].x;
                mapList[idx] = item;
                setMarker(map, item);
            } 
        });
	}
	
}        

    
//지점 마커표시   
function setMarker(map, item){
	var coords = new kakao.maps.LatLng(item.lati, item.longi);
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });

    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:200px;text-align:center;padding:6px 0;">' + item.name + '</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
    
}
</script>
</body>

</html>
<!-- 
지점
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/kakaomap.jsp"/> 
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
.flex-col{
    flex-direction: column;
}

</style>
<body>
	<!-- 상단 메뉴 -->
	<jsp:include page="../common/navigation.jsp" />

	<main id="main"> 
	   <!-- 상단 이미지 및 설명 --> 
	   <jsp:include page="../common/top.jsp" /> 
	   <!-- 페이지 설명 및 메뉴 위치 표기 --> 
	   <jsp:include page="../common/intro.jsp" />

		<section class="property-single nav-arrow-b">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
	
						<!--썸네일 슬라이드-->
						<div style="-swiper-navigation-color: #fff; - -swiper-pagination-color: #fff; height: 45vh" class="swiper mySwiper2">
							<div class="swiper-wrapper">
	
								<!-- 지점 이미지 -->
								<c:forEach items="${locImgList}" var="img">
									<div class="swiper-slide" id="loc">
										<img src="/store/${img.filePath1}" onerror="this.src='/img/no_image.png';"/>
										<div class="text_position">
											<c:if test="${img.locName != ''}">															
												<p>${img.locName}</p>
											</c:if>
										</div>
									</div>
								</c:forEach>
								<!-- 회의실 이미지 -->
								<c:forEach items="${roomImgList}" var="img">
									<div class="swiper-slide" id="room">
										<img src="/store/${img.filePath1}" onerror="this.src='/img/no_image.png';"/>
										<div class="text_position">
											<c:if test="${img.roomName != ''}">															
												<p>${img.roomName}</p>
											</c:if>
										</div>
									</div>
								</c:forEach>
																		
							</div>
	
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>
	
						<!--썸네일-->
						<div thumbsSlider="" class="swiper mySwiper">
							<div class="swiper-wrapper">
						
								<!-- 지점 썸네일 이미지 -->	
								<c:forEach items="${locImgList}" var="img">
									<div class="swiper-slide">
										<img src="/store/${img.filePath2}" onerror="this.src='/img/no_image.png';"/>
									</div>
								</c:forEach>		
								<!-- 회의실 썸네일 이미지 -->	
								<c:forEach items="${roomImgList}" var="img">
									<div class="swiper-slide">
										<img src="/store/${img.filePath2}" onerror="this.src='/img/no_image.png';"/>
									</div>
								</c:forEach>
											
							</div>
						</div>
						<!--//썸네일 슬라이드-->
						<div style="clear: both"></div>
	
						<!--스펙설명-->
						<div class="row justify-content-between">
							<div class="col-md-5 col-lg-4">
								<div class="property-price d-flex justify-content-center foo">
									<div class="card-header-c d-flex">
										<div class="card-box-ico">
											<span class="ion-money"></span>
										</div>
	
										<div class="card-title-c align-self-center">
											<h5 class="title-c">${loc.name}</h5>
										</div>
									</div>
								</div>
	
								<div class="property-summary">
									<div class="row">
										<div class="col-sm-12">
											<div class="title-box-d section-t2">
												<h3 class="title-d">상세정보</h3>
											</div>
										</div>
									</div>
	
									<div class="summary-list">
									   ${loc.detailInfo }
										
									</div>
	
									<!-- 예약 바로가기 -->
									<button type="button"
										class="btn btn-primary btn-lg mt-2 btn-block" onclick="location.href='/book/bookMain/${loc.locSeq}/0'" style="padding: 10px 40px;">
										예약 바로가기 <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
									</button>
	
									<!-- 투어신청 -->
									<button type="button"
										class="btn btn-dark  btn-lg mt-2  btn-block" onclick="location.href='/tour/tourMain?locSeq=${loc.locSeq}'" style="padding: 10px 40px;">
										투어신청 <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
									</button>
	
								</div>
							</div>
	
							<div class="col-md-7 col-lg-7 section-md-t3">
								<div class="row">
									<%--<img style="width: 300px" src="/img/location/myungdong/logo_myungdong.png" /> --%>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<div class="title-box-d">
											<h3 class="title-d">개요</h3>
										</div>
									</div>
								</div>
	
								<div class="property-description">
									<p class="description color-text-a">${loc.expln}</p>
	
									<div class="row">
										<div class="col-sm-12">
											<div class="title-box-d">
												<h3 class="title-d">운영시간</h3>
											</div>
										</div>
									</div>
	
									<p class="description color-text-a no-margin">
										<i class="fa-solid fa-clock iconborder"></i> 
										평일: ${loc.strtTm} ~ ${loc.endTm} / 주말 및 공휴일 : 협의가능
										<br />
										<br /> 
										<i class="fa-solid fa-lightbulb iconborder"></i>
										입퇴실 시간 : 행사준비, 퇴장, 정리 시간은 예약시간에 포함
										<br />
                                        <br /> 
                                        <i class="fa-solid fa-phone iconborder"></i> 
                                        TEL : ${loc.tel}
									</p>
	
									<div class="row mt-3">
										<div class="col-sm-12">
											<div class="title-box-d">
												<h3 class="title-d">시설안내</h3>
											</div>
										</div>
									</div>
	
									<div class="amenities-list color-text-a">
										<ul class="list-a no-margin">
											<c:forEach items="${roomList}" var="list">
												<li>${list.name}
											</c:forEach>
										</ul>
									</div>
	
								</div>
	
							</div>
						</div>
					</div>
	
					<div class="clear:both"></div>
					<!--//기본정보-->
					<!--회의실리스트-->
					<jsp:include page="../common/locationInfo.jsp" />
				</div>
			</div>
			</div>
		</section>
	<!-- End Property Single--> 
	</main>
	<!-- End #main -->

	<jsp:include page="../common/footer.jsp" />


	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<!--swiper-->


	<!--  Swiper -->
	<script>
var swiper = new Swiper(".mySwiper", {
	spaceBetween: 10,
	slidesPerView: 4,
	freeMode: true,

	watchSlidesProgress: true,
});

var swiper2 = new Swiper(".mySwiper2", {
	spaceBetween: 10,
	autoplay: {
		delay: 5000,
		disableOnInteraction: false,
	},
	navigation: {
		nextEl: ".swiper-button-next",
		prevEl: ".swiper-button-prev",
	},
	thumbs: {
		swiper: swiper,
	},
});

</script>

</body>

</html>

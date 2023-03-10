<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="common/head.jsp" />

<body>
<jsp:include page="common/navigation.jsp" />
 <link rel="stylesheet" href="/vendor/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="/vendor/jquery-ui.min.css">


    
<!-- ======= 슬라이드메인 ======= -->
<section class="">

<div class="main">	 
   <div class="container_date">
            <form id="booking-form" class="booking-form" method="POST">
                <div class="form-group">
                    <div class="form-destination">
                        <label for="destination">SPOT</label>
                        <input type="text" id="destination" name="destination" placeholder="CLUBD Haeundae" disabled/>
                    </div>
                    <div class="form-date-from form-icon">
                        <label for="date_from">DATE</label>
                        <input type="text" id="date_from" class="date_from" placeholder="날짜선택" />
                    </div>
                  
                    <div class="form-quantity">
                        <label for="quantity">Adult</label>
                        <span class="modify-qty plus" onClick="Tang1()"><i class="fa-solid fa-caret-up"></i></span>
                        <input type="number" name="quantity" id="quantity" value="0" min="0" class="nput-text qty text">
                        <span class="modify-qty minus" onClick="Giam1()"><i class="fa-solid fa-caret-down"></i></span>
                    </div>

                    <div class="form-quantity">
                        <label for="quantity">Children</label>
                        <span class="modify-qty plus" onClick="Upup()"><i class="fa-solid fa-caret-up"></i></span>
                        <input type="number" name="quantity2" id="quantity2" value="0" min="0" class="nput-text qty text">
                        <span class="modify-qty minus" onClick="Down()"><i class="fa-solid fa-caret-down"></i></span>
                    </div>

                    <div class="form-submit">
                        <input type="submit" id="submit" class="submit" value="검색" />
                    </div>
                </div>
            </form>
        </div>
       </div>
       
       
<div class="intro intro-carousel">
<div id="carousel" class="owl-carousel owl-theme">
	
	<div class="carousel-item-a intro-item bg-image" style="background-image: url(/img/main/date_bg.jpg)">
		<div class="overlay overlay-a"></div>
		<div class="intro-content display-table">
			<div class="table-cell">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="intro-body">
								<h1 class="intro-title mb-4 animate__fadeInUp animate__animated" style="">
									Exciting PIC 
									<span class="color-b">CLUBD OASIS</span>
									<!-- <img src="/img/logo_white.png"class="" style="width:150px"> -->
								</h1>
							
							</div>
						</div>
					</div>
				</div>
			</div>
			<h2  class="intro-title-top font_eng">SWITCH 22 by Grape</h2>
		</div>
	</div>
	
<div class="carousel-item-a intro-item bg-image" style="background-image: url(/img/main/date_bg2.jpg)" >
		<div class="overlay overlay-a"></div>
		<div class="intro-content display-table">
			<div class="table-cell">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="intro-body">
								<h1 class="intro-title  mb-4  animate__animated">
								Kid Friendly PIC
									<span class="color-b">CLUBD OASIS</span>
								</h1>
								 
							</div>
						</div>
					</div>
				</div>
			</div>
			<h2 style="" class="intro-title-top font_eng">SOL Lounge with Grape</h2>
		</div>
	</div>
	 
	<div class="carousel-item-a intro-item bg-image" style="background-image: url(/img/main/date_bg3.jpg)">
		<div class="overlay overlay-a"></div>
		<div class="intro-content display-table">
			<div class="table-cell">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="intro-body">
								<h1 class="intro-title  mb-4  animate__animated"> 
									Luxury PIC 
									<span class="color-b animate__animated animate__delay-4s">CLUBD OASIS</span>
								</h1>
								
								 
							</div>
						</div>
					</div>
				</div>
			</div>
			<p class="intro-title-top font_eng">
								Grape Lounge  </p>
		</div>
	</div>

	  
	</div>
</div>
</section>
<!-- End  -->



<!-- 달력아래 컨텐츠 --> 
<section class="div_date" style="">
	<div class="container aos-init aos-animate service">
		
	
		 <img src="/img/main/oasis.png" class="img-d img-fluid">
		 <p class="tc fs22">Club D Oasis는 사막 한 가운데, 갈증 속에서 만나는 오아시스처럼<br/>
	바쁜 일상에 치인 우리에게 휴식을 주는 공간이 되고자 합니다.
		 </p>
	</div>




</section>




<main id="main">  
<!-- =======지점 location ======= -->
<section class="section-property section-t3 section-b2" style="overflow:hidden">
<div class="container spot_container">
	<div class="row">
		<div class="col-md-12">
			<div class="title-wrap d-flex justify-content-between">
				<div class="title-box">
					<h2 class="title-a">EVENT</h2>
				</div>
				<div class="title-link">
					<a href="/loc/locMain">전체보기
						<i class="fa-solid fa-angle-right"></i>
					</a>
				</div> 
			</div>
		</div>
	</div>
	
	

	<!--event-->
	<div id="property-carousel" style="" class="owl-carousel owl-theme overflow aos-init aos-animate pc_location" data-aos="fade-up" data-aos-delay >
	    <c:forEach items="${locs}" var="list">
			<div class="carousel-item-b">
				<div class="card-box-a card-shadow">
					<div class="img-box-a">
						<img src="/store/${list.filePath1}" onerror="this.src='/img/no_image.png';" alt="" class="img-a img-fluid img-loc-list">
					</div>
					<div class="card-overlay location">
						<div class="card-overlay-a-content">
							<div class="card-header-a">
								<h2 class="card-title-a">
									<a href="/loc/locDetail/${list.locSeq}">${list.name}</a>
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
</div>
       
</section><!-- //pc지점 End -->

<!--모바일전용 지점선택-모바일만보임-->
<div class="container mobile_location">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
                <c:forEach items="${locs}" var="list">
					<div class="col-md-4">
						<div class="card-box-a card-shadow">
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
		</div>
	</div>
</div> 
<!--//모바일용 지점-->
<section id="about" class="mt-5" style="background:url(/img/main/bg_location2.jpg) no-repeat 35% 50%;background-size: cover;">
	<div class="container aos-init aos-animate service">

		<div class="row">
			<div class="col-lg-12 mb-4"> 
				<h2 class="text-center title-a">OUR SERVICE</h2>
			</div>

			<div class="col-lg-4 text-center aos-init aos-animate" data-aos="fade-up" data-aos-delay="0">
				<i class="fs30 fa-solid fa-people-arrows-left-right"></i>  
				<h3>        
				MEETING ROOM 
				</h3>
				<p> 업무/학습/미팅에 최적화된 공간을 제공합니다. </p>
			</div>

			<div class="col-lg-4 text-center aos-init aos-animate" data-aos="fade-up" data-aos-delay="200">
				<i class="fs30 fa-solid fa-building"></i>
				<h3>CONFERENCE</h3>
				<p>교육,행사,면접,세미나 등에 적합한 공간을 제공합니다. </p>
			</div>

			<div class="col-lg-4 text-center aos-init aos-animate" data-aos="fade-up" data-aos-delay="400">
				<i class="fs30 fa-solid fa-desktop"></i>
				<h3>OFFICE</h3>
				<p>고객의 NEEDS를 반영한 PRIVATE OFFICE, CO-WORKING 등의 사무공간을 제공합니다. </p>
			</div>
			</div>
		<div class="row mt-3">
			<div class="col-lg-6 text-center aos-init aos-animate" data-aos="fade-up" data-aos-delay="600">
				<i class="fs30 fa-solid fa-comment-dots"></i>
				<h3>COMMUNITY</h3>
				<p>동호회,취미모임,헬스,라운지 등의 공간서비스를 제공합니다.<br> </p>
			</div>
			 <div class="col-lg-6 text-center aos-init aos-animate" data-aos="fade-up" data-aos-delay="600">
				<i class="fs30 fa-solid fa-mug-saucer"></i>
				<h3>Café &amp; Lounge </h3>
				<p>모든 지점이 프리미엄 원두를 사용하며, 전문 바리스타가 직접 제조하는 Signature 음료를 제공합니다. <br> </p>
			</div>		
		</div>
	 
	</div>
</section>
 
<!-- =======경험 ======= -->
<section class="section-agents section-t8">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title-wrap d-flex justify-content-between">
					<div class="title-box" data-aos="fade-up"  data-aos-duration="2000" >
						<h2 class="title-a">EXPERIENCE</h2>
					</div>
				</div>
			</div>
		</div>

		<div class="row" >
			<!-- Hospitality -->
			<div class="col-md-6 col-lg-6 section-md-t3"  data-aos="fade-up">
				<div class="row">
					<div class="col-sm-12">
						<img src="/img/main/ex_1.jpg" alt="" class="img-d img-fluid">
						<div class="title-box-d">
							<h3 class="title-d">Hospitality</h3>
						</div>
					</div>
				</div>
			
				<div class="property-description">
					<p class="description color-text-a">
					임차인의 만족도를 높여주는
					공간을 제공합니다.
					오피스 입주사 임직원들의 라이프스타일을 반영하여
					사용도와 선호도가 높은 시설/공간을 배치하고
					프리미엄 퀄리티의 인테리어를 구현하여 머무는 즐거움을 드립니다.
					</p> 
				</div> 
			</div>
			
			<!-- Tech -->
			<div class="col-md-6 col-lg-6 section-md-t3"  data-aos="fade-up" data-aos-delay="100">
				<div class="row">
					<div class="col-sm-12">
						<img src="/img/main/ex_2.jpg" alt="" class="img-d img-fluid">
						<div class="title-box-d">
						<h3 class="title-d">Tech</h3>
						</div>
					</div>
				</div>
			
				<div class="property-description">
					<p class="description color-text-a">
					데이터와 기술을 접목하여 편리함을 제고합니다.
					IT/Tech 기반으로 오피스 커뮤니티 시설 (회의실 및 컨퍼런스 포함)
					예약 및 이용 관리 와 멤버쉽 서비스 프로그램을 효과적으로 운영합니다.
					더 나아가 확보된 건물 내 데이터들을 바탕으로하여
					건물 관리 통합시스템으로 확장합니다.
					</p> 
				</div>  
			</div>
			
			<!-- Design and Space -->
			<div class="col-md-6 col-lg-6 section-md-t3"  data-aos="fade-up" data-aos-delay="100">
				<div class="row">
					<div class="col-sm-12">
						<img src="/img/main/ex_3.jpg" alt="" class="img-d img-fluid">
						<div class="title-box-d">
							<h3 class="title-d">Design and Space</h3>
						</div>
					</div>
				</div>
			
				<div class="property-description">
					<p class="description color-text-a">
					머무는 즐거움을 주는 깔끔하고 세련된 인테리어, 오래 앉아 있어도 편안한 자리, 맛있는 음료와 간식을 준비하여 라운지 멤버들이 개인의 성장을 위해 노력하는 시간을 좀 더 즐겁고 가치 있게 만들어 드리고자 고민했습니다.  
					</p> 
				</div>  
			</div>
			
			<!-- Contents -->
			<div class="col-md-6 col-lg-6 section-md-t3"  data-aos="fade-up" data-aos-delay="100">
				<div class="row">
					<div class="col-sm-12">
						<img src="/img/main/ex_4.jpg" alt="" class="img-d img-fluid">
						<div class="title-box-d">
							<h3 class="title-d">Contents  </h3>
						</div>
					</div>
				</div>
				
				<div class="property-description">
					<p class="description color-text-a">
					그레이프는 단순히 공간 운영에만 머무르지 않습니다.
					유망 스타트업들과 제휴하여 다양한 컨텐츠와 프로그램을
					입주사 임직원 및 지역 고객들에게 제공하여
					공간과 서비스가 결합된 새로운 상품을 구현합니다.
					</p> 
				</div>  
			</div> 
		
		</div>
	</div>
</section> 

<!--그레이프소개-->
<section id="about" class="mt-5" style="background:url(/img/main/bg_location3.jpg) no-repeat 57% 20%;background-size:cover">
	<div class="container aos-init aos-animate" data-aos="fade-up">
		<div class="row">
			<div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
				<h2 class="textshadow letter-1" style="color: #fff0da;" >         
				Where you can do anything or just do nothing   </h2>
				<p>그레이프라운지는 고객들이 하고 싶은 일을 마음껏 즐길 수 있는 넓고 쾌적한 공간과 다양한 편의 시설을 제공합니다. </p>
			</div>
			
			<div class="col-lg-3" data-aos="fade-up" data-aos-delay="300">
				<h2 class="colorpink textshadow letter-1">  Well-Serviced </h2>
				<hr>
				<p>전통적 오피스 공간을 혁신적인 Well-Serviced 오피스 공간으로 혁신해갑니다</p>
			</div>
			
			<div class="col-lg-3" data-aos="fade-up" data-aos-delay="500">
				<h2 class="colorpink2 textshadow letter-1">  Grape Vision
				</h2>
				<hr>
				<p>다양한 라이프스타일 서비스를 이용하고 커뮤니티를 구축할 수 있는 공간으로 만듭니다.
				</p>
			</div>
		</div>
	</div>
</section>


<!-- End  -->

<div class="cont_inquire" style="position: relative;bottom: -60px; ">
	<!-- 예약하기 -->
	<a href="/loc/locMain" class="link_inquire link_kakaobus">
		<div class="namebox">
             <div class="txt bold txt_dormitory">
             	지점찾기 <i class="fa-solid fa-chevron-right"></i>
             </div>
        </div>
		<span class="bg_dimmed"></span>
	</a>
	
	<!-- 투어신청 -->
	<a href="/tour/tourMain"  class="link_inquire link_kakaometro">
		<div class="namebox">
             <div class="txt bold txt_dormitory">
             	투어신청 <i class="fa-solid fa-chevron-right"></i>
             </div>
        </div>
		<span class="bg_dimmed"></span>
	</a>
</div>

<div style="clear:both"></div>
 
</main>
<!-- End #main -->


<!--팝업--> 
<div class="layer_popup" style="display:none" id="layer_pop"> 
	<div class="">
		<!--pc에서보이는이미지 -->
		<!-- <a class="pc_popup" href="" target="_blank">  -->
			<img class="img_popup" src="/img/main/popup_app.jpg">		
		<!-- </a> --> 
 
	</div>
	<div class="close" style="opacity: 0.9;"> 
		<form name="pop_form">
			<!-- <div id="check"><input type="checkbox" name="chkbox" value="checkbox" /> 오늘 하루동안 보지 않기</div>   -->
			<div id="close"	style="margin: auto; cursor: pointer; float: right; margin-right: 10px;">
				<a style="color: #ffffff" href="javascript:closeWin()">X 닫기</a>
			</div>
		</form>
	</div>
</div>  

  
<jsp:include page="common/footer.jsp" />
<jsp:include page="common/script.jsp" />

<script> 
	AOS.init(); // 자바스크립트로 init()을 해야 동작한다.
</script>


<!--swiper섬네일 옵션-->
<script>
	 
$(document).ready(function($) {
  
	$(".scroll_move").click(function(event){         
  
		event.preventDefault();
  
		$('html,body').animate({scrollTop:$(this.hash).offset().top}, 5500); 
    }); 
	
    $(function () { //툴팁
		$('[data-toggle="tooltip"]').tooltip()
	});
    
    /*
    if (/iPhone|iPad|iPod/i.test(navigator.userAgent.toLowerCase())) {
        $('#ios').show();
        $('#noIos').hide();
    }else{
        $('#ios').hide();
        $('#noIos').show();
    }
    */
    
    $('#ios').hide();
    $('#noIos').show();
  
});

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

function fnQrScan(){
	location.href="/qrscan";
}
 
</script> 





<script type="text/javascript">
	$('#close').on("click", function() {
		$('#layer_pop').hide();
	});

	
	    
	    
</script>
  
  
</body>

  
    <script src="/vendor/jquery.min.js"></script>
    <script src="/vendor/jquery-ui.min.js"></script>
    <script src="/vendor/main.js"></script>

</html>
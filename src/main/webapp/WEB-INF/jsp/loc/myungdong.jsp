<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/head.jsp" />

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
	<div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff;height:45vh"   class="swiper mySwiper2"  >
		<div class="swiper-wrapper">

			<div class="swiper-slide">
				<img src="/img/location/myungdong/1.jpg" /> 
				<div class="text_position"><p>오픈라운지</p></div>
			</div>
			
			<div class="swiper-slide">
				<img src="/img/location/myungdong/2.jpg" /> 
				<div class="text_position"><p>미팅룸 12인</p></div>
			</div>
			
			<div class="swiper-slide">
				<img src="/img/location/myungdong/3.jpg" /> 
				<div class="text_position"><p>미팅룸 8인</p></div>
			</div>
			
			<div class="swiper-slide">
				<img src="/img/location/myungdong/4.jpg" /> 
				<div class="text_position"><p>미팅룸 6인</p></div>
			</div>
				
			<div class="swiper-slide">
				<img src="/img/location/myungdong/5.jpg" /> 
				<div class="text_position"><p>미팅룸 4인</p></div>
			</div>
			
			<div class="swiper-slide">
				<img src="/img/location/myungdong/6.jpg" /> 
				<div class="text_position"><p>프라이빗 오피스</p></div>
			</div>
		</div>
		
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>

	<!--썸네일-->
	<div thumbsSlider="" class="swiper mySwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<img src="/img/location/myungdong/1.jpg" /> 
			</div>
			<div class="swiper-slide">
				<img src="/img/location/myungdong/2.jpg" /> 
			</div>
			<div class="swiper-slide">
				<img src="/img/location/myungdong/3.jpg" /> 
			</div>
			<div class="swiper-slide">
				<img src="/img/location/myungdong/4.jpg" /> 
			</div>
			<div class="swiper-slide">
				<img src="/img/location/myungdong/5.jpg" /> 
			</div>
			<div class="swiper-slide">
				<img src="/img/location/myungdong/6.jpg" /> 
			</div>
		</div>
	</div>
	<!--//썸네일 슬라이드-->      
	<div style="clear:both"></div>
           
	<!--스펙설명-->
	<div class="row justify-content-between">
	<div class="col-md-5 col-lg-4">
		<div class="property-price d-flex justify-content-center foo">
			<div class="card-header-c d-flex">
				<div class="card-box-ico">
					<span class="ion-money"></span>
				</div>

				<div class="card-title-c align-self-center">
					<h5 class="title-c">명동점</h5>
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
				<ul class="list">
				<li class="d-flex justify-content-between">
				<strong>Property ID:</strong>
				<span>1134</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>Location:</strong>
				<span>서울시 중구</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>타입:</strong>
				<span>1111</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>Status:</strong>
				<span>Sale</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>면적:</strong>
				<span>340m
				<sup>2</sup>
				</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>회의실수:</strong>
				<span>10개</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>라운지면적:</strong>
				<span>340m</span>
				</li>
				<li class="d-flex justify-content-between">
				<strong>기타장비:</strong>
				<span>1</span>
				</li>
				</ul>
			</div>

			<!-- 예약 바로가기 -->  
			<button type="button" class="btn btn-primary btn-lg mt-2 btn-block"  onclick="location.href='/grape/book'" style="padding: 10px 40px;">예약 바로가기 
			<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
			</button>

			<!-- 투어신청 -->  
			<button type="button" class="btn btn-dark  btn-lg mt-2  btn-block"  onclick="location.href='/grape/tour'" style="padding: 10px 40px; ">투어신청               
			<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
			</button>

		</div>
	</div>
			  
	<div class="col-md-7 col-lg-7 section-md-t3">
		<div class="row"> 
			<img style="width:300px" src="/img/location/myungdong/logo_myungdong.png" />  
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="title-box-d">
					<h3 class="title-d">개요
					</h3>
				</div>
			</div>
		</div>

	<div class="property-description">
		<p class="description color-text-a">
		쏠라운지는 신한은행과 공유 공간 서비스 스타트업인 그레이프가 협력하여 새로운 시작으로 만든 공유라운지 입니다.<br/>
		신한은행 고객이나 일반 고객이 복잡한 절차 없이 시간권, 종일권, 월 정기권 등 필요한 만큼 사용할 수 있습니다.<br/><br/>
		쏠라운지에는 업무공간(공유오피스), 오픈형 좌석, 몰입형 좌석, 미팅룸, 휴식공간 등 다양한 공간이 있습니다. <br/>
		명동성당 종탑이 보이는 Library of Inspiration, 통창을 통해 밝은 빛이 들어오는 오픈라운지와, 
		다양한 편의시설은 쾌적한 환경을 조성하여 업무, 세미나, 미팅 등을 위한 최적의 공간을 제공합니다. 
		</p>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="title-box-d">
					<h3 class="title-d">운영시간
					</h3>
				</div>
			</div>
		</div>
		
		<p class="description color-text-a no-margin"> 
		<i class="fa-solid fa-clock iconborder"></i>  평일: 08:00 AM ~ 22:00 PM / 주말: 10:00 AM ~ 20:00 PM
		<br/><br/> 
		<i class="fa-solid fa-phone iconborder"></i> TEL : 02-779-9355
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
			<li>OPEN LOUNGE </li>
			<li>미팅룸 12인</li>
			<li>미팅룸 8인</li>
			<li>미팅룸 6인</li>
			<li>미팅룸 4인</li>
			<li>프라이빗 오피스</li> 
			</ul>
		</div>

</div>

</div>
</div>
</div>

<div class="clear:both"></div>
<!--//기본정보-->

<!--회의실리스트-->
<div class="mt-5">
<div class="col-md-12">
	<div class="row section-t3">
		<div class="col-sm-12" style="border-top: 2px solid #d7d7d7;">
			<div class="title-box-d">
				<h3 class="title-d">라운지 회의실 리스트 </h3>
			</div>
		</div>
	</div>
	
<div class="row">
<section class="news-grid grid">
<div class="container">
<div class="row">
	<!--뮤직라운지-->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/1.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">라운지</a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="" data-toggle="modal" data-target=".bs-example-modal-lg">Open Lounge
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a" data-toggle="modal" data-target=".bs-example-modal-lg">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ┌────────────────── 회의실 자세히보기 팝업창 ──────────────────┐ -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">OPEN LOUNGE </h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body">  
					<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
						<li data-target="#carouselExampleControls" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleControls" data-slide-to="1"></li>
						<li data-target="#carouselExampleControls" data-slide-to="2"></li>
						<li data-target="#carouselExampleControls" data-slide-to="3"></li>
						</ol>

						<div class="carousel-inner object_image">
							<div class="carousel-item active">
								<img class="d-block w-100" src="/img/location/myungdong/1.jpg" alt="First slide">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="/img/location/yeouido/1-2.jpg" alt="Second slide">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="/img/location/yeouido/1-3.jpg" alt="Third slide">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="/img/location/yeouido/1-4.jpg" alt="4">
							</div>
						</div>
						
						<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>

					<div class="row">
						<div class="col-12 mt-2">
							<h4 class="mt-2">오픈 라운지</h4>
							<p> 
							SOL Lounge는 고객님의 가치를 한 단계 더 높여드립니다.<br/>
							개인의 업무 목적과 취향에 따라 다양한 공간으로 구성되어 있습니다. <br/>
							개방된 오픈형 좌석, 시원한 개방감의 창가석, 포근한 느낌의 모듈석, 집중을 위한 고정석까지
							목적에 따라 다양한 형태의 공간을 경험해 보세요. </p>
							<h4 class="mt-2"> 시설안내</h4>
							○ 편의시설        : Drink Bar, 무인스낵 판매대, OA 서비스 (복사, 프린트, 스캔), 사물함(유료) <br/>
							○ 쉐어링 품목    : 독서대, 담요, 슬리퍼, 충전기, 1회용 칫솔세트, 서적, 보드게임<br/>
							○ 대여 가능 품목:  노트북
							</p>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary">예약하기 </button>
				</div>
			</div>
		</div>
	</div>
	<!-- └────────────────── 회의실 자세히보기 팝업창 ──────────────────┘ -->

	<!--미팅룸 12인 -->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/2.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">회의실</a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="blog-single.html"> 미팅룸 12인
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--미팅룸 8인 -->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/3.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">회의실 </a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="blog-single.html">미팅룸 8인
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--미팅룸 6인 -->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/4.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">회의실</a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="blog-single.html">미팅룸 6인
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--미팅룸 4인 -->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/5.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">회의실</a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="blog-single.html">미팅룸 4인
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!- 프라이빗 오피스 -->
	<div class="col-md-4">
		<div class="card-box-b card-shadow news-box">
			<div class="img-box-b">
				<img src="/img/location/myungdong/6.jpg" alt="" class="img-b img-fluid">
			</div>
			<div class="card-overlay">
				<div class="card-header-b">
					<div class="card-category-b">
						<a href="#" class="category-b">회의실</a>
					</div>
					<div class="card-title-b">
						<h2 class="title-2">
						<a href="">프라이빗 오피스 
						<br>  </a>
						</h2>
					</div>
					<div class="card-date">
						<a href="property-single.html" class="link-a">자세히보기
						<i class="fa-solid fa-angle-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
             
</div>
</div>
</section> 
<div>
  
</div>

<!-- 요금표 / 오시는길 / 평면도-->
<div class="col-md-12  load_yeouido" >
	<ul class="nav nav-pills-a nav-pills mb-3 section-t3" id="pills-tab" role="tablist">

		<!-- 요금표 -->
		<li class="nav-item">
			<a class="nav-link active" id="pills-pay-tab" data-toggle="pill" href="#pills-pay" role="tab" aria-controls="pills-pay" aria-selected="false">요금표</a>
		</li> 

		<!-- 오시는길 -->
		<li class="nav-item">
			<a class="nav-link " id="pills-map-tab" data-toggle="pill" href="#pills-map" role="tab" aria-controls="pills-map" aria-selected="false">오시는길</a>
		</li> 

		<!-- 평면도 -->
		<li class="nav-item">
			<a class="nav-link" id="pills-plans-tab" data-toggle="pill" href="#pills-plans" role="tab" aria-controls="pills-plans" aria-selected="false">평면도</a>
		</li>  
	</ul>

	<!--탭시작-->
	<div class="tab-content" id="pills-tabContent">
		<div class="tab-pane fade " id="pills-map" role="tabpanel" aria-labelledby="pills-map-tab">
			<p>주소: 서울 중구 명동10길 52 6층</p>
			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.7302420140245!2d126.98350061531154!3d37.56141887979886!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2f07d341891%3A0x86770bf734415ec9!2z7ISc7Jq47Yq567OE7IucIOykkeq1rCDrqoXrj5kxMOq4uCA1Mg!5e0!3m2!1sko!2skr!4v1653293837135!5m2!1sko!2skr" width="100%" height="460" frameborder="0" style="border:0" allowfullscreen></iframe>                  
		</div>
		
		<div class="tab-pane fade" id="pills-plans" role="tabpanel" aria-labelledby="pills-plans-tab">
			<img src="/img/location/myungdong/floor.png" alt="" class="img-fluid">
		</div> 
			
		<!--요금-->
		<div class="tab-pane fade show active" id="pills-pay" role="tabpanel" aria-labelledby="pills-plans-pay">
			<div class=""> 
				<table class="table">
					<thead class="thead-dark">
					<tr>
					<th scope="col">면적</th>
					<th scope="col">수용인원</th>
					<th scope="col">1시간당</th> 
					<th scope="col">초과요금(1시간)</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<th scope="row">MUSIC LOUNGE</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					<tr>
					<th scope="row">SWITCH HALL</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					<tr>
					<th scope="row">회의실 M1</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					<tr>
					<th scope="row">회의실 M2</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					<tr>
					<th scope="row">회의실 M3</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					<tr>
					<th scope="row">회의실 M4</th>
					<td>30명</td>
					<td>100,000원</td>
					<td>300,000원</td>
					<td>500,000원</td>
					</tr>
					</tbody>
				</table>
				<hr>
				<div class="title-box-d mt-3">
					<h3 class="title-d">예약안내</h3> 
				</div> 
				<p>
				1) 예약 확정을 위해 예약 신청 후 당일 이내에 대관료의 30%(예약금)을 선입금해주셔야 합니다.
				미확인 시 예약 확정 불가 및 취소가 이루어질 수 있습니다.<br/>
				2) 잔금은 대관일 1일 전까지 입금해주셔야 합니다.<br/>
				이용일 이후 잔금 결제 불가, 대관일 1일 전까지 입금되지 않을 경우
				예약이 취소되며 취소 수수료가 청구됩니다.
				</p>
				<div class="title-box-d mt-4">
				<h3 class="title-d">취소 및 환불규정</h3>
				</div>
				<p>
				이용 8일 전까지 : 취소 수수료 없음<br/>
				이용 7일 전 ~ 1일 전 : 예약금 100%<br/>
				이용 1일 전 ~ 이용 당일 : 예약금 100% + 잔금 100%<br/>
				</p>

			</div>
		</div>
		<!--//요금-->
	</div> 
</div>
<!--//탭종료-->
</div>
<!--//탭 오시는길 평면도-->

           
</div>
</div>
</div>
</div>
</div>
</section><!-- End Property Single-->

</main><!-- End #main -->

<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script><!--swiper-->


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

<!-- 
회사소개
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="common/head.jsp" />

<style>
.owl-dots{display:none}
</style>

<body>
<!-- 상단 메뉴 -->
<jsp:include page="common/navigation.jsp" />

<main id="main">
	<!-- 상단 이미지 및 설명 -->
	<jsp:include page="common/top.jsp" />

    <!-- =======회사소개 ======= -->
	<section class="section-agents section-t3">
		<div class="container"> 
		
			<div class="row"> 
				<div class="container">  
					<div class="row">
						<div class="col-sm-12">  
						
							<!-- 페이지 설명 및 메뉴 위치 표기 -->
							<jsp:include page="common/intro.jsp" />
							
							<div class="title-box-d">
								<h3 class="title-d">그레이프는 공유라운지를 기반으로 한 오피스 라이프스타일 플랫폼입니다. </h3>
							</div> 
							<p>
								<br/>오피스 Amenity(편의)공간에 컨텐츠/서비스/Tech(기술)를 접목해 시설 및 서비스를 기획, 운영함으로써,
								<br/>그레이프라운지가 입점한 건물은 오피스 라이프스타일 플랫폼으로 진화하게 됩니다.
							</p> 
							<img src="/img/about/about_grape1.jpg" alt="" class="img-d img-fluid">  
						</div>
					</div>
				</div> 
			</div>
		</div>
	</section> 
	        
      <section id="about" class="mt-5" style="background: url(/img/main/bg_location3.jpg) center 26%;background-size: cover;">
        <div class="container aos-init aos-animate service">
          
          <div class="row">
            <div class="col-lg-12 mb-4"> 
              <h2 class="text-center title-a">Grape Office Lifestyle Platform</h2>
              
              </div> 
          </div>
        </div>
      </section>
 
    <section class="section-agents section-t3">
      <div class="container"> 
        <div class="row"> 
          <div class="container">  
            <!--1--> 
            <div class="business_mainbox pt-3">
              <div class="img100 mainbox_left  wow fade-in" data-aos="fade-up" style="visibility: visible; animation-name: fadeIn;">
                <div id="carouselExampleControls1" class="carousel slide" data-ride="carousel">

                  <ol class="carousel-indicators">
                    <li data-target="#carouselExampleControls1" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="1"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="2"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="3"></li>
                  </ol>
        
                  <div class="carousel-inner object_image">
                    <div class="carousel-item active">
                      <img class="d-block w-100" src="/img/about/space1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space2.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space3.jpg" alt="Third slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space4.jpg" alt="4">
                    </div>
                  </div>
                  <a class="carousel-control-prev" href="#carouselExampleControls1" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleControls1" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
                  <!--썸네일-->
               
                  <!--//썸네일 슬라이드-->        
              </div>
              

              <div class="img100 mainbox_right wow fadeInUp" data-aos="fade-up" data-aos-delay="200" style="visibility: visible; animation-name: fadeInUp;">
                  <div class="pd30">
                      <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">SPACE
                      </div>
                    </div>
                      <span class=" colorsilver">
                        임차인의 만족도를 높여주는
                        공간을 제공합니다.<br/>
                        오피스 입주사 임직원들의 라이프스타일을 반영하여
                        사용도와 선호도가 높은 시설/공간을 배치하고
                        프리미엄 퀄리티의 인테리어를 구현하여 머무는 즐거움을 드립니다.
                      </span>
                  </div>
              </div>
          </div>

          <div style="clear: both"></div>
     
            <!--2-->
            <div class="business_mainbox">
              <div class="img100 mainbox_right wow fade-in" data-aos="fade-up" style="visibility: visible; animation-name: fadeIn;">
                <div id="carouselExampleControls2" class="carousel slide" data-ride="carousel">

                  <ol class="carousel-indicators">
                    <li data-target="#carouselExampleControls2" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="1"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="2"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="3"></li>
                  </ol>
        
                  <div class="carousel-inner object_image">
                    <div class="carousel-item active">
                      <img class="d-block w-100" src="/img/about/ex_4.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/ex_3.jpg"alt="Second slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/ex_2.jpg"alt="Third slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/office_space_img03.jpg" alt="4">
                    </div>
                  </div>
                  <a class="carousel-control-prev" href="#carouselExampleControls2" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleControls2" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
              </div>

              <div class="img100 mainbox_left  wow fadeInUp" data-aos="fade-up" data-aos-delay="200" style="visibility: visible; animation-name: fadeInUp;">
                  <div class="pd30">
                    <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">CONTENTS</h3>
                      </div>
                    </div> 
                      <span class=" colorsilver">    
                        다양한 영역의 최고 프로그램들을
                        가까운 곳으로 전해드립니다.<br/>
                        그레이프는 단순히 공간 운영에만 머무르지 않습니다.
                        유망 스타트업들과 제휴하여 다양한 컨텐츠와 프로그램을
                        입주사 임직원 및 지역 고객들에게 제공하여
                        공간과 서비스가 결합된 새로운 상품을 구현합니다.
                      </span>  
                  </div>
              </div>
            </div> 
 
                <div style="clear: both"></div>
                <hr/>


                <div class="title-wrap d-flex justify-content-between">
                  <div class="title-box">
                    <h2 class="title-a">BUSINESS VALUE </h2>
                  </div>
                </div>
                <p>그레이프는 건축주, 오피스 임차인, 컨텐츠 제공업체 등
                  오피스 공간을 소유하고, 임차하고, 사용하는 모든 이해 관계자들을 만족시킵니다.</p>

                <img src="/img/about/about_grape2.jpg" alt="" class="img-d img-fluid mb-3">
                
             </div> 
        </div>
      </div>
      
    </section> 


    <section class="section-agents section-t8"> 
      <div class="container">
        <div class="row">
          <div class="col-md-12"> 
        <hr/>
            <div class="title-wrap d-flex justify-content-between">
              <div class="title-box">
                <h2 class="title-a">CEO</h2>
              </div>
            </div>
          </div>
        </div>
            <div class="row"> 
			<div class="col-md-4 col-lg-4  aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
				<div class="row">
					 <img src="/img/about/team1_raeik.jpg" alt="" class="img-d img-fluid">
				</div> 
			</div>
			
			<!-- Contents -->
			<div class="col-md-8 col-lg-8 aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
                      <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">박래익 대표이사
                      </h3></div>
                    </div>
                      <span class=" colorsilver" style="word-break:keep-all">
					                      박래익대표는 그레이프에서 경영을 총괄하면서 사업기회 발굴 및 개발기획, 사업성 검토, 금융조달 등을 맡고 있습니다. <br/><br/>
					                      그레이프 전에는 부동산 투자 및 개발, 자산운용 등의 업무를 25년 이상 수행하였습니다. <br/><br/>
					                      주요한 경력으로는 싱가포르투자청(GIC) 한국 지사장, 코람코자산운용 대표이사, GE Real Estate 한국대표, 현대건설 리츠팀장 등이 있습니다. 
					                      <br/><br/>박래익대표는 서울대에서 건축공학 학사를 취득했으며, 
					              미국 메세추세츠 공과대학(MIT)에서 부동산 개발·도시계획 석사 학위를 받았습니다.
                      </span>
			</div> 
		</div> 
      </div>
    </section>

 
    
  </main><!-- End #main -->



<jsp:include page="common/footer.jsp" />
<jsp:include page="common/script.jsp" />




<!-- Initialize Swiper -->
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
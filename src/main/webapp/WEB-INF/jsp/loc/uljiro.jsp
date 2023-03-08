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
                <img src="/img/location/uljiro/main.jpg" alt=""> 
                <div class="text_position"><p>메인홀</p></div>
              </div>
               <div class="swiper-slide">
                 <img src="/img/location/uljiro/0.jpg" alt=""> 
                 <div class="text_position"><p>세미나룸 1+2</p></div>
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/1.jpg" alt=""> 
                <div class="text_position"><p>세미나룸 1</p></div>
              </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/2.jpg" alt=""> 
                 <div class="text_position"><p>세미나룸 2</p></div>
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/3.jpg" alt=""> 
                 <div class="text_position"><p>중회의실 1</p></div>
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/4.jpg" alt=""> 
                 <div class="text_position"><p>중회의실 2</p></div>
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/5.jpg" alt=""> 
                <div class="text_position"><p>소회의실 1</p></div>
              </div>
              <div class="swiper-slide">
                <img src="/img/location/uljiro/6.jpg" alt=""> 
                <div class="text_position"><p>소회의실 2</p></div>
              </div>
              <div class="swiper-slide">
                <img src="/img/location/uljiro/7.jpg" alt=""> 
                <div class="text_position"><p>소회의실 3</p></div>
              </div>
               
             </div>
             <div class="swiper-button-next"></div>
             <div class="swiper-button-prev"></div>
        </div>

             <!--썸네일-->
             <div thumbsSlider="" class="swiper mySwiper">
             <div class="swiper-wrapper">
              <div class="swiper-slide">
                <img src="/img/location/uljiro/main.jpg" alt=""> 
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/0.jpg" alt=""> 
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/1.jpg" alt=""> 
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/2.jpg" alt=""> 
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/3.jpg" alt=""> 
               </div>
               <div class="swiper-slide">
                <img src="/img/location/uljiro/4.jpg" alt=""> 
              </div>
              <div class="swiper-slide">
                <img src="/img/location/uljiro/5.jpg" alt=""> 
              </div>
              <div class="swiper-slide">
                <img src="/img/location/uljiro/6.jpg" alt=""> 
              </div>
              <div class="swiper-slide">
                <img src="/img/location/uljiro/7.jpg" alt=""> 
              </div>
             </div>
             </div>
             <!--//썸네일 슬라이드-->      
             <div style="clear:both"></div>
       

            <div class="row justify-content-between">
              <div class="col-md-5 col-lg-4">
                <div class="property-price d-flex justify-content-center foo">
                  <div class="card-header-c d-flex">
                    <div class="card-box-ico">
                      <span class="ion-money"></span>
                    </div>
                    <div class="card-title-c align-self-center">
                      <h5 class="title-c">을지로점</h5>
                    </div>
                  </div>
                </div>
                <div class="property-summary">
                  <div class="row">
                    <div class="col-sm-12">
                      <div class="title-box-d section-t4">
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
                  <div class="col-sm-12">
                    <div class="title-box-d">
                      <h3 class="title-d">Grape Lounge 을지로</h3>
                    </div>
                  </div>
                </div>
                <div class="property-description">
                  <p class="description color-text-a">
                    설명글 필요 설명글 필요설명글 필요설명글 필요설명글 필요<br/>
                    설명글 필요 설명글 필요설명글 필요설명글 필요설명글 필요
                    설명글 필요 설명글 필요설명글 필요설명글 필요설명글 필요
                    
                  </p>
                  <div class="row mt-3">
                    <div class="col-sm-12">
                      <div class="title-box-d">
                        <h3 class="title-d">운영시간
                        </h3>
                      </div>
                    </div>
                  </div>
                  <p class="description color-text-a no-margin"> 
                    <i class="fa-solid fa-clock iconborder"></i>09:00 AM ~ 22:00 PM
                    <br/><br/>
                    <i class="fa-solid fa-phone iconborder"></i> TEL : 02-6020-0198
                  </p>
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <div class="title-box-d">
                      <h3 class="title-d">시설안내</h3>
                    </div>
                  </div>
                </div>
                <div class="amenities-list color-text-a">
                  <ul class="list-a no-margin">
                    <li>세미나룸 1</li>
                    <li>세미나룸 2</li>
                    <li>중회의실 1</li>
                    <li>중회의실 2</li>
                    <li>소회의실 1</li>
                    <li>소회의실 2</li>
                    <li>소회의실 3</li>
                  </ul>
                </div>
 
              </div>
            </div>
          </div>
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
    <!--세미나실-->
                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/0.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">세미나실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="" data-toggle="modal" data-target=".bs-example-modal-lg">세미나룸 1+2
                                  <br>  </a>
                              </h2>
                            </div>
                            <div class="card-date">
                              <a href="" class="link-a" data-toggle="modal" data-target=".bs-example-modal-lg">자세히보기
                                <i class="fa-solid fa-angle-right"></i>
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
 
<!-- 팝업 modal -->
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg">Large modal</button> -->

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">세미나룸 1+2</h4>
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
              <img class="d-block w-100" src="/img/location/uljiro/0.jpg" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="/img/location/uljiro/1.jpg" alt="Second slide">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="/img/location/uljiro/2.jpg" alt="Third slide">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="/img/location/uljiro/3.jpg" alt="4">
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
      
       <h4 class="mt-2"> 시설안내</h4>
        <p>
          세미나룸 1+2<br/>
          
          100명 이상 수용 가능한 룸으로, 세미나룸1과 2를 이어 이용합니다. <br/>
          
          탁 트인 공간에서 세미나 및 컨퍼런스 등 대형 모임을 진행할 수 있습니다. <br/>
          
          기준 인원: 스쿨식 100명(최소 80명 ~ 최대 100명)
        <br/><br/>
        ○ 구비 품목: 빔 프로젝터, 전동 스크린, 벽면 글라스보드, 연설대<br/>

        ○ 대여 가능 품목: 앰프(마이크), 마이크 스탠드, 레이저 포인터<br/>
       
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
<!-- //팝업 modal -->



                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/1.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">세미나실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="blog-single.html"> 세미나룸 1
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

                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/2.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">세미나실 </a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="blog-single.html"> 세미나룸 2
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

                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/3.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">회의실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="">중회의실 1
                                  <br>  </a>
                              </h2>
                            </div>
                            <div class="card-date">
                              <a href="" class="link-a">자세히보기
                                <i class="fa-solid fa-angle-right"></i>
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/4.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">회의실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="">중회의실 2
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

                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/5.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">회의실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="blog-single.html">소회의실 1
                                  <br>  </a>
                              </h2>
                            </div>
                            <div class="card-date">
                              <a href="" class="link-a">자세히보기
                                <i class="fa-solid fa-angle-right"></i>
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="card-box-b card-shadow news-box">
                        <div class="img-box-b">
                          <img src="/img/location/uljiro/6.jpg" alt="" class="img-b img-fluid">
                        </div>
                        <div class="card-overlay">
                          <div class="card-header-b">
                            <div class="card-category-b">
                              <a href="#" class="category-b">회의실</a>
                            </div>
                            <div class="card-title-b">
                              <h2 class="title-2">
                                <a href="blog-single.html">소회의실 2
                                  <br>  </a>
                              </h2>
                            </div>
                            <div class="card-date">
                              <a href="" class="link-a">자세히보기
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

<!--탭 오시는길 평면도-->

              <div class="col-md-12  load_yeouido" >
                <ul class="nav nav-pills-a nav-pills mb-3 section-t3" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-pay-tab" data-toggle="pill" href="#pills-pay" role="tab" aria-controls="pills-pay" aria-selected="false">요금표</a>
                  </li> 
                  <li class="nav-item">
                    <a class="nav-link " id="pills-map-tab" data-toggle="pill" href="#pills-map" role="tab" aria-controls="pills-map" aria-selected="false">오시는길</a>
                  </li> 
              
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

                  <div class="tab-pane fade " id="pills-video" role="tabpanel" aria-labelledby="pills-video-tab">
                    <iframe src="https://player.vimeo.com/video/73221098" width="100%" height="460" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
                  </div>

                  <div class="tab-pane fade" id="pills-plans" role="tabpanel" aria-labelledby="pills-plans-tab">
                    <img src="/img/location/uljiro/floor.png" alt="" class="img-fluid">
                  </div> 
                  <!--요금-->
                  <div class="tab-pane fade show active" id="pills-pay" role="tabpanel" aria-labelledby="pills-plans-pay">
                    <div class=""> 
                      <table class="table">
                        <thead class="thead-dark">
                          <tr>
                            <th scope="col">면적</th>
                            <th scope="col">수용인원</th>
                            <th scope="col">1시간</th>
                            <th scope="col">3시간</th>
                            <th scope="col">5시간</th>
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

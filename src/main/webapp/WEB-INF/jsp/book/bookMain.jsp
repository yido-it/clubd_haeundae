<!-- 
예약 1단계
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/kakaomap.jsp"/> 
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<style>
.owl-dots{display:none}
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
		<input type="hidden" value="${lastBookDt != null ? lastBookDt : ''}" id="lastBookDt" name="lastBookDt"/>
		<div class="row">
			<div class="col-sm-12">
			
				<div class="row justify-content-between">
					<div class="col-md-6 col-lg-6">
					
						<div class="property-summary">
							<div class="row"> 
					
								<div class="col-sm-12 imgArea"> 
									<!--썸네일 슬라이드-->        
									<div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff"   class="swiper mySwiper2"  >
										<div class="swiper-wrapper">
											<!-- 지점 이미지 -->
											<c:forEach items="${locImgList}" var="img">
												<div class="swiper-slide" id="loc">
													<img src="/store/${img.filePath1}" alt="">
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
													<img src="/store/${img.filePath1}" alt="">
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
										<div class="swiper-wrapper thumbImg">		
											<!-- 지점 썸네일 이미지 -->	
											<c:forEach items="${locImgList}" var="img">
												<div class="swiper-slide">
													<img src="/store/${img.filePath2}" />
												</div>
											</c:forEach>		
											<!-- 회의실 썸네일 이미지 -->	
											<c:forEach items="${roomImgList}" var="img">
												<div class="swiper-slide">
													<img src="/store/${img.filePath2}" />
												</div>
											</c:forEach>
										</div>
									</div>
									<!--//썸네일 슬라이드-->        
					
									<div class="" style="clear:both"></div>
						 
								</div>  
						
								<div class="col-sm-12">
									<!--평면도사진-->
									<c:if test="${flrPlan != ''}">					
									<img class="img-d img-fluid floor_img" src="/store/${flrPlan.filePath1}" style="border: 1px solid #e5e5e5;"/>
									</c:if>
								</div>
							</div>  
						</div>  
					</div>
					
					<div class="col-md-6 col-lg-6 section-md-t3 m_pd0"> 
						<div class="col-sm-12 reservation_time"> 
							<!--날짜선택-->
							<div class="title-box-d">
								<h3 class="title-d">날짜선택</h3>
							</div> 
							<input type="text" class="form-control form-control-lg form-control-a" name="bookDt" id="bookDt" data-colname="예약일자" style="display:none;" />
							
							<!--시설(회의실)선택-->
							<div class="row" style="margin-top:20px">
								<div class="col-sm-12">
									<div class="title-box-d">
										<h3 class="title-d">시설선택</h3>
									</div>
								</div>
							</div>
							
							<select class="selectroom custom-select custom-select-lg mb-3" id="selectroom" onchange="fnChangeRoom()">
								<option value="" selected>예약할 시설을 선택하세요</option>
								
								<c:forEach items="${roomList}" var="room">
									<option value="${room.roomSeq}">[${room.cmnNm}] ${room.name}</option>
								</c:forEach>
							</select>
							<!--//시설(회의실)선택-->
					
							<!--시간선택시작-->
							<div class="div_reservation_time">
								<hr/> 
								<!--시간예약-->
								<div class="row">
									<div class="col-md-12 col-lg-5"> 
										<div class="title-box-d ">
											<h3 class="title-d">시간선택</h3>
										</div>
									</div>
									
									<div class="col-md-12 col-lg-7 mt-3">
										<nav class="breadcrumb-box d-flex justify-content-lg-end">
											<span class="badge badge-pill badge-primary ml-1" data-toggle="tooltip" data-placement="top"  title="현재 선택된 시간대입니다.">선택됨</span>											
											<span class="badge badge-pill badge-secondary ml-1"  data-toggle="tooltip" data-placement="top"  title="선택된 날짜에 해당 시간대는 다른 방문자가 예약진행중으로 선택할 수 없습니다.">예약진행중</span>
											<span class="badge badge-pill badge-danger ml-1" data-toggle="tooltip" data-placement="top"  title="선택된 날짜에 해당 시간대는 선택할 수 없습니다.">마감</span>
										</nav>
					
									</div>
								</div> 
					           
					            <!-- 시간선택 -->
								<div class="row div_time">
									<div class="col-sm-12">
										<div> 
                  					<!-- 	<h4 class="mt-2"> 오전</h4> -->
										<div class="btn-group" data-toggle="buttons" id="timeTable1">
											<!-- 
											<ul id='timeTable' class="bkDetailTime">
												<li class="bkTime"></li>
											</ul>
											 -->
										</div>
										</div>
										
										<div> 
                  					<!-- 	<h4 class="mt-3"> 오후</h4> -->
										<div class="btn-group" data-toggle="buttons" id="timeTable2">
											<!-- 
											<ul id='timeTable' class="bkDetailTime">
												<li class="bkTime"></li>
											</ul>
											 -->
										</div>
										</div>
									</div>
								</div>   
								<div class="row noDate" style="display:none;padding-left:20px">
								</div>
								<!--//시간선택-->
								 
								<p class="prevContent">
									<!--  [회의실M1] / 5.26(목)~5.31(화) (6일) /  09:00~ (2시간) / 1,250,000원  -->
								</p>
								<input type="hidden" class="tempBookAmt" value=""/><!--1250000-->
								
								<button class="btn btn-dark btn-lg btn_add" style="padding: 10px 35px;">
									예약담기 <i class="fa-solid fa-angle-down"></i>
								</button>
								
								<p class="prevNotice" style="margin-top:20px;">
									<!-- 
									예약이 이미 진행중이거나 마감인 시간대가 있어서 해당 날짜는 제외하고 예약 됩니다.
									2022-08-02/10:00/예약마감
									2022-08-02/11:00/예약마감
									-->
								</p>
								<p class="prevNotice2" style="margin-top:20px;">
									<!-- 
									예약이 설정되지 않은 시간대가 있어서 해당 날짜는 제외하고 예약 됩니다.
									2022-08-02/10:00
									2022-08-02/11:00
									-->
								</p>
								<hr/>
					
							</div>
							<!--//시간선택종료-->
					
							<!-- 예약 담기 목록 -->
							<div class="div_reservation_add" id="div_reservation_add">	
								<div class="bookAdd">
								<!-- [회의실M1] / 5.26(목)~5.31(화) /  09:00~ (2시간) -->
								</div>
								<hr class="hr_2border"/>
					
								<!--합계-->
								<div class="row pt-3">
									<div class="col-md-12 col-lg-6"> 
										<h2 class="title-single">합계금액 </h2> 
									</div>
									<div class="col-md-12 col-lg-6">
										<nav class="breadcrumb-box d-flex justify-content-lg-end">
										<h2 class="bold totalAmt"></h2>
										<input type="hidden" class="nTotalAmt" value=""/>
										</nav>
									</div>
								</div> 
								
								<button type="button" class="mt-3 btn btn-dark btn-lg btn-block btn-next">
									다음단계 <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
								</button>
							</div>
							<!--// 예약 담기 목록 -->
				
						</div>
					</div>
					<!--//기본정보-->
							
					<!--회의실리스트-->
					<jsp:include page="../common/locationInfo.jsp" />
				</div>
			</div>
		</div>
	</div>
	</section><!-- End Property Single-->
	
	</main>
</body>
</html>

<jsp:include page="../common/footer.jsp" />

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script><!--swiper-->


<!--예약show hide-->
<script>

let clickCnt = 0;					// 시간 선택 횟수 (2번 클릭시 무조건 0으로 초기화)
let firstSelectedTime = ""; 		// 첫번째 선택한 시간 
let prevSelectedTime = ""; 			// 이전에 선택한 시간들 (쉼포구분으로 들어감) 

var bookIdx = 0;					// 예약 담기할때 사용	
var bookData = new Object();		// 예약 담기할때 사용
var bookList = new Array();			// 예약 담기할때 사용
var excludedDate = "";				// 예약 제외할 날짜 (콤마로 구분해서 들어감)
var totalAmt = 0; 					// 예약 합계금액 
var basicFee = "";					// 요금 조회 후 담길 금액 변수

// 회의실 선택시 
// 날짜 + 회의실로 예약설정 데이터 조회 및 표출
function fnChangeRoom(){
	
	// 회의실이나 시간선택했을때 날짜가 하루밖에 선택되지 않은 경우 더이상 진행되지 않도록 처리 (시간 해제 + 문구 삭제) 
	if ( deselectTime() == false ) return;
	
	bkTimeShow();
}

$(document).ready(function(){
	
	// 회의실 자세히보기 팝업창에서 예약하기 누를경우 처리 .. 
	if ( ${roomId} != null && ${roomId} > 0 ) {
		$('#selectroom').val(${roomId});
		fnChangeRoom();
	}
	// end.
	
	$('.div_reservation_time, .div_reservation_add').hide();

	// 예약담기 
	$('.btn_add').click(function(){
		reservationAdd();
	});   
	
	// 다음단계 
	$('.btn-next').click(function(){
		
		if ( bookList.length === 0 ) {
			alert('담겨있는 예약이 없습니다.');
			return;
		}
		
		/*
		예약 임시테이블(book_temp) key(book_cd) 생성 
		랜덤 3자리 + 년월일시분초(YYYYMMDDHHMMSS) ==> nnn + 20220804150905
		*/
		var date = new Date;
		var tempBookCd = "";
		
		tempBookCd = String(randomNum()) + String(date.getFullYear()) + getTimeFormat((date.getMonth() + 1)) + getTimeFormat(date.getDate())
						+ getTimeFormat(date.getHours()) + getTimeFormat(date.getMinutes()) + getTimeFormat(date.getSeconds());
	
		$.ajax({
	        url: "/book/"+tempBookCd+"/"+${loc.locSeq},
	        type: "post",
	        dataType: 'json',
	        contentType:"application/json; charset=utf-8",
	        data: JSON.stringify(bookList),
            success:function(data){
            	if(data.result && data.locSeq != null){
            		location.href="/entBook/"+tempBookCd+"/"+data.locSeq;
            	} else if (data.message != null) {
            		alert(data.message);
            	}
            },
			error: function(data) {
				alert('처리중 오류가 발생하였습니다.');
			}
	    }); 
	});   
});

// 예약담기취소 
function fnDelete(idx){

	var json_idx = bookList.findIndex(function(key) {
		return key.bookIdx === idx
	});
	
	// 합계 금액 변경
	var tempAmt = $(".nTotalAmt").val() - bookList[json_idx].bookAmt;

	$(".nTotalAmt").val(tempAmt);
	totalAmt = Number.parseInt(tempAmt);
	document.querySelector(".totalAmt").innerHTML = (tempAmt).toLocaleString("ko-KR") + "원";	
	
	// 모두 삭제했지만, 선택된 시간대가 있는 경우엔 해당 금액을 totalAmt 변수에 담는다.
	// totalAmt = Number.parseInt($('.tempBookAmt').val());
	// end.
	
	bookList.splice(json_idx, 1);

	// 선택한 예약 데이터 삭제 
	var cur_columns = document.getElementsByClassName('rowBookIdx'+idx);
	cur_columns[0].parentNode.removeChild(cur_columns[0]);
}

//예약담기
function reservationAdd() {
	
	if ( Object.keys(bookData).length === 0 ) {
		alert('예약할 시간을 선택해주세요.');
		return;
	}
	
	if( bookList.filter((e) => { return e.bookIdx == bookData.bookIdx }).length >= 1 ) {
		alert('이미 담은 예약 입니다.');
		return;
	}
	
	/* ┌─────── 2022-10-04 추가 ───────┐ */
	clickCnt = 0;				
	firstSelectedTime = "";		
	
	// 예약담기 후 선택된거 제거 	
	if (prevSelectedTime.toString().indexOf(',') > 0) {
		words = prevSelectedTime.split(',');
		for (let i = 0; i < words.length ; i++){
			$('#time_' + words[i]).removeClass('active');
		}
	} else {		
		words = prevSelectedTime;
		$('#time_' + words).removeClass('active');
	}
	document.querySelector(".prevContent").innerHTML = "";
	/* └─────── 2022-10-04 추가 ───────┘ */
	
	var bookDt = $('#bookDt').val();
	var nowStrtDt = bookDt.substr(0,10).trim();		// 현재 선택한 시작일자 
	var nowEndDt = bookDt.substr(12,18).trim();		// 현재 선택한 종료일자 
	var strtDt; 									// [예약담기목록] 배열에 담겨있는 시작일자
	var endDt;										// [예약담기목록] 배열에 담겨있는 종료일자
	
	var nowStrtTm = bookData.strtTm.trim();			// 현재 선택한 시작시간 
	var nowEndTm = bookData.endTm.trim();			// 현재 선택한 종료시간 
	var strtTm; 									// [예약담기목록] 배열에 담겨있는 시작시간
	var endTm;										// [예약담기목록] 배열에 담겨있는 종료시간

	// ┌──────────────────── 겹치는 시간대 체크 ────────────────────┐
	for (let i=0; i< bookList.length; i++) {
		if (bookList[i].roomSeq == bookData.roomSeq) {
			
			strtDt = bookList[i].bookDt.substr(0,10).trim();
			endDt = bookList[i].bookDt.substr(12,18).trim();
			
			strtTm = bookList[i].strtTm.trim();
			endTm = bookList[i].endTm.trim();

			//console.log('nowStrtDt:', nowStrtDt, '/nowEndDt:', nowEndDt, '/strtDt:', strtDt, '/endDt:', endDt);
			//console.log('nowStrtTm:', nowStrtTm, '/nowEndTm:', nowEndTm, '/strtTm:', strtTm, '/endDt:', endTm);
			
			// 이전 데이터도 하루이고, 현재 데이터도 하루이면서 두 날짜가 같으면 시간만 체크
			// 그렇지 않으면 날짜 겹치는지 체크 후 , 날짜 겹친다고 하면  시간 겹치는지 체크
			if (nowStrtDt == nowEndDt && strtDt == endDt && nowStrtDt == strtDt) {
				//console.log('날짜 같으므로, 시간만 체크');
				
				if((strtTm <= nowStrtTm && nowStrtTm <= endTm) || (strtTm <= nowEndTm && nowEndTm <= endTm) ) {
					alert('겹치는 시간대가 존재합니다. (error code: 1)');
					return;
				}
				
				if((nowStrtTm <= strtTm && strtTm <= nowEndTm) || (nowStrtTm <= endTm && endTm <= nowEndTm) ) {
					alert('겹치는 시간대가 존재합니다. (error code: 2)');
					return;
				}
				
			} else {
				var chkDt = false;
				if((strtDt <= nowStrtDt && nowStrtDt <= endDt) || (strtDt <= nowEndDt && nowEndDt <= endDt) ) {
					//console.log('겹치는 날짜 존재 -1');
					chkDt = true;
				}
				
				if((nowStrtDt <= strtDt && strtDt <= nowEndDt) || (nowStrtDt <= endDt && endDt <= nowEndDt) ) {
					//console.log('겹치는 날짜 존재 -2');
					chkDt = true;
				}
				
				if (chkDt) {
					if((strtTm <= nowStrtTm && nowStrtTm <= endTm) || (strtTm <= nowEndTm && nowEndTm <= endTm) ) {
						alert('겹치는 시간대가 존재합니다. (error code: 3)');
						return;
					}
					
					if((nowStrtTm <= strtTm && strtTm <= nowEndTm) || (nowStrtTm <= endTm && endTm <= nowEndTm) ) {
						alert('겹치는 시간대가 존재합니다 . (error code: 4)');
						return;
					}
				}
			}	
		}
	}
	// └──────────────────── 겹치는 시간대 체크 ────────────────────┘
	
	if (bookList.length <= 0) {
		// 예약담기에 아무것도 없으면, 현재 담을 예약의 금액으로 재설정 
		totalAmt = Number.parseInt(bookData.bookAmt);
	} else {
		// 예약담기에 있는 것들 + 현재 담을 예약의 금액
		totalAmt += Number.parseInt(basicFee);
	}
			    
	if (Number.parseInt(basicFee) == 0) {
		alert('대여 금액이 0원입니다.');
		return;
	}
	//console.log("[reservationAdd] 예약담기 > bookData:", bookData);
	bookList.push(bookData);
	
	//console.log("[reservationAdd] 예약담기 > bookList:", bookList);

	var divAdd = "";
	divAdd = "<div class='row mt-1 rowBookIdx"+bookData.bookIdx+"'>";
	divAdd += "<div class='col-md-12 col-lg-8'>";	
	divAdd += "<span class='pd10 badge badge-pill badge-info'>";	
	divAdd += "<i class='fa-solid fa-x mr-2' onclick='fnDelete("+bookData.bookIdx+")'></i>"+bookData.prevContent+"</span>";	
	divAdd += "</div>";	
	divAdd += "<div class='col-md-12 col-lg-4'>";	
	divAdd += "<nav class='breadcrumb-box d-flex justify-content-lg-end'>";
	divAdd += "<h5 class='''>"+  Number(bookData.bookAmt).toLocaleString("ko-KR") +"원</h3>";
	divAdd += "</nav>";
	divAdd += "</div>";
	divAdd += "</div>";	
	
	document.querySelector(".bookAdd").innerHTML += divAdd;	
	
	// 합계금액  
	//document.querySelector(".totalAmt").innerHTML = totalAmt.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원";	
	document.querySelector(".totalAmt").innerHTML = Number(totalAmt).toLocaleString("ko-KR") + "원";	
	
	$(".nTotalAmt").val(totalAmt);
		
	$('.div_reservation_add').show();
	bookData = {};	// 2022-10-04 추가
	prevSelectedTime = "";	
}

//회의실 자세히보기
function showDetail(seq) {
	$(".modal-content").load('/room/popDetail/'+seq).fadeIn("fast");
	$('#popModal').modal('show');  
}

//날짜 + 회의실로 예약설정 데이터 조회 및 표출
function bkTimeShow() {

	excludedDate = "";
	bookData = {};
	
	document.querySelector(".prevContent").innerHTML = "";
	document.querySelector(".prevNotice").innerHTML = "";
	document.querySelector(".prevNotice2").innerHTML = "";

	var bookDt = $('#bookDt').val();
	
	if ($('.selectroom').val() != null && $('.selectroom').val() != "") {
		$.ajax({
			url: "/bookTimeTable",
			type: "post",
			dataType: 'json',
			data: { 
				"bookDt" :bookDt
				, "roomSeq" : $('.selectroom').val() 
			},
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
			success: function(data) {
				var list = data.list;
			
				var divTimeTable1 = "";
				var divTimeTable2 = "";
				var className = "";
				var content = "";
				
				// 선택한 날짜수 획득...
				var sdt = new Date(bookDt.substr(0,10));
				var edt = new Date(bookDt.substr(12,18));
				var dateDiff = Math.ceil((edt.getTime()-sdt.getTime())/(1000*3600*24) + 1);
				// end
				
				var prevTime = "";
				for (let i=0; i< list.length; i++) {

					if (list[i].strtTm != prevTime) {
						 
						if (list[i].groupByCnt == dateDiff) {
							// groupByCnt가 선택한 날짜수와 같다면... 
							if (list[i].roomSttsCd == "400001") {
								
								className = "btn btn-info disabled";
								content = "<span>"+list[i].strtTm+"</span>";
								
							} else if (list[i].roomSttsCd == "400002") {
								
								className = "btn btn-secondary";
								content = list[i].strtTm;
								
							} else if (list[i].roomSttsCd == "400003") {
								
								className = "btn btn-danger disabled";
								content = "<span>"+list[i].strtTm+"</span>";
								
							}
						} else {
							className = "btn btn-secondary";
							content = list[i].strtTm;
						}
						
						var strtTm = list[i].strtTm.substr(0,2);
						if (strtTm <= 12) {
							// 오전 
							divTimeTable1 += '<label class="bkTime '+className+'" id="time_'+strtTm+'" onClick="fnTimeClick('+strtTm+')"><input type="checkbox" autocomplete="off">'+content+'</label>';
						} else {
							// 오후 
							divTimeTable2 += '<label class="bkTime '+className+'" id="time_'+strtTm+'" onClick="fnTimeClick('+strtTm+')"><input type="checkbox" autocomplete="off">'+content+'</label>';
						}
					
						prevTime = list[i].strtTm;
					}
				}
				
				if ( list.length <= 0 ) {
					document.querySelector(".noDate").innerHTML = "오픈된 예약이 없습니다.";
					$('.btn_add').css('display', 'none');
					$('.noDate').css('display', 'inline');
					$('.div_time').css('display', 'none');
					
				} else {
					document.querySelector(".noDate").innerHTML = "";
				 	document.querySelector("#timeTable1").innerHTML = divTimeTable1;
				 	document.querySelector("#timeTable2").innerHTML = divTimeTable2;
					$('.btn_add').css('display', 'inline');
					$('.noDate').css('display', 'none');
					$('.div_time').css('display', 'block');
				}
			 	
				$('.div_reservation_time').show();
				
			},
			error: function(data) {
				// 
			}
		});
	}
}

// 회의실이나 시간선택했을때 날짜가 하루밖에 선택되지 않은 경우 더이상 진행되지 않도록 처리 (시간 해제 + 문구 삭제) 
function deselectTime() {
	
	if ($('#bookDt').val().includes('~') == false) {
		alert('날짜 선택을 완료 해주세요. 당일선택시 해당날짜를 더블클릭하시면 됩니다.');
	
		// 시간해제 
		words = prevSelectedTime.split(',');
		
		setTimeout(function() { 
			for (let i = 0; i < words.length ; i++){
				$('#time_' + words[i]).removeClass('active');
			}
		}, 50);
		
		// 문구삭제 
		document.querySelector(".prevNotice").innerHTML = "";
		document.querySelector(".prevNotice2").innerHTML = "";
		document.querySelector(".prevContent").innerHTML = "";
		bookData = {};
			
		return false;
	}
}

// 시간 선택 완료시 
function fnTimeClick(time) {
	time = getTimeFormat(time);
	
	let finalSelectedTime = ""; // 선택된 시간 모두 저장 (11,12,13)
	var timeCnt; 				// 몇시간 예약했는지 (2시간이면 -> 2)

	clickCnt += 1;				
	//console.log('[시간 선택 완료] 클릭수:', clickCnt, ', 첫번째 선택한 시간:', firstSelectedTime, ', 현재 선택한 시간:', time);
	
	// 2022-10-04 추가 (IF문)
	if (prevSelectedTime != time && clickCnt > 1) {
		// 현재 선택한 시간이 이전에 선택한 시간과 똑같지 않거나 클릭을 두번 이상 했을때..
		
		var selectedTime1 = "";		// ex: 9시
		var selectedTime2 = "";		// ex: 14시
		
		// 14시 선택 후, 9시 선택한 경우 서로 바꿔주기 
		if (time < firstSelectedTime) {
			selectedTime1 = time;
			selectedTime2 = firstSelectedTime;
		} else {
			selectedTime1 = firstSelectedTime;
			selectedTime2 = time;
		}
		timeCnt = (selectedTime2 - selectedTime1) + 1;
		
		//console.log('시간 선택 + 클릭수 0으로 초기화 > 선택해야할 시간갯수:', timeCnt);
		
		var chkTime = Number(selectedTime1);
		for (let i = 0; i < timeCnt ; i++){
			var realChkTime = "";
			 realChkTime = getTimeFormat(chkTime);
			
			if ( finalSelectedTime == "" ) finalSelectedTime += realChkTime;
			else finalSelectedTime += "," + realChkTime;

			// 클릭한 시간 모두 선택되도록 
			if (i == 0 || i+1 == timeCnt) {
				// 마지막에 클릭한 시간이 선택되지 않아서 setTimeOut 설정 
				setTimeout(function() { $('#time_' + realChkTime).addClass('active'); }, 50);
			} else {
				$('#time_' + realChkTime).addClass('active');
			}
			// end. 
			chkTime += 1;
		}
	
		clickCnt = 0;
		firstSelectedTime = "";
		prevSelectedTime = finalSelectedTime;
		
		// 회의실이나 시간선택했을때 날짜가 하루밖에 선택되지 않은 경우 더이상 진행되지 않도록 처리 (시간 해제 + 문구 삭제) 
		if ( deselectTime() == false ) return;
		
		
	} else {
		/* ┌──────── 2022-10-04 추가 ────────┐ */
		if (clickCnt == 1 && prevSelectedTime != null) {
			// 처음선택시, 이전에 이미 선택된게 있으면 제거 
			words = prevSelectedTime.split(',');
			
			for (let i = 0; i < words.length ; i++){
				$('#time_' + words[i]).removeClass('active');
			}
		}
		selectedTime2 = time;	
		timeCnt = 1;	   		

		finalSelectedTime = time;
		prevSelectedTime = time;
		/* └──────── 2022-10-04 추가 ────────┘ */
		
		// 현재 선택한 시간은 선택되도록 
		setTimeout(function() { $('#time_' + time).addClass('active'); }, 50);
		
		firstSelectedTime = time;
	}
	finalSelectedTime = finalSelectedTime.toString();

	// 예약담기에 아무것도 없으면 totalAmt 초기화 후 재설정 
	if (bookList.length <= 0) {
		totalAmt = 0;
	}
	document.querySelector(".prevNotice").innerHTML = "";
	document.querySelector(".prevNotice2").innerHTML = "";
	document.querySelector(".prevContent").innerHTML = "";
	bookData = {};
		
	var bookDt = $('#bookDt').val();
	
	// 예약진행중 or 마감을 포함했는지 체크
	if ( timeCheck(finalSelectedTime) == false ) {
		return;
	}
	
	// 선택한 시간대로 DB 조회해서 예약진행중 or 마감된 시간대가 있는지 체크 
	ajaxTimeCheck(finalSelectedTime);
	
	setTimeout(function() {
		var strtTm = finalSelectedTime.slice(0,2) + ":00";				// 선택 시작시간
		var endTm = finalSelectedTime.slice(-2, finalSelectedTime.length);	// 선택 종료시간
		endTm = endTm.slice(0,2) + ":00";							// 선택 종료시간
		var strtDt = bookDt.substr(5,5);							// 선택 시작날짜 (MM-DD)
		var endDt = bookDt.substr(18,20);							// 선택 종료날짜 (MM-DD)
		var yoil1 = getDate(bookDt.substr(0,10));					// 선택 시작 요일
		var yoil2 = getDate(bookDt.substr(12,18));					// 선택 종료 요일
		var prevContent = "";
		var target = document.getElementById("selectroom");
		
		setTimeout(function() {
			// ┌────────────── 요금 조회 ──────────────┐ 
			$.ajax({
		        url: "/fee/getFee",
		        type: "post",
		        dataType: 'json',
		        data: { 
		        	"roomSeq" : $('#selectroom').val() 
		        	, "strtDt" : bookDt.substr(0,10)
		        	, "endDt" : bookDt.substr(12,18)
		        	, "timeCnt" : timeCnt
		        	, "excludedDate" : bookData.excludedDate  // 예약 제외할 날짜 (콤마로 구분해서 들어감)
		        },
		        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		        success: function(data) {
		        	basicFee = data.basicFee;
		        	
		        	var prevContentAmt = "";
					// ┌────────────────── 화면에 보여줄 내용 구성 ──────────────────┐
					// 회의실
					prevContent = target.options[target.selectedIndex].text;	
					// 선택한 날짜&요일
					if (strtDt == endDt) {
						prevContent += " / " + strtDt + "(" + yoil1 + ")";		
					} else {
						prevContent += " / " + strtDt + "(" + yoil1 + ")~" + endDt + "(" + yoil2 + ") ";		
					}
					// 선택한 시간
					prevContent += " / " + strtTm + "~ (" + timeCnt + "시간)" ;							
					// 총금액 
					//prevContentAmt = " / " + basicFee.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원";
					prevContentAmt = " / " + Number(basicFee).toLocaleString("ko-KR") + "원";
						
					document.querySelector(".prevContent").innerHTML = prevContent + prevContentAmt;
					// └────────────────── 화면에 보여줄 내용 구성 ──────────────────┘
					
					$('.tempBookAmt').val(basicFee);
					
					// 선택 완료되었을때.. 
					bookIdx += 1;
					bookData.bookIdx = bookIdx;
					bookData.bookDt = bookDt;	// 2022-08-01 ~ 2022-08-03
					bookData.strtTm = strtTm;	// 09:00
					bookData.endTm = endTm;		// 13:00
					bookData.bookAmt = basicFee;
					bookData.prevContent = prevContent;
					bookData.roomSeq = $('#selectroom').val();	
					// end.
		
					//console.log('[시간 선택 완료] 화면 표출 후 > bookData : ', bookData);
		        },
		        error: function(data) {
		           //  alert('등록중 오류가 발생하였습니다.');
		        }
		    });
			// └────────────── 요금 조회 ──────────────┘
		}, 50);
		
		excludedDate = "";
	}, 100);	
	
}

// 예약진행중 or 마감을 포함했는지 체크
function timeCheck(sTime) {
	var selectedTime = sTime.toString();
	var strtTm = selectedTime.slice(0, 2);						// 선택 시작시간 (09)
	var endTm = selectedTime.slice(-2, selectedTime.length);	// 선택 종료시간 (10시)
	var lastWord = endTm.slice(0,2);							// 선택 종료시간 (10)
	var unChecked = false;										// 공통
	//var consecutiveHours = false; 							// 연속된 시간 체크했는지 여부 
	var includeCheck = false; 									// 예약진행중 or 마감을 포함해서 선택했는지 여부 
	var divNotice;
	
	var words = "";
	if (selectedTime.includes(',')) {
		// 여러시간 선택 (10시,11시,12시)
		words = selectedTime.split(',');
		
		for (let i = 0; i < words.length -1 ; i++) {
			// ┌───────── 예약진행중 or 마감을 포함했는지 체크  ─────────┐
			var className = document.getElementById('time_' + words[i]).className;
			if ( className.includes('btn-info') || className.includes('btn-danger') ) {
				unChecked = true;
				includeCheck = true;
			}
			// └───────── 예약진행중 or 마감을 포함했는지 체크  ─────────┘
		}

		if (unChecked) {
			// 선택 해제
			for (let i = 0; i < words.length; i++) {
				
				if ( i == 0 || i+1 == words.length ){
					// 마지막에 클릭한 시간이 해제되지 않아서 setTimeOut 설정 
					setTimeout(function() { $('#time_' + (words[i])).removeClass('active'); }, 50);
				} else {
					$('#time_' + (words[i])).removeClass('active');
				}				
			}
	
			if (includeCheck) {
				var showTime = "";
				divNotice = "<span class='notice'>예약진행중이거나 마감된 시간대가 포함되어있습니다. 예약가능한 시간대로 선택해주세요.</span>";
			
				if ( strtTm == lastWord ) {
					showTime = strtTm + "시";
				} else {
					showTime = strtTm + "~" + lastWord + "시";
				}
				divNotice += "<br><span class='notice'>※ 선택한 시간대 : " + showTime + "</span>";
				
				document.querySelector(".prevContent").innerHTML = divNotice;
			}
		
			return false;
		}
		
	} else {
		// 1개 시간 선택  (10시)
		// ┌───────── 예약진행중 or 마감을 포함했는지 체크  ─────────┐
		var className = document.getElementById('time_' + selectedTime.toString()).className;
		if ( className.includes('btn-info') || className.includes('btn-danger') ) {
			unChecked = true;
			includeCheck = true;
		}
		// └───────── 예약진행중 or 마감을 포함했는지 체크  ─────────┘
	
		if (unChecked) {
			// 선택 해제
			setTimeout(function() { $('#time_' + selectedTime).removeClass('active'); }, 50);
			return false;
		}
	}
}


// 선택한 시간대로 DB 조회해서 예약진행중 or 마감된 시간대가 있는지 체크 
function ajaxTimeCheck(sTime) {

	var selectedTime = sTime.toString();
	document.querySelector(".prevNotice").innerHTML = "";
	document.querySelector(".prevNotice2").innerHTML = "";
	var bookDt = $('#bookDt').val();
	
	var strtTm = selectedTime.slice(0, 2);						// 선택 시작시간 (09)
	var endTm = selectedTime.slice(-2, selectedTime.length);	// 선택 종료시간 (10시)
	var lastWord = endTm.slice(0,2);							// 선택 종료시간 (10)

	$.ajax({
        url: "/bookNotAvailableTime",
        type: "post",
        dataType: 'json',
        data: { 
        	"strtDt" : bookDt.substr(0,10)
        	, "endDt" : bookDt.substr(12,18)
        	, "strtTm" : strtTm + ":00:00"
        	, "endTm" : lastWord + ":00:00"
        	, "roomSeq" : $('#selectroom').val() 
        },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
       		//console.log("[ajaxTimeCheck] 선택한 시간대로 DB 조회 > 예약진행중/마감된 시간대가 있는지 체크 > 결과 : ", data);
       		
       		var list = data.bookNotAvailableTimeList;
       		var list2 = data.bookNotSettingList;
       		var excludedDate = "";
       		
       		if (list != null && list.length > 0) {
       			var divNotice = "<span class='notice'> 예약이 이미 진행중이거나 마감인 시간대가 있어서 해당 날짜는 제외하고 예약 됩니다.";
       			
       			var prevDate = "";
    			for (let i=0; i< list.length; i++) {
    		       	divNotice += "<br>" + list[i].bookDt + '/' + list[i].strtTm + '/'+ list[i].roomSttsNm;
    		       	
    		       	if (list[i].bookDt != prevDate) {
    		       		if ( excludedDate == "" ) {
    		       			excludedDate = list[i].bookDt;
    		       		} else {
    		       			excludedDate += "," + list[i].bookDt;
    		       		}
    		       	}
    		       	prevDate = list[i].bookDt;
    			}
    			
    			bookData.excludedDate = excludedDate; 
				// console.log("[ajaxTimeCheck] 예약 제외할 날짜: ", excludedDate);
				
    			divNotice += "</span>";
    			document.querySelector(".prevNotice").innerHTML = divNotice;
       		}
       		
       		// DB 에 아예 세팅된 데이터가 없을때 
       		if (list2 != null && list2.length > 0) {
       			var divNotice = "<span class='notice'> 예약이 설정되지 않은 시간대가 있어서 해당 날짜는 제외하고 예약 됩니다. ";
       			var prevDate2 = "";
    			for (let i=0; i< list2.length; i++) {

       		       	divNotice += "<br>" + list2[i].bookDt + '/' + list2[i].strtTm;
       		       	
       		       	if (list2[i].bookDt != prevDate2) {
       		       		if ( excludedDate == "" ) {
       		       			excludedDate = list2[i].bookDt;
       		       		} else {
       		       			// 이미 있으면 넣지않기 
       		       			if (excludedDate.indexOf(list2[i].bookDt) < 0) {
           		       			excludedDate += "," + list2[i].bookDt;
       		       			}
       		       		}
   					}
    		       	prevDate2 = list2[i].bookDt;
    			}
    			
    			bookData.excludedDate = excludedDate; 
				
    			divNotice += "</span>";
    			document.querySelector(".prevNotice2").innerHTML = divNotice;       			
       		}

			//console.log("[ajaxTimeCheck] 예약 제외할 날짜: ", excludedDate);
        },
        error: function(data) {
           //  alert('등록중 오류가 발생하였습니다.');
        }
    });
}

// 선택한 회의실에 대한 이미지로 변경 
/*
function imgShow() {
	
	if ($('#selectroom').val() == "") {
		return;
	}
	
	$.ajax({
        url: "/room/imagelist",
        type: "post",
        dataType: 'json',
        data: { 
        	"roomSeq" : $('#selectroom').val()
        	, "flrPlanYn" : "N"
        },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(list) {
       		console.log(list);
       		
       		if (list.length > 0) {
       			var divMainImg = "";
       			var divThumbImg = "";
       			
       			// 이미지 슬라이드 
       			divMainImg += '<div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper mySwiper2">';
       			divMainImg += '<div class="swiper-wrapper">';
    			for (let i=0; i< list.length; i++) {
    				divMainImg += '<div class="swiper-slide">';
    				divMainImg += '<img src="/store/'+list[i].filePath1+'" alt="">';
    				divMainImg += '<div class="text_position">';
    				divMainImg += '<p>'+list[i].roomName+'</p>';
    				divMainImg += '</div>';
    				divMainImg += '</div>';
    			} 
    			divMainImg += '</div>';
    			divMainImg += '<div class="swiper-button-next"></div>';
    			divMainImg += '<div class="swiper-button-prev"></div>';
    			divMainImg += '</div>';
    			
    			// 썸네일 슬라이드 
				divThumbImg += '<div thumbsSlider="" class="swiper mySwiper thumbnail">';
				divThumbImg += '<div class="swiper-wrapper">';
				for (let i=0; i< list.length; i++) {
					divThumbImg += '<div class="swiper-slide">';
					divThumbImg += '<img src="/store/'+list[i].filePath2+'" />';
					divThumbImg += '</div>';
				} 
				divThumbImg += '</div>';
				divThumbImg += '</div>';
				divThumbImg += '<div class="" style="clear:both"></div>';
    			document.querySelector(".imgArea").innerHTML = divMainImg + divThumbImg;
       		} else {
    			document.querySelector(".imgArea").innerHTML = "<div style='margin-bottom:20px'><img src='/img/no_image.png'><br><span>등록된 회의실 이미지가 없습니다.</span></div>";
       		}
        },
        error: function(data) {
           //  alert('등록중 오류가 발생하였습니다.');
        }
    });
}*/

</script>

<script>

var dateSelector = document.querySelector('#bookDt');

//오늘 날짜 
var today = getToDay('-');
var fp = dateSelector.flatpickr({  
	 locale: 'ko'
	, mode: "range" 
	, maxDate : $('#lastBookDt').val()
	, dateFormat: "Y-m-d"
	, conjunction: " ~ "
	, minDate : today
	, confirmIcon: "<i class='fa fa-check'></i>" 
	, inline : true
	, showMonths : 1
	, defaultDate: [new Date(), new Date()]
	, onClose: function(selectDates, dateStr, instance){
		// 날짜 선택 완료 되었을때 
		var strtDt = getStringDt(selectDates[0], '-');
		var endDt = getStringDt(selectDates[1], '-');

		if (strtDt == endDt) {
			$('#bookDt').val(strtDt + " ~ " + endDt);
		}
		
		document.querySelector(".prevContent").innerHTML = "";
		// 예약 설정 데이터 조회 
		bkTimeShow();		
	}
});

$('#bookDt').val(today + " ~ " + today);

</script>

<!--swiper섬네일 옵션-->
<script>
$('.carousel').carousel({
	interval: 2500  //슬라이드  속도
})
</script>

<!--스크롤자연스럽게-->
<script>
$(document).ready(function(){

	$(".scroll_move").click(function(event){         

		event.preventDefault();

		$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500); 
	}); 
	$(function () { //툴팁
		$('[data-toggle="tooltip"]').tooltip()
	})

});
</script> 

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

<style>
.notice { color:red;font-weight:bold;font-size:14px }

.flatpickr-months .flatpickr-month{
	background:#7256a4;
}
.flatpickr-weekdays{
	background:#7256a4;
}
.flatpickr-current-month .flatpickr-monthDropdown-months{
	background:#7256a4;
}
.flatpickr-current-month .flatpickr-monthDropdown-months .flatpickr-monthDropdown-month{
	background:#7256a4;
}
span.flatpickr-weekday{
	background:#7256a4;
	color:white;
}
.flatpickr-day.selected, .flatpickr-day.startRange, .flatpickr-day.endRange, .flatpickr-day.selected.inRange, .flatpickr-day.startRange.inRange, .flatpickr-day.endRange.inRange, .flatpickr-day.selected:focus, .flatpickr-day.startRange:focus, .flatpickr-day.endRange:focus, .flatpickr-day.selected:hover, .flatpickr-day.startRange:hover, .flatpickr-day.endRange:hover, .flatpickr-day.selected.prevMonthDay, .flatpickr-day.startRange.prevMonthDay, .flatpickr-day.endRange.prevMonthDay, .flatpickr-day.selected.nextMonthDay, .flatpickr-day.startRange.nextMonthDay, .flatpickr-day.endRange.nextMonthDay{
	background:#7256a4;
	border-color:#7256a4;
}
.flatpickr-day.selected.startRange + .endRange:not(:nth-child(7n+1)), .flatpickr-day.startRange.startRange + .endRange:not(:nth-child(7n+1)), .flatpickr-day.endRange.startRange + .endRange:not(:nth-child(7n+1)){
	box-shadow:-10px 0 0 #7256a4;
}
</style>
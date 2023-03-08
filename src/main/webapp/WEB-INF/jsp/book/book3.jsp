<!-- 
예약 3단계 (예약 결과 확인 & 견적서신청)
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/head.jsp" />

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
 
	<section class="contact">
	<div class="container">
		<div class="title-box-d text-center">
			<i class="fa-solid fa-circle-check" style="font-size: 60px;color: #7b559f;margin-bottom: 20px;"></i>
			<h2 class="">그레이프 여의도점 예약이 완료되었습니다.</h2>
			<hr/>
			<h5 class="pt-3"> 예약 담당자가 확인 후 결제 관련한 메일과 유선 연락 드리겠습니다. </h5>
			<p class="pt-3">
			<i class="fa-solid fa-phone iconborder" style="margin-right:0"></i> 예약담당자: ${loc.estEmail}
			&nbsp; 
			<i class="fa-solid fa-envelope iconborder" style="margin-right:0"></i> ${loc.estTel}
			</p> 
		</div>

		<!-- 예약목록 -->
		<c:forEach items="${list}" var="book">
			<div class="summary-list mt-3">   
				<div class="row ">
					<div class="col-md-12 col-lg-8"> 
						<div class="row mt-2 ">
							<div class="col-md-12 col-lg-2"> 
								<h5 class=""> 예약자</h5>
							</div> 
							<div class="col-md-12 col-lg-10"> 
								<p class=""> ${book.NAME}</p>
							</div>
						</div>
	
						<div class="row mt-2 ">
							<div class="col-md-12 col-lg-2"> 
								<h5 class=""> 장소</h5>
							</div>
	
							<div class="col-md-12 col-lg-10"> 
								<p class=""> ${book.ROOM_NM}</p>
							</div>
						</div>
							
						<div class="row mt-2 ">
							<div class="col-md-12 col-lg-2"> 
								<h5 class=""> 일정</h5>
							</div>
	
							<div class="col-md-12 col-lg-10"> 
								<!-- <p class=""> 2022.04.06(금) 오전 11:00 ~ 오전 13:00 (2시간)</p> -->
								 <p class=""> ${book.BOOK_RESULT}</p>
							</div>
						</div>
	
						<div class="row mt-2 ">
							<div class="col-md-12 col-lg-2"> 
								<h5 class=""> 금액</h5>
							</div>
	
							<div class="col-md-12 col-lg-10"> 
								<p class=""><fmt:formatNumber value="${book.FEE}" pattern="#,###" />원</p>
							</div> 
						</div> 
						
						<c:if test="${loc.accntNo != ''}">
						<div class="row mt-2 ">
							<div class="col-md-12 col-lg-2"> 
								<h5 class="">입금계좌</h5>
							</div> 
							<div class="col-md-12 col-lg-10"> 
								<p class=""> ${loc.bankNm} ${loc.accntNo} (예금주: 주식회사 ${loc.cmpyTp})</p>
							</div>
						</div>
						</c:if>
					</div>
					
					<!--대표이미지-->
					<div class="col-md-12 col-lg-4"> 
						<img src="/store/${book.ROOM_IMG}" alt="" style="width:100%;border-radius:10px">
					</div> 
				</div>
			</div>
		</c:forEach>
		<!-- // 예약목록 -->
      
		<div class="row text-center mt-3">
			<div class="col-md-12">
				<!-- 견적서신청 -->
				<a href="#move">
					<button class="btn btn-dark btn-lg gg" >
						<i class="fa-solid fa-file-lines"></i> 견적서 신청
					</button>
				</a>

				<!-- 예약확인 -->
				<a href="/bookConfirm">
					<button class="ml-2 btn btn-primary btn-lg">
						<i class="fa-solid fa-house"></i> 예약 확인
					</button>
				</a>
			</div>
		</div>

		<hr class="pt-3"/>

		<!--견적정보입력-->
		<div class="row estimate"  >

			<div class="col-sm-12 section-t3"  id="move">
				<div class="title-box-d ">
					<h3 class="title-d" >견적서 정보 입력</h3>
				</div>
			
				<div class="row">

				<div class="col-md-7">
				<form action="forms/contact.php" method="post" role="form" class="php-email-form">
					<div class="row">
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input type="text" name="subject" class="form-control form-control-lg form-control-a" placeholder="회사명: 이도" disabled >
								<div class="validate"></div>
							</div>
						</div>
						
						<div class="col-md-12 mb-3">
							<div class="form-group">
								<input type="text" name="subject" class="form-control form-control-lg form-control-a" placeholder="회의실명: 회의실M2, 회의실M1" disabled >
								<div class="validate"></div>
							</div>
						</div>
							
						<div class="col-md-12 mb-3">
							<div class="form-group">
								<input type="text" name="subject" class="form-control form-control-lg form-control-a" placeholder="견적금액: 360,000원" disabled >
								<div class="validate"></div>
							</div>
						</div>
			
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input type="text" name="name" class="form-control form-control-lg form-control-a" placeholder="담당자" data-rule="minlen:4" data-msg="성함을 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
							
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input name="email" type="email" class="form-control form-control-lg form-control-a" placeholder="회의명" data-rule="email" data-msg="이메일주소를 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						
						<div class="col-md-12 mb-3">
							<div class="form-group">
								<input type="text" name="subject" class="form-control form-control-lg form-control-a" placeholder="연락처" data-rule="minlen:4" data-msg="연락처를 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
			
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input type="text" name="subject" class="form-control form-control-lg form-control-a" placeholder="견적서정보" data-rule="minlen:4" data-msg="연락처를 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input type="text" name="name" class="form-control form-control-lg form-control-a" placeholder="견적서정보" data-rule="minlen:4" data-msg="성함을 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						
						<div class="col-md-6 mb-3">
							<div class="form-group">
								<input name="email" type="email" class="form-control form-control-lg form-control-a" placeholder="견적서정보" data-rule="email" data-msg="이메일주소를 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						
						<div class="col-md-12">
							<div class="form-group">
								<textarea name="message" class="form-control" name="message" cols="45" rows="8" data-rule="required" data-msg="요청사항을 적어주세요" placeholder="업체에 요청하실 내용이 있다면 적어주세요"></textarea>
								<div class="validate"></div>
							</div>
						</div>
			
						<!--개인정보-->
						<div class="col-md-12">
							<p class="fs16 colorblack bold">위약금규정</p>
							<div class="contant txt_privacy" >
								<jsp:include page="../common/privacy.jsp" />
							</div>
							
							<!-- 개인정보동의 -->         	
							<div class="agree_btm mt-3 tl">           
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="y">
									<label class="form-check-label" for="inlineRadio1">동의합니다</label>
								</div>
								
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="n"  checked="">
									<label class="form-check-label" for="inlineRadio2">동의하지 않습니다.</label>
								</div>
							
								<div class="validate">개인정보취급방침에 동의가 필요합니다</div>
							</div>
							<!--//개인정보-->
						</div>
				
						<div class="col-md-12 text-center">
							<button type="submit" class="mt-3 btn btn-dark btn-lg btn-block btn_estimate" id="">
								<i class="fa-solid fa-note-sticky"></i> 견적서 미리보기
							</button>
						</div>
					</div>
				</form>
				</div>

				<div class="col-md-5 section-md-t3">
					<div class="icon-box section-b2">
					
						<div class="icon-box-content table-cell">
							<div class="icon-box-title">
								<h4 class=""><i class="fa-solid fa-circle-exclamation iconborder" style=""></i>유의사항</h4>
							</div>
							<div class="icon-box-content">
								<p class="mb-1">항목에 맞게 입력하시면 견적서를 신청하실 수 있~
								</p>
							
								<p class="mb-1 mt-3">내용을 입력하시면 견적서를 출력하실수 있습니다. 
								</p>
								
								<p class="mb-1 mt-3"> 
								외부자재 반입 승인여부는 시설팀에 문의바랍니다. <br/>(010-2223-3333)
								</p>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
		<!--//견적입력-->
	</div>
	</section><!-- End  -->

</main><!-- //#main -->
  
 
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />

<!--견적서 슬라이드토글-->
<script type="text/javascript">
$( document ).ready( function() {
	$( '.estimate' ).hide(); 
	$( '.gg' ).click( function() {
		//$( '.estimate' ).show();
		window.open('/rptEstimate/${bookCd}');
	} );
} );
</script>

</body>

</html>
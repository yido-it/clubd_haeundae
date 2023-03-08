<!-- 
예약 상세 내역 
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<fmt:parseDate value="${book.bookReqDt}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReqDt" type="both"/>
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
		
			<div class="col-md-12  load_yeouido" id="payment">
				<!--예약확인-->
				<div class="row"> 
					<div class="col-sm-12 ">
				
						<div class="row">
							<div class="col-md-7">
							<div class="row ">
								<div class="col-md-12 col-lg-12"> 
									<!-- 예약상태 -->
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 예약상태 </h5>
										</div> 
										<div class="col-md-12 col-lg-9"> 
											<p class="">${book.bookSttsNm} </p>
										</div>
									</div> 
									<!-- 예약코드 -->
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 예약코드</h5>
										</div> 
										<div class="col-md-12 col-lg-9"> 
											<p class=""> 
											${book.bookCd}
											</p>
										</div>
									</div>
									<!-- 예약일 -->
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 예약일</h5>
										</div> 
										<div class="col-md-12 col-lg-9"> 
											<p class=""> ${book.bookStrtDt} ~ ${book.bookEndDt}</p>
										</div>
									</div>
									<!-- 예약신청일자 -->
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 예약신청일자</h5>
										</div>
										<div class="col-md-12 col-lg-9"> 
											<p class=""><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${bookReqDt}" /></p>
										</div> 
									</div> 
									<!-- 
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 총금액</h5>
										</div>
										<div class="col-md-12 col-lg-9"> 
											<p class=""><fmt:formatNumber value="${book.bookAmt}" pattern="#,###" />원</p>
										</div> 
									</div> 
									
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 할인금액</h5>
										</div>
										<div class="col-md-12 col-lg-9"> 
											<p class=""><fmt:formatNumber value="${book.dcAmt}" pattern="#,###" />원</p>
										</div> 
									</div>  -->
									
									<!-- 결제금액 -->
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 금액</h5>
										</div>
										<div class="col-md-12 col-lg-9"> 
											<p class=""><fmt:formatNumber value="${book.payAmt}" pattern="#,###" />원</p>
										</div> 
									</div> 
									
									<!-- 입금계좌 -->
									<c:if test="${loc.accntNo != ''}">
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-3"> 
											<h5 class=""> 입금계좌</h5>
										</div>
										<div class="col-md-12 col-lg-9"> 
											<p class=""> ${loc.bankNm} ${loc.accntNo} (예금주: 주식회사 ${loc.cmpyTp})</p>
										</div> 
									</div>
									</c:if>
								</div>
							</div>
							</div>
		
							<div class="col-md-5 section-md-t3">
								<div class="icon-box">
									<div class="icon-box-icon">
										<i class="fa-solid fa-phone iconborder"></i>
									</div>
									<div class="icon-box-content table-cell">
										<div class="icon-box-title">
											<h4 class="icon-title">예약 담당자 연락처</h4>
										</div>
										<div class="icon-box-content">
											<p class="mb-1">Email.
											<span class="color-a">${loc.estEmail}</span>
											</p>
											<p class="mb-1">Phone.
											<span class="color-a">${loc.estTel}</span>
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> 
			<!--//예약확인--> 
		
			<!--예약조회-->  
			<div class="reservation_confirm" >
				<div class="title-box-d text-center"> 
					<hr/> 
					<h5 class="pt-3" > 
					<i class="fa-solid fa-circle-check"></i> <span class="bookResult">${totalCnt}건의 예약내역이 있습니다.</span>  </h5> 
				</div>
		
				<!-- 예약 목록 -->
				<div class="resultContent">
					<c:forEach items="${list}" var="bk">
					<div class="summary-list mt-3" id="move" > 
						<div class="row ">
							<div class="col-md-12 col-lg-8">  
								<!-- 예약자 -->
								<div class="row mt-2 ">
									<div class="col-md-12 col-lg-2"> 
										<h5 class=""> 예약자</h5>
									</div> 
									<div class="col-md-12 col-lg-10"> 
										<p class=""> ${bk.NAME}</p>
									</div>
								</div> 
								<!-- 장소 -->
								<div class="row mt-2 ">
									<div class="col-md-12 col-lg-2"> 
										<h5 class=""> 장소</h5>
									</div> 
									<div class="col-md-12 col-lg-10"> 
										<p class=""> ${bk.ROOM_NM}</p>
									</div>
								</div>
								<!-- 일정 -->
								<div class="row mt-2 ">
									<div class="col-md-12 col-lg-2"> 
										<h5 class=""> 일정</h5>
									</div> 
									<div class="col-md-12 col-lg-10"> 
										<p class=""> ${bk.BOOK_RESULT} 
											<span style="color:blue" onclick="showDetail(${bk.BOOK_GROUP_CD})"> [상세보기]</span>
										</p> 
									</div>
								</div>
								<!-- 금액 -->
								<div class="row mt-2 ">
									<div class="col-md-12 col-lg-2"> 
										<h5 class=""> 금액</h5>
									</div>
									<div class="col-md-12 col-lg-10"> 
										<p class=""><fmt:formatNumber value="${bk.FEE}" pattern="#,###" />원</p>
									</div> 
								</div> 
							</div>
							<!--대표이미지-->
							<div class="col-md-12 col-lg-4" > 
								<img src="/store/${bk.ROOM_IMG}" alt="" style="width:100%;border-radius:10px">
							</div> 
						</div>
					</div>
					</c:forEach> 
				</div>
				<div class="row text-center mt-3">
		            <div class="col-md-12">
		                <!-- 견적서신청 -->
		                <a href="#move">
		                    <button class="btn btn-dark btn-lg gg" >
		                        <i class="fa-solid fa-file-lines"></i> 견적서 출력
		                    </button>
		                </a>               
		            </div>
		        </div>
			</div>
		</div> 
		<!--//예약조회-->  
		
			
		<!-- ┌────────────────── 예약내역 상세보기 팝업창 ──────────────────┐ -->
		<div class="modal fade bs-example-modal-lg" id="popModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content"></div>
			</div>
		</div>
		<!-- └────────────────── 예약내역 상세보기 팝업창 ──────────────────┘ -->
	
	
	</section><!-- End  -->

</main><!-- //#main -->


<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />

<script type="text/javascript">

$( document ).ready( function() {
    $( '.estimate' ).hide(); 
    $( '.gg' ).click( function() {
        //$( '.estimate' ).show();
        window.open('/rptEstimate/${book.bookCd}');
    } );
} );

// 예약내역 상세보기
function showDetail(groupCd) {

	$(".modal-content").load('/popBookDetail/${book.bookCd}/'+groupCd).fadeIn("fast");
	$('#popModal').modal('show');  
}
</script>
</body>

</html>
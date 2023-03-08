<!-- 
예약확인/취소
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../../common/head.jsp" />

<style>
.owl-dots{display:none}
</style>

<body>
<!-- 상단 메뉴 -->
<jsp:include page="../../common/navigation.jsp" />

<main id="main">
	<!-- 상단 이미지 및 설명 -->
	<jsp:include page="../../common/top.jsp" />
	
	<!-- 페이지 설명 및 메뉴 위치 표기 -->
	<jsp:include page="../../common/intro.jsp" />

	<section class="contact">
		<div class="container">
		
			<div class="col-md-12  load_yeouido" id="payment">
				<!--예약확인-->
				<div class="row"> 
					<div class="col-sm-12 ">
						<div class="title-box-d ">
							<h3 class="title-d">예약자 확인</h3>
						</div>
						
						<div class="row">
							<div class="col-md-7">
								<form role="form" class="php-email-form" id="frmBook">
									<div class="row">
										<div class="col-md-6 mb-3">
											<!-- 예약자 성함 -->
											<div class="form-group">
												<input type="text" name="name" id="name" class="form-control form-control-lg form-control-a" placeholder="예약자 성함" data-rule="minlen:2" data-msg="성함을 입력해주세요" value="${param.name }">
												<div class="validate"></div>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<!-- 이메일주소 -->
											<div class="form-group">
												<input type="email" name="email" id="email" class="form-control form-control-lg form-control-a" placeholder="이메일주소" data-rule="email" data-msg="이메일주소를 입력해주세요" value="${param.email }">
												<div class="validate"></div>
											</div>
										</div>
		
										<div class="col-md-12 text-center">
											<button class="btn btn-dark btn-lg btn-block btn-book-srch"><i class="fa-solid fa-check"></i> 예약 조회</button>										
										</div>
									</div>
								</form>
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
											<span class="color-a">contact@example.com</span>
											</p>
											<p class="mb-1">Phone.
											<span class="color-a">+54 356 945234</span>
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
					<i class="fa-solid fa-circle-check"></i> <span class="bookResult">홍길동 님은 9건의 예약내역이 있습니다.</span>  </h5> 
				</div>
		
				<!-- 예약 목록 -->
				<div class="resultContent"></div>
				
			</div>
		</div> 
		<!--//예약조회-->  
	</section><!-- End  -->

</main><!-- //#main -->

<!-- 취소 모달 -->
<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-md" id="popModal2" role="document">
        <div class="modal-content">

        </div>
    </div>
</div>	


<jsp:include page="../../common/footer.jsp" />
<jsp:include page="../../common/script.jsp" />

<script type="text/javascript">
// 예약코드 클릭시, 상세 페이지로 이동 
function fnDetail(bookCd){	
	location.href='/bookDetailConfirm/'+bookCd;
}

// 예약취소 클릭시 
function fnBookCancel(bookCd){	
	$('.modal-dialog').draggable({
		handle: ".modal-header"
	});
		
	$(".modal-content").load('/popBookCancel/'+bookCd).fadeIn("fast");
	$('#popModal').modal('show');  
}

$( document ).ready( function() {

	$(document).ready(function($) {

		// 예약조회 
		function php_email_form_submit() {
		    $.ajax({
		        url: "/bookConfirm/result",
		        type: "post",
		        dataType: 'json',
		        data: $('#frmBook').serialize(),
		        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		        success: function(data) {
		        	console.log(data);
		        	if (data.result) {
						var divElement = "";		
						var list = data.list;
						
						// 홍길동 님은 2건의 예약내역이 있습니다.
						$(".bookResult").html($('#name').val() + '님은 ' + data.resultCnt + '건의 예약내역이 있습니다.');
			    	
						// 목록표출
						for (let i=0; i< list.length; i++) {
							var sttsClass = "";
							switch (list[i].bookSttsCd) {
								case "100001":
									// 예약신청
									sttsClass = "badge-info";
									break;
								case "100002":
									// 예약확정
									sttsClass = "badge-primary";
									break;
								case "100003":
									// 결제완료
									sttsClass = "badge-danger";
									break;
								case "100004":
									// 예약취소신청
									sttsClass = "badge-secondary";
									break;
							}
							
							divElement += '<div class="summary-list mt-3"> ';
							divElement += '<div class="row ">';
							divElement += '<div class="col-md-12 col-lg-12">';
							divElement += '<div class="row mt-2 ">';
							divElement += '<div class="col-md-12 col-lg-2"> ';
							divElement += '	<h5 class=""> 예약상태</h5>';
							divElement += '	</div>';
							divElement += '<div class="col-md-12 col-lg-10"> ';
							divElement += '<nav class="breadcrumb-box justify-content-lg-end">';
							divElement += '<span class="badge badge-pill '+sttsClass+' ml-1" >'+list[i].bookSttsNm+'</span>';
							divElement += ' </nav>';
							divElement += '	</div>';
							divElement += '</div>';
							divElement += '<div class="row mt-2 ">';
							divElement += '<div class="col-md-12 col-lg-2"> ';
							divElement += '<h5 class=""> 예약코드</h5>';
							divElement += '</div> ';
							divElement += '<div class="col-md-12 col-lg-10"> ';
							divElement += '<p class="" onclick="fnDetail('+list[i].bookCd+')" style="text-decoration : underline;">' + list[i].bookCd + '</p>';
							divElement += '</div>';
							divElement += '</div>';
							divElement += '<div class="row mt-2 ">';
							divElement += '<div class="col-md-12 col-lg-2"> ';
							divElement += '<h5 class=""> 예약일</h5>';
							divElement += '</div>';
							divElement += '	<div class="col-md-12 col-lg-10"> ';
							divElement += '		<p class="">' + list[i].bookStrtDt + ' ~ ' + list[i].bookEndDt  +  '</p>';
							divElement += '	</div>';
							divElement += '	</div>';
							divElement += '<div class="row mt-2 ">';
							divElement += '<div class="col-md-12 col-lg-2"> ';
							divElement += '	<h5 class=""> 예약신청일자</h5>';
							divElement += '	</div>';
							divElement += '<div class="col-md-12 col-lg-10"> ';
							divElement += '	<p class="">' + list[i].bookReqDt + '</p>';
							divElement += '	</div>';
							divElement += '</div>';
							divElement += '<div class="row mt-2 ">';
							divElement += '	<div class="col-md-12 col-lg-2"> ';
							divElement += '		<h5 class=""> 금액</h5>';
							divElement += '	</div>';
							divElement += '	<div class="col-md-12 col-lg-10"> ';
							divElement += '	<p class="">' + (list[i].payAmt).toLocaleString("ko-KR") + '원</p>';
							divElement += '</div> ';
							divElement += '</div> ';
							divElement += '</div>';
							divElement += '</div> ';
							
							if (list[i].bookSttsCd == "100001") {
								// 예약취소 버튼 
								divElement += '<div class="row text-right mt-1">';
								divElement += '<div class="col-md-12">';
								divElement += '<button class="btn btn-primary btn-md" onclick="fnBookCancel('+list[i].bookCd+')">';
								divElement += '<i class="fa-solid fa-xmark"></i> 예약 취소</button>'; 
								divElement += '</div>';
								divElement += '</div>';
							}
							
							divElement += '</div> ';
						}
						$(".resultContent").html(divElement);
						
						$( '.reservation_confirm' ).show();
		        	} else {
		        		alert(data.message);
		        	}
		    	              
		        },
		        error: function(data) {
		          // alert('[error] 예약중 오류가 발생하였습니다..');
		        }
		    });
		}
		
		if($("#name").val() == ""){
			$( '.reservation_confirm' ).hide(); 
		}else{
			php_email_form_submit();
		}
	});    
	
	//등록/수정 팝업창 닫힐때 ..
	$('#popModal').on('hidden.bs.modal', function () {
		php_email_form_submit();
	});
	
	$(".btn-book-srch").on("click", function() {
		php_email_form_submit();
	}); 
});
</script>

</body>

</html>
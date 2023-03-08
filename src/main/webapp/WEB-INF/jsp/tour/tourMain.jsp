<!-- 
투어신청
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
		<div class="col-md-12  load_yeouido" id="payment">
	
			<!--예약확인-->
			<hr/>
			<div class="row"> 
				<div class="col-sm-12 section-t3 ">
					<div class="row">
						<div class="col-md-7">
							<div class="title-box-d">
								<h3 class="title-d">지점 선택</h3>
							</div>
							<form id="frmTour" class="php-email-form">
							
							<select class="custom-select custom-select-lg mb-3 validation-col" id="locSeq" name="locSeq" data-msg="투어희망 지점을 선택해주세요." onchange="fnChangeLoc()">
								<option value="" selected>예약할 지점을 선택하세요</option>
								
								<c:forEach items="${locs}" var="loc">
								<option value="${loc.locSeq}" <c:if test="${loc.locSeq == locSeq }">selected</c:if>>${loc.name}</option> 
								</c:forEach>
							</select>
		
							<div class="title-box-d">
								<h3 class="title-d">희망 날짜</h3>
							</div>
							<div class="row">
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<input type="text" name="tourDt" id="tourDt" class="form-control form-control-lg form-control-a validation-col" placeholder="투어희망일자" data-msg="투어희망일자는 필수입니다.">
									</div>
								</div>
		
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<input type="text" name="tourTm" id="tourTm" class="form-control form-control-lg form-control-a validation-col" placeholder="투어희망시간"  data-msg="투어희망시간을 입력해주세요.">
									</div>
								</div>
							</div>
		
							<div class="title-box-d ">
							<h3 class="title-d">신청자 정보</h3>
							</div>
							<div class="row">
								<!-- 성함 -->
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<input type="text" name="reqNm" id="reqNm" class="form-control form-control-lg form-control-a validation-col" placeholder="신청자명" data-msg="신청자명을 입력해주세요.">
									</div>
								</div>
								<!-- 연락처 -->
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <input type="text" name="reqTel" id="reqTel"  class="form-control form-control-lg form-control-a  validation-col" placeholder="연락처" maxlength="13" data-name="tel" data-msg="연락처를 입력해주세요">                                       
                                    </div>
                                </div>
                                
								<!-- 회사명/부서 -->
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<input type="text" name="reqInfo" id="reqInfo" class="form-control form-control-lg form-control-a" placeholder="회사명/부서" >
									</div>
								</div>
								<!-- 이메일주소 -->
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<input type="email" name="reqEmail" id="reqEmail"  class="form-control form-control-lg form-control-a" placeholder="이메일주소">
									</div>
								</div>
							</div>
							<div class="title-box-d ">
                            <h3 class="title-d">요청사항</h3>
                            </div>
                            <div class="row">
                                <!-- 요청사항 -->
                                <div class="col-md-12 mb-3">
                                    <div class="form-group">
                                        <textarea name="reqCnts" id="reqCnts" class="form-control" placeholder="요청사항" rows="5" cols="45"></textarea>
                                    </div>
                                </div>
                            </div>
                        </form>
                            <div class="row">		
								<!-- 신청하기 -->
								<div class="col-md-12 text-center">
									<button type="button" class="mt-3 btn btn-dark btn-lg btn-block" id="btn-req">
										<i class="fa-solid fa-check"></i> 신청하기
									</button>        
								</div>
							</div>

						</div>
						<!--입력끝-->
		
						<!-- ┌─────────────────── 투어 담당자 연락처 ─────────────────┐ --> 
						<div class="col-md-5 section-md-t3">
							<div class="icon-box section-b2">
								<div class="icon-box-icon">
									<i class="fa-solid fa-phone iconborder"></i>
								</div>
								<div class="icon-box-content table-cell">
									<div class="icon-box-title">
										<h4 class="icon-title">투어 담당자 연락처</h4>
									</div>
									<div class="icon-box-content">
										<p class="mb-1">Email.
										<span class="color-a email">${cont.email}</span>
										</p>
										<p class="mb-1">Phone.
										<span class="color-a tel">${cont.tel}</span>
										</p>
									</div>
								</div>
							</div>
						</div>
						<!-- └────────────────── 투어 담당자 연락처 ─────────────────┘ --> 
					</div>
					<!--//예약확인--> 
				</div>
			</div>
		</div> 
	</div> 

	<!-- ┌────────────────────── 신청확인 모달 ──────────────────────┐ --> 
	<div class="modal fade floor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">투어신청확인</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-12 mt-2">
							<div class="row ">
								<div class="col-md-12 col-lg-8">
									<!-- 날짜 -->  
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-2"> 
											<h5 class=""> 날짜 </h5>
										</div>
					
										<div class="col-md-12 col-lg-10"> 
											<p class="" id="txtTourTm"> </p>
										</div>
									</div>
									<!-- 지점 -->  
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-2"> 
											<h5 class=""> 지점</h5>
										</div>
					
										<div class="col-md-12 col-lg-10"> 
											<p class="" id="txtLocNm"> </p>
										</div>
									</div>
									<!-- 신청자 -->  
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-2"> 
											<h5 class=""> 신청자</h5>
										</div> 
										<div class="col-md-12 col-lg-10"> 
											<p class="" id="txtReqNm"> </p>
										</div>
									</div>
									<!-- 연락처 -->  
									<div class="row mt-2 ">
										<div class="col-md-12 col-lg-2"> 
											<h5 class=""> 연락처</h5>
										</div>
					
										<div class="col-md-12 col-lg-10"> 
											<p class="" id="txtReqTel"> </p>
										</div> 
									</div> 
								</div>
								
								<!-- 지점 대표이미지-->
								<div class="col-md-12 col-lg-4"> 
								    <c:forEach items="${locs}" var="loc">
                                    <img src="/store/${loc.filePath1}" alt="" style="width:100%;border-radius:10px;<c:if test="${loc.locSeq ne locSeq }">display:none;</c:if>" id="repImg${loc.locSeq}" class="modalLocImg"  onerror="this.src='/img/no_image.png';" />
                                    <%-- --%> 
                                    </c:forEach>
									
								</div> 
							</div>
						</div>
					</div>
				</div>
					
				<div class="modal-footer">
					<!-- 신청하기 -->
					<button type="button" class="btn btn-primary btn-lg" id="btn-submit">신청하기</button>
					<!-- 취소 -->
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- └────────────────────── 신청확인 모달 ──────────────────────┘ --> 

</section><!-- End  -->

</main><!-- //#main -->
  
<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />

</body>
<script>

// 지점 선택시..
function fnChangeLoc(){
	
	if ($('#locSeq').val() != '') {
		// 지점 담당자 이메일, 연락처 표출 
		$.ajax({
	        url: "/loc/info/" + $('#locSeq').val(),
	        type: "post",
	        dataType: 'json',
	        contentType:"application/json; charset=utf-8",
	        success:function(data){
	        	if(data.loc != null && data.loc.locSeq != null){
	        		document.querySelector(".email").innerHTML = data.loc.estEmail;
	        		document.querySelector(".tel").innerHTML = data.loc.estTel;
	        	}        	
	        },
			error: function(data) {
				alert('처리중 오류가 발생하였습니다.');
			}
	    }); 
	} else {
		// 대표번호로 표출 
		document.querySelector(".email").innerHTML = '${cont.email}';
		document.querySelector(".tel").innerHTML = '${cont.tel}';
	}
}


//투어희망일자 달력셋팅
$('#tourDt').flatpickr({  
    locale: 'ko'
        , dateFormat: "Y-m-d"
        , minDate: moment().add(1, 'd').format() //내일부터 1년후까지만.
        , maxDate: moment().add(1, 'y').format()
        , showMonths : 1
        , defaultDate: moment().add(1, 'd').format()
    });

$('#locSeq').on('change', function(){
	$('.modalLocImg').hide();
	$('#repImg'+$(this).val()).show();
});

 //신청자 연락처 format
$('#reqTel').on("keydown, keyup", function() { 
    $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") );
});  
  
//신청하기 버튼 클릭 -> 투어신청 확인 팝업 오픈
$('#btn-req').on('click', function(){
	var flg = true;
	$('.validation-col').each(function(){
		if($(this).val() == '') {
			alert($(this).data('msg'));
			$(this).focus();
			flg = false;
			return false;
		}
		
		if ($(this).data('name') == "tel") {
			if ($(this).val().trim() == "") {
				alert($(this).data('msg'));
				$(this).focus();
				flg = false;
				return false;
			}
			
			var sTel = $(this).val().replace(/-/g, "");
			// '-' 제외 하고 자리수 체크 
			if (sTel.length < 9) {
				alert('연락처를 정확하게 입력해주세요.');
				$(this).focus();
				flg = false;
				return false;
			}
		}
	});
	
	if ($('#reqEmail').val().trim() != "") {
		emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i;
		if (!emailExp.test($('#reqEmail').val().trim())) {
			alert('이메일을 정확하게 입력해주세요.');
			$('#reqEmail').focus();
			flg = false;
			return false;
		}
	}
	
	if(flg) {
		$('#txtLocNm').text( $('#locSeq option:checked').text() );
		$('#txtTourTm').text( $('#tourDt').val() + ' ' + $('#tourTm').val());
		$('#txtReqNm').text($('#reqNm').val() + ' / ' + $('#reqInfo').val());
		$('#txtReqTel').text($('#reqTel').val() + ' / ' + $('#reqEmail').val());
		$('.floor').modal('show');
	} else {
		return false;
	}
});

//투어신청확인 팝업오픈에서 내용확인 후 실제신청하기버튼 클릭
$('#btn-submit').on('click', function(){
	$.ajax({
        url: "/tour/saveRequestTour",
        type: "post",
        dataType: 'json',
        data: $('#frmTour').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
            	alert('신청이 완료되었습니다.');
            	location.href="/main";
            } else {
            	alert(data.message);
            }
            
        },
        error: function(data) {
            alert('투어신청 중 오류가 발생하였습니다.');
        }
    });
});
</script>
</html>
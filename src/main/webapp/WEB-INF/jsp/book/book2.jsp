<!-- 
예약 2단계 (정보입력)
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
		<div class="summary-list">
		
			<!-- 예약 목록 -->
			<c:forEach items="${list}" var="book">
				<div class="row mt-2 ">
					<div class="col-md-12 col-lg-8"> 
						<span class="badge-info" style="display: block;border-radius: 15px;padding:0 10px">
						${book.prevCnts}</span>
					</div>
	
					<div class="col-md-12 col-lg-4">
						<nav class="breadcrumb-box d-flex justify-content-lg-end">
						<h4 class=""> <fmt:formatNumber value="${book.bookAmt}" pattern="#,###" />원</h4>
						</nav>
					</div>
				</div>
			</c:forEach>
		
			<hr class="hr_2border">
			<div class="row">
				<div class="col-md-12 col-lg-6"> 
					<h3 class="title-single">합계금액 </h3> 
				</div>
				<div class="col-md-12 col-lg-6">
					<nav class="breadcrumb-box d-flex justify-content-lg-end">
					<h3 class="bold"><fmt:formatNumber value="${totalAmt}" pattern="#,###" />원 </h3>
					</nav>
				</div>
			</div>
		</div>

		<!--정보입력-->
        <div class="row">

		<div class="col-sm-12 section-t3 ">
			<div class="title-box-d ">
				<h3 class="title-d">예약 정보</h3>
			</div>
			<div class="row">
	
			<div class="col-md-7">
				<form action="/makeBook" method="post" role="form" class="php-email-form" id="frmBook">
				<input type="hidden" name="bookTempCd" id="bookCd" value="${bookCd}"/>
					<div class="row">
						<div class="col-md-6 mb-3">
							<!-- 예약자 성함 -->
							<div class="form-group">
								<input type="text" name="name" id="name" class="form-control form-control-lg form-control-a" placeholder="예약자 성함" data-rule="minlen:2" data-msg="성함을 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<!-- 이메일주소 -->
							<div class="form-group">
								<input type="text" name="email" id="email" class="form-control form-control-lg form-control-a" placeholder="이메일주소" data-rule="email" data-msg="이메일주소를 정확하게 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						<div class="col-md-12 mb-3">
							<!-- 연락처 -->
							<div class="form-group">
								<input type="text" name="tel" id="tel" class="form-control form-control-lg form-control-a" placeholder="연락처" maxlength="13" data-rule="tel:9" data-msg="연락처를 정확하게 입력해주세요">
								<div class="validate"></div>
							</div>
						</div>
						<div class="col-md-12">
							<!-- 요청사항 -->
							<div class="form-group">
								<textarea class="form-control" name="reqCnts" id="reqCnts" cols="45" rows="8" placeholder="업체에 요청하실 내용이 있다면 적어주세요"></textarea>
								<div class="validate"></div>
							</div>
						</div>
						
						<!-- 개인정보취급방침 -->
						<div class="col-md-12">
							<p class="fs16 colorblack bold">개인정보취급방침</p>
							<div class="contant txt_privacy">
								<jsp:include page="../common/privacy.jsp" />
							</div>
					     	
							<div class="agree_btm mt-3 tl">        
								<div class="validate validate_privacy"></div>   
								
								<div class="form-check form-check-inline form-group">
									<input class="form-check-input" type="radio" name="privacyYn" id="privacy1" value="Y">
									<label class="form-check-label" for="privacy1">동의합니다</label>
								</div>
								<div class="form-check form-check-inline form-group">
									<input class="form-check-input" type="radio" name="privacyYn" id="privacy2" value="N"  data-rule="checked" data-msg="개인정보취급방침에 동의가 필요합니다" checked>
									<label class="form-check-label" for="privacy2">동의하지 않습니다.</label>
								</div>
							</div>
						</div>
						<!-- //개인정보취급방침 -->
				
						<div class="col-md-12 text-center">
							<!-- 예약완료 버튼 -->
							<button type="submit" class="mt-3 btn btn-dark btn-lg btn-block btn-next">
								<i class="fa-solid fa-check"></i> 예약 완료
							</button>
						</div>
					</div>
				</form>
			</div>
	
			<div class="col-md-5 section-md-t3">
				<div class="icon-box section-b2">
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
				
				<div class="icon-box section-b2">
					<div class="icon-box-icon">
						<i class="fa-solid fa-location-dot iconborder"></i>
					</div> 
					<div class="icon-box-content table-cell">
						<div class="icon-box-title">
							<h4 class="icon-title">Contact</h4>
						</div>
						<div class="icon-box-content">
							<p class="mb-1">
							${loc.addr}
							<br/> ${loc.tel}
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
		</div>
	</div>
	</section><!-- End Contact Single-->

</main><!-- End #main -->


<jsp:include page="../common/footer.jsp" />
<jsp:include page="../common/script.jsp" />


</body>
<script>
// 연락처 format
$('#tel').on("keydown, keyup", function() {     
    $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") );
});  
  
$(document).ready(function($) {
	
	// 예약확인 페이지에서 뒤로가기 눌렀을때를 대비하여 로직 추가
	var bookList = ${listSize};
	if (bookList <= 0) {
		alert('예약데이터가 존재하지않습니다.');
		location.href="/main";
	}
	// end. 

	$('form.php-email-form').submit(function(e) {
		e.preventDefault();
	
		var f = $(this).find('.form-group'),
		ferror = false,
		emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i;
	
		f.children('input').each(function() { // run all inputs
	
			var i = $(this); // current input
			var rule = i.attr('data-rule');
			
			if (rule !== undefined) {
				var ierror = false; // error flag for current input
				var pos = rule.indexOf(':', 0);
				if (pos >= 0) {
					var exp = rule.substr(pos + 1, rule.length);
					rule = rule.substr(0, pos);
				} else {
					rule = rule.substr(pos + 1, rule.length);
				}

				var sErrorMsg = "";
		
				switch (rule) {
					case 'minlen':
						if (i.val().length < parseInt(exp)) ferror = ierror = true;
					break;
					
					case 'email':
						if (!emailExp.test(i.val().trim())) ferror = ierror = true;
					break;
					
					case 'tel':
						var sTel = i.val().replace(/-/g, "");
						
						// '-' 제외 하고 자리수 체크 
						if (sTel.length < parseInt(exp)) ferror = ierror = true;
					
					break;
					
					case 'checked':
						var radioVal = $('input[name="'+i[0].name+'"]:checked').val();
						if (radioVal == "N") ferror = ierror = true;
					break;
				}
				
				if (rule == 'checked') {
					$('.validate_privacy').html((ierror ? (i.attr('data-msg') !== undefined ? i.attr('data-msg') : 'wrong Input') : '')).show('blind');
				} else if (rule == 'tel') {
					
					if (ierror) {
						if (i.val().trim() == "") {
							sErrorMsg = '핸드폰 번호를 입력해주세요';
						} else {
							if (i.attr('data-msg') !== undefined) {
								sErrorMsg = i.attr('data-msg'); 
							} else {
								sErrorMsg = 'wrong Input';
							}
						}
					} 
					
					i.next('.validate').html(sErrorMsg).show('blind');
			
				} else if (rule == 'email') {
					
					if (ierror) {
						if (i.val().trim() == "") {
							sErrorMsg = '이메일주소를 입력해주세요';
						} else {
							if (i.attr('data-msg') !== undefined) {
								sErrorMsg = i.attr('data-msg'); 
							} else {
								sErrorMsg = 'wrong Input';
							}
						}
					} 
					
					i.next('.validate').html(sErrorMsg).show('blind');
			
				} else {
					i.next('.validate').html((ierror ? (i.attr('data-msg') !== undefined ? i.attr('data-msg') : 'wrong Input') : '')).show('blind');
				}
			}
		});
	
		if (ferror) return false;
		
		var this_form = $(this);
		var action = $(this).attr('action');
	
		if( ! action ) return false;
	
		this_form.find('.sent-message').slideUp();
		this_form.find('.error-message').slideUp();
		this_form.find('.loading').slideDown();
	
		if ( $(this).data('recaptcha-site-key') ) {
			var recaptcha_site_key = $(this).data('recaptcha-site-key');
			grecaptcha.ready(function() {
				grecaptcha.execute(recaptcha_site_key, {action: 'php_email_form_submit'}).then(function(token) {
					php_email_form_submit(this_form,action,this_form.serialize() + '&recaptcha-response=' + token);
				});
			});
		} else {
			php_email_form_submit(this_form,action,this_form.serialize());
		}
	
		return true;
	});

	// 예약완료 처리 
	function php_email_form_submit(this_form, action, data) {
	
	    $.ajax({
	        url: action + "/" + ${locSeq},
	        type: "post",
	        dataType: 'json',
	        data: $('#frmBook').serialize(),
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        success: function(data) {
	    	
	            if(data.result && data.bookCd != ""){
					// 예약 성공시, 다음 페이지로 이동 
					location.href="/resultBook/"+data.bookCd+"/"+data.locSeq;
	            } else {
	                alert(data.message);                    
	            }                
	        },
	        error: function(data) {
	           alert('[error] 예약중 오류가 발생하였습니다..');
	        }
	    });
	}
});    


</script>
</html>
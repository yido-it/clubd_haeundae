<!-- 
관리자 > 투어신청관리 > 상세보기
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">
			투어신청 상세
		</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<!-- <h4 class="card-title">Horizontal Two column</h4> -->
		<form class="form-sample" id="frmTourDetail">
		<input type="hidden" name="tourSeq" id="tourSeq" value="${tour.tourSeq}" />
			<!-- <p class="card-description"> Personal info </p> -->
			
			<div class="row">
				<!-- 신청상태 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">신청상태</label>
						<div class="col-sm-9">
							<select class="form-select" id="reqSttsCd" name="reqSttsCd" data-colname="신청상태">				
								<c:forEach items="${reqSttsList}" var="reqStts">
									<option value="${reqStts.cmnCd}" <c:if test="${tour.reqSttsCd == reqStts.cmnCd}">selected</c:if>>${reqStts.cmnNm}</option> 
								</c:forEach>
							</select> 
						</div>
					</div>
				</div>
				
				<div class="col-md-8"></div>
			</div>
			
			
			<div class="row">
				<!-- 지점 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">지점</label>
						<div class="col-sm-9">
							<select class="form-select" id="locSeq" name="locSeq" data-colname="지점" >				
								<c:forEach items="${locs}" var="loc">
									<option value="${loc.locSeq}" <c:if test="${tour.tourSeq == loc.locSeq}">selected</c:if>>${loc.name}</option> 
								</c:forEach>
							</select> 
						</div>
					</div>
				</div>
			
				<!-- 투어일자 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">투어일자</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="tourDt" id="tourDt" data-colname="투어일자" 
								value="${tour.tourDt}" />
						</div>
					</div>
				</div>
				
				<!-- 투어시간 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">투어시간</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="tourTm" id="tourTm" data-colname="투어시간" 
								value="${tour.tourTm}"/>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<!-- 신청자 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">신청자</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="reqNm" id="reqNm" data-colname="신청자" 
								value="${tour.reqNm}"/>
						</div>
					</div>
				</div>
				<!-- 연락처 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">연락처</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="reqTel" id="reqTel" data-colname="연락처" 
								value="${tour.reqTel}"/>
						</div>
					</div>
				</div>
				<!-- 이메일 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">이메일</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="reqEmail" id="reqEmail"
								value="${tour.reqEmail}"/>
						</div>
					</div>
				</div>
			</div>
				
			<div class="row">
				<!-- 회사/부서 -->
				<div class="col-md-12">
					<div class="form-group row">
						<label class="col-sm-1 col-form-label">회사/부서</label>
						<div class="col-sm-11">
							<input type="text" class="form-control form-control-sm col-valid" name="reqInfo" id="reqInfo" 
								value="${tour.reqInfo}"/>
						</div>
					</div>
				</div>
			</div>
		
			<div class="row">
				<!-- 요청사항 -->
				<div class="col-md-12">
					<div class="form-group row">
						<label class="col-sm-1 col-form-label">요청사항</label>
						<div class="col-sm-11">
							<textarea class="form-control" cols="50" rows="3" id="reqCnts" name="reqCnts" style="padding:5px;resize: vertical;">${tour.reqCnts}</textarea>
							
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
		
	<div class="modal-footer">
		<!-- 저장 -->
		<button type="button" class="btn btn-primary btnSave">
			<i class="far fa-check-circle"></i>저장
		</button>
		<!-- 닫기 -->
		<button type="button" class="btn btn-outline-light btnClose">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>
//연락처 format
$('#reqTel').on("keydown, keyup", function() { 
    $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^0[0-9]{2})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") ); 
});  
  
// 저장 버튼 클릭
$('.btnSave').on('click', function(){
	
	// 빈값확인
    var rtnCd = false;
    $('.col-valid').each(function(){
        if($(this).val()=='' && $(this).data('colname') != undefined) {
            alert($(this).data('colname') + '을(를) 입력해주세요.');
            rtnCd = true;
            return false;
        }
    });
    if(rtnCd) return;
   
	var email = $('#reqEmail').val().trim();
	if(email != ''){
		emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i;
		if (!emailExp.test(email)) {
			alert('이메일을 정확하게 입력해주세요.');
			return;
		}
	}
	
    $.ajax({
        url: "/admin/updateTour",
        type: "post",
        dataType: 'json',
        data: $('#frmTourDetail').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('저장이 완료되었습니다.');
                $('#popModal').modal('hide');
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('투어신청 정보 변경 처리중 오류가 발생하였습니다.');
        }
    });
});

//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
});

var dateSelector = document.querySelector('#tourDt');

//오늘 날짜 
var today = getToDay('-');
var fp = dateSelector.flatpickr({  
	 locale: 'ko'
	, mode: "single" 
	, dateFormat: "Y-m-d"
	, confirmIcon: "<i class='fa fa-check'></i>"
	, showMonths : 1
	, defaultDate: today
});

</script>



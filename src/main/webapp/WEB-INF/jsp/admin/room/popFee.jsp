<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">이용요금 입력</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<form id="frmFee">
		<input type="hidden" name="feeSeq" id="feeSeq" value="${info.feeSeq}"/>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-5 col-form-label">시작일자</label>
						<div class="col-sm-7">
							<input type="text" class="form-control col-valid" name="strtDt" id="strtDt" data-colname="시작일자"/>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-5 col-form-label">주간요금(9~18)</label>
						<div class="col-sm-7">
							<input type="number" class="form-control col-valid" name="basicFee" id="basicFee" 
								data-colname="주간요금" value="${info.basicFee}" min="0" max="9999999999" maxlength="10" oninput="maxLengthCheck(this);" />
							<input type="hidden" name="basicHr" value="60"/>
		
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-5 col-form-label">야간요금(18~22)</label>
						<div class="col-sm-7">
							<input type="number" class="form-control" name="nightFee" id="nightFee" value="${info.nightFee}" min="0" max="9999999999" maxlength="10" oninput="maxLengthCheck(this);" />
							
						</div>
					</div>
				</div>
			</div>
			
			<div class="guideTxt" style="display:none">
				<span style="color:red; font-weight:bold; font-size:0.875rem">※ 시작일자가 오늘이전인 경우는 요금 수정 불가능합니다.</span>
			</div>
		</form>
	</div>
	<div class="modal-footer">
		<c:if test='${info.feeSeq == null}'>
		<button type="button" class="btn btn-primary btn-save-fee">
			<i class="far fa-check-circle"></i>저장
		</button>
		</c:if>
		<c:if test='${info.feeSeq != null}'>
		<button type="button" class="btn btn-primary btn-modify-fee">
			<i class="far fa-check-circle"></i>수정
		</button>
		</c:if>
		<button type="button" class="btn btn-outline-light btn-close-fee" data-type='popFee'>
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>
$("document").ready(function() {
	var today = getToDay('-');
	
	if (today < $("#strtDt").val()) {
		//console.log('요금 수정가능');
	} else {
		//console.log('요금 수정불가능');
		$("#basicFee").attr("disabled", true); 
		$("#nightFee").attr("disabled", true); 
		$(".btn-save-fee").attr("disabled", true); 
		$(".guideTxt").css("display", "inline"); 
		
	}
});


var _popRtnData;

if($("#strtDt").val() == ""){
	$("#strtDt").val(formatDate());
}

function padTo2Digits(num) {
  return num.toString().padStart(2, '0');
}

function formatDate(date = new Date()) {
  return [
    date.getFullYear(),
    padTo2Digits(date.getMonth() + 1),
    padTo2Digits(date.getDate()),
  ].join('-');
}

// 저장버튼 클릭
$('.btn-save-fee').on('click', function(){
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
    
    var tableData = table.getSelectedData()[0];
    
    var sUrl = "/admin/insertFee";
    
    $.ajax({
        url: "/admin/selectSameDateFeeCnt",
        type: "post",
        dataType: 'json',
        data: $('#frmFee').serialize()
        	  + "&locSeq="+tableData.locSeq
        	  + "&roomSeq="+tableData.roomSeq
        	  ,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
        	//같은 날에 한 건이라도 등록되어 있다면
        	if(data > 0){
        		if(confirm("같은 날에 이미 입력된 요금이 있습니다. 업데이트 할까요?")){
            		sUrl = "/admin/updateSameFee";
            		fnSaveFee(sUrl, tableData.locSeq, tableData.roomSeq);
        		}
        		
        	}else{
        		//없으면 신규이므로 sUrl 유지.
        		fnSaveFee(sUrl, tableData.locSeq, tableData.roomSeq);
        	}
        },
        error: function(data) {
            alert('등록된 요금 조회중 오류가 발생하였습니다.');
        }
    });
});

function fnSaveFee(sUrl, nLocSeq, nRoomSeq){
	
	$.ajax({
        url: sUrl,
        type: "post",
        dataType: 'json',
        data: $('#frmFee').serialize()
        	  + "&locSeq="+nLocSeq
        	  + "&roomSeq="+nRoomSeq
        	  ,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('저장이 완료되었습니다.');
                _popRtnData = "complete";
                popObj = $('.btn-close-fee');
                $('#popModal').modal('hide');
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('요금 등록(수정)중 오류가 발생하였습니다.');
        }
    });
}

// 수정 버튼 클릭
$('.btn-modify-fee').on('click', function(){
	//빈값확인
    var rtnCd = false;
    $('.col-valid').each(function(){
        if($(this).val()=='' && $(this).data('colname') != undefined) {
            alert($(this).data('colname') + '을(를) 입력해주세요.');
            rtnCd = true;
            return false;
        }
    });
    if(rtnCd) return;

	if(table.getSelectedData() == null || table.getSelectedData() == ""){
		alert("회의실이 선택되지 않았습니다. 회의실을 선택해 주세요.");
		return;
	}

    var tableData = table.getSelectedData()[0];
    
	$.ajax({
        url: "/admin/updateFee",
        type: "post",
        dataType: 'json',
        data: $('#frmFee').serialize()
			  	  + "&locSeq="+tableData.locSeq
				  + "&roomSeq="+tableData.roomSeq
				  ,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('수정이 완료되었습니다.');
                _popRtnData = "complete";
                popObj = $('.btn-close-fee');
                $('#popModal').modal('hide');
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('요금 수정중 오류가 발생하였습니다.');
        }
    });
});

//팝업닫기버튼
$('.btn-close-fee').on('click', function(){
	popObj = $(this);
	$('#popModal').modal('hide');
});

//number에서 maxlength 효과주기
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }    
}

var dateSelector = document.querySelector('#strtDt');

//내일 날짜 
var tomorrow = getToTomorrow('-');
var fp = dateSelector.flatpickr({  
	 locale: 'ko'
	, mode: "single" 
	, dateFormat: "Y-m-d"
	, confirmIcon: "<i class='fa fa-check'></i>"
	, showMonths : 1
	, defaultDate: tomorrow 
});

if ("${info.strtDt}" != null && "${info.strtDt}" != "") {
	$('#strtDt').val("${info.strtDt}");
}

</script>

<style>
.border-red {
	border-color: red
}

.input-group-text {
	min-width: 120;
}
.required {
	color: red;
	padding-left: 5px;
	padding-right: 5px;
	font-size: 6px;
}
</style>

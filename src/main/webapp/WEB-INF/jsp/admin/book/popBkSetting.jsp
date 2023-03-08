<!-- 
예약세팅 팝업창
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">
			예약세팅 
		</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<!-- <h4 class="card-title">Horizontal Two column</h4> -->
		<form class="form-sample" id="frmBkSetting">
			<!-- <p class="card-description"> Personal info </p> -->
			<div class="row">
				<div class="col-md-12">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">예약일자</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="bookDt" id="bookDt" data-colname="예약일자" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
			
				<!-- 지점 -->
				<div class="col-md-12">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">지점</label>
						<div class="col-sm-9">
							<select class="form-select col-valid" name="locSeq" id="locSeq" onchange="fnChageLoc()" data-colname="지점">
								<option value="" selected>선택</option>
								<c:forEach items="${locs}" var="loc">
									<option value="${loc.locSeq}"> ${loc.name} </option> 
								</c:forEach>
							</select>	
						</div>
					</div>
				</div>
			</div>
			<div class="row">
			
				<!-- 회의실 -->
				<div class="col-md-12">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">회의실</label>
						<div class="col-sm-9">
							<select class="form-select" name="roomSeq" id="roomSeq">
								<option value="" selected>지점을 선택해주세요.</option>
							</select>		
						</div>
					</div>
				</div>
			
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="form-group row">
						<div class="col-sm-3">
							<div class="form-check">
								<label class="form-check-label"  style="margin-top:20px">
								<input type="radio" class="form-check-input" name="settingType" id="settingType_1" value="1" checked>
								기본설정
								<i class="input-helper"></i></label>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-check">
								<label class="form-check-label" style="margin-top:20px">
								<input type="radio" class="form-check-input" name="settingType" id="settingType_2" value="2">
								복사
								<i class="input-helper"></i></label>
							</div>
						</div>
						
						<div class="col-sm-4">
							<!-- 복사할 날짜 -->
							<div class="form-check">							
								<input type="text" class="form-control form-control-sm col-valid" id="copyBookDt" name="copyBookDt" 
									style="width:150px;display:inline-block" data-colname="복사할날짜"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="row">
				<div class="col-md-12">
					<p class="text-danger">※ 예약일자에 포함되는 기존 데이터가 이미 존재하는 경우 모두 삭제 후 재등록 됩니다.</p>
				</div>
			</div>
				
		</form>
	</div>
		
	<div class="modal-footer">
		<!-- 등록 -->
		<button type="button" class="btn btn-primary btn-save">
			<i class="far fa-check-circle"></i> 설정하기 
		</button>
		<!-- 닫기 -->
		<button type="button" class="btn btn-outline-light btn-close">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>
  
// 지점 선택시 해당 지점에 대한 회의실 목록을 가져온다
function fnChageLoc() {
	
	if ($('#locSeq').val() == null || $('#locSeq').val() == "") {
		return;
	}

    $.ajax({
        url: "/room/list",
        type: "post",
        dataType: 'json',
        data: { "locSeq" : $('#locSeq').val() },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
        	var rooms = data.rooms;
        
        	var selectElement = "<option value='' selected>선택</option>";
        	if ( rooms.length == 0 ) {
        		selectElement = "<option value='' selected>등록된 회의실이 없습니다</option>";
        	} else {
	        	for (let i=0; i< rooms.length; i++) {
	            	selectElement += "<option value='"+rooms[i].roomSeq+"'>"+rooms[i].name+"</option>";            	
	            }
        	}
        	document.querySelector("#roomSeq").innerHTML = selectElement;            
        },
        error: function(data) {
            // 
        }
    });
}

// 설정하기 버튼 클릭
$('.btn-save').on('click', function(){
	
	// 빈값확인
    var rtnCd = false;
    $('.col-valid').each(function(){
        if($(this).val()=='' && $(this).data('colname') != undefined) {
            alert($(this).data('colname') + '을(를) 선택해주세요.');
            rtnCd = true;
            return false;
        }
    });
    if(rtnCd) return;
    
   	if ($('input[name=settingType]:checked').val() == 2 && $('#roomSeq').val() == ""){
   		// 복사를 선택한 경우에는 회의실을 선택하도록 한다 
   		alert('복사를 하실 경우에는 회의실을 선택해주세요.');
        return false;
   	}
     
    var settingType = $("input[name='settingType']:checked").val();
    var message = "";
    
    if (settingType == 1) {
    	message = "기본설정의 경우 지점에 대한 운영시간 및 요금으로 데이터가 자동 생성 됩니다. 설정하시겠습니까?";
    } else if (settingType == 2) {
    	
   		message += "일자: " + $('#copyBookDt').val() ;
   		message += "\n지점: " + $("#locSeq option:checked").text();
   		message += "\n회의실: " + $("#roomSeq option:checked").text();
   
    	
    	message = message + "\n\n세팅정보를 위 내용 기준으로 그대로 복사합니다. 설정하시겠습니까?";
    }
    
    if(confirm(message)){
        $.ajax({
            url: "/admin/bkSetting",
            type: "post",
            dataType: 'json',
            data: { 
            	"bookDt" : $('#bookDt').val() 
            	, "locSeq" : $('#locSeq').val() 
            	, "roomSeq" : $('#roomSeq').val() 
            	, "copyBookDt" : $('#copyBookDt').val() 
            	, "settingType" : settingType
            },  
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
            success: function(data) {
                if(data.result){
                    /*
                    if($('#bookSeq').val() != '') {
                        alert('수정이 완료되었습니다.');
                    } else {
                        alert('등록이 완료되었습니다.');   	 
                    }   
                    */
                    
                    $('#popModal').modal('hide');
                } else {
                    alert(data.message);                    
                }                
            },
            error: function(data) {
                alert('설정중 오류가 발생하였습니다.');
            }
        });
    }
});


//팝업닫기버튼
$('.btn-close').on('click', function(){
	$('#popModal').modal('hide');
});
  

//오늘 날짜 
var today = getToDay('-');

// 예약일자 
var dateSelector = document.querySelector('#bookDt');

var fp = dateSelector.flatpickr({  
	 locale: 'ko'
	, mode: "range" 
	, dateFormat: "Y-m-d"
	, conjunction: " ~ "
	, confirmIcon: "<i class='fa fa-check'></i>" 
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

// 복사일자 
var dateSelector = document.querySelector('#copyBookDt');

var fp = dateSelector.flatpickr({  
	 locale: 'ko'
	, mode: "single" 
	, dateFormat: "Y-m-d"
	, confirmIcon: "<i class='fa fa-check'></i>" 
	, showMonths : 1
	, defaultDate: today
});

</script>


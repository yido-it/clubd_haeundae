<!-- 
예약설정 등록/수정 팝업창
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">
			예약설정 
			${bkDetail.bookSeq == null ? "등록" : "수정"} 
		</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<!-- <h4 class="card-title">Horizontal Two column</h4> -->
		<form class="form-sample" id="frmBookDetail">
		<input type="hidden" name="pBookSeq" id="pBookSeq" value="${bkDetail.bookSeq}" />
		<input type="hidden" name="pBookDt" id="pBookDt" value="${bkDetail.bookDt}" />
			<!-- <p class="card-description"> Personal info </p> -->
			<div class="row">
				<!-- 지점 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">지점</label>
						<div class="col-sm-9">
							<c:if test="${bkDetail.bookSeq == null}">
								<!-- 등록 -->
								<select class="form-select col-valid" name="locSeq" id="locSeq" onchange="fnChageLoc()" data-colname="지점">
									<option value="" selected>선택</option>
									<c:forEach items="${locs}" var="loc">
										<option value="${loc.locSeq}"> ${loc.name} </option> 
									</c:forEach>
								</select>							
							</c:if> 
							
							<c:if test="${bkDetail.bookSeq != null}">
								<!-- 수정 -->
								<input type="text" class="form-control col-valid" value="${bkDetail.locNm}" readonly/>
								<input type="hidden" name="locSeq" id="locSeq" value="${bkDetail.locSeq}"/>
							</c:if> 
						</div>
					</div>
				</div>
				<!-- 회의실 -->
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">회의실</label>
						<div class="col-sm-9">
						
							<c:if test="${bkDetail.bookSeq == null}">
								<!-- 등록 -->
								<select class="form-select col-valid" name="roomSeq" id="roomSeq" onchange="fnGetFee()" data-colname="회의실">
									<option value="" selected>지점을 선택해주세요.</option>
								</select>							
							</c:if> 
							
							<c:if test="${bkDetail.bookSeq != null}">
								<!-- 수정 -->
								<input type="text" class="form-control col-valid" value="${bkDetail.roomNm}" readonly/>
								<input type="hidden" name="roomSeq" id="roomSeq" value="${bkDetail.roomSeq}"/>
							</c:if> 
						</div>
					</div>
				</div>
			
				<div class="col-md-4"></div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">예약일자</label>
						<div class="col-sm-9">
							<input type="text" class="form-control form-control-sm col-valid" name="bookDt" id="bookDt" onchange="fnGetFee()" data-colname="예약일자" 
								value="${bkDetail.bookDt}" <c:if test="${bkDetail.bookSeq != null}">readonly</c:if>  />
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">시작시간</label>
						<div class="col-sm-9">
							<select class="form-select col-valid" name="strtTm" id="strtTm" data-colname="시작시간" onchange="fnStrtTm()" >
								<option value="">선택</option>
								<c:forEach items="${timeMap}" var="time">
									<option value="${time.value}" <c:if test="${bkDetail.strtTm==time.value}">selected</c:if>>${time.value}</option>
								</c:forEach>
							</select>
							<input type="hidden" name="oriStrtTm" id="oriStrtTm" value="${bkDetail.strtTm}"/>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">종료시간</label>
						<div class="col-sm-9">
							<select class="form-select col-valid" name="endTm" id="endTm" data-colname="종료시간">
								<option value="">선택</option>
								<c:forEach items="${timeMap}" var="time">
									<option value="${time.value}" <c:if test="${bkDetail.endTm==time.value}">selected</c:if>>${time.value}</option>
								</c:forEach>	
							</select>
							<input type="hidden" name="oriEndTm" id="oriEndTm" value="${bkDetail.endTm}"/>
						</div>
					</div>
				</div>
			</div>
				
			<div class="row">
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">금액</label>
						<div class="col-sm-9">
							<input type="number" class="form-control form-control-sm col-valid" name="fee" id="fee" data-colname="금액" value="${bkDetail.fee}"/>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">오픈여부</label>
						<div class="col-sm-4">
							<div class="form-check">
								<label class="form-check-label"  style="margin-top:15px">
								<input type="radio" class="form-check-input" name="openYn" id="openYn_N" value="X"
									 ${bkDetail.bookSeq == null ? "checked": bkDetail.bookSeq != null && bkDetail.openYn == "X" ? "checked": ""}>
								미오픈
								<i class="input-helper"></i></label>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-check">
								<label class="form-check-label" style="margin-top:15px">
								<input type="radio" class="form-check-input" name="openYn" id="openYn_Y" value="O"
									 ${bkDetail.bookSeq != null && bkDetail.openYn == "O" ? "checked": ""}>
								오픈
								<i class="input-helper"></i></label>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4"></div>
			</div>
		
		</form>
	</div>
		
	<div class="modal-footer">
		<!-- 등록 / 수정 -->
		<button type="button" class="btn btn-primary btnSave">
			<i class="far fa-check-circle"></i>
			 ${bkDetail.bookSeq == null ? "등록" : "수정"}
		</button>
		<!-- 삭제 -->
		<c:if test="${bkDetail.bookSeq != null}">
			<button type="button" class="btn btn-outline-danger btn-fw btnDel">
				<i class="far fa-check-circle"></i> 삭제
			</button>
		</c:if>
		<!-- 닫기 -->
		<button type="button" class="btn btn-outline-light btnClose">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>
  
// 지점 선택시 해당 지점에 대한 회의실 목록을 가져온다
function fnChageLoc() {
	$('#fee').val("");
	
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

// 회의실 & 예약일자 선택시 해당 회의실에 대한 요금 정보를 가져온다
// 예약날짜가 요금설정 기간에 포함되는 데이터를 가져와야함 
function fnGetFee() {
	
	if ($('#roomSeq').val() == null || $('#roomSeq').val() == "") {
		return;
	}
	
	$.ajax({
		url: "/fee/getFee",
		type: "post",
		dataType: 'json',
		data: { 
			"roomSeq" : $('#roomSeq').val() 
			, "bookDt" : $('#bookDt').val() 
		},
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		success: function(data) {
			var basicFee = data.basicFee;
	
			$('#fee').val(basicFee);
		},
		error: function(data) {
			// 
		}
	});
		
}

// 등록 or 수정 버튼 클릭
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
    
    // 시작시간, 종료시간  비교 
    var bookDt = $('#bookDt').val();
    var strtTm = $('#strtTm').val();
    var endTm = $('#endTm').val();
    
  	const date1 = new Date(bookDt.substr(0,4), bookDt.substr(5,2), bookDt.substr(8,2), strtTm.substr(0,2) , strtTm.substr(3,2), 0);
  	const date2 = new Date(bookDt.substr(0,4), bookDt.substr(5,2), bookDt.substr(8,2), endTm.substr(0,2) , endTm.substr(3,2), 0);
  
  	const elapsedMSec = date2.getTime() - date1.getTime(); // 9004000
  	const elapsedSec = elapsedMSec / 1000; // 9004
  	const elapsedMin = elapsedMSec / 1000 / 60; 
  	 
  	//console.log('elapsedMin: ' + elapsedMin);
    if ( elapsedMin > 60 || elapsedMin < 60 ) {
    	alert('1시간단위로 등록해주세요. \n또한, 시작시간은 종료시간보다 클 수 없습니다.');
    	return;
    }
  
    var ajaxUrl = '';
    if($('#pBookSeq').val() != '') {
    	// 수정
    	ajaxUrl = "/admin/updateBookSetting";
    	
    	// 수정인데 시간 변경하지 않았으면 중복체크하지 않는다
    	if ( $('#oriStrtTm').val() != $('#strtTm').val() || $('#oriEndTm').val() != $('#endTm').val() ) {
    		ajaxUrl += "?updateTime=Y";
    	}
    } else {
    	// 등록 
    	ajaxUrl = "/admin/insertBookDetail";       	 
    }      
    	
    // console.log($('#frmBookDetail').serialize());
    $.ajax({
        url: ajaxUrl,
        type: "post",
        dataType: 'json',
        data: $('#frmBookDetail').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                
                if($('#pBookSeq').val() != '') {
                    alert('수정이 완료되었습니다.');
                } else {
                    alert('등록이 완료되었습니다.');   	 
                }    
                
                $('#popModal').modal('hide');
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('등록중 오류가 발생하였습니다.');
        }
    });
});

// 삭제 버튼 클릭 
$('.btnDel').on('click', function(){
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
	        url: "/admin/deleteBookSetting",
	        type: "post",
	        dataType: 'json',
	        data: {bookSeq: $('#pBookSeq').val()},
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        success: function(data) {
	            if(data.result == false){
	                alert(data.message);
	            } else {
	                alert('삭제되었습니다.');
	                $('#popModal').modal('hide');
	                table.setData();
	            }                
	        },
	        error: function(data) {
	            alert('삭제중 오류가 발생하였습니다.');
	        }
	    });
	}
});

//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
});

// 시작시간 선택시 종료시간 자동으로 1시간 이후로 선택되도록 
function fnStrtTm() {
	var strtTm = $('#strtTm').val();
	var endTm = Number(strtTm.substr(0,2)) + 1;
	
	if (endTm < 10) endTm = "0" + endTm;
	$('#endTm').val(endTm + ":00");
}

var dateSelector = document.querySelector('#bookDt');

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

if($('#pBookSeq').val() != '') {
	// 수정
	$('#bookDt').val($('#pBookDt').val());
} else {
	// 등록 
	$('#bookDt').val(today); 
}

</script>



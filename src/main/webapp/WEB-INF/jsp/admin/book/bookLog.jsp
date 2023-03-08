<!-- 
관리자 > 예약관리 > 예약이력
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="../../common/admin/head.jsp"/>
<jsp:include page="../../common/admin/script.jsp"/>
<body>
<div class="container-scroller">
<!-- 상단 -->
<jsp:include page="../../common/admin/top.jsp" />
	
	<div class="container-fluid page-body-wrapper">
		<!-- 좌측메뉴 -->
		<jsp:include page="../../common/admin/menu.jsp" />
			
		<div class="main-panel">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-md-6 grid-margin-sm-0">
						<div class="row">
							<div class="col-12 col-xl-8 mb-4 mb-xl-0">
								<h5 class="font-weight-bold">예약이력</h5>
							</div>
						</div>
					</div>
					<div class="col-md-6 grid-margin-sm-0" style="text-align:right">
						<div class="row">
							<div class="col-12 col-xl-12 mb-12 mb-xl-0">
								<span class="menuRoute">예약관리 > 예약이력</span>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-margin">		
					<!-- 조회 -->
					<div class="row">	
						
						<!-- 일자 -->					
						<div class="col-lg-6 col-xl-3">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">일자</label>
								<div class="col-xl-9">
									<input type="text" class="form-control form-control-sm" id="searchBookDt" name="searchBookDt" />
								</div>
							</div>
						</div>			
						<!-- 지점 -->					
						<div class="col-lg-6 col-xl-3">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">지점</label>
								<div class="col-xl-9">
								
									<select class="form-select" id="searchLocSeq" name="searchLocSeq" onchange="fnSearch()" >
									<option value="" selected>전체</option>
									
									<c:forEach items="${locs}" var="loc">
										<option value="${loc.locSeq}">${loc.name}</option> 
									</c:forEach>
									</select> 
								</div>
							</div>
						</div>		
					</div>
					<!-- // 조회 -->
					
					<!-- 목록 -->
					<div class="row">
						<div class="col-12">
						   <div id="tabList" class="is-bordered"></div>
						</div>
					</div>
		
				</div>
					
		
			</div>
		</div>
	</div>   
</div>
</body>

<script>
$(function () {
	fnSearch();
});

var editIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-table-edit'></i>";
}

var searchUrl = "/admin/bookLog/list";
var searchParam = function(){
    return {
    	bookDt : $('#searchBookDt').val() 
		, locSeq : $('#searchLocSeq').val()
    }
}

// 목록 조회 
function fnSearch(){
	table.setData(searchUrl, searchParam);
}

var	table = new Tabulator("#tabList", {
	layout:"fitData",
	ajaxURL: searchUrl,
	ajaxParams: searchParam,
	ajaxConfig:"POST", 
	placeholder:"데이터가 존재하지 않습니다.",
    pagination:"local",
    paginationSize:15,
    paginationSizeSelector:[30,50,100],
    movableColumns:true,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
	columns : [
		 { title:"예약시작일자", field:"bookStrtDt", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"} 
		,{ title:"예약종료일자", field:"bookEndDt", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"} 
		,{ title:"예약코드", field:"bookCd", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
		,{ title:"지점", field:"locNm", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"} 
		,{ title:"예약상태", field:"bookSttsNm", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}
		,{ title:"예약자명", field:"name", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
		,{ title:"연락처", field:"tel", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
		,{ title:"이메일", field:"email", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
		,{ title:"예약금액", field:"bookAmt", sorter:"integer", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false}}
		,{ title:"할인금액", field:"dcAmt", sorter: "integer", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false}}
		,{ title:"결제금액", field:"payAmt", sorter: "integer", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false}}
		,{ title:"변경일자", field:"regDt", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
		,{ title:"변경자ID", field:"regId", sorter:"string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input"}  
	
	] 
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

//지점 선택시 해당 지점에 대한 회의실 목록을 가져온다
$("#searchLocSeq").on("change", function(){

	if ($('#searchLocSeq').val() == null || $('#searchLocSeq').val() == "") {
		// 지점 전체 선택시 ..
    	document.querySelector("#searchRoomSeq").innerHTML = "<option value='' selected>지점을 선택해주세요.</option>";    	
	} else {
		// 지점 선택시 .. 
	    $.ajax({
	        url: "/room/list",
	        type: "post",
	        dataType: 'json',
	        data: { "locSeq" : $('#searchLocSeq').val() },
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        success: function(data) {
	        	var rooms = data.rooms;
	        
	        	var selectElement = "<option value='' selected>전체</option>";
	            for (let i=0; i< rooms.length; i++) {
	            	selectElement += "<option value='"+rooms[i].roomSeq+"'>"+rooms[i].name+"</option>";            	
	            }
	        	document.querySelector("#searchRoomSeq").innerHTML = selectElement;
	            
	        },
	        error: function(data) {
	            // 
	        }
	    });
	}
	
    // 예약설정 데이터 조회 
    fnSearch();
});

//오늘 날짜 
var today = getToDay('-');

// 예약일자 
var dateSelector = document.querySelector('#searchBookDt');

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
			$('#searchBookDt').val(strtDt + " ~ " + endDt);
		}
		
		fnSearch();
	}
});
$('#searchBookDt').val(today + " ~ " + today);


</script>

</html>



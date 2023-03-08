<!-- 
관리자 > 예약관리 > 예약정보 > 추가 팝업창 
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">
			예약추가
		</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<!-- 조회 -->
		<div>
			<form name="searchFrm" id="searchFrm" method="post">
			일자 
			<input type="text" class="form-control form-control-sm" id="searchBookDt" name="searchBookDt" onchange="fnSearch()" style="width:150px;display:inline-block"/>
			&nbsp;
			지점
			<select class="form-select" id="searchLocSeq" name="searchLocSeq" style="width:150px;">				
				<c:forEach items="${locs}" var="loc">
					<option value="${loc.locSeq}" <c:if test="${locSeq == loc.locSeq}">selected</c:if>>${loc.name}</option> 
				</c:forEach>
			</select> 
			&nbsp;
			회의실
			<select class="form-select" id="searchRoomSeq" name="searchRoomSeq" onchange="fnSearch()" style="width:150px;">	
				<option value="">전체</option> 		
				<c:forEach items="${rooms}" var="room">
					<option value="${room.roomSeq}">${room.name}</option> 
				</c:forEach>
			</select> 
			&nbsp;
			예약상태
			<select class="form-select" id="searchStts" name="searchStts" onchange="fnSearch()" style="width:150px;">	
				<option value="">전체</option> 		
				<c:forEach items="${roomSttsCodes}" var="stts">
					<option value="${stts.cmnCd}">${stts.cmnNm}</option> 
				</c:forEach>
			</select> 
			</form>
		</div>
		<!-- // 조회 -->	
						
		<!-- 목록 -->
		<div style="text-align:right;padding-bottom:5px">
			<span style="color:#e70e0e; font-weight:bold; font-size:9pt">
				※ 추가할 데이터를 선택해주세요. 예약상태가 '예약가능'인 것만 추가 가능합니다.
			</span>
		</div>
		
		<div id="bkList" class="is-bordered"></div>
						
	</div>
		
	<div class="modal-footer">
		<!-- 추가 -->
		<button type="button" class="btn btn-primary btnSave">
			<i class="far fa-check-circle"></i>추가
		</button>
		<!-- 닫기 -->
		<button type="button" class="btn btn-outline-light btnClose">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>
$(function () {
	fnSearch();
});

var bookData = new Object();		
var bookList = new Array();			

var deleteIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-delete'></i>";
}	

var searchUrl = "/admin/bkDetail/list";
var searchParam = function(){
    return {
    	bookDt : $('#searchBookDt').val() 
		, locSeq : $('#searchLocSeq').val()
		, roomSeq : $('#searchRoomSeq').val()
		, roomSttsCd : $('#searchStts').val() 
		, openYn : "O"
    }
}

// 목록 조회 
function fnSearch(){
	table.setData(searchUrl, searchParam);
}

var table = new Tabulator("#bkList", {
	
	layout:"fitColumns",
	ajaxURL: searchUrl,
	ajaxParams: searchParam,
	ajaxConfig:"POST", 
	placeholder:"데이터가 존재하지 않습니다.",
    pagination:"local",
    paginationSize:10,
    paginationSizeSelector:[10,30,50,100],
    movableColumns:true,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
    columnHeaderVertAlign:"middle",
    selectable:true, 
    selectableCheck:function(row){
        return row.getData().roomSttsCd == '400002'; // 예약가능만 선택되도록 
    },
    rowFormatter:function(row){
        if(row.getData().roomSttsCd == '400002'){
        	// row.getElement().style.backgroundColor = "rgb(231 229 203)";
        	 row.getElement().style.color = "red";
        }
    },
	columns : [
		 { title:"지점", field:"locNm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"list", headerFilterParams:{valuesURL:"/admin/getLocNmList"}} 
		,{ title:"회의실", field:"roomNm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"일자", field:"bookDt", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"예약시간", field:"strtTm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"금액", field:"fee", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false }}
		,{ title:"예약상태", field:"roomSttsNm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"list", headerFilterParams:{valuesURL:"/getRroomSttsList"}}
		,{ title:"지점코드", field:"locSeq", visible:false}
		,{ title:"회의실코드", field:"roomSeq", visible:false}
		,{ title:"예약코드", field:"bookSeq", visible:false}
	] 
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

table.on("rowSelectionChanged", function(data, rows){		
	bookList = data;
	console.log('[rowSelectionChanged] bookList > ', bookList);
});

//로우가 선택되었을때
table.on("rowSelected", function(row){
		row.getElement().style.color = "white";
});

//로우가 선택해제 되었을때
table.on("rowDeselected", function(row){
		row.getElement().style.color = "red";
});

// 추가 버튼 클릭
$('.btnSave').on('click', function(){
	
	if (bookList == null || bookList.length == 0) {
		alert('추가할 예약데이터를 선택해주세요.');
		return;
	}
	
	$.ajax({
        url: "/admin/updateBookDetail/"+${bookCd},
        type: "post",
        dataType: 'json',
        contentType:"application/json; charset=utf-8",
        data: JSON.stringify(bookList),
        success:function(data){
        	if(data.result){
        		alert('정상적으로 추가되었습니다.');
        		
        		parent.document.frmBook.reloadYn.value="Y";
        		$('#popModal').modal('hide');
        	}
        },
		error: function(data) {
			alert('처리중 오류가 발생하였습니다.');
		}
    }); 
	
});

//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
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

var dateSelector = document.querySelector('#searchBookDt');

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

<style>
/* 테이블 선택 CSS */
.tabulator-row.tabulator-selected {
	background-color : #4b49ac!important;
	color:white
	
}

.tabulator-row.tabulator-selected:hover {
	background-color : #4b49ac!important;
	color:white
}

</style>

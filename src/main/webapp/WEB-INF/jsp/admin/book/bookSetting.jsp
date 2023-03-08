<!-- 
관리자 > 예약관리 > 예약설정셋팅
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
								<h5 class="font-weight-bold">예약설정셋팅</h5>
							</div>
						</div>
					</div>
					<div class="col-md-6 grid-margin-sm-0" style="text-align:right">
						<div class="row">
							<div class="col-12 col-xl-12 mb-12 mb-xl-0">
								<span class="menuRoute">예약관리 > 예약설정셋팅</span>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-margin">			
					<!-- 조회 -->
					<div class="row">		
						<!-- 일자 -->		
						<div class="col-3 col-xl-2">
						  <div class="form-group row">
							   <label class="col-xl-3 col-form-label">일자</label>
							   <div class="col-xl-9">
							       <input type="text" class="form-control form-control-sm" id="searchBookDt" name="searchBookDt" onchange="fnSearch()"/>
							   </div>
						  </div>
						</div>			
						<!-- 지점 -->			
						<div class="col-3 col-xl-2">
						  <div class="form-group row">
							   <label class="col-xl-3 col-form-label">지점</label>
							   <div class="col-xl-9">
							       <select class="form-select" id="searchLocSeq" name="searchLocSeq">
										<option value="" selected>전체</option>
										
										<c:forEach items="${locs}" var="loc">
											<option value="${loc.locSeq}">${loc.name}</option> 
										</c:forEach>
									</select> 
							   </div>
						  </div>
						</div>			
						<!-- 회의실 -->			
						<div class="col-3 col-xl-3">
						  <div class="form-group row">
							   <label class="col-xl-3 col-form-label">회의실</label>
							   <div class="col-xl-9">
							       	<select class="form-select" id="searchRoomSeq" name="searchRoomSeq" onchange="fnSearch()">
										<option value="" selected>지점을 선택해주세요.</option>
									</select>
							   </div>
						  </div>
						</div>
						<!-- 버튼 -->		
						<div class="col-3 col-xl-4">
							<div class="form-group row">
								<div class="col-xl-4">
							 		<button type="button" id="btnInsert" class="btn btn-inverse-primary btn-fw" style="width:100%">추가</button>
							  	 </div>
								<div class="col-xl-4">
									<button type="button" id="btnOpen" class="btn btn-inverse-primary btn-fw" style="width:100%">전체오픈</button>
							  	 </div>
								<div class="col-xl-4">
									<button type="button" id="btnSetting" class="btn btn-inverse-primary btn-fw" style="width:100%">예약세팅</button>		
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
						
					<!-- 등록/수정 Modal -->
					<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
					    <div class="modal-dialog modal-dialog-centered modal-xl" id="popModal2" role="document">
					        <div class="modal-content">
					
					        </div>
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

var deleteIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-delete'></i>";
}

var editIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-table-edit'></i>";
}

var searchUrl = "/admin/bkDetail/list";
var searchParam = function(){
    return {
    	bookDt : $('#searchBookDt').val() 
		, locSeq : $('#searchLocSeq').val()
		, roomSeq : $('#searchRoomSeq').val()
    }
}

// 목록 조회 
function fnSearch(){
	table.setData(searchUrl, searchParam);
}

// 팝업창 닫힐때 
$('#popModal').on('hidden.bs.modal', function () {
	fnSearch();
});   

var table = new Tabulator("#tabList", {
	
	layout:"fitColumns",
	ajaxURL: "/admin/bkDetail/list",
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
    columnHeaderVertAlign:"middle",
	columns : [
		 { title:"지점", field:"locNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}
		,{ title:"회의실", field:"roomNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"일자", field:"bookDt", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"시작시간", field:"strtTm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"종료시간", field:"endTm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"금액", field:"fee", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false }}
		,{ title:"오픈여부", field:"openYn", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"변경", formatter: editIcon, width:70, hozAlign:"center", headerHozAlign:"center", resizable:false, headerSort:false,
				cellClick:function(e, cell){
					var bookSeq = cell._cell.row.data.bookSeq;
			    	var url = '/admin/popBkDetail?bookSeq=' + bookSeq;

			    	$('.modal-dialog').draggable({ handle: ".modal-header" });
			    	$('#popModal2').addClass('modal-xl');
			    	$(".modal-content").load(url).fadeIn("fast");
			        $('#popModal').modal('show');}}
		,{ title:"삭제", formatter: deleteIcon, width:70, hozAlign:"center", headerHozAlign:"center", resizable:false, headerSort:false,
			cellClick:function(e, cell){
				if(confirm("삭제하시겠습니까?")){
					cell._cell.row.delete();
					fnDelete(cell._cell.row.data.bookSeq); 
				}}}
		,{ title:"지점코드", field:"locSeq", visible:false }
		,{ title:"회의실코드", field:"roomSeq", visible:false }
		,{ title:"예약코드", field:"bookSeq", visible:false }
	] 
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

//삭제 
function fnDelete(bookSeq){
	
	$.ajax({
        url: "/admin/deleteBookSetting",
        type: "post",
        dataType: 'json',
        data: {bookSeq:bookSeq},
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result == false){
                alert(data.message);
            } else {
                alert('삭제되었습니다.');
                table.setData();
            }                
        },
        error: function(data) {
            alert('삭제중 오류가 발생하였습니다.');
        }
    });
}

//추가 버튼 클릭시 
$('#btnInsert').on('click', function(){
	$('.modal-dialog').draggable({
		handle: ".modal-header"
	});
		
	$('#popModal2').addClass('modal-xl');
	$(".modal-content").load('/admin/popBkDetail').fadeIn("fast");
	$('#popModal').modal('show');  
});

//예약세팅 버튼 클릭시 
$('#btnSetting').on('click', function(){
	$('.modal-dialog').draggable({
		handle: ".modal-header"
	});
	$('#popModal2').removeClass('modal-xl');
	$(".modal-content").load('/admin/popBkSetting').fadeIn("fast");
	$('#popModal').modal('show');  
});

//전체오픈 버튼 클릭시 
$('#btnOpen').on('click', function(){
	var message = "";

	if ( $('#searchBookDt').val() != null ) {
		message += "일자: " + $('#searchBookDt').val() ;
	}
	if ( $('#searchLocSeq').val() != null && $('#searchLocSeq').val() != "" ) {
		message += "\n지점: " + $("#searchLocSeq option:checked").text();
	}
	if ( $('#searchRoomSeq').val() != null && $('#searchRoomSeq').val() != "" ) {
		message += "\n회의실: " + $("#searchRoomSeq option:checked").text();
	}
	
	if ( message != "" ) {
		if (confirm(message + "\n\n전체오픈 하시겠습니까?")) {
			
		    $.ajax({
		        url: "/admin/bookDetail/openAll",
		        type: "post",
		        dataType: 'json',
		        data: {
		        	"bookDt" : $('#searchBookDt').val() 
					, "locSeq" : $('#searchLocSeq').val()
					, "roomSeq" : $('#searchRoomSeq').val()
		        },
		        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		        success: function(data) {
		            if(data.result){
		                alert('전체오픈 되었습니다.');   	
		                table.setData();
		            } else {
		                alert(data.message);                    
		            }                
		        },
		        error: function(data) {
		            alert('처리중 오류가 발생하였습니다.');
		        }
		    });			
	    }
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
</html>



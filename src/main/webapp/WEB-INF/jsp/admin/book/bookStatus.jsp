<!-- 
관리자 > 예약관리 > 예약현황
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
								<h5 class="font-weight-bold">예약현황</h5>
							</div>
						</div>
					</div>
					<div class="col-md-6 grid-margin-sm-0" style="text-align:right">
						<div class="row">
							<div class="col-12 col-xl-12 mb-12 mb-xl-0">
								<span class="menuRoute">예약관리 > 예약현황</span>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-margin" style="width:70%;float:left">		
					<!-- 조회 -->
					<div class="row">	
						
						<!-- 일자 -->					
						<div class="col-lg-6 col-xl-4">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">일자</label>
								<div class="col-xl-9">
									<input type="text" class="form-control form-control-sm" id="searchBookDt" name="searchBookDt" />
								</div>
							</div>
						</div>		
						<!--  -->					
						<div class="col-lg-6 col-xl-4">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">조회구분</label>
								<div class="col-xl-9">
									<select class="form-select" id="searchType" name="searchType" onchange="fnSearch()" >
									<option value="" selected>전체</option>
									<option value="Y">예약</option>
									<option value="N">미예약</option>
									</select> 
								</div>
							</div>
						</div>		
					</div>
					<div class="row">	
							
						<!-- 지점 -->					
						<div class="col-lg-6 col-xl-4">
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
						<!-- 회의실 -->					
						<div class="col-lg-6 col-xl-4">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">회의실</label>
								<div class="col-xl-9">
								
									<select class="form-select" id="searchRoomSeq" name="searchRoomSeq" onchange="fnSearch()" >
										<option value="" selected>지점을 선택해주세요.</option>
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
						
					<!-- 등록/수정 Modal -->
					<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
					    <div class="modal-dialog modal-dialog-centered modal-xl" id="popModal2" role="document">
					        <div class="modal-content">
					
					        </div>
					    </div>
					</div>	
				</div>
					
				<!-- 예약코드 클릭시, 상세내용 (book_detail_log) 표출 -->
				<div class="card" style="padding:10px;margin:20px 0 0 10px;width:28%;float:left">
					<!-- 예약자정보 -->
					<div class="bkDetailLogInfo" style="display:none">
						<i class="mdi mdi-18px mdi-account"></i>
						<span class="mdi_txt_2">예약자 정보</span><br/>
						<span style="padding-left:20px" id="name">- 이름:xxx</span><br/>
						<span style="padding-left:20px" id="email">- 이메일:xxx@naver.com</span><br/>
						<span style="padding-left:20px" id="tel">- 연락처:010-1111-2222</span>
					</div>
					<!-- //예약자정보 -->
					<div id="tabDetail" class="is-bordered"></div>
				</div>
			</div>
		</div>
	</div>   
</div>
</body>

<script>

$(function () {
	fnSearch();
	fnDetailSearch();
});

var editIcon = function(cell, formatterParams, onRendered) {
	if ( cell._cell.row.data.bookCd != null ) {
		return "<i class='mdi mdi-24px mdi-table-edit'></i>";
	} else {
		return "";
	}
}

var searchUrl = "/admin/bkDetail/status";
var searchParam = function(){
    return {
    	searchBookDt : $('#searchBookDt').val() 
		, locSeq : $('#searchLocSeq').val()
		, roomSeq : $('#searchRoomSeq').val()
		, searchType : $('#searchType').val()
    }
}

// 목록 조회 
function fnSearch(){
	table.setData(searchUrl, searchParam);
}

var table = new Tabulator("#tabList", {
	layout:"fitColumns",
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
    columnHeaderVertAlign:"middle",
	columns : [
		 { title:"지점", field:"locNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"회의실", field:"roomNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"일자", field:"bookDt", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}
		,{ title:"예약시간", field:"strtTm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}
		,{ title:"금액", field:"fee", sorter:"integer", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false }}
		,{ title:"예약코드", field:"bookCd", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}
		,{ title:"예약상태", field:"roomSttsNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"} 
		,{ title:"예약정보변경", formatter: editIcon, width:100, hozAlign:"center", headerHozAlign:"center", headerSort:false,
			cellClick:function(e, cell){
				var bookCd = cell._cell.row.data.bookCd;
				if (bookCd != null) location.href = '/admin/book/detail?bookCd=' + bookCd; }}
	]	    
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

table.on("rowClick", function(e, row){
	if (row._row.data.bookCd != null) {
		
	// 예약코드에 해당하는 상세 내용(book_detail_log) 출력
		fnDetailSearch(row._row.data.bookCd);

		// 예약자정보 조회 
        $.ajax({
            url: '/admin/book',
            type: "post",
            dataType: 'json',
            data: { "bookCd" : row._row.data.bookCd },
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
            success: function(data) {
		
            	if (data != null && data.bookCd != null) {
                	document.querySelector("#name").innerHTML = "- 예약자명: " + data.name;
                	document.querySelector("#email").innerHTML = "- 이메일: " + data.email;
                	document.querySelector("#tel").innerHTML = "- 연락처: " + data.tel;
    			 	$('.bkDetailLogInfo').css('display', 'inline');
            	} else {
            		document.querySelector("#name").innerHTML = "";
                	document.querySelector("#email").innerHTML = "";
                	document.querySelector("#tel").innerHTML = "";
    			 	$('.bkDetailLogInfo').css('display', 'none');
            	}
		 
            },
            error: function(data) {
                // 
            }
        });		
	}
});

//상세 목록 조회 
function fnDetailSearch(bookCd){
	var table2 = new Tabulator("#tabDetail", {
		
		layout:"fitColumns",
		ajaxURL: '/admin/bkDetail/status',
		ajaxParams:{ "bookCd" : bookCd },
		ajaxConfig:"POST", 
		placeholder:"데이터가 존재하지 않습니다.",
	    pagination:"local",
	    paginationSize:10,
	    paginationSizeSelector:[10,30,50,100],
	    movableColumns:true,
	    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
	        return "총 " + totalRows + "건";
	    },
		columns : [
			 { title:"회의실명", field:"roomNm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}  
			,{ title:"예약일자", field:"bookDt", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}   
			,{ title:"예약시간", field:"strtTm", sorter:"string", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"}  
			,{ title:"대여금액", field:"fee", sorter:"integer", hozAlign:"center", headerHozAlign:"center", headerFilter:"input"
				, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false }}
		]
		, locale:true
		, langs:{
			"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
		}
	});
}

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



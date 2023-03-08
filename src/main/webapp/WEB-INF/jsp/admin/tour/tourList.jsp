<!-- 
관리자 > 투어신청관리
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
								<h5 class="font-weight-bold">투어신청 리스트</h5>
							</div>
						</div>
					</div>
					<div class="col-md-6 grid-margin-sm-0" style="text-align:right">
						<div class="row">
							<div class="col-12 col-xl-12 mb-12 mb-xl-0">
								<span class="menuRoute">투어관리 > 신청리스트</span>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-margin">		
					<!-- 조회 -->
					<div class="row">	
						<!-- 일자 -->
						<div class="col-3 col-xl-3">
						  <div class="form-group row">
							   <label class="col-sm-3 col-form-label">일자</label>
							   <div class="col-sm-9">
							       <input type="text" class="form-control form-control-sm" id="searchDt" style="display:inline-block"/>
							       <input type="hidden" id="searchStrtDt">
							       <input type="hidden" id="searchEndDt">
							   </div>
						  </div>
						</div>
						<!-- 지점 -->
						<div class="col-3 col-xl-3">
						   <div class="form-group row">
		                       <label class="col-sm-3 col-form-label">지점</label>
		                       <div class="col-sm-9">
		                           <select class="form-select" id="searchLocSeq" >
		                            <option value="" selected>전체</option>
		                            <c:forEach items="${locs}" var="loc">
		                                <option value="${loc.locSeq}">${loc.name}</option> 
		                            </c:forEach>
		                        </select>
		                       </div>
		                   </div>
	                    </div>	
						<!-- 버튼 -->		
						<div class="col-6 col-xl-6">
							<div class="form-group row" style="float:right">
								<div class="col-xl-12">
							 		<button type="button" class="btn btn-inverse-primary btn-fw btn-save">저장</button>
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
					
					<!-- 상세보기 Modal -->
					<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
					    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
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

var editIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-table-edit'></i>";
}

var searchUrl = "/tour/list";
var searchParam = function(){
    return {
    	  searchDt : $('#searchDt').val() 
    	, locSeq : $('#searchLocSeq').val()
    }
}

var table = new Tabulator("#tabList", {
    layout:"fitData",
    ajaxURL: searchUrl,
    ajaxParams:searchParam,
    ajaxConfig:"POST", 
    placeholder:"데이터가 존재하지 않습니다.",
    pagination:"local",
    paginationSize:15,
    paginationSizeSelector:[30,50,100],
    movableColumns:true,
    selectable:1,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
    columnHeaderVertAlign:"middle",
    columns : [
    	{ title:"상세보기", formatter: editIcon, hozAlign:"center", headerHozAlign:"center", resizable:false, headerSort:false,
			cellClick:function(e, cell){
				var tourSeq = cell._cell.row.data.tourSeq;
		    	var url = '/admin/popTourDetail?tourSeq=' + tourSeq;

		    	$('.modal-dialog').draggable({ handle: ".modal-header" });
		    	$(".modal-content").load(url).fadeIn("fast");
		        $('#popModal').modal('show');}}
    	,
    	 { title:"신청상태", field:"reqSttsNm", headerHozAlign:"center", hozAlign:"center", editor:"select"
    		 , editorParams:{valuesURL:"/admin/getCmnCodeNmList?upCd=300"}, headerFilter:"input"}
        ,{ title:"지점", field:"locName", headerHozAlign:"center", hozAlign:"center", editor:"select"
        	, editorParams:{valuesURL:"/admin/getLocNmList"}, headerFilter:"input"}
        ,{ title:"투어일자", field:"tourDt", headerHozAlign:"center", hozAlign:"center", editor:"date", headerFilter:"input"}
        ,{ title:"투어시간", field:"tourTm", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"} 
        ,{ title:"신청자", field:"reqNm", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"}
        ,{ title:"연락처", field:"reqTel", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"}    
        ,{ title:"이메일", field:"reqEmail", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"}
        ,{ title:"회사/부서", field:"reqInfo", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"}
        ,{ title:"요청사항", field:"reqCnts", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input"}
       
		,{ title:"투어순번", field:"tourSeq", visible:false}
    ] 
    , locale:true
    , langs:{
        "ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
    }
});

// 목록 조회 
function fnSearch(){
    table.setData(searchUrl, searchParam);
}

$('#searchLocSeq').on('change', function(){
	fnSearch();
});


//저장 버튼 클릭
$('.btn-save').on('click', function(){
		
	if(table.getSelectedData() == null || table.getSelectedData() == ""){
		alert("변경할 데이터가 선택되지 않았습니다. \n변경할 데이터를 선택해 주세요.");
		return;
	}
	
	var tableData = table.getSelectedData()[0];

	tableData.reqTel = tableData.reqTel.replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-"); 

	if(tableData.tourDt == '' || typeof tableData.tourDt == "undefined" || tableData.tourDt == null){
		alert("투어일자를 입력해주세요.");
		return;
	}

	if(tableData.tourTm == '' || typeof tableData.tourTm == "undefined" || tableData.tourTm == null){
		alert("투어시간을 입력해주세요.");
		return;
	}

	if(tableData.reqNm == '' || typeof tableData.reqNm == "undefined" || tableData.reqNm == null){
		alert("신청자를 입력해주세요.");
		return;
	}

	if(tableData.reqEmail.trim() != ''){
		emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i;
		if (!emailExp.test(tableData.reqEmail.trim())) {
			alert('이메일을 정확하게 입력해주세요.');
			return;
		}
	}

    $.ajax({
        url: "/admin/updateTour",
        type: "post",
        dataType: 'json',
        data: $('#tourForm').serialize() 
        	+ "&tourSeq=" + tableData.tourSeq
        	+ "&reqSttsNm=" + tableData.reqSttsNm
        	+ "&locName=" + tableData.locName
        	+ "&tourDt=" + tableData.tourDt
        	+ "&tourTm=" + tableData.tourTm
        	+ "&reqNm=" + tableData.reqNm
        	+ "&reqTel=" + tableData.reqTel
            + "&reqEmail="+(tableData.reqEmail == '' || typeof tableData.reqEmail == "undefined" || tableData.reqEmail == null ? "" : tableData.reqEmail)
        	+ "&reqInfo="+(tableData.reqInfo == '' || typeof tableData.reqInfo == "undefined" || tableData.reqInfo == null ? "" : tableData.reqInfo)
        	+ "&reqCnts="+(tableData.reqCnts == '' || typeof tableData.reqCnts == "undefined" || tableData.reqCnts == null ? "" : tableData.reqCnts)
        ,contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        ,success: function(data) {
            if(data.result){
                alert('저장이 완료되었습니다.');
            } else {
                alert(data.message);                    
            }                
        }
        ,error: function(data) {
            alert('투어신청 정보 변경 처리중 오류가 발생하였습니다.');
        }
    });
});

// 팝업창 닫힐때 ..
$('#popModal').on('hidden.bs.modal', function () {
	table.setData();
});   

var fp = $('#searchDt').flatpickr({  
	 locale: 'ko'
	, mode: "range" 
	, dateFormat: "Y-m-d"
	, conjunction: " ~ "
	, confirmIcon: "<i class='fa fa-check'></i>"
	, showMonths : 1
	, defaultDate: [ moment().format(), moment().add(1, 'months').format()]
	, onClose: function(selectDates, dateStr, instance){

		// 날짜 선택 완료 되었을때 
		var strtDt = getStringDt(selectDates[0], '-');
		var endDt = getStringDt(selectDates[1], '-');
	
		if (strtDt == endDt) {
			$('#searchDt').val(strtDt + " ~ " + endDt);
		}
		
		fnSearch();
	}
});


</script>


</html>



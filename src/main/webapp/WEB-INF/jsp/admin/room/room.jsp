<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="../../common/admin/head.jsp"/>
<jsp:include page="../../common/admin/script.jsp"/> 

<link rel="stylesheet" href="../../css/admin/swiper.min.css">
<script type="text/javascript" src="../../js/admin/luxon.min.js"></script>
<script type="text/javascript" src="../../js/admin/swiper.min.js"></script>
<link href="../../css/admin/dropzone.css" rel="stylesheet">
<script src="../../js/admin/dropzone.min.js"></script>

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
								<h5 class="font-weight-bold">회의실관리</h5>
							</div>
						</div>
					</div>
				</div>
			
				<div class="card card-margin" style="width:63%;float:left">		
					<!-- 조회 -->
					<div class="row">				
									
						<div class="col-lg-5 col-xl-5">
							<div class="form-group row">
								<label class="col-xl-3 col-form-label">회의실</label>
								<div class="col-xl-9">
								
									<select class="form-select" id="searchLocSeq" name="searchLocSeq" >
										
										<c:if test='${myAuth ne "[ROLE_AAA001]" }'>
										<option value="" selected>전체</option>
										</c:if>
										
										<c:forEach items="${locs}" var="loc">
											<option value="${loc.locSeq}">${loc.name}</option> 
										</c:forEach>
									</select> 
								</div>
							</div>
						</div>	
						
						<!-- 버튼 -->	
						<div class="col-lg-7 col-xl-7">
						
							<div class="form-group row">	
								<div class="col-2"></div>
								<div class="col-10">
									<div class="row">
										<div class="col-4" style="text-align:right">
											<input type="button" class="btn btn-inverse-primary btn-new" style="float:right;width:100%" value="추가" >
										</div>
										<div class="col-4" style="text-align:right">
											<input type="button" class="btn btn-inverse-primary btn-save" style="float:right;width:100%" value="저장" >
										</div>
										<div class="col-4" style="text-align:right">
											<input type="button" class="btn btn-inverse-danger btn-del" style="float:right;width:100%" value="삭제" >
										</div>
									</div>	
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
					
				<div class="card" style="padding:10px;margin:20px 0 0 10px;width:35%;float:left">
				
					<div class="bkDetailLogInfo">
						<div class="row">
							<div class="col-6">
								<i class="mdi mdi-18px mdi-history"></i>
								<span class="mdi_txt_2">이용요금이력</span>
							</div>
							<div class="col-3">
								<input type="button" class="btn btn-inverse-primary btn-save-fee" style="float:right;width:100%" value="저장" >
							</div>
							<div class="col-3">
								<input type="button" class="btn btn-inverse-primary btn-new-fee" style="float:right;width:100%" value="추가" >
							</div>
						</div>
					</div>
					
					<div id="tabDetail" class="is-bordered"></div>
				</div>	
				
						
				<div class="card card-margin" style="width:100%">		
					<div class="row" style="border-top: 2px solid black;padding: 20px 2px;margin: 20px 2px;">
							
					<div class="col-6">
							<div>
								<div>회의실설명</div>
								<hr/>
								<textarea class="form-control" id="expln" rows="10" class="ckeditor"></textarea>
							</div>
							<hr style="border: solid black 1px;"/>
							<div>
								<div>시설안내</div>
								<hr/>
								<textarea class="form-control" id="guide" rows="10" class="ckeditor"></textarea>
							</div>
						</div>
						<div class="col-6">
							<div class="rows">
								<div>
									<div style="display:inline;">회의실사진</div>
									<input type="button" class="btn btn-inverse-primary btn-popRoom" value="추가" />
									<p style="font-size:12px;">(가로,세로의 크기가 760x340px인 이미지를 추천합니다.)</p>
									<hr/>
									<div id="pop_room_pic">
									</div>									
								</div>
							</div>
						</div>
					</div>						
				</div>
			</div>
		</div>
		
		
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
	    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
	        <div class="modal-content">
	
	        </div>
	    </div>
	</div>
</div>
</body>

<script src="../../js/ckeditor/ckeditor.js"></script>
<script src="../../js/ckeditor/config.js"></script>
<script type="text/javascript">

var numSelectRow = "";
var leftLocSeq = "";
var leftRoomSeq = "";

var editorIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-table-edit'></i>";
}
	
$("document").ready(function() {
	new Swiper(".swiper-container", {
		navigation: {
		    prevEl: ".swiper-button-prev",
		    nextEl: ".swiper-button-next",
		  }
	});
});

$(".btn-new-fee").hide();
$(".btn-save-fee").hide();
$(".btn-popRoom").hide();

var myUID = "${myUserId}";
var myAuth = "${myAuth}";
var thisAjaxParams = {}; 

if(myAuth == "[ROLE_AAA001]"){
	thisAjaxParams = {adminId:myUID};
}else{
	thisAjaxParams = {};
}

// 회의실 목록 조회 
var table = new Tabulator("#tabList", {
	layout:"fitColumns",
	placeholder:"데이터가 존재하지 않습니다.",
    pagination:true,
    paginationSize:10,
    paginationInitialPage:1,
    movableColumns:true,
    //paginationCounter:"rows",
    ajaxURL:"/admin/getRoomList",
    ajaxParams:thisAjaxParams,
    ajaxConfig:"POST",
    selectable:1,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
	columns : [
		{ title: "번호", field : "roomSeq", sorter: "string", headerHozAlign:"center", hozAlign:"center", maxWidth: "80px"},
		{ title: "지점명", field : "locName", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"select", editorParams:{valuesURL:"/admin/getLocNmList"}, headerFilter:"input" },
		{ title: "회의실명", field : "name", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "회의실타입", field : "cmnNm", sorter: "string", headerHozAlign:"center", hozAlign:"center", maxWidth: "130px", editor:"select", editorParams:{valuesURL:"/admin/getCmnCodeNmList?upCd=200"}, headerFilter:"input" },
		{ title: "수용인원", field : "capacity", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"number", maxWidth: "100px", headerFilter:"input" },
		{ title: "정렬순서", field : "roomOrd", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"number", maxWidth: "100px", headerFilter:"input" },
		{ title: "주간요금(9~18)", field : "basicFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", formatter:"money", formatterParams:{
																															    decimal:".",
																															    thousand:",",
																															    symbol:"",
																															    symbolAfter:"p",
																															    precision:false,
																															} , headerFilter:"input"},
		{ title: "야간요금(18~22)", field : "nightFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", formatter:"money", formatterParams:{
																															    decimal:".",
																															    thousand:",",
																															    symbol:"",
																															    symbolAfter:"p",
																															    precision:false,
																															}, headerFilter:"input" }
	]
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});


//로우가 선택되었을때
table.on("rowSelected", function(row){
	
	//테이블이 선택되었다가 다른 로우를 선택할 때 너무 빨라서 에디터가 인식을 못함. 그래서 0.1초후 실행되도록 함.
	var timer = setInterval(function() {
	
		leftLocSeq = row._row.data.locSeq;
		leftRoomSeq = row._row.data.roomSeq;
		
		//신규추가된 항목이라면 다음의 과정을 실행하지 않는다.
		if(leftLocSeq == null || typeof leftLocSeq == "undefind" || leftLocSeq == ""){
			$(".btn-new-fee").hide();
			$(".btn-save-fee").hide();
		    clearInterval(timer);
			return;
		}else{
			$(".btn-new-fee").show();
			//$(".btn-save-fee").show();
		}
	
		
		//이용요금 목록 조회 (이용요금 목록 조회 2군데 있음, 수정할때 2군데 다 수정해주어야함)
		tableFee = new Tabulator("#tabDetail", {
			layout:"fitColumns",
			placeholder:"데이터가 존재하지 않습니다.",
		    pagination:true,
		    paginationSize:10,
		    paginationInitialPage:1,
		    movableColumns:true,
		    //paginationCounter:"rows",
		    ajaxURL:"/admin/getFeelist",
		    ajaxParams:{locSeq:leftLocSeq, roomSeq:leftRoomSeq},
		    ajaxConfig:"POST",
		    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
		        return "총 " + totalRows + "건";
		    },
			columns : [
				{ title: "적용시작일", field : "strtDt", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
				{ title: "적용종료일", field : "endDt", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
				{ title: "주간요금(9~18)", field : "basicFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"input", formatter:"money" , formatterParams:{
																																			    decimal:".",
																																			    thousand:",",
																																			    symbol:"",
																																			    symbolAfter:"p",
																																			    precision:false,
																																			}, headerFilter:"input"},
				{ title: "야간요금(18~22)", field : "nightFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", editor:"input", formatter:"money" , formatterParams:{
																																			    decimal:".",
																																			    thousand:",",
																																			    symbol:"",
																																			    symbolAfter:"p",
																																			    precision:false,
																																			}, headerFilter:"input" },
			    { 
					// 수정버튼 
					title: "수정", formatter: editorIcon, width:70, minWidth:70, headerHozAlign:"center", hozAlign:"center", resizable:false, headerSort:false,
			     	cellClick:function(e, cell){
			     		console.log(cell._cell.row.data);
						var feeSeq = cell._cell.row.data.feeSeq;
			        	var url = '/admin/popFeeInfo?feeSeq=' + feeSeq;
			   
			        	$(".modal-content").load(url).fadeIn("fast");
			            $('#popModal').modal('show');
			      	}
			    } ,																																				
																																			
			]
			, locale:true
			, langs:{
				"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
			}
		});
		
		var tableData = table.getSelectedData()[0];
		
		CKEDITOR.instances.expln.setReadOnly(false);
	    CKEDITOR.instances.guide.setReadOnly(false);
		
	    if(tableData.roomSeq != '' && typeof tableData.roomSeq != "undefined" && tableData.roomSeq != null){
	    	
	    	CKEDITOR.instances.expln.setData(tableData.expln);	
		    CKEDITOR.instances.guide.setData(tableData.guide);
	    }
	    
	    $(".btn-popRoom").show();
	    selectImage("N");
	    
	    clearInterval(timer);

	}, 100);
    
	numSelectRow = row._row;
	
});

//로우가 선택해제 되었을때
table.on("rowDeselected", function(row){
	CKEDITOR.instances.expln.setData("");
	CKEDITOR.instances.expln.setReadOnly(true);
	CKEDITOR.instances.guide.setData("");
    CKEDITOR.instances.guide.setReadOnly(true);
    
    $(".btn-popRoom").hide();
    $("#pop_room_pic").empty();
    
    numSelectRow = "";
});


//이용요금 목록 조회 (이용요금 목록 조회 2군데 있음, 수정할때 2군데 다 수정해주어야함)
var tableFee = new Tabulator("#tabDetail", {
	layout:"fitColumns",
	placeholder:"데이터가 존재하지 않습니다.",
    pagination:true,
    paginationSize:10,
    paginationInitialPage:1,
    movableColumns:true,
    //paginationCounter:"rows",
    ajaxURL:"/admin/getFeelist",
    ajaxParams:{locSeq:9999, roomSeq:9999},
    ajaxConfig:"POST",
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
	columns : [
		{ title: "적용시작일", field : "strtDt", sorter: "string", headerHozAlign:"center", hozAlign:"center" , headerFilter:"input"},
		{ title: "적용종료일", field : "endDt", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
		{ title: "주간요금(9~18)", field : "basicFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", formatter:"money" , formatterParams:{
																																	    decimal:".",
																																	    thousand:",",
																																	    symbol:"",
																																	    symbolAfter:"p",
																																	    precision:false,
																																	} , headerFilter:"input"},
		{ title: "야간요금(18~22)", field : "nightFee", sorter: "string", headerHozAlign:"center", hozAlign:"center", formatter:"money" , formatterParams:{
																																	    decimal:".",
																																	    thousand:",",
																																	    symbol:"",
																																	    symbolAfter:"p",
																																	    precision:false,
																																	}, headerFilter:"input"  },
	    { 
			// 수정버튼 
			title: "수정", formatter: editorIcon, width:70, minWidth:70, headerHozAlign:"center", hozAlign:"center", resizable:false, headerSort:false,
	     	cellClick:function(e, cell){
	     		//
	      	}
	    } ,																																	
	]
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});


//에디터
var ckeditor_config = {
        enterMode: CKEDITOR.ENTER_BR, // 엔터키를 <br> 로 적용함.
        shiftEnterMode: CKEDITOR.ENTER_P,  // 쉬프트 +  엔터를 <p> 로 적용함.
        toolbarCanCollapse: true,
        allowedContent: true,
        removePlugins: 'iframe', // DOM 출력하지 않음
        imgUploadUrl: '/editorImgUpload?type=editor',//&schlCd='+schlCd+'&bbsId='+bbsId,
        filebrowserUploadUrl: '/editorImgUpload?type=editor', //&schlCd='+schlCd+'&bbsId='+bbsId,
        uploadUrl:'/editorImgUploadPaste?type=editor&responseType=json',
        toolbar: [
            ['Source', '-', 'NewPage', 'Preview'],
            ['Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo'],
            ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
            '/',
            ['Styles', 'Format', 'Font', 'FontSize'],
            ['TextColor', 'BGColor'],
            ['ImgUpload', 'Flash', 'Table', 'SpecialChar', 'Link', 'Unlink']
        ],
        height: '150px',
        width: '100%',
        disallowedContent: 'img{width, height}'
    };

    CKEDITOR.replace('expln', ckeditor_config);

    CKEDITOR.on('dialogDefinition', function (ev) {
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;

        switch (dialogName) {
            case 'image': //Image Properties dialog
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                break;
        }
    });
    
    var ckeditor_config = {
            enterMode: CKEDITOR.ENTER_BR, // 엔터키를 <br> 로 적용함.
            shiftEnterMode: CKEDITOR.ENTER_P,  // 쉬프트 +  엔터를 <p> 로 적용함.
            toolbarCanCollapse: true,
            allowedContent: true,
            removePlugins: 'iframe', // DOM 출력하지 않음
            imgUploadUrl: '/editorImgUpload?type=editor',//&schlCd='+schlCd+'&bbsId='+bbsId,
            filebrowserUploadUrl: '/editorImgUpload?type=editor', //&schlCd='+schlCd+'&bbsId='+bbsId,
            uploadUrl:'/editorImgUploadPaste?type=editor&responseType=json',
            toolbar: [
                ['Source', '-', 'NewPage', 'Preview'],
                ['Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo'],
                ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
                ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
                '/',
                ['Styles', 'Format', 'Font', 'FontSize'],
                ['TextColor', 'BGColor'],
                ['ImgUpload', 'Flash', 'Table', 'SpecialChar', 'Link', 'Unlink']
            ],
            height: '150px',
            width: '100%',
            disallowedContent: 'img{width, height}'
        };

        CKEDITOR.replace('guide', ckeditor_config);

        CKEDITOR.on('dialogDefinition', function (ev) {
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;

            switch (dialogName) {
                case 'image': //Image Properties dialog
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
        
        $("#searchLocSeq").on("change", function(){
        	var selNm = $("#searchLocSeq option:selected").text();
        	if(selNm != "전체"){
        		table.setFilter("locName","=", selNm);
        	}else{
        		table.clearFilter();
        	}
        });
        
      //저장 버튼 클릭
        $('.btn-save').on('click', function(){
        	
        	if(table.getSelectedData() == null || table.getSelectedData() == ""){
        		alert("회의실이 선택되지 않았습니다. 회의실을 선택해 주세요.");
        		return;
        	}
        	//
        	
        	var tableData = table.getSelectedData()[0];
        	
        	if(tableData.locName == '' || typeof tableData.locName == "undefined" || tableData.locName == null){
        		alert("지점명이 선택되지 않았습니다.");
        		return;
        	}
        	
        	if(tableData.name == '' || typeof tableData.name == "undefined" || tableData.name == null){
        		alert("회의실명이 입력되지 않았습니다.");
        		return;
        	}
        	
        	if(tableData.cmnNm == '' || typeof tableData.cmnNm == "undefined" || tableData.cmnNm == null){
        		alert("회의실타입이 선택되지 않았습니다.");
        		return;
        	}
        	
        	if(tableData.capacity == '' || typeof tableData.capacity == "undefined" || tableData.capacity == null){
        		alert("수용인원이 입력되지 않았습니다.");
        		return;
        	}
        	
        	if(tableData.capacity > 999999 ){
        		alert("수용인원이 너무 큽니다.");
        		return;
        	}
        	
        	if(tableData.roomOrd > 999999){
        		alert("정렬순서가 너무 큽니다.");
        		return;
        	}
        	
        	var nOrd = 0;
			if(tableData.roomOrd == '' || typeof tableData.roomOrd == "undefiend" || tableData.roomOrd == null){
        		nOrd = 999999;
        	}else{
        		nOrd = tableData.roomOrd;
        	}
        	
        	var ajaxUrl = '';
            if(tableData.roomSeq != '' && typeof tableData.roomSeq != "undefined" && tableData.roomSeq != null) {
            	// 수정
            	ajaxUrl = "/admin/updateRoomInfo";
            } else {
            	// 등록 
            	ajaxUrl = "/admin/insertRoomInfo";
            }  
            
            $.ajax({
                url: ajaxUrl,
                type: "post",
                dataType: 'json',
                data:  "&locSeq="+(ajaxUrl == "/admin/updateRoomInfo" ? tableData.locSeq : "")
                	+  "&locName="+tableData.locName
                    +  "&roomSeq="+(ajaxUrl == "/admin/updateRoomInfo" ? tableData.roomSeq : "")
                    +  "&name="+tableData.name
                    +  "&capacity="+tableData.capacity
                    +  "&roomOrd="+nOrd
                    +  "&cmnNm="+tableData.cmnNm
                    +  "&expln="+CKEDITOR.instances.expln.getData()
                    +  "&guide="+CKEDITOR.instances.guide.getData()
        			,
       			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
       	        success: function(data) {
       	            if(data.result){
       	            	alert('저장이 완료되었습니다.');
	       	            table.setData().then(function(){
	       	            	CKEDITOR.instances.expln.setData("");
		       	         	CKEDITOR.instances.expln.setReadOnly(true);
		       	         	CKEDITOR.instances.guide.setData("");
		       	            CKEDITOR.instances.guide.setReadOnly(true);
		       	             
		       	            $(".btn-popRoom").hide();
		       	            $("#pop_room_pic").empty();
	                    });
       	            } else {
       	                alert(data.message);                    
       	            }                
       	        },
       	        error: function(data) {
       	            alert('회의실 등록(변경)중 오류가 발생하였습니다.');
       	        }	
            });
        });
      
      	//회의실 추가 버튼 클릭 
        $('.btn-new').on('click', function(){
        	table.addData([{locSeq: ""}])
        	.then(function(rows){
        		table.deselectRow();
        		table.selectRow(rows);	
        	});
        	
        	// 이용요금이력 테이블 clear
        	tableFee.clearData();        	
        });	
      	
      	//이용요금 추가 버튼 클릭 
        $('.btn-new-fee').on('click', function(){
        	
        	if(table.getSelectedData() == null || table.getSelectedData() == ""){
        		alert("회의실이 선택되지 않았습니다. 회의실을 먼저 선택해 주세요.");
        		return;
        	}
       
        	$(".modal-content").load('/admin/popFeeInfo').fadeIn("fast");
        	$('#popModal').modal('show');
        });
      	
     	// 등록/수정 팝업창 닫힐때 ..
        $('#popModal').on('hidden.bs.modal', function () {
        	var selRow = table.getSelectedRows();

        	//팝업을 그냥 닫을 때는 아무것도 하지 않게 한다.
    		if(typeof _popRtnData === "undefined"){
				
			}else {
				if(popObj.data('type') == "popFee"){
					table.setData();
					tableFee.setData().then(function(){
						$("#btn-new-fee").hide();
						
						CKEDITOR.instances.expln.setData("");
	       	         	CKEDITOR.instances.expln.setReadOnly(true);
	       	         	CKEDITOR.instances.guide.setData("");
	       	            CKEDITOR.instances.guide.setReadOnly(true);
	       	             
	       	            $(".btn-popRoom").hide();
	       	            $("#pop_room_pic").empty();
		        	});

				}else if(popObj.data('type') == "popRoom"){
					selectImage("N");
				}	    		
	    	}
        });
     	
        function selectImage(sFlrPlanYn){
        	
        	var tableData = table.getSelectedData()[0];
        	
        	$.ajax({
        	    url: "/admin/getImagelist",
        	    type: "post",
        	    dataType: 'json',
        	    data: {"locSeq":tableData.locSeq, "roomSeq":tableData.roomSeq, "flrPlanYn":"N"},
        	    contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        	    success: function(data) {
        	        if(data.result == false){
        	            alert(data.message);
        	        } else {
        	        	//평면도 등록된 이미지 추가
       	        		var sHtml = "";
       	        		$("#pop_room_pic").empty();
       	        			sHtml += "<div class='swiper-container'>";
       	        			sHtml += "	<div class='swiper-wrapper' style='height:auto;'>";
       	        		for(var i=0; i<data.length; i++){
       	        			sHtml += "		<div class='swiper-slide' style='text-align:center;'>";
       						sHtml += "			<img src='/store/" + data[i].filePath1 + "' class='img" + data[i].imgSeq + "' width='600px' />";
       						
       						sHtml += "			<div style='margin-top:10px;padding-left:50px'>";
       						sHtml += "			<div style='display: inline; vertical-align: bottom; width:20%'><input type='button' class='btn btn-inverse-danger btn_del_pic' value='삭제' data-img-seq='" + data[i].imgSeq + "'";
       						sHtml += "			 data-filePath1='" + data[i].filePath1 + "' data-filePath2='" + data[i].filePath2 + "'";
       						sHtml += "			 data-ord='" + data[i].ord + "'  style='float:left'/></div>";
       						
       						if(data[i].ord > 0){
       							sHtml += "		<div style='display: block;float:left;width:30%;margin-left:10px'><input type='button' value='대표사진설정' class='btn btn-inverse-primary btn-repr' data-img-seq='" + data[i].imgSeq + "'" + "/></div>";
       						}
       						sHtml += "			<div style='display: block;float:left;50%;margin-left:10px' class='ordDiv'>이미지순서 <input type='number' style='width:100px;display:inline' maxlength='6' value='"+data[i].ord+"' class='form-control ordNum' data-img-seq='" + data[i].imgSeq + "'/></div>";
       						sHtml += "		</div></div>";
       	        		}
       						sHtml += "	</div>";
       	        			sHtml += "	<div class='swiper-button-prev'></div>";
       	        			sHtml += "	<div class='swiper-button-next'></div>";
       						sHtml += "</div>";
       	        		$("#pop_room_pic").append(sHtml);
       	        		
       	        		new Swiper(".swiper-container", {
       	        			navigation: {
       	        			    prevEl: ".swiper-button-prev",
       	        			    nextEl: ".swiper-button-next",
       	        			  }
       	        		});
        	        }                
        	    },
        	    error: function(data) {
        	        alert('이미지 조회 중 오류가 발생하였습니다.');
        	    }
        	});
        }     	
     	
        //지점사진 추가
        $('.btn-popRoom').on('click', function(){
        	if(table.getSelectedData() == null || table.getSelectedData() == ""){
        		alert("회의실이 선택되지 않았습니다. 번호를 눌러서 회의실을 선택해 주세요.");
        		return;
        	}
        	
            $(".modal-content").load('/admin/roomPop').fadeIn("fast");
            $('#popModal').modal('show');
        });
        
        // 이미지 삭제 - 동적생성으로 이벤트를 발생시키기 위해 document 사용함. 
        $(document).on('click', '.btn_del_pic', function (e) {
        	
        	if(table.getSelectedData() == null || table.getSelectedData() == ""){
        		alert("회의실이 선택되지 않았습니다. 회의실을 먼저 선택해 주세요.");
        		return;
        	}
        	
        	if(!confirm("이미지를 지울까요?")){
        		return;
        	}
        	
        	var sObj = $(this);
        	var sImgSeq = $(this).attr('data-img-seq');
        	var sfilePath1 = $(this).attr('data-filePath1');
        	var sfilePath2 = $(this).attr('data-filePath2');

        	$.ajax({
                url: "/admin/deleteImage",
                type: "post",
                dataType: 'json',
                data: {imgSeq:sImgSeq, filePath1:sfilePath1, filePath2:sfilePath2},
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
                success: function(data) {
                    if(data.result == false){
                        alert(data.message);
                    } else {
                        alert('삭제되었습니다.');
                        selectImage("N");
                    }                
                },
                error: function(data) {
                    alert('이미지 삭제중 오류가 발생하였습니다.');
                }
            });
        	
        });
        
      	//ord 순서값이 바뀌면 일어나는 이벤트
        $(document).on('change', '.ordNum', function (e) {
        	var nImgSeq = $(this).attr('data-img-seq');
        	var nOrd = $(this).val();
        	
        	$.ajax({
                url: "/admin/changeImageOrd",
                type: "post",
                dataType: 'json',
                data: {imgSeq:nImgSeq, ord:nOrd},
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
                success: function(data) {
                    if(data.result == false){
                        alert(data.message);
                    } else {
                        alert('변경되었습니다.');
                        selectImage("N");
                    }                
                },
                error: function(data) {
                    alert('회의실사진 순서변경 중 오류가 발생하였습니다.');
                }
            });
        });
      	
      	//대표사진이 바뀌면 일어나는 이벤트
        $(document).on('click', '.btn-repr', function (e) {
        	
        	if(!confirm("대표사진으로 설정할까요?")){
        		return;
        	}
        	
        	$(this).parents("div").parents("div").children(".ordDiv").children(".ordNum").val(0);
        	$(this).parents("div").parents("div").children(".ordDiv").children(".ordNum").trigger("change");
        });
        
// 회의실삭제
$('.btn-del').on('click', function(){
	
	var sel = table.getSelectedData();
	if(sel.length == 0){
		alert("삭제할 회의실을 선택해주세요.");
		return;
	} else {
		data = sel[0];
		if(!confirm('(' + data.name + ')회의실을 삭제하시겠습니까?')) return;
		fnDeleteRoom(data.roomSeq);           
	}
});

function fnDeleteRoom(nRoomSeq){
	$.ajax({
		url: "/admin/deleteRoomInfo",
		type: "post",
		dataType: 'json',
		data: {"roomSeq":nRoomSeq},
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		success: function(data) {
			if(data.result){
				alert('삭제가 완료되었습니다.');
				table.setData("/admin/getRoomList");
			} else {
				alert(data.message);                    
			}                
		},
		error: function(data) {
			alert('회의실 삭제중 오류가 발생하였습니다.');
		}
	});
}
</script>   
</html>

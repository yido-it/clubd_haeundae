<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="../../common/admin/head.jsp"/>
<jsp:include page="../../common/admin/script.jsp"/> 
<jsp:include page="../../common/kakaomap.jsp"/> 

<link rel="stylesheet" href="../../css/admin/swiper.min.css">
<script type="text/javascript" src="../../js/admin/luxon.min.js"></script>
<script type="text/javascript" src="../../js/admin/swiper.min.js"></script>

<link href="../../css/admin/dropzone.css" rel="stylesheet">
<script src="../../js/admin/dropzone.min.js"></script>

<body>
<sec:authentication property="principal" var="MyName"/>
<sec:authentication property="principal.Authorities" var="myAuth"/>
		
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
								<h5 class="font-weight-bold">지점관리</h5>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card card-margin">
					<div class="form-group row">	
						<div class="col-8"></div>
						<div class="col-4">
							<div class="row">
								<div class="col-4" style="text-align:right">
									<input type="button" class="btn btn-inverse-primary btn-new" style="float:right;width:100%" value="추가" >
								</div>
								<div class="col-4" style="text-align:right">
									<input type="button" class="btn btn-inverse-primary btn-save" style="float:right;width:100%" value="저장" >
								</div>
								<div class="col-4" style="text-align:right">
									<input type="button" class="btn btn-inverse-danger btn-del-loc" style="float:right;width:100%" value="삭제" >
								</div>
							</div>	
						</div>
					</div>	
					
					<!-- 목록 -->
					<div class="row">
						<div class="col-12">
						  <div id="tabList" class="is-bordered" style="margin-top:10px"></div>
						</div>
					</div>
					
					<div class="row" style="border-top: 2px solid black;padding: 20px 2px;margin: 20px 2px;">
							
						<div class="col-6">
							<div>
								<div>지점설명(개요)</div>
								<hr/>
								<textarea class="form-control" id="expln" name="expln" rows="10" class="ckeditor"></textarea>
							</div>
							<hr style="border: solid black 1px;"/>
							<div>
								<div>예약안내</div>
								<hr/>
								<textarea class="form-control" id="bookGuide" name="bookGuide" rows="10" class="ckeditor"></textarea>
							</div>
							<hr style="border: solid black 1px;"/>
							<div>
								<div>취소 및 환불규정</div>
								<hr/>
								<textarea class="form-control" id="cnclGuide" name="cnclGuide" rows="10" class="ckeditor"></textarea>
							</div>
							<hr style="border: solid black 1px;"/>
							<div>
								<div>상세정보</div>
								<hr/>
								<textarea class="form-control" id="" name="detailInfo" rows="10" class="ckeditor"></textarea>
							</div>
						</div>
						<div class="col-6">
							<div class="rows">
								<div>
									<div style="display:inline;">지도</div>
									<hr/>
								</div>
								<div class="col-12">
									<div id="pop_gis" style="height: 500px;">
										<div id="map" style="width: 100%; height: 100%;"></div>
									</div>
								</div>
								<hr style="border: solid black 1px;"/>
								<div>
									<div style="display:inline;">평면도</div>
									<input type="button" class="btn btn-inverse-primary btn-popFlrPln" value="추가" />
									<hr/>
								</div>
								<div class="col-12">
									<div id="pop_flr_pic">
									</div>
								</div>
								<hr style="border: solid black 1px;"/>
								<div>
									<div style="display:inline;">지점사진</div>
									<input type="button" class="btn btn-inverse-primary btn-popLoc" value="추가" />
									<p style="font-size:14px;">(가로,세로의 크기가 1100x420px인 이미지를 추천합니다.)</p>
									<hr/>
									<div id="pop_loc_pic">
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
		
		<input type="hidden" id="lati"/>
		<input type="hidden" id="longi"/>
	</div>

</div>
</body>



<script src="../../js/ckeditor/ckeditor.js"></script>
<script src="../../js/ckeditor/config.js"></script>
<script type="text/javascript">

$("document").ready(function() {
});

var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
var mapOption = { 
    center: new kakao.maps.LatLng(37.563147461477634, 126.97518984688405), // 지도의 중심좌표
    level: 2 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var marker = new kakao.maps.Marker({ 
   });

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        

	// 클릭한 위도, 경도 정보를 가져옵니다 
	var latlng = mouseEvent.latLng;
	marker.setPosition(latlng);
	marker.setMap(map);
	
	$("#lati").val(latlng.getLat());
	$("#longi").val(latlng.getLng());
});
	
//마커표시 후 이동
function setMarker(lat, lng){
	var markerPosition = new kakao.maps.LatLng(lat, lng);
	marker.setPosition(markerPosition);
	marker.setMap(map);
	map.setCenter(markerPosition);
}

$("#map").hide();
$(".btn-popFlrPln").hide();
$(".btn-popLoc").hide();



//
function setLocToGis(sAddr, sName){
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(sAddr, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        marker.setPosition(coords);
	    	marker.setMap(map);
	    	map.setCenter(coords);
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        /*
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+sName+'</div>'
	        });
	        infowindow.open(map, marker);
	        */
	    }else{
	    	setMarker(37.563147461477634, 126.97518984688405);
	    } 
	}); 
}

var myUID = "${myUserId}";
var myAuth = "${myAuth}";
var thisAjaxParams = {}; 

if(myAuth == "[ROLE_AAA001]"){
	thisAjaxParams = {adminId:myUID};
}else{
	thisAjaxParams = {};
}

// 지점 목록 조회 
var table = new Tabulator("#tabList", {
	layout:"fitData",
	placeholder:"데이터가 존재하지 않습니다.",
    pagination:true,
    paginationSize:10,
    paginationInitialPage:1,
    movableColumns:true,
    ajaxURL:"/admin/getLoclist",
    ajaxParams:thisAjaxParams,
    ajaxConfig:"POST",
    selectable:1,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
	columns : [
		{ title: "번호", field : "locSeq", headerHozAlign:"center", hozAlign:"center" },
		{ title: "지점명", field : "name", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "주소", field : "addr", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "전화번호", field : "tel", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "평일시작시간", field : "strtTm", headerHozAlign:"center", hozAlign:"center", editor:"time", headerFilter:"input" },
		{ title: "평일종료시간", field : "endTm", headerHozAlign:"center", hozAlign:"center", editor:"time", headerFilter:"input" },
		{ title: "그레이프여부", field : "cmpyTp", headerHozAlign:"center", hozAlign:"center", editor:"select", editorParams:{values:["그레이프", "그레이프라운지"]}, headerFilter:"input" },
		{ title: "견적서은행", field : "bankNm", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "견적서계좌번호", field : "accntNo", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "상호명", field : "estCorpnm", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "사업자등록번호", field : "estCorpno", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "담당자명", field : "estEmpNm", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "담당자이메일", field : "estEmail", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "담당자연락처", field : "estTel", headerHozAlign:"center", hozAlign:"center", editor:"input", headerFilter:"input" },
		{ title: "면적", field : "area", headerHozAlign:"center", hozAlign:"center", editor:"number", headerFilter:"input" },
		{ title: "회의실수", field : "roomCnt", headerHozAlign:"center", hozAlign:"center", editor:"number", headerFilter:"input" },
		{ title: "정렬순서", field : "ord", headerHozAlign:"center", hozAlign:"center", editor:"number", validator:"max:999999", headerFilter:"input" }
	]
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

//로우가 선택되었을때
table.on("rowSelected", function(row){
	
	selRow = row;
	//테이블이 선택되었다가 다른 로우를 선택할 때 너무 빨라서 에디터가 인식을 못함. 그래서 0.1초후 실행되도록 함.
	var timer = setInterval(function() {
	    
		////
		var tableData = table.getSelectedData()[0];
		
		/** 지도 설정 부분
		 ** 1.좌표가 있다면 좌표로 설정한다.
		 ** 2.주소가 있다면 주소로 설정한다.
		 ** 3.없으면 씨티스퀘어를 설정한다.
		*/

		if( (tableData.lati != 0 && typeof tableData.lati != "undefined" && tableData.lati != null)
				&& (tableData.longi != 0 && typeof tableData.longi != "undefined" && tableData.longi != null) ){
			setMarker(tableData.lati, tableData.longi);
			
		}else if(tableData.addr != '' && typeof tableData.addr != "undefined" && tableData.addr != null){
			setLocToGis(tableData.addr, tableData.name);
			
		}else{
			setMarker(37.563147461477634, 126.97518984688405);
			
		}
	    	
		    CKEDITOR.instances.expln.setReadOnly(false);
		    CKEDITOR.instances.bookGuide.setReadOnly(false);
		    CKEDITOR.instances.cnclGuide.setReadOnly(false);
		    CKEDITOR.instances.detailInfo.setReadOnly(false);
		    
	    if(tableData.locSeq != '' && typeof tableData.locSeq != "undefined" && tableData.locSeq != null){
	    	
		   	CKEDITOR.instances.expln.setData(tableData.expln.replace(/¸/g, ","));	
		    CKEDITOR.instances.bookGuide.setData(tableData.bookGuide.replace(/¸/g, ","));
		    CKEDITOR.instances.cnclGuide.setData(tableData.cnclGuide.replace(/¸/g, ",").replace(/＋/g, "+"));
		    CKEDITOR.instances.detailInfo.setData(tableData.detailInfo.replace(/¸/g, ","));
		    
		    $("#map").show();
			$(".btn-popFlrPln").show();
			$(".btn-popLoc").show();
		    
		    //y면 평면도 조회, "N"이면 지점사진 조회. 사진 업로드 후 개별로 부르기 위해 나눔.
		    selectImage("Y");
		    selectImage("N");
	    ////
	    }
		
	    clearInterval(timer);
	}, 100);
	
    
});

//로우가 선택해제 되었을때
table.on("rowDeselected", function(row){
	CKEDITOR.instances.expln.setData("");
	CKEDITOR.instances.expln.setReadOnly(true);
	CKEDITOR.instances.bookGuide.setData("");
    CKEDITOR.instances.bookGuide.setReadOnly(true);
    CKEDITOR.instances.cnclGuide.setData("");
    CKEDITOR.instances.cnclGuide.setReadOnly(true);
    CKEDITOR.instances.detailInfo.setData("");
    CKEDITOR.instances.detailInfo.setReadOnly(true);
    
    $("#map").hide();
    $(".btn-popFlrPln").hide();
	$(".btn-popLoc").hide();
	$("#pop_flr_pic").empty();
	$("#pop_loc_pic").empty();
	
});

function selectImage(sFlrPlanYn){

	var tableData = table.getSelectedData()[0];
	
	$.ajax({
	    url: "/admin/getImagelist",
	    type: "post",
	    dataType: 'json',
	    data: {"locSeq":tableData.locSeq, "flrPlanYn":sFlrPlanYn, "locYn":"Y", "getLocYn":"Y"},
	    contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	    success: function(data) {
	        if(data.result == false){
	            alert(data.message);
	        } else {
	        	//평면도 등록된 이미지 추가
	        	if(sFlrPlanYn=="Y"){
	        		var sHtml = "";
	        		$("#pop_flr_pic").empty();
	        		for(var i=0; i<data.length; i++){
						sHtml += "<img src='/store/" + data[i].filePath1 + "' class='img" + data[i].imgSeq + "' width='600px'/>"
						sHtml += "<input type='button' class='btn btn-inverse-danger btn_del_pic' value='삭제' data-img-seq='" + data[i].imgSeq + "'";
						sHtml += " data-filePath1='" + data[i].filePath1 + "' data-filePath2='" + data[i].filePath2 + "' style='margin-top:10px'/>"
	        		}
	        		$("#pop_flr_pic").append(sHtml);
	        	}else{
	        		var sHtml = "";
	        		$("#pop_loc_pic").empty();
	        			sHtml += "<div class='swiper-container'>";
	        			sHtml += "	<div class='swiper-wrapper' style='height:auto;'>";
	        		for(var i=0; i<data.length; i++){
	        			sHtml += "		<div class='swiper-slide' style='text-align:center;'>";
						sHtml += "			<img src='/store/" + data[i].filePath1 + "' class='img" + data[i].imgSeq + "' width='600px' />";
						
						sHtml += "			<div style='margin-top:10px;padding-left:50px'>";
						sHtml += "			<div style='display: inline; vertical-align: bottom; width:20%'>";
						sHtml += "				<input type='button' class='btn btn-inverse-danger btn_del_pic' value='삭제' data-img-seq='" + data[i].imgSeq + "'";
						sHtml += "			 		data-filePath1='" + data[i].filePath1 + "' data-filePath2='" + data[i].filePath2 + "'";
						sHtml += "			 		data-ord='" + data[i].ord + "' style='float:left'/></div>";
						
						
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
	        		$("#pop_loc_pic").append(sHtml);
	        		
	        		new Swiper(".swiper-container", {
	        			navigation: {
	        			    prevEl: ".swiper-button-prev",
	        			    nextEl: ".swiper-button-next",
	        			  }
	        		});
	        	}
	        }                
	    },
	    error: function(data) {
	        alert('이미지 조회 중 오류가 발생하였습니다.');
	    }
	});
}

//저장 버튼 클릭
$('.btn-save').on('click', function(){
	
	if(table.getSelectedData() == null || table.getSelectedData() == ""){
		alert("지점이 선택되지 않았습니다. 지점을 선택해 주세요.");
		return;
	}
	
	var tableData = table.getSelectedData()[0];
	
	if(tableData.tel != '' && typeof tableData.tel != "undefined" && tableData.tel != null){
		tableData.tel = tableData.tel.replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-");
	}

	if(tableData.cmpyTp == '' || typeof tableData.cmpyTp == "undefined" || tableData.cmpyTp == null){
		alert("그레이프여부가 선택되지 않았습니다.");
		return;
	}
	
	if(tableData.bankNm == '' || typeof tableData.bankNm == "undefined" || tableData.bankNm == null){
		alert("견적서은행이 입력되지 않았습니다.");
		return;
	}
	
	if(tableData.accntNo == '' || typeof tableData.accntNo == "undefined" || tableData.accntNo == null){
		alert("계좌번호가 입력되지 않았습니다.");
		return;
	}
	
	if(tableData.area == '' || typeof tableData.area == "undefined" || tableData.area == null){
		alert("면적이 입력되지 않았습니다.");
		return;
	}	
	
	if(tableData.ord > 999999){
		alert("정렬순서 값이 너무 큽니다.");
		return;
	}
	
	if(tableData.roomCnt == '' || typeof tableData.roomCnt == "undefined" || tableData.roomCnt == null){
		alert("회의실수가 입력되지 않았습니다.");
		return;
	}
	
	if(tableData.roomCnt > 999999){
		alert("회의실수 값이 너무 큽니다.");
		return;
	}
	
	if(tableData.strtTm == '' || typeof tableData.strtTm == "undefined" || tableData.strtTm == null){
		alert("평일시작시간을 입력해주세요.");
		return;
	}
	
	if(tableData.endTm == '' || typeof tableData.endTm == "undefined" || tableData.endTm == null){
		alert("평일종료시간을 입력해주세요.");
		return;
	}	
	
	if(tableData.estCorpnm != undefined && tableData.estCorpnm.length > 50){
		alert("견적서 상호명 값이 너무 큽니다.");
		return;
	}
	if(tableData.estCorpno != undefined && tableData.estCorpno.length > 12){
		alert("견적서 사업자등록번호 값이 너무 큽니다.");
		return;
	}
	if(tableData.estEmpNm != undefined  && tableData.estEmpNm.length > 10){
		alert("담당자명 값이 너무 큽니다.");
		return;
	}
	if(tableData.estEmail != undefined  && tableData.estEmail.length > 20){
		alert("담당자 이메일 값이 너무 큽니다.");
		return;
	}
	if(tableData.estTel != null){
		if(tableData.estTel.length > 20){
			alert("담당자 연락처 값이 너무 큽니다.");
			return;
		}
	}
	
	var ajaxUrl = '';
    if(tableData.locSeq != '' && typeof tableData.locSeq != "undefined" && tableData.locSeq != null) {
    	// 수정
    	ajaxUrl = "/admin/updateLocInfo";
    } else {
    	// 등록 
    	ajaxUrl = "/admin/insertLocInfo";
    }
    
    var nOrd = 0;
    if(tableData.ord == '' || typeof tableData.ord == "undefined" || tableData.ord == null){
   		nOrd = 999999; 	
   	}else{
   		nOrd = tableData.ord;
   	}
    
    tableData.addr = tableData.addr.replace(/,/g, "¸");
    
    var textExpln = CKEDITOR.instances.expln.getData().replace(/,/g, "¸");
    var textBookGuide = CKEDITOR.instances.bookGuide.getData().replace(/,/g, "¸");
    	textBookGuide = textBookGuide.replace(/%/g, "％");
    var textCnclGuide = CKEDITOR.instances.cnclGuide.getData().replace(/,/g, "¸");
    	textCnclGuide = textCnclGuide.replace(/%/g, "％");
    	textCnclGuide = textCnclGuide.replace(/\+/g, "＋");
    var textDetailInfo = CKEDITOR.instances.detailInfo.getData().replace(/,/g, "¸");
    var textEstTel = (tableData.textEstTel == null ? "" : tableData.textEstTel); 
    var textTel = (tableData.tel == '' || typeof tableData.tel == "undefined" || tableData.tel == null ? "" : tableData.tel);

    console.log(CKEDITOR.instances.expln.getData());
    console.log(CKEDITOR.instances.bookGuide.getData());
    
     $.ajax({
        url: ajaxUrl,
        type: "post",
        dataType: 'json',
        data: $('#locForm').serialize() 
        	+ "&locSeq="+(ajaxUrl == "/admin/updateLocInfo" ? tableData.locSeq : "")
            + "&name="+(tableData.name == '' || typeof tableData.name == "undefined" || tableData.name == null ? "" : tableData.name)
        	+ "&addr="+(tableData.addr == '' || typeof tableData.addr == "undefined" || tableData.addr == null ? "" : tableData.addr)
        	+ "&tel="+textTel
        	+ "&strtTm="+tableData.strtTm
        	+ "&endTm="+tableData.endTm
        	+ "&expln="+textExpln
        	+ "&area="+tableData.area
        	+ "&roomCnt="+tableData.roomCnt
        	+ "&bookGuide="+textBookGuide
        	+ "&cnclGuide="+textCnclGuide
        	+ "&detailInfo="+textDetailInfo
        	+ "&cmpyTp="+tableData.cmpyTp
        	+ "&bankNm="+tableData.bankNm
        	+ "&accntNo="+tableData.accntNo
        	
        	+ "&estCorpnm="+tableData.estCorpnm
        	+ "&estCorpno="+tableData.estCorpno
        	+ "&estEmpNm="+tableData.estEmpNm
        	+ "&estEmail="+tableData.estEmail

        	+ "&estTel="+tableData.estTel
        	
        	+ "&ord="+nOrd
        	+ "&lati="+$("#lati").val()
        	+ "&longi="+$("#longi").val()
        	,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('저장이 완료되었습니다.');
                table.setData().then(function(){
                	CKEDITOR.instances.expln.setData("");
                	CKEDITOR.instances.expln.setReadOnly(true);
                	CKEDITOR.instances.bookGuide.setData("");
                    CKEDITOR.instances.bookGuide.setReadOnly(true);
                    CKEDITOR.instances.cnclGuide.setData("");
                    CKEDITOR.instances.cnclGuide.setReadOnly(true);
                    CKEDITOR.instances.detailInfo.setData("");
                    CKEDITOR.instances.detailInfo.setReadOnly(true);
                    
                    $("#map").hide();
                    $(".btn-popFlrPln").hide();
                	$(".btn-popLoc").hide();
                	$("#pop_flr_pic").empty();
                	$("#pop_loc_pic").empty();
                });
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('지점 등록(변경)중 오류가 발생하였습니다.');
        }
    });
});	 

//추가 버튼 클릭 
$('.btn-new').on('click', function(){
	table.addData([{strtTm:"08:00", endTm:"18:00"}])
	.then(function(rows){
		table.deselectRow();
		table.selectRow(rows);	
	});
	
});	

//에디터
var ckeditor_config = {
        enterMode: CKEDITOR.ENTER_BR, // 엔터키를 <br> 로 적용함.
        shiftEnterMode: CKEDITOR.ENTER_P,  // 쉬프트 +  엔터를 <p> 로 적용함.
        toolbarCanCollapse: true,
        allowedContent: true,
        removePlugins: 'iframe', // DOM 출력하지 않음
        imgUploadUrl: '/admin/editorImgUpload?type=editor',//&schlCd='+schlCd+'&bbsId='+bbsId,
        filebrowserUploadUrl: '/admin/editorImgUpload?type=editor', //&schlCd='+schlCd+'&bbsId='+bbsId,
        uploadUrl:'/admin/editorImgUploadPaste?type=editor&responseType=json',
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
        disallowedContent: 'img{width, height}',
        readOnly: true
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
            imgUploadUrl: '/admin/editorImgUpload?type=editor',//&schlCd='+schlCd+'&bbsId='+bbsId,
            filebrowserUploadUrl: '/admin/editorImgUpload?type=editor', //&schlCd='+schlCd+'&bbsId='+bbsId,
            uploadUrl:'/admin/editorImgUploadPaste?type=editor&responseType=json',
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
            disallowedContent: 'img{width, height}',
            readOnly: true
        };

        CKEDITOR.replace('bookGuide', ckeditor_config);

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
                imgUploadUrl: '/admin/editorImgUpload?type=editor',
                filebrowserUploadUrl: '/admin/editorImgUpload?type=editor',
                uploadUrl:'/admin/editorImgUploadPaste?type=editor&responseType=json',
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
                disallowedContent: 'img{width, height}',
                readOnly: true
            };

            CKEDITOR.replace('cnclGuide', ckeditor_config);

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
                imgUploadUrl: '/admin/editorImgUpload?type=editor',
                filebrowserUploadUrl: '/admin/editorImgUpload?type=editor',
                uploadUrl:'/admin/editorImgUploadPaste?type=editor&responseType=json',
                toolbar: [
                    ['Source', '-', 'NewPage', 'Preview'],
                    ['Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo'],
                    ['Bold', 'Italic', 'Underline', 'Strike'],
                    ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
                    '/',
                    ['Styles', 'Format', 'Font', 'FontSize'],
                    ['TextColor', 'BGColor'],
                    ['ImgUpload', 'Flash', 'Table', 'SpecialChar', 'Link', 'Unlink']
                ],
                height: '349px',
                width: '382px',
                font_defaultLabel: '맑은고딕',
                font_names: '맑은고딕',
                fontSize_defaultLabel: '16px',
                fontSize_sizes: '16px',
                disallowedContent: 'img{width, height}',
                readOnly: true
            };

            CKEDITOR.replace('detailInfo', ckeditor_config);

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
                selectImage("Y");
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
            alert('지점사진 순서변경 중 오류가 발생하였습니다.');
        }
    });
});

//평면도 추가
$('.btn-popFlrPln').on('click', function(){
	if(table.getSelectedData() == null || table.getSelectedData() == ""){
		alert("지점이 선택되지 않았습니다. 번호를 눌러서 지점을 선택해 주세요.");
		return;
	}
	
    $(".modal-content").load('/admin/flrPlnPop').fadeIn("fast");
    $('#popModal').modal('show');
});	

//지점사진 추가
$('.btn-popLoc').on('click', function(){
	if(table.getSelectedData() == null || table.getSelectedData() == ""){
		alert("지점이 선택되지 않았습니다. 번호를 눌러서 지점을 선택해 주세요.");
		return;
	}
	
    $(".modal-content").load('/admin/locPop').fadeIn("fast");
    $('#popModal').modal('show');
});

//등록/수정 팝업창 닫힐때
$('#popModal').on('hidden.bs.modal', function () {
	selectImage("Y");
    selectImage("N");
});

//지점삭제
$('.btn-del-loc').on('click', function(){
	   
	var sel = table.getSelectedData();
    if(sel.length == 0){
       alert("삭제할 지점을 선택해주세요.");
       return;
    } else {
        data = sel[0];
        if(!confirm(data.name+')지점을 삭제하시겠습니까?')) return;
        fnDeleteLoc(data.locSeq);           
    }
});

function fnDeleteLoc(nLocSeq){
	$.ajax({
        url: "/admin/deleteLocInfo",
        type: "post",
        dataType: 'json',
        data: {"locSeq":nLocSeq},
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('삭제가 완료되었습니다.');
                table.setData("/admin/getLoclist");
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('지점 삭제중 오류가 발생하였습니다.');
        }
    });
}

//대표사진이 바뀌면 일어나는 이벤트
$(document).on('click', '.btn-repr', function (e) {
	
	if(!confirm("대표사진으로 설정할까요?")){
		return;
	}
	
	$(this).parents("div").parents("div").children(".ordDiv").children(".ordNum").val(0);
	$(this).parents("div").parents("div").children(".ordDiv").children(".ordNum").trigger("change");
});

</script>   


</html>

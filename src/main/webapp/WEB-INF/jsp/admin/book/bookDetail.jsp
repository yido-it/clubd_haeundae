<!-- 
관리자 > 예약관리 > 예약정보
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:parseDate value="${book.bookReqDt}" pattern="yyyy-MM-dd'T'HH:mm" var="bookReqDt" type="both"/>
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
								<h3 class="font-weight-bold">예약정보</h3>
							</div>
						</div>
					</div>
					<div class="col-md-6 grid-margin-sm-0" style="text-align:right">
						<div class="row">
							<div class="col-12 col-xl-12 mb-12 mb-xl-0">
								<span class="menuRoute">예약관리 > 예약정보</span>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-margin">
				
					<div style="padding:10px 20px 0 0;text-align:right">
						<c:if test="${book.bookSttsCd == '100001'}">
						<button type="button" id="btnInsert" class="btn btn-inverse-primary btn-fw">
							추가
						</button>		
						</c:if>		
						<button type="button" id="btnSave" class="btn btn-inverse-primary btn-fw">
							저장
						</button>				
					</div>	
							
					<div class="card-body" style="padding:0.25rem 1.25rem">
						<form name="frmBook" id="frmBook" method="post">
						<input type="hidden" value="${totalCnt}" id="totalCnt" name="totalCnt" />
						<input type="hidden" value="${book.locSeq}" id="locSeq" name="locSeq" />
						<input type="hidden" value="${book.bookCd}" id="bookCd" name="bookCd" />
						<input type="hidden" value="${book.bookStrtDt}" id="bookStrtDt" name="bookStrtDt" />
						<input type="hidden" value="${book.bookEndDt}" id="bookEndDt" name="bookEndDt" />
						<input type="hidden" value="N" id="reloadYn" name="reloadYn" />
						<table class="bkDetail" border="1" >
							<tbody>
							<tr> 
								<th>예약코드</th>
								<td style="padding-left:8px">${book.bookCd}</td>
								
								<th>예약신청일자</th>
								<td style="padding-left:8px"><fmt:formatDate value="${bookReqDt}" pattern="yyyy-MM-dd HH:mm"/></td>
							
								<th>예약상태</th>
								<td>
									<c:if test="${book.bookSttsCd != '100004'}">
									<select class="form-select col-valid" id="bookSttsCd" name="bookSttsCd" style="width:150px;" data-colname="예약상태">
										<option value="" selected>전체</option>
										
										<c:forEach items="${roomSttsCodes}" var="stts">
											<option value="${stts.cmnCd}" <c:if test="${stts.cmnCd==book.bookSttsCd}">selected</c:if>>${stts.cmnNm}</option> 
										</c:forEach>
									</select> 
									</c:if>
									
									<c:if test="${book.bookSttsCd == '100004'}">
									${book.bookSttsNm}
									</c:if>
								</td>
							</tr>
							<tr> 
								<th>예약자명</th>
								<td>
									<input type="text" class="form-control form-control-sm col-valid" id="name" name="name" value="${book.name}" data-colname="예약자명"/>
								</td>
								
								<th>예약자연락처</th>
								<td>
									<input type="text" class="form-control form-control-sm col-valid" id="tel" name="tel" value="${book.tel}" data-colname="예약자연락처"/>
								</td>
								
								<th>예약자이메일</th>
								<td>
									<input type="text" class="form-control form-control-sm col-valid" id="email" name="email" value="${book.email}" data-colname="예약자이메일"/>
								</td>
							</tr>
							<tr> 
								<th>총금액</th>
								<td style="padding-left:8px" >
									<span class="txtBookAmt"><fmt:formatNumber value="${book.bookAmt}" pattern="#,###" />원</span>								
									<input type="hidden" id="bookAmt" name="bookAmt" value="${book.bookAmt}"/>
								</td>
								
								<th>할인금액</th>
								<td>
									<input type="text" class="form-control form-control-sm" id="dcAmt" name="dcAmt" value="${book.dcAmt}"/>
								</td>
								
								<th>결제금액</th>
								<td style="padding-left:8px"  class="txtPayAmt"> 
									<span class="txtPayAmt"><fmt:formatNumber value="${book.payAmt}" pattern="#,###" />원</span>	
									<input type="hidden" id="payAmt" name="payAmt" value="${book.payAmt}"/>
								</td>
							</tr>
							<tr> 
								<th>예약요청사항</th>
								<td colspan="5" align="left">
									<textarea class="form-control" cols="50" rows="3" id="reqCnts" name="reqCnts" style="padding:5px;resize: vertical">${book.reqCnts}</textarea>
								</td>
							</tr>
							</tbody>
						</table>
						</form>
						
						<div style="margin:20px 0 10px 0">
							<i class='mdi mdi-18px mdi-format-list-bulleted'></i>
							<span class="mdi_txt_2">예약상세</span>
						</div>
						<!-- 예약상세 목록 -->
						<div id="tabList" class="is-bordered" style="width:900px"></div>
					</div>   
 				 </div>
 			
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-hidden="true" data-focus="false" data-backdrop="static" data-keyboard="false">
		    <div class="modal-dialog modal-dialog-centered modal-xl" id="popModal2" role="document">
		        <div class="modal-content">
		
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
	// 예약신청의 경우만 삭제가능하도록 
	if ( ${book.bookSttsCd} == '100001') {
		return "<i class='mdi mdi-24px mdi-close-circle'></i>";
	} else {
		return "-";
	}
}

var searchUrl = "";
if (${book.bookSttsCd} == '100004') {
	searchUrl = "/admin/bkDetailLog/groupByList";
} else {
	searchUrl = "/admin/bkDetail/list";
}

var searchParam = function(){
    return { bookCd : ${book.bookCd} }
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
    paginationSize:10,
    paginationSizeSelector:[10,30,50,100],
    movableColumns:true,
    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
        return "총 " + totalRows + "건";
    },
    columnHeaderVertAlign:"middle",
	columns : [
		 { title:"지점명", field:"locNm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"list", headerFilterParams:{valuesURL:"/admin/getLocNmList"}} 
		,{ title:"회의실명", field:"roomNm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"}  
		,{ title:"예약일자", field:"bookDt", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"}  
		,{ title:"예약시간", field:"strtTm", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"}  
		,{ title:"대여금액", field:"fee", sorter:"string", hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerFilter:"input"
			, formatter:"money", formatterParams:{thousand:",", symbol:"원", symbolAfter:"p", precision:false }}
		,{ title: "삭제", field:"btnDelete", formatter: deleteIcon, width:100,hozAlign:"center", vertAlign:"middle", headerHozAlign:"center", headerSort:false,
			cellClick:function(e, cell){
				if ( ${book.bookSttsCd} == '100001') {
					// 예약신청의 경우만 삭제가능하도록 
					var message = "";
					if ( $('#totalCnt').val() == 1 ) {
						message = "해당 예약건의 예약상태가 [예약취소신청]으로 변경됩니다. 삭제하시겠습니까?";
					} else {
						message = "삭제하시겠습니까?";
					}
					if(confirm(message)){
						cell._cell.row.delete();
						fnDelete(cell._cell.row.data.bookSeq, cell._cell.row.data.bookCd, cell._cell.row.data.fee); 
					}
				} 
			}
		}
			
	]
    
	, locale:true
	, langs:{
		"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
	}
});

//삭제 
function fnDelete(bookSeq, bookCd, fee){

	$.ajax({
        url: '/admin/deleteBookDetail',
        type: "post",
        dataType: 'json',
        data: {
        	"bookSeq": bookSeq
        	, "bookCd": bookCd
        	, "fee": fee
        },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result == false){
                alert(data.message);
            } else {
            	alert('삭제되었습니다.');
            	location.reload();
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
	$(".modal-content").load('/admin/popInsertBook?bookCd='+$('#bookCd').val()+'&locSeq='+$('#locSeq').val()).fadeIn("fast");
	$('#popModal').modal('show');  
});

//저장 버튼 클릭시 
$('#btnSave').on('click', function(){

	// 빈값확인
    var rtnCd = false;
    $('.col-valid').each(function(){
        if($(this).val()=='' && $(this).data('colname') != undefined) {
            alert($(this).data('colname') + ' 을(를) 입력해주세요.');
            rtnCd = true;
            return false;
        }
    });
    if(rtnCd) return;
    
    $.ajax({
        url: "/admin/updateBook",
        type: "post",
        dataType: 'json',
        data: $('#frmBook').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
               	alert('수정이 완료되었습니다.');
               	location.reload();
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('등록중 오류가 발생하였습니다.');
        }
    });    
});

// 팝업창 닫힐때 ..
$('#popModal').on('hidden.bs.modal', function () {

	// 변경된 내용이 있을때 페이지 새로고침
	if ($('#reloadYn').val() == 'Y') {
		location.reload();
	}
});   
</script>
</html>



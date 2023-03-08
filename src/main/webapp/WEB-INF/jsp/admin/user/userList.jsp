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
								<h5 class="font-weight-bold">사용자관리</h5>
							</div>
						</div>
					</div>
				</div>
	
				<div class="card card-margin" style="width:1100px">
					<div class="form-group row">	
						<div class="col-12" style="text-align:right">
						<input type="button" class="btn btn-inverse-primary btn-new" value="등록" >
						</div>
					</div>	
					
					<!-- 목록 -->
					<div class="row">
						<div class="col-12">
						  <div id="tabList" class="is-bordered" style="margin-top:10px"></div>
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
</div>
</body>

<script type="text/javascript">

var editorIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-table-edit'></i>";
}
	
var deleteIcon = function(cell, formatterParams, onRendered) {
	return "<i class='mdi mdi-24px mdi-delete'></i>";
}
	
// 사용자 목록 조회 
var	table = new Tabulator("#tabList", {
		layout:"fitColumns",
		placeholder:"데이터가 존재하지 않습니다.",
	    pagination:true,
	    paginationSize:10,
	    paginationInitialPage:1,
	    movableColumns:true,
	    ajaxURL:"/user/getUserList",
	    ajaxParams:{},
	    ajaxConfig:"POST",
	    paginationCounter:function(pageSize, currentRow, currentPage, totalRows, totalPages){
	        return "총 " + totalRows + "건";
	    },
		columns : [
			{ title: "사용자ID", field : "userId", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
			{ title: "이름", field : "userNm", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
			{ title: "권한", field : "userAuthNm", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
			{ title: "관리지역", field : "locName", sorter: "string", headerHozAlign:"center", hozAlign:"center", headerFilter:"input" },
		    { 
				// 수정버튼 
				title: "수정", formatter: editorIcon, width:100, minWidth:100, headerHozAlign:"center", hozAlign:"center", resizable:false, headerSort:false,
		     	cellClick:function(e, cell){
					var userId = cell._cell.row.data.userId;
		        	var url = '/admin/popUserInfo?userId=' + userId;
		   
		        	$(".modal-content").load(url).fadeIn("fast");
		            $('#popModal').modal('show');
		      	}
		    } ,
			{ 
		    	// 삭제버튼
		    	title: "삭제", formatter: deleteIcon, width:100, minWidth:100, headerHozAlign:"center", hozAlign:"center", resizable:false, headerSort:false,
				cellClick:function(e, cell){
					if(confirm("삭제하시겠습니까?")){
						cell._cell.row.delete();
						fnDeleteUser(cell._cell.row.data.userId);
					}
				}
			}
		]
		, locale:true
		, langs:{
			"ko":{"pagination":{"page_size":"", "first":"<<", "last":">>", "prev":"<", "next":">"}}
		}
	});

table.clearData();
table.setData();

// 삭제 
function fnDeleteUser(userId){
	
	$.ajax({
        url: "/user/deleteUser",
        type: "post",
        dataType: 'json',
        data: {userId:userId},
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result == false){
                alert(data.message);
            } else {
                alert('삭제되었습니다.');
                $('#grid').DataTable().ajax.reload();
            }                
        },
        error: function(data) {
            alert('현장 삭제중 오류가 발생하였습니다.');
        }
    });
}

// 추가 버튼 클릭 
$('.btn-new').on('click', function(){
    $(".modal-content").load('/admin/popUserInfo').fadeIn("fast");
    $('#popModal').modal('show');
});	

// 등록/수정 팝업창 닫힐때 ..
$('#popModal').on('hidden.bs.modal', function () {
	table.setData();
});   

</script>   
</html>

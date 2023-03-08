<!-- 
예약 취소 팝업창
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header"> 
		<h4 class="modal-title" id="myModalLabel">예약 취소</h4>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-12 mt-2">
				<div class="row ">
					<div class="col-md-12 text-center">   
						<i class="fa-solid fa-circle-xmark" style="font-size: 40px;color: #7b559f;margin-bottom: 20px;"></i>
						<h4>예약을 정말 취소하시겠습니까?</h4>
						<p>취소하신 예약은 복원되지 않습니다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-primary btn-md btnCancel" >취소하기</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
</div>

<script>
//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
});
// 취소하기 버튼 
$('.btnCancel').on('click', function(){

	$.ajax({
        url: "/bookCancel/"+${bookCd},
        type: "post",
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result == false){
                alert(data.message);
            } else {
                alert('취소되었습니다.');
            	$('#popModal').modal('hide');
            }                
        },
        error: function(data) {
            alert('취소중 오류가 발생하였습니다.');
        }
    });
	
});
</script>

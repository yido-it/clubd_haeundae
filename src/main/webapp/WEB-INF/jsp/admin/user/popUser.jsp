<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">사용자 관리</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<form id="frmUser">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">사용자ID</label>
						<div class="col-sm-9">
							<input type="text" class="form-control col-valid" style="width: 50%;display:inline" name="userId" id="userId" data-colname="사용자ID" value="${info.userId }" ${info.userId!=null ? 'readonly': ''}>
							<!-- 중복확인 -->
							<c:if test='${info.userId == null}'>
								<button type="button" class="btn btn-dark btn-dupl" style="height: 40;margin-left:10px;display:inline" ${info.userId!=null ? 'disabled': ''}>중복확인</button>
							</c:if>
							<input type="hidden" id="chkYn" value="${info.userId!=null ? 'true': 'false'}"> 
							<input type="hidden" id="oriUserId" value="${info.userId}" />
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">비밀번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control col-valid" name="userPwd" id="userPwd" data-colname="비밀번호" data-toggle="tooltip" value="${info.userPwd != null ? '******' : '' }" />
						</div>
					</div>
				</div>
			</div>
			

			<div class="row">
				<div class="col-md-6">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="userNm" id="userNm" data-colname="이름" value="${info.userNm}">
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">권한</label>
						<div class="col-sm-9">
							
							<select class="form-control border-red site-info " name="userAuth" id="userAuth" data-colname="권한" style="width: 40%;display:inline">
								<option value="">선택</option>
								<c:forEach items="${authList}" var="list" varStatus="i">
									<option value="${list.cmnCd}" <c:if test="${info.userAuth==list.cmnCd}">selected</c:if>>${list.cmnNm}</option>
								</c:forEach>
							</select>
							
							<select class="form-control border-red site-info " name="locSeq" id="locSeq" data-colname="지역" style="width: 50%;display:inline">
								<option value="">선택</option>
								<c:forEach items="${locList}" var="listLoc" varStatus="i">
									<option value="${listLoc.locSeq}" <c:if test="${info.locSeq==listLoc.locSeq}">selected</c:if>>${listLoc.name}</option>
								</c:forEach>
							</select>
					
						</div>
					</div>
				</div>
			</div>
			
	
		</form>

	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-primary btn-save">
			<i class="far fa-check-circle"></i>저장
		</button>
		<button type="button" class="btn btn-outline-light btn-close">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script>

//전체사용자라면 초기지역코드 숨김
if($('#userAuth').val() == "AAA001"){
	$('#locSeq').show();
}else{
	$('#locSeq').hide();
}
   
//userId 중복확인
$('.btn-dupl').on('click', function(){
    if($('#userId').val()==''){
        alert('사용자ID를 입력해주세요.');
        return;
    }
    
    $.ajax({
        url: "/user/checkUserId",
        type: "post",
        dataType: 'json',
        data: {userId:$('#userId').val()},
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
        	//사용가능
            if(data.result){
            	alert('사용가능한 ID입니다.');
                $('#chkYn').val(true);
                $('#userId').removeClass('border-red');
                
            } else {
            	alert('이미 사용중인 ID입니다.');
                $('#chkYn').val(false);
                $('#userId').addClass('border-red');
            }                
        },
        error: function(data) {
            alert('ID중복체크중 오류가 발생하였습니다..');
        }
    });    
});


//userId 변경시 중복체크 확인
$('#userId').on('change', function(){
    $('#chkYn').val(false);
    $('#userId').addClass('border-red');
    
    var chkKor = /[\ㄱ-ㅎ ㅏ-ㅣ 가-힣]/gi;
    var chkSpc = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
    if($(this).val().search(/\s/) != -1){
    	alert('ID는 공백을 포함할수 없습니다.');
    	$(this).val('');
    }
    if( chkKor.test($(this).val()) ){
    	alert('ID는 한글을 포함할수 없습니다.');
    	$(this).val('');
    }
    if( chkSpc.test($(this).val()) ){
        alert('ID로 사용할 수 없는 특수문자가 포함되었습니다.');
        $(this).val('');
    }
});

//저장버튼 클릭
$('.btn-save').on('click', function(){
	
	//중복 확인 실패
	if($('#oriUserId').val() == '') {

		// 조건문 수정 - 배은화 (2022-09-15)
		if( $('#chkYn').val() == "false" ){
	        alert('ID중복체크를 해주세요.');
	        return false;
	    }
	}
	
	//빈값확인
    var rtnCd = false;
    $('.col-valid').each(function(){
        if($(this).val()=='' && $(this).data('colname') != undefined) {
            alert($(this).data('colname') + '을(를) 입력해주세요.');
            rtnCd = true;
            return false;
        }
    });
    if(rtnCd) return;
    
    var ajaxUrl = '';
    if($('#oriUserId').val() != '') {
    	// 수정
    	ajaxUrl = "/user/updateUserInfo";
        if($('#userPwd').val() != '******') $('#userPwd').attr('name', 'userPwd');
    } else {
    	// 등록 
    	ajaxUrl = "/user/insertUserInfo";
        $('#userPwd').attr('name', 'userPwd');        	 
    }        
    
    if($("#locSeq").val() == ""){
    	$("#locSeq").val(0)
    }
    
    $.ajax({
        url: ajaxUrl,
        type: "post",
        dataType: 'json',
        data: $('#frmUser').serialize(),
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
            if(data.result){
                alert('저장이 완료되었습니다.');
                $('#popModal').modal('hide');
            } else {
                alert(data.message);                    
            }                
        },
        error: function(data) {
            alert('사용자 등록중 오류가 발생하였습니다.');
        }
    });
});


//팝업닫기버튼
$('.btn-close').on('click', function(){
	$('#popModal').modal('hide');
});

$('#userAuth').on('change', function(){
	if($(this).val() == "AAA001"){
		$('#locSeq').show();
	}else{
		$('#locSeq').hide();
	}
}); 

</script>

<style>
.border-red {
	border-color: red
}

.input-group-text {
	min-width: 120;
}
.required {
	color: red;
	padding-left: 5px;
	padding-right: 5px;
	font-size: 6px;
}
</style>

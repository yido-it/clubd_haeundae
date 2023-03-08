<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h5 class="modal-title" id="exampleModalLongTitle">지점사진 업로드</h5>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="card-body">
		<div class="row mb-2">
			<div class="input-group col-md-12">
				<div class="dropzone dz-clickable" id="file-dropzone" style="width:84.3%">
					<div class="dz-message text-center">
						<span style="">첨부할 사진을 마우스로 끌어서 추가할 수 있습니다.</span>
					</div>
				</div>
			</div>
			<div class="input-group col-sm-6">
				<div class="input-group-prepend">
					<span class="input-group-text">순번(미입력시 자동 입력됩니다.)</span>
				</div>
				<input type="number" class="form-control" style="width: 35%;" name="ord" id="ord" value="">
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-primary btn-save-loc">
			<i class="far fa-check-circle"></i>저장
		</button>
		<button type="button" class="btn btn-default btn-close-loc">
			<i class="far fa-times-circle"></i>닫기
		</button>
	</div>
</div>

<script type="text/javascript">

var tableData = table.getSelectedData()[0];
/* 드롭다운 이벤트 */
Dropzone.autoDiscover = false;
var myDropzone = new Dropzone("div#file-dropzone", { 
    	autoProcessQueue : false,
        url: "/admin/flrPlnUpload?locSeq=" + tableData.locSeq + "&flrPlanYn=N&roomSeq=0&ord="+$("#ord").val() , // 드롭다운 시 업로드 되는 URL
        maxFilesize: 10, // MB 드롭다운 시 파일 크기
    	resizeQuality: 1,
    	//resizeHeight: 1024,
    	resizeWidth: 960,
        parallelUploads: 100,
        dictFileTooBig: "파일이 너무 큽니다.({{filesize}}MB) {{maxFilesize}}MB까지 가능합니다!",
        paramName: "file",
        addRemoveLinks: true,
        acceptedFiles: "image/*",
        uploadMultiple:true,
        init: function() {
        	this.on('drop', function(file) {
	 	          $(".upload-progress").show();
	 	    });
	 	    
	   		//모든 업로드가 완료됬을때
	   		this.on("queuecomplete", function(file){
	   			alert('파일이 등록 되었습니다.');
	   			$('#popModal').modal('hide');
	   		});
	   		
	   		this.on('sending', function(file, xhr, formData){

	   		});
	   		
	   		this.on("thumbnail", function(file) {
                if (file.size < 10000) {
                    alert("이미지가 너무 작습니다. 새로운 이미지를 올려주세요.");
                }
            });
        }
	});

//이미지 업로드
$('.btn-save-loc').on('click', function(){
	myDropzone.processQueue();
});

//팝업닫기버튼
$('.btn-close-loc').on('click', function(){
	$('#popModal').modal('hide');
});

</script>
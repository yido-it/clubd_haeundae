<!-- 
예약 > 회의실 자세히보기 팝업창
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<!-- 회의실 이름 -->
		<h4 class="modal-title" id="myModalLabel">${room.name}</h4>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	
	<div class="modal-body">
				
		<!-- ┌─────────── 회의실 이미지 슬라이드 ───────────┐ -->
		<c:choose> 
		<c:when test="${fn:length(imgs) > 0}">
		<div id="carouselExampleControls1" class="carousel slide" data-ride="carousel">
	
			<ol class="carousel-indicators">
			<li data-target="#carouselExampleControls1" data-slide-to="0" class="active"></li>
			<li data-target="#carouselExampleControls1" data-slide-to="1"></li>
			<li data-target="#carouselExampleControls1" data-slide-to="2"></li>
			<li data-target="#carouselExampleControls1" data-slide-to="3"></li>
			</ol>
	
			<!-- 이미지 표출 -->
			<div class="carousel-inner object_image">
		    <c:forEach items="${imgs }" var="list" varStatus="i">
		        <div class="carousel-item <c:if test="${i.index == 0}"> active</c:if>">
                    <img class="d-block w-100" src="/store/${list.filePath1}" onerror="this.src='/img/no_image.png';">
                </div>
		    </c:forEach>
			</div>

			<a class="carousel-control-prev" href="#carouselExampleControls1" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carouselExampleControls1" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		</c:when> 
		<c:otherwise>
			등록된 이미지가 없습니다.
		</c:otherwise> 
		</c:choose> 
		<!-- └─────────── 회의실 이미지 슬라이드 ───────────┘ -->
	
		<div class="row">
			<div class="col-12 mt-2">
				<!-- 회의실 이름 -->
				<h4 class="mt-2">${room.name}</h4>
				
				<!-- 회의실 설명-->
				<p> 
					<c:if test="${room.expln == null}">
						회의실 설명을 등록해주세요.
					</c:if>
					<c:if test="${room.expln != null}">
						${room.expln}
					</c:if>
				</p>
	
				<!-- 시설안내-->
				<h4 class="mt-2"> 시설안내</h4>
				<p> 
					<c:if test="${room.guide == null}">
						시설안내를 등록해주세요.
					</c:if>
					<c:if test="${room.guide != null}">
						${room.guide}
					</c:if>
				</p>
			</div>
		</div>
	
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		<button type="button" class="btn btn-primary" id="btn-book">예약하기</button>
	</div>
</div>

<script>
//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
});

$('#btn-book').on('click', function(){
	location.href="/book/bookMain/${room.locSeq}/${room.roomSeq}";
});
</script>

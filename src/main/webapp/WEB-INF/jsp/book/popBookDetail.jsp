<!-- 
사용자 예약확인 페이지(/bookDetailConfirm/220906000014/2)에서 상세내역 확인하는 팝업창 
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="div-userform">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">예약상세</h4>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	
	<div class="modal-body">
	
		<table class="table">
			<thead class="thead-dark">
			<tr>
			<th scope="col">지점명</th>
			<th scope="col">회의실명</th>
			<th scope="col">예약일자</th> 
			<th scope="col">예약시간</th>
			<th scope="col">대여금액</th>
			</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${list}" var="bk">
					<tr>
						<th scope="row">${bk.locNm}</th>
						<th scope="row">${bk.roomNm}</th>
						<th scope="row">${bk.bookDt}</th>
						<th scope="row">${bk.strtTm}</th>
						<td><fmt:formatNumber value="${bk.fee}" pattern="#,###" />원</td> 						
					</tr>
				</c:forEach>
			</tbody>
		</table>
	
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
</div>

<script>
//팝업닫기버튼
$('.btnClose').on('click', function(){
	$('#popModal').modal('hide');
});

$('#btn-book').on('click', function(){
	location.href="/book/bookMain/${room.locSeq}";
});
</script>

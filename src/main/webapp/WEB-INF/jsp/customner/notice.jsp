<!-- 
비용안내
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="common/head.jsp" />

<style>
.owl-dots{display:none}
</style>

<body>
<!-- 상단 메뉴 -->
<jsp:include page="common/navigation.jsp" />

<main id="main">
	<!-- 상단 이미지 및 설명 -->
	<jsp:include page="common/top.jsp" />

	<!-- 페이지 설명 및 메뉴 위치 표기 -->
	<jsp:include page="common/intro.jsp" />

    <section class="property-single nav-arrow-b">
		<div class="container">
			<div class="col-md-12"> 
				<div class="row"> 
					<!--탭--> 
					<div class="col-md-12  load_yeouido" >
						<ul class="nav nav-pills-a nav-pills mb-3" id="pills-tab" role="tablist">
							<!-- 지점 탭 -->
							<c:forEach items="${locs}" var="loc" varStatus="status">
							<li class="nav-item">
								<a class="nav-link <c:if test="${status.index==0}">active</c:if>" id="pills-${loc.locSeq}-tab" data-toggle="pill" href="#pills-${loc.locSeq}" role="tab" aria-controls="pills-${loc.locSeq}" aria-selected="false">
								${loc.name}
								</a>
							</li> 
							</c:forEach>
						</ul>
		
						<!-- ┌─────────────────── 요금표 / 예약안내 / 취소 및 환불규정 ───────────────────┐ -->
						<div class="tab-content" id="pills-tabContent"> 
							<!-- ┌─────────────────── 요금 ───────────────────┐ -->
							<c:forEach items="${locs}" var="loc" varStatus="status">
							
							<div class="tab-pane fade <c:if test="${status.index==0}">show active</c:if>" id="pills-${loc.locSeq}" role="tabpanel" aria-labelledby="pills-plans-pay">
								<div class=""> 
									<table class="table">
										<thead class="thead-dark">
										<tr>
										<th scope="col">면적</th>
										<th scope="col">수용인원</th>
										<th scope="col">주간(9~18)</th> 
										<th scope="col">야간(18~22)</th>
										</tr>
										</thead>
										
										<tbody>
											<c:forEach items="${feeList}" var="fee">
												<c:if test="${fee.locSeq == loc.locSeq}">
												<tr>
													<th scope="row">${fee.roomNm}</th>
													<td>${fee.capacity}명</td>
													<td><fmt:formatNumber value="${fee.basicFee}" pattern="#,###" />원</td> 
													<td>
														<c:choose> 
														<c:when test="${fee.nightFee > 0}">
															<fmt:formatNumber value="${fee.nightFee}" pattern="#,###" />원
														</c:when> 
														<c:otherwise>
															
														</c:otherwise> 
														</c:choose> 
													</td>
												</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
								<hr> 
								</div>
							</div> 
							</c:forEach>
							<!-- └─────────────────── 요금 ───────────────────┘ -->
		
		
							<!--공통안내-->
							<div class="title-box-d mt-3">
								<h3 class="title-d">예약안내</h3> 
							</div> 
							<p>
								1) 예약 확정을 위해 예약 신청 후 당일 이내에 대관료의 30%(예약금)을 선입금해주셔야 합니다.<br/>
								미확인 시 예약 확정 불가 및 취소가 이루어질 수 있습니다.<br/>
								2) 잔금은 대관일 1일 전까지 입금해주셔야 합니다.<br/>
								이용일 이후 잔금 결제 불가, 대관일 1일 전까지 입금되지 않을 경우
								예약이 취소되며 취소 수수료가 청구됩니다.
							</p>
							<div class="title-box-d mt-4">
								<h3 class="title-d">취소 및 환불규정</h3>
							</div>
							<p>
								이용 8일 전까지 : 취소 수수료 없음<br/>
								이용 7일 전 ~ 1일 전 : 예약금 100%<br/>
								이용 1일 전 ~ 이용 당일 : 예약금 100% + 잔금 100%<br/>
							</p>
							<!--//공통안내-->
		
						</div> 
						<!-- └─────────────────── 요금표 / 예약안내 / 취소 및 환불규정 ───────────────────┘ -->
					</div>
					<!--//탭종료-->
				</div>
			</div>
		</div>
	</section><!-- End -->

</main><!-- End #main -->
 
<jsp:include page="common/footer.jsp" />
<jsp:include page="common/script.jsp" />

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script><!--swiper-->

</body>

</html>

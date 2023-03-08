<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<c:choose>
<c:when test="${menu eq 'loc'}">
	<!-- 지점 -->
	<section id="about" class="sub_img" style="background: url(/img/main/bg_location3.jpg);background-size: cover;background-position: center center;">
		<div class="container aos-init aos-animate service">
			<div class="row">
				<div class="col-lg-12 mb-4"> 
					<h2 class="text-center title-a">Location</h2>
					<p class="text-center">예약하실 지점을 선택해주세요</p>
				</div>
			</div>
		</div>
	</section>
</c:when>

<c:when test="${menu eq 'meeting'}">
	<!-- 미팅 & 이벤트 -->
	<section id="about" class="sub_img" style="background: url('/img/main/bg_location4.jpg');background-size: cover;background-position: center center;">
		<div class="container aos-init aos-animate service">
			<div class="row">
				<div class="col-lg-12 mb-4"> 
					<h2 class="text-center title-a">OUR SERVICE</h2>
					<p class="text-center">제공하는 서비스</p>
				</div>
			</div>
		</div>
	</section> 
</c:when>

<c:when test="${menu eq 'about'}">
	<!-- 회사소개 -->
	<section id="about" class="sub_img" style="background: url('/img/main/bg_location2.jpg');background-size: cover;background-position: center center;">
		<div class="container aos-init aos-animate service">
			<div class="row">
				<div class="col-lg-12 mb-4"> 
					<h2 class="text-center title-a">ABOUT US</h2>
					<p class="text-center">회사소개</p>
				</div> 
			</div>
		</div>
	</section> 
</c:when>

<c:when test="${menu eq 'charge'}">
	<!-- 비용안내 -->
	<section id="about" class="sub_img" style="background: url('/img/main/bg_location.jpg');background-size: cover;background-position: center center;">
		<div class="container aos-init aos-animate service">
			<div class="row">
				<div class="col-lg-12 mb-4"> 
					<h2 class="text-center title-a">RESERVATION</h2>
					<p class="text-center">예약관련</p>
				</div>
			</div>
		</div>
	</section>
</c:when>

<c:otherwise>
	<!-- 기타 -->
	<section id="about" class="sub_img" style="background: url('/img/main/bg_location.jpg');background-size: cover;background-position: center center;">
		<div class="container aos-init aos-animate service">
			<div class="row">
				<div class="col-lg-12 mb-4"> 
					<h2 class="text-center title-a">RESERVATION</h2>
					<p class="text-center">예약</p>
				</div>
			</div>
		</div>
	</section> 
</c:otherwise>

</c:choose>
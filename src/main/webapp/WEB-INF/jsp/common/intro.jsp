<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<section class="intro-single">
<div class="container">
<div class="row">
			
<c:choose>
	<c:when test="${menu eq 'loc'}">

		<!-- 지점  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">그레이프라운지 ${loc.name}</h1>
				<span class="color-text-a">주소 :${loc.addr}</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
				<li class="breadcrumb-item">
				<a href="/main">Home</a>
				</li>
				<li class="breadcrumb-item">
				<a href="/loc/locMain">Locations</a>
				</li>
				<li class="breadcrumb-item active" aria-current="page">
					${loc.name}
				</li>
				</ol>
			</nav>
		</div>
			
	</c:when>

	<c:when test="${menu eq 'book'}">
	
		<!-- 예약하기  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">예약하기 (${loc.name})</h1>
				<span class="color-text-a">그레이프 ${loc.name} 예약을 진행합니다.</span>
			</div>
		</div>
	
	</c:when>

	<c:when test="${menu eq 'book2'}">

		<!-- 예약 2단계  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">예약 확인</h1>
				<span class="color-text-a">예약 정보를 입력해주세요.</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="/main">Home</a>
				</li>
				<li class="breadcrumb-item">
				Reservation
				</li>
				<li class="breadcrumb-item active" aria-current="page">
					예약 정보
				</li>
				</ol>
			</nav>
		</div>

	</c:when>
	
	<c:when test="${menu eq 'book3'}">

		<!-- 예약 3단계  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">예약 완료</h1>
				<span class="color-text-a">예약 정보를 확인해주세요</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="/main">Home</a>
				</li>
				<li class="breadcrumb-item">
				Reservation
				</li>
				<li class="breadcrumb-item active" aria-current="page">
					예약 완료
				</li>
				</ol>
			</nav>
		</div>

	</c:when>
	
	<c:when test="${menu eq 'tour'}">

		<!-- 투어신청  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">투어신청</h1>
				<span class="color-text-a">오피스 투어를 신청하실 수 있습니다 .</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/main">Home</a>
					</li>
					<li class="breadcrumb-item">
					Reservation
					</li>
					<li class="breadcrumb-item active" aria-current="page">
						투어신청
					</li>
				</ol>
			</nav>
		</div>

	</c:when>
	
	<c:when test="${menu eq 'about'}">
	
		<!-- 회사소개  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">그레이프 소개</h1>
				<span class="color-text-a"></span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/main">Home</a>
					</li>
				
					<li class="breadcrumb-item active" aria-current="page">
						About US
					</li>
				</ol>
			</nav>
		</div>

	</c:when>
	
	<c:when test="${menu eq 'charge'}">
	
		<!-- 비용안내  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">비용안내</h1>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/main">Home</a>
					</li>
					<li class="breadcrumb-item">
					Reservation
					</li>
					<li class="breadcrumb-item active" aria-current="page">
						비용안내
					</li>
				</ol>
			</nav>
		</div>
		
	</c:when>
	
	<c:when test="${menu eq 'bookConfirm'}">
	
		<!-- 예약 확인/취소  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">예약 확인/취소</h1>
				<span class="color-text-a">예약 정보를 확인하실 수 있습니다. 신청하신 성함과 메일주소를 입력해주세요.</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/main">Home</a>
					</li>
					<li class="breadcrumb-item">
					Reservation
					</li>
					<li class="breadcrumb-item active" aria-current="page">
						예약 확인/취소
					</li>
				</ol>
			</nav>
		</div>
		
	
	</c:when>
	
	<c:when test="${menu eq 'bookConfirm2'}">
	
		<!-- 예약 확인/취소  -->
		<div class="col-md-12 col-lg-8">
			<div class="title-single-box">
				<h1 class="title-single">예약 확인/취소</h1>
				<span class="color-text-a">예약 정보를 확인하실 수 있습니다.</span>
			</div>
		</div>
		<div class="col-md-12 col-lg-4">
			<nav aria-label="breadcrumb" class="breadcrumb-box d-flex justify-content-lg-end">
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="/main">Home</a>
					</li>
					<li class="breadcrumb-item active" aria-current="page">
						예약 확인/취소
					</li>
				</ol>
			</nav>
		</div>
		
	
	</c:when>

</c:choose>

</div>
</div>
</section>
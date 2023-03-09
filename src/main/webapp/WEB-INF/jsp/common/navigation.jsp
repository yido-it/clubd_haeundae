<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
	<div class="container">
		<button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
		<span></span>
		<span></span>
		<span></span>
		</button>
		
		<a class="navbar-brand text-brand" href="/main">
			<!-- <img src="/img/logo.png" alt="" class="img-a img-fluid" >      -->
		</a>
		
		<!--QR없을때 -->
		<button type="button" class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none" id="noIos">				
		</button>
		<!--QR있을때-->
		<button type="button" class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none btn-qrscan" id="ios" style="display:none;" onclick="javscript:fnQrScan();">			
			<i class="fa-solid fa-qrcode"></i>
		</button>
		
		<div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
			<ul class="navbar-nav">
				<!-- 예약하기 -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						예약하기
					</a>
					<!-- 예약하기 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/loc/locMain">예약하기</a>
					</div>
					<!-- 이용가이드 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/reservation/reservation">예약하기</a>            
					</div>
				</li>
				
				<!-- 이용가이드 -->
				<li class="nav-item">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						이용가이드
					</a>
					<!-- 이용가이드 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/guide/charge">이용요금</a>
						<a class="dropdown-item" href="/guide/service">운영/운휴정보</a> 
						<a class="dropdown-item" href="/guide/location">교통/주차안내</a>
						<a class="dropdown-item" href="/guide/map">가이드맵</a>               
					</div>
				</li>
				
				<!-- 즐길거리 -->
				<li class="nav-item">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						즐길거리
					</a>
					<!-- RESERVATION 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/enjoy/infinity">인피니티풀</a>
						<a class="dropdown-item" href="/enjoy/kids">키즈존</a> 
						<a class="dropdown-item" href="/enjoy/food">푸드코드</a>
						<a class="dropdown-item" href="/enjoy/spring">노천탕</a>               
					</div>
				</li>
				
				<!-- 소통공간 -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						소통공간
					</a>
					
					<!-- 소통공간 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/customer/notice">공지사항</a>
						<a class="dropdown-item" href="/customer/event">이벤트</a>            
					</div>
				</li>
				<!-- <li class="nav-item">
				<a class="nav-link" href="blog-grid.html">APP download </a>
				</li> --> 
			</ul>
		</div>
		<div class="topRight">

        <!-- 예약/날씨 -->
		<div class="gnbUtil">
			<a href="http://www.pic.co.kr/reservation/" class="reservBtn">RESERVATION</a>
		</div>
		<div class="weatherBox">
			<div class="weatherWrap">
				<dl>
					<dt>BUSAN</dt>
					<dd class="wicon"><img src="http://www.pic.co.kr/img/ico/03d.svg" alt="Clouds"></dd>
					<dd class="temperature">30.3°c</dd>
				</dl>
			</div>
		</div>
		
     </div>
	</div>
</nav>

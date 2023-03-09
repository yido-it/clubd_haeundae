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
				<!-- LOCATIONS -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						LOCATIONS
					</a>
					<!-- LOCATIONS 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/loc/locMain">모든지점</a>
						
						<c:forEach items="${locs}" var="loc">
							<a class="dropdown-item" href="/loc/locDetail/${loc.locSeq}">${loc.name}</a>
						</c:forEach>
					</div>
				</li>
				
				<!-- MEETINGS & EVENTS -->
				<li class="nav-item">
					<a class="nav-link" href="/meeting">OUR SERVICE</a>
				</li>
				
				<!-- ABOUT US -->
				<li class="nav-item">
				<a class="nav-link" href="/about">ABOUT US</a>
				</li>
				
				<!-- RESERVATION -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button"  data-toggle="dropdown">
						RESERVATION
					</a>
					
					<!-- RESERVATION 하위메뉴 -->
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/loc/locMain">공간 예약</a>
						<a class="dropdown-item" href="/bookConfirm">예약확인/취소</a> 
						<a class="dropdown-item" href="/charge">비용 안내</a>
						<a class="dropdown-item" href="/tour/tourMain">투어 신청</a>               
					</div>
				</li>
				<!-- <li class="nav-item">
				<a class="nav-link" href="blog-grid.html">APP download </a>
				</li> --> 
			</ul>
		</div> 
	</div>
</nav>

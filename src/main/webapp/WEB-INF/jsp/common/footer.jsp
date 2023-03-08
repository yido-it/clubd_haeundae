<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="section-footer">
<div class="container">
	<div class="row">
		<div class="col-sm-12 col-md-7">
			<div class="widget-a">
				<div class="w-header-a">
					<h3 class="w-title-a text-brand">그레이프</h3>
				</div>
				<div class="w-body-a">
					<p class="w-text-a color-text-a">
						오피스 편의공간에 Contents/Service/Tech를 접목한 시설 및 서비스를 기획·운영함으로써 
						그레이프라운지가 입점한 건물은 오피스 라이프스타일 플랫폼으로 진화하게 됩니다.

					</p>
				</div>
			</div>
		</div>
	
		<div class="col-sm-12 col-md-3 section-md-t3">
			<div class="widget-a">
				<div class="w-header-a">
					<h3 class="w-title-a text-brand">Contact</h3>
				</div>
				<div class="w-footer-a">
					<ul class="list-unstyled">
						<!-- 연락처 -->
						<li class="color-a">
							<span class="color-text-a">Phone .</span> ${cont.tel}
						</li>
						<!-- 이메일 -->
						<li class="color-a">
							<span class="color-text-a">Email .</span> ${cont.email}
						</li>
					</ul>
				</div>
			</div>
		</div>
			
		<div class="col-sm-12 col-md-2 section-md-t1" style="text-align: right;">
			<img src="/img/logo.png" alt="" class="img-a img-fluid mt-3 footer_logo">
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="copyright-footer">
				<p class="copyright color-text-a">
					&copy; Copyright 2022
					<span class="color-a">Yido</span> All Rights Reserved.
				</p>
			</div>
		</div>
	</div>
</div>
</section>

<!-- 예약하기 -->
<a href="/loc/locMain" class="back-to-top2" style="bottom: 65px">
	<span style="top: 15px;position: relative;">예약</span>
</a>

<!-- 위로가기 -->
<a href="#" class="back-to-top">
	<i class="fa fa-chevron-up"></i>
</a>

<div id="preloader"></div>

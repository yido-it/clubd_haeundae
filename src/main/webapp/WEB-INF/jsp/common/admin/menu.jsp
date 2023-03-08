<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<sec:authentication property="principal.Authorities" var="myAuth"/>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
		<c:if test="${myAuth eq '[ROLE_AAA000]'}">
			<!-- 사용자관리 -->
			<li class="nav-item">
				<a class="nav-link" href="/admin/userList">
					<i class="mdi mdi-24px mdi-account"></i>
					<span class="menu-title mdi_txt_5" >사용자관리</span>
				</a>
			</li>
		</c:if>
		
		<!-- 지점관리 -->
		<li class="nav-item">
			<a class="nav-link" href="/admin/locList">
				<i class="mdi mdi-24px mdi-home"></i>
				<span class="menu-title mdi_txt_5">지점관리</span>
			</a>
		</li>
		<!-- 회의실관리 -->
		<li class="nav-item">
			<a class="nav-link" href="/admin/roomList">
				<i class="mdi mdi-24px mdi-home-outline"></i>
				<span class="menu-title mdi_txt_5">회의실관리</span>
			</a>
		</li>
		<!-- 예약관리 -->
		<li class="nav-item">
			<a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
				<i class="mdi mdi-24px mdi-tooltip-text"></i>
				<span class="menu-title mdi_txt_5">예약관리</span>
				<i class="menu-arrow"></i>
			</a>
			<div class="collapse" id="ui-basic">
				<ul class="nav flex-column sub-menu">
					<li class="nav-item"> <a class="nav-link" href="/admin/bookSetting">예약설정셋팅</a></li>
					<li class="nav-item"> <a class="nav-link" href="/admin/bookMain">예약리스트</a></li>
					<li class="nav-item"> <a class="nav-link" href="/admin/bookStatus">예약현황</a></li>
					<li class="nav-item"> <a class="nav-link" href="/admin/bookLog">예약이력</a></li>
					<li class="nav-item"> <a class="nav-link" href="/admin/bookDetailLog">예약상세이력</a></li>
				</ul>
			</div>
			<!-- 투어신청관리 -->
	        <li class="nav-item">
	            <a class="nav-link" href="/admin/tourList">
	                <i class="mdi mdi-24px mdi-home-outline"></i>
	                <span class="menu-title mdi_txt_5">투어신청관리</span>
	            </a>
	        </li>
			
		</li>
	</ul>
</nav>
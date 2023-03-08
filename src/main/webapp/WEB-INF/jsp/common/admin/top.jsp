<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<sec:authentication property="principal.username" var="userId"/>
<sec:authentication property="principal.authorities" var="auth"/>

<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
		<!-- 로고 -->
		<a class="navbar-brand brand-logo mr-5" style="padding-left:30px" href="/admin/main">
		<img src="/img/logo.png" class="mr-2" alt="logo"/>
		</a>
		<!-- 메뉴 접기 -->
		<button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
		<span class="icon-menu"></span>
		</button>
	</div>
		
	<div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
		
	
		 <i class="mdi mdi-18px mdi-account"></i>
		<span class="mdi_txt_2">${userId}님</span>

		&nbsp;&nbsp; <span style="color:#80808073">|</span> &nbsp;&nbsp;
		
		<a href="/logout">
		<i class="mdi mdi-18px mdi-logout"></i>
		<span class="mdi" style="font-size:11pt">로그아웃</span> 
		</a>

	</div>
</nav>

<style>
a {
  text-decoration: none;
  color:#6C7383
}
a:hover { 
	text-decoration:none !important;
	color:#4B49AC;
	font-weight:bold;
}
</style>
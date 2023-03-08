<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="common/admin/head.jsp"/>

<body>
<jsp:include page="common/admin/script.jsp"/>

<div class="container-scroller">
	<div class="container-fluid page-body-wrapper full-page-wrapper">
		<div class="content-wrapper d-flex align-items-center auth px-0">
			<div class="row w-100 mx-0">
				<div class="col-lg-4 mx-auto">
					<div class="auth-form-light text-left py-5 px-4 px-sm-5">
						<div class="brand-logo">
							<img src="/img/logo.png" alt="logo">
						</div>
						<!--  
						<h4>Hello! let's get started</h4>
						<h6 class="font-weight-light">Sign in to continue.</h6> 
						-->
						<form class="pt-3" id="form-login" action="/checkLogin" method="post" novalidate="novalidate">
							<!-- 아이디 -->
							<div class="form-group">
								<input type="text" name="userId" id="userId" class="form-control form-control-lg"  placeholder="아이디" value="">
							</div>
							<!-- 비밀번호 -->
							<div class="form-group">
								<input type="password" name="password" id="password" class="form-control form-control-lg" placeholder="비밀번호" value="">
							</div>
							<!-- 로그인 -->
							<div class="mt-3">
								<a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">로그인</a>
							</div>
							<div class="my-2 d-flex justify-content-between align-items-center">
								<div class="form-check">
									<label class="form-check-label text-muted">
									<input type="checkbox" class="form-check-input" name="remember_me" id="remember_me">
									자동로그인
									</label>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>

<script>
$(document).ready(function(){

	if('${errorMessage}' != ''){
        alert('${errorMessage}');
	}
	
	$('#form-login').validate();
});

// 로그인 버튼 클릭
$(".auth-form-btn").on("click", function(){
	var userId = $('#userId').val().trim();
	var password = $('#password').val().trim();
	
	if (userId == "") {
		alert('아이디를 입력해주세요.');
		return;
	}
	if (password == "") {
		alert('비밀번호를 입력해주세요.');
		return;
	}
	
	$("#form-login").submit();
})

$('#password').on('keyup', function(e){
	if(e.keyCode == 13) $('.auth-form-btn').trigger('click');
});

</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="../common/admin/head.jsp"/>
<jsp:include page="../common/admin/script.jsp"/>

<body>
<div class="container-scroller">
<!-- 상단 -->
<jsp:include page="../common/admin/top.jsp" />
	
	<div class="container-fluid page-body-wrapper">
		<!-- 좌측메뉴 -->
		<jsp:include page="../common/admin/menu.jsp" />
			
		<div class="main-panel">
			<div class="content-wrapper">
				<div class="row">
					<div class="col-md-12 grid-margin">
						<div class="row">
							<div class="col-12 col-xl-8 mb-4 mb-xl-0">
								<h3 class="font-weight-bold">Grape</h3>
								<h6 class="font-weight-normal mb-0">관리자모드입니다.</h6>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>   
</div>
</body>
</html>


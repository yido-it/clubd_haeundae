
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="common/admin/head.jsp"/>
<jsp:include page="common/admin/script.jsp"/>
<body>
	<div>
		<div class="page-container " >


			<div class="page-content-wrapper" id="mainDiv" style="display:none;">
				<div class="row mt30">
				    <div class="col-md-2">
				    </div>
					<div class="col-md-8">

						<div class="card card-outline box-info col-lg-12">
							<div class="box-header with-border">
								<h3 class="box-title">
									<i class="fas fa-exclamation-triangle"></i>
									보고서를 출력하기 위해서 PDF뷰어를 설치해야합니다.<br>
									PDF뷰어가 자동으로 다운로드가 실행되지 않을 때 아래 버튼을 클릭하여 <br>
									수동으로 PDF뷰어를 다운로드하여 실행 후 설치해주시기 바랍니다.
								</h3>
								<br>
								<br>
								<br>
								<br>
								<h3 class="box-title">
								<a href="/store/readerdc_kr_xa_cra_install.exe"><i class="fas fa-file-download"></i>&nbsp;&nbsp;PDF뷰어 다운로드</a>
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


<style>
.box-title{
font-size:19px !important;
}
.fa-exclamation-triangle{
font-size: 36px;
}

.fa-file-download{
font-size: 50px;
}
</style>

<script type="text/javascript">
var getAcrobatInfo = function() {

	  var getBrowserName = function() {
	    return this.name = /*this.name ||*/ function() {
	      var userAgent = navigator ? navigator.userAgent.toLowerCase() : "other";

	      if(userAgent.indexOf("chrome") > -1)        return "chrome";
	      else if(userAgent.indexOf("safari") > -1)   return "safari";
	      else if(userAgent.indexOf("msie") > -1||userAgent.indexOf("trident") > -1)     return "ie";
	      else if(userAgent.indexOf("firefox") > -1)  return "firefox";
	      return userAgent;
	    }();
	  };

	  var getActiveXObject = function(name) {
	    try { return new ActiveXObject(name); } catch(e) {}
	  };

	  var getNavigatorPlugin = function(name) {
	    for(key in navigator.plugins) {
	      var plugin = navigator.plugins[key];
	      if(plugin.name == name) return plugin;
	    }
	  };

	  var getPDFPlugin = function() {
	    return this.plugin = this.plugin || function() {
	      if(getBrowserName() == 'ie') {
	        //
	        // load the activeX control
	        // AcroPDF.PDF is used by version 7 and later
	        // PDF.PdfCtrl is used by version 6 and earlier
	        return getActiveXObject('AcroPDF.PDF') || getActiveXObject('PDF.PdfCtrl');
	      }
	      else {
	        return getNavigatorPlugin('Adobe Acrobat') || getNavigatorPlugin('Chrome PDF Viewer') || getNavigatorPlugin('WebKit built-in PDF');
	      }
	    }();
	  };

	  var isAcrobatInstalled = function() {
	    return !!getPDFPlugin();
	  };

	  var getAcrobatVersion = function() {
	    try {
	      var plugin = getPDFPlugin();

	      if(getBrowserName() == 'ie') {
	        var versions = plugin.GetVersions().split(',');
	        var latest   = versions[0].split('=');
	        return parseFloat(latest[1]);
	      }

	      if(plugin.version) return parseInt(plugin.version);
	      return plugin.name
	      
	    }
	    catch(e) {
	      return null;
	    }
	  }

	  //
	  // The returned object
	  // 
	  return {
	    browser:        getBrowserName(),
	    acrobat:        isAcrobatInstalled() ? true : false,
	    acrobatVersion: getAcrobatVersion()
	  };
	};
	var info = getAcrobatInfo();
	//console.log(info);
	//alert(info.browser+ " " + info.acrobat + " " + info.acrobatVersion);
	
	
	if(info.browser == 'ie' && info.acrobat == false){
		$('#mainDiv').show();
		//alert('보고서를 출력하기 위해서는 PDF뷰어를 설치해야합니다. \nPDF뷰어를 설치 후 새로고침(F5) 해주세요.');
		location.href= "/store/readerdc_kr_xa_cra_install.exe";
	} else {
		location.href= "/tmpReport/"+decodeURI('${fileName}') + "?v="+new Date().getTime();		
	}
</script>
</body>
</html>
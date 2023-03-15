<!-- 회사소개 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="common/head.jsp" />
<link href="/css/member.css" rel="stylesheet">
<body>
<!-- 상단 메뉴 -->
<jsp:include page="common/navigation.jsp" />

<main id="main">
	<!-- 상단 이미지 및 설명 -->
	<jsp:include page="common/top.jsp" />
	
	
	<div class="container">
		
		<div class="small-container">
			<div class="login">
				<h1>로그인</h1>
				<div class="login_wrap">					
					<div class="input_wrap">
						<div class="input_type">
							<label for="login_id">아이디</label>
							<input type="text" id="mbIdStr" name="mbIdStr" placeholder="" value="">
						</div>
						<div class="input_type">
							<label for="login_pw">비밀번호</label>
							<input type="password" id="mbPw" name="mbPw" placeholder="" value="">
						</div>
					</div>
					<div class="login_menu">
						<div class="chk_type">
							<input type="checkbox" name="chk_saveId" id="chk_saveId" value=""> <label for="chk_saveId">아이디 저장</label>
						</div>
						<div class="find_menu">
							<a href="javascript:void(0);" id="btn_findIdPage">아이디 찾기</a>
							<a href="javascript:void(0);" id="btn_findPwPage">비밀번호 찾기</a>
						</div>
					</div>
					<div class="btn_wrap btn_one">
						<button type="submit" class="btn_type btn_red" value="로그인" id="btn_login">로그인</button>
					</div>
				</div>
				<div class="sns_login">
					<h5>SNS 간편 로그인</h5>
					<div>
						<a href="javascript:void(0);" class="btn_type btn_white" id="btn_kakaoLogin">
							<span>
								<i>카카오</i> 로그인
							</span>
						</a>
						<a href="javascript:void(0);" class="btn_type btn_white" id="btn_naverLogin">
							<span>
								<i>네이버</i> 로그인
							</span>
						</a>
					</div>
				</div>
				<div class="join_link">
					<h5>아직 회원이 아니신가요?</h5>
					<p>회원이 되시면 홈페이지에서 제공하는 온라인 서비스를 이용하실 수 있습니다.</p>
					<a href="javascript:void(0);" class="btn_type btn_white btn_join">회원가입</a>
				</div>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>회원가입</h1>
				<div class="login_wrap">					
					<div class="age_type no_line">
						<a href="javascript:void(0);" id="btn_joinKid">
							<strong>만 14세 미만</strong>
							<span>본인 및 법정대리인<br> 인증이 필요합니다</span>
						</a>
						<a href="javascript:void(0);" id="btn_joinAdult">
							<strong>만 14세 이상</strong>
							<span>본인 확인<br> 인증이 필요합니다</span>
						</a>
					</div>
				</div>
				<div class="sns_login">
					<h5>SNS 간편 회원가입</h5>
					<p>SNS계정으로 빠르고 쉽게 회원가입 할 수 있습니다.</p>
					<div>
						<a href="javascript:void(0);" class="btn_type btn_white" id="btn_kakaoLogin">
							<span>
								<i>카카오</i> 회원가입
							</span>
						</a>
						<a href="javascript:void(0);" class="btn_type btn_white" id="btn_naverLogin">
							<span>
								<i>네이버</i> 회원가입
							</span>
						</a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>회원가입</h1>
				<div class="login_wrap">					
					<div class="age_type">
						<a href="javascript:void(0);" class="phone_cert" id="hpAuth" style="display: inline-block; float: none;">
							<strong>휴대폰 인증</strong>
							<span>휴대폰 본인 확인을 통해<br> 실명확인 후 가입합니다</span>
						</a>
					</div>
				</div>
				<div class="sns_login">
					<p>2012년 8월 18일부터 시행되는 정보통신망 이용 촉진 및 정보보호 등에 관한 법류(이하 정보통신망법) 제 23조의 2
					 ”주민등록번호의 사용제한” 에 따라 주민등록번호를 입력받지 않습니다.<br>
					 이에따라 회원가입시 주민등록번호를 입력하는 실명인증 대신 본인명의로 가입된 휴대폰을 이용하여 본인인증을 하셔야 
					 회원가입을 하실 수 있습니다.
					 </p>
					 <hr>
					<p>본인인증에 실패하셨나요?<br>
					정보가 해당 인증기관에 등록되어 있지 않거나 기타 다른 사유로 실패한 경우일 수 있습니다.<br>
					인증이 안되시는 경우 나이스신용평가정보 고객센터(1600-1522)로 문의하여 주시기 바랍니다.<br>
					통화 가능시간(평일:09~18시, 토/일요일(공휴일):휴무)<br>
					<br>
					국내거주 외국인의 회원가입은 법무부 출입국관리사무소에서 등록번호를 부여 받은 경우에만 가능합니다.
					</p>
				</div>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h2>회원가입</h2>
				<div class="input_wrap">
					<div class="input_type">
						<div class="sort_wrap">
							<label for="join_id">아이디</label>
							<input type="text" name="mbId" id="mbId" placeholder="6~10자리, 영문으로 시작">
							<a href="javascript:void(0);" class="btn_type btn_white" id="btn_duplCheck">중복확인</a>
						</div>
						<p class="check_result false" id="check_result"></p>
					</div>
					<div class="input_type">
						<label for="login_pw">비밀번호</label>
						<input type="password" name="mbPw" id="mbPw" placeholder="9~20자리, 영문/숫자/특수문자 3개조합">
					</div>
					<div class="input_type">
						<label for="login_pw_chk">비밀번호 확인</label>
						<input type="password" name="chkMbPw" id="chkMbPw">
					</div>
					<div class="input_type">
						<label for="login_email">이메일</label>
						<input type="email" name="mbEmail" id="mbEmail">
					</div>
					<div class="input_type sort_wrap">
						<label for="join_name">이름</label>
						<input type="text" name="mbWname" id="mbWname" readonly="readonly" value="김다예">
						<div class="radio_type2">
							<span>
								<input type="radio" name="mbWsex" id="male" value="01"> 
								<label for="male"> 남자</label>
							</span>
							<span>
								<input type="radio" name="mbWsex" id="female" value="02" checked="checked">  
								<label for="female"> 여자</label>
							</span>
						</div>
					</div>
					<div class="input_type">
						<label for="join_birth">생년월일</label>
						<input type="tel" name="mbWbirthymd" id="mbWbirthymd" value="19921114" readonly="readonly">
					</div>
					<div class="input_type">
						<label for="join_phone">휴대폰 번호</label>
						<input type="tel" name="mbHp" id="mbHp" value="01028896660" readonly="readonly">
					</div>
					<div class="input_type">
						<label>지역</label>
						<div class="local_pick">
							<select class="slt_type" name="addrSido" id="addrSido"><option value="11">서울</option><option value="26">부산</option><option value="27">대구</option><option value="28">인천</option><option value="29">광주</option><option value="30">대전</option><option value="31">울산</option><option value="36">세종</option><option value="41">경기</option><option value="42">강원</option><option value="43">충북</option><option value="44">충남</option><option value="45">전북</option><option value="46">전남</option><option value="47">경북</option><option value="48">경남</option><option value="50">제주</option><option value="99">해외</option><option value="98">미등록</option></select>
							<select class="slt_type" name="addrSigungu" id="addrSigungu"><option value="110">종로구</option><option value="140">중구</option><option value="170">용산구</option><option value="200">성동구</option><option value="215">광진구</option><option value="230">동대문구</option><option value="260">중랑구</option><option value="290">성북구</option><option value="305">강북구</option><option value="320">도봉구</option><option value="350">노원구</option><option value="380">은평구</option><option value="410">서대문구</option><option value="440">마포구</option><option value="470">양천구</option><option value="500">강서구</option><option value="530">구로구</option><option value="545">금천구</option><option value="560">영등포구</option><option value="590">동작구</option><option value="620">관악구</option><option value="650">서초구</option><option value="680">강남구</option><option value="710">송파구</option><option value="740">강동구</option></select>
						</div>
					</div>
				</div>
				<div class="join_agree">
					<div class="chk_type mt10">
						<input type="checkbox" class="allchkbox" id="allchk" onclick="fn_checkAll();">
						<label for="allchk"><b>전체 동의</b></label>
					</div>
					<div class="terms_wrap mt30">
						<div class="inner">
							<div class="chk_type">
								<input type="checkbox" class="chkbox" name="checkRow" id="chk1" onclick="fn_unAll();">
								<label for="chk1">클럽디 오아시스 이용약관(필수)</label>
							</div>
							<div class="terms">
								<ol>
									<li>
										제 1 조 목적<br>
										이 약관은 클럽디 오아시스(주) (이하 "회사"라 합니다)에서 제공하는 인터넷 정보 서비스 (이하 "서비스"라 한다)의 이용 조건ㆍ절차, 이용자의 권리ㆍ의무 및 기타 필요한 사항을 규정함을 목적으로 합니다.
									</li>
									<li>
										제 2 조 약관의 효력과 변경
										<ol>
											<li>서비스는 본 약관에 규정된 조항을 변경 없이 이용자가 수락하는 것을 조건으로 제공됩니다. 이용자께서 본 서비스를 사용하면 본 약관에 대하여 이용자가 동의한다는 것을 의미합니다.</li>
											<li>(회사)는 약관의 규제 등에 관한 법률, 전자거래 기본법, 전자서명법, 정보통신망 이용 촉진 등에 관한 법률, 방문판매 등에 관한 법률, 소비자 보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수있습니다.</li>
											<li>(회사)는 전자상거래 등에서의 소비자보호에 관한 법률, 전자거래 기본법, 전자서명법, 정보통신망 이용촉진 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위해하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
											<li>(회사)가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 "서비스"의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 회사는 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</li>
											<li>(회사)가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 회사에 송신하여 회사의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.</li>
										</ol>
									</li>
								</ol>
							</div>
						</div>
						<div class="inner mt30">
							<div class="chk_type">
								<input type="checkbox" class="chkbox" name="checkRow" id="chk2" onclick="fn_unAll();">
								<label for="chk2">개인정보 보호정책 동의(필수)</label>
							</div>
							<div class="terms">
								클럽디 오아시스는 귀하의 개인정보보호를 매우 중요시하며, 『정보통신망 이용촉진 및 정보보호에 관한 법률』상의 개인정보보호규정 및 정보통신부가 제정한 『개인정보보호지침』을 준수하고 있습니다. 클럽디 오아시스는 개인정보취급방침을 통하여 귀하께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.<br><br>
								클럽디 오아시스는 개인정보취급방침을 홈페이지 화면에 공개함으로써 귀하께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.<br><br>
								<ol>
									<li>
										1. 개인정보의 수집 및 이용목적
										<p>클럽디 오아시스는 다음과 같은 목적을 위하여 개인정보를 수집하고 있습니다.</p>
										<ul>
											<li>성명, 아이디, 비밀번호, 전화번호, 휴대전화번호 : 회원제 서비스 이용에 따른 본인 확인, 개인 식별, 불량회원의 부정이용방지, 비인가 사용 방지, 가입 의사 확인, 가입회수 제한, 만 14세 미만 아동 개인정보 수집 시 법정 대리인 동의 여부 확인, 추후 법정 대리인 본인확인</li>
											<li>전자우편(e-mail)주소, (뉴스레터 수신여부) : 고지사항 전달, 본인 의사 확인, 불만사항 민원 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스, 이벤트 정보 등 최신 정보의 안내</li>
											<li>그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료</li>
											<li>
												서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
												<p>IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록</p>
											</li>
											<li>
												부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 해당 서비스의 이용자에 한해서만 아래와 같은 정보들이 수집될 수 있습니다.
												<p>주소, 연락처, 사용 이동통신사 등</p>
											</li>
										</ul>
									</li>
									<li>
										2. 개인정보의 수집범위
										<p>클럽디 오아시스는 별도의 회원가입 절차 없이 대부분의 컨텐츠에 자유롭게 접근할 수 있습니다. 클럽디 오아시스의 회원제 서비스를 이용하시고자 할 경우 다음의 필수사항을 입력해주셔야 하며, 선택사항은 입력하시지 않았다 하여 서비스 이용에 제한은 없습니다.</p>
										<ol>
											<li>
												회원가입 시 수집하는 개인정보의 범위
												<p>성명, 희망 ID, 비밀번호, 주소, 전화번호, 휴대전화 번호, 이메일주소, 생년월일</p>
											</li>
											<li>
												서비스 이용과정에서 생성, 수집되는 정보
												<p>서비스 이용기록, 접속로그, 쿠키, 접속IP정보, 결제기록, 이용정지 기록</p>
											</li>
										</ol>
									</li>
									<li>
										3. 개인정보의 보유기간 및 이용기간
										<ol>
											<li>
												귀하의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 지체 없이 파기됩니다. 단, 상법 등 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 예외로 합니다.
												<ul>
													<li>회원가입정보의 경우, 회원가입을 탈퇴하거나 회원에서 제명된 때</li>
													<li>설문조사, 이벤트 등 일시적 목적을 위하여 수집된 경우 : 당해 설문 조사, 이벤트 등이 종료한 때</li>
												</ul>
											</li>
											<li>
												위 개인정보 수집목적 달성 시 즉시파기 원칙에도 불구하고 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등에 근거하여 일정기간 보유합니다.
												<p>소비자의 불만 또는 분쟁처리에 관한 기록 : 3년</p>
											</li>
										</ol>
									</li>
								</ol>
							</div>
						</div>
					</div>
					<span class="mt10" style="display: block;">(나이스평가정보에서 인증 받은 휴대폰 번호를 사용하고 있습니다.)</span>
					<div class="agree_wrap">
						<div class="agree_list">
							<span>서비스 및 이벤트 혜택에 대한 정보 수신(선택)</span>
							<div class="chk_type mt10">
								<input type="checkbox" class="chkbox" name="emailFlag" id="emailFlag" value="Y" onclick="fn_unAll();">
								<label for="emailFlag">이메일</label>
							</div>
							<div class="chk_type mt10">
								<input type="checkbox" class="chkbox" name="smsFlag" id="smsFlag" value="Y" onclick="fn_unAll();">
								<label for="smsFlag">휴대전화</label>
							</div>
						</div>
					</div>
					<div class="btn_wrap btn_one mt30">
						<!-- <button type="submit" class="btn_type btn_red" id="btn_join">가입하기</button> -->
						<a href="javascript:void(0);" class="btn_type btn_red" id="btn_join">가입하기</a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>회원가입 완료</h1>				
				<h5>회원가입이 완료되었습니다</h5>
				<p>클럽디 오아시스 회원이 되신 것을 환영합니다.<br>
				이제 클럽디 오아시스가 제공하는 다양한 서비스를 경험해 보실 수 있습니다.</p>
				<div class="join_link tc" style="padding: 30px 0px;">
					<h5><b style="font-size: 15px; font-weight: normal;">아이디</b> dy1114</h5>
				</div>
				<div class="btn_wrap btn_small btn_width_limit tc">
					<a href="javascript:void(0);" class="btn_type btn_white btn_mypage">로그인하기</a>
				</div>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>아이디 찾기</h1>				
				<form>
					<div class="login_wrap">
						<div class="input_wrap">
							<div class="input_type">
								<label for="find_name">이름</label>
								<input type="text" name="mbWname" id="mbWname">
							</div>
							<div class="input_type">
								<label for="find_phone">휴대폰 번호</label>
								<input type="text" name="mbHp" id="mbHp" class="mbHp">
							</div>
						</div>
						<span><br></span>
						<!-- 맞지 않을때 팝업 메시지 시작 -->
						<div class="notice resultN" style="display: none;">
							<b>등록된 회원이 아닙니다.</b>
						</div>
						<!-- 맞지 않을때 팝업 메시지 끝 -->
						<!-- 찾기완료시 시작 -->
						<div class="notice resultY" style="display: none;">
							<b>입력하신 정보와 일치하는 정보입니다.</b><br>(개인정보 보호를 위해 끝자리는 *로 표시)
						</div>
						<table class="resultY" style="display: none;">
							<tbody id="resultTbody">				
							</tbody>
						</table>
						<div class="textarea resultY tc" style="display: none;">
							소셜 아이디는 해당 SNS를 통해 로그인 하시기 바랍니다.
						</div>
						<!-- 찾기완료시 끝 -->
						<div class="btn_wrap btn_one">
							<a href="javascript:void(0);" class="btn_type btn_red" id="btn_find">아이디 찾기</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>비밀번호 찾기</h1>				
				<form>
					<div class="login_wrap">
						<div class="input_wrap">
							<div class="input_type">
								<label for="find_name">아이디</label>
								<input type="text" name="mbId" id="mbId">
							</div>
							<div class="input_type">
								<label for="find_name">이름</label>
								<input type="text" name="mbWname" id="mbWname">
							</div>
							<div class="input_type">
								<label for="find_phone">휴대폰 번호</label>
								<input type="text" name="mbHp" id="mbHp">
							</div>
						</div>
						<span><br></span>
						<div class="notice resultN" style="display: none;">
							<b>등록된 회원이 아닙니다.</b>
						</div>
						<div class="btn_wrap btn_one">
							<a href="javascript:void(0);" class="btn_type btn_red" id="btn_find">비밀번호 찾기</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>비밀번호 찾기</h1>				
				<p class="tc">등록된 핸드폰번호로 임시 비밀번호가 발송되었습니다!</p>
				<div class="join_link tc mt10" style="padding: 30px 0px;">
					<h5><b style="font-size: 15px; font-weight: normal;">등록된 휴대폰번호</b> 010-2889-6660</h5>
				</div>
				<div class="btn_wrap btn_small btn_width_limit tc">
					<a href="javascript:void(0);" class="btn_type btn_white btn_mypage">로그인하기</a>
				</div>
			</div>
		</div>
		
		<div id="MemberWrap">
		<div class="small-container">
			<div class="login">
				<h1>비밀번호 변경</h1>
				<h5>임시 비밀번호로 로그인하셨습니다.</h5>			
				<p>안전한 계정관리를 위하여 비밀번호를 변경하셔야 서비스 이용이 가능합니다.</p>
				<div class="input_wrap">
					<div class="input_type">
						<label for="login_pw necessary"><b style="color: red;">*</b> 기존(임시) 비밀번호</label>
						<input type="password" name="mbPw" id="mbPw" placeholder="기존(임시) 비밀번호">
					</div>
					<div class="input_type">
						<label for="login_pw necessary"><b style="color: red;">*</b> 새 비밀번호</label>
						<input type="password" name="mbPw" id="mbPw" placeholder="9~20자리, 영문/숫자/특수문자 3개조합">
					</div>
					<div class="input_type">
						<label for="login_pw necessary"><b style="color: red;">*</b> 새 비밀번호 확인</label>
						<input type="password" name="mbPw" id="mbPw" placeholder="새 비밀번호를 한번 더 입력해주세요.">
					</div>					
				</div>
				<span><br></span>
				<div class="btn_wrap btn_one mt30">
					<a href="javascript:void(0);" class="btn_type btn_red" id="btn_find">비밀번호 변경하기</a>
				</div>
			</div>
		</div>
		</div>
		
		<div class="small-container">
			<div class="login">
				<h1>비밀번호 변경</h1>
				<h5>임시 비밀번호가 변경되었습니다.</h5>			
				<p>변경된 비밀번호로 로그인 후 서비스를 이용해 주시기 바랍니다.</p>
				<div class="btn_wrap btn_small btn_width_limit tc">
					<a href="javascript:void(0);" class="btn_type btn_white btn_mypage">로그인하기</a>
				</div>
			</div>
		</div>
		
		<h1>티켓 예매 조회</h1>	
		<p>그동안 예매하신 내역을 확인할 수 있어요</p>
						
						
			
			<div class="col-md-12  load_yeouido" id="payment">
				<!--예약확인-->
				<div class="row"> 
					<div class="col-sm-12 ">
						<div class="title-box-d ">
							<h3 class="title-d">예약자 확인</h3>
						</div>
						
						<div class="row">
							<div class="col-md-7">
								<form action="/bookConfirm/result" method="post" role="form" class="php-email-form" id="frmBook">
									<div class="row">
										<div class="col-md-6 mb-3">
											<!-- 예약자 성함 -->
											<div class="form-group">
												<input type="text" name="name" id="name" class="form-control form-control-lg form-control-a" placeholder="예약자 성함" data-rule="minlen:2" data-msg="성함을 입력해주세요">
												<div class="validate"></div>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<!-- 이메일주소 -->
											<div class="form-group">
												<input type="email" name="email" id="email" class="form-control form-control-lg form-control-a" placeholder="이메일주소" data-rule="email" data-msg="이메일주소를 입력해주세요">
												<div class="validate"></div>
											</div>
										</div>
		
										<div class="col-md-12 text-center">
											<button type="submit" class="btn btn-dark btn-lg btn-block"><i class="fa-solid fa-check"></i> 예약 조회</button>										
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div> 
			<!--//예약확인--> 
		
			<!--예약조회 결과-->  
			<div class="reservation_confirm" style="display: none;">
				<div class="title-box-d text-center"> 
					<hr> 
					<h5 class="pt-3"> 
					<i class="fa-solid fa-circle-check"></i> <span class="bookResult">홍길동 님은 2건의 예약내역이 있습니다.</span>  </h5> 
				</div>
		
				<!-- 예약 목록 -->
				<div class="resultContent"></div>
				
			</div>
		</div>
		
		

    <!-- =======회사소개 ======= -->
	<section class="section-agents section-t3">
		<div class="container"> 
		
			<div class="row"> 
				<div class="container">  
					<div class="row">
						<div class="col-sm-12">  
						
							<!-- 페이지 설명 및 메뉴 위치 표기 -->
							<jsp:include page="common/intro.jsp" />
							
							<div class="title-box-d">
								<h3 class="title-d">그레이프는 공유라운지    를 기반으로 한 오피스 라이프스타일 플랫폼입니다. </h3>
							</div> 
							<p>
								<br/>오피스 Amenity(편의)공간에 컨텐츠/서비스/Tech(기술)를 접목해 시설 및 서비스를 기획, 운영함으로써,
								<br/>그레이프라운지가 입점한 건물은 오피스 라이프스타일 플랫폼으로 진화하게 됩니다.
							</p> 
							<img src="/img/about/about_grape1.jpg" alt="" class="img-d img-fluid">  
						</div>
					</div>
				</div> 
			</div>
		</div>
	</section> 
	        
      <section id="about" class="mt-5" style="background: url(/img/main/bg_location3.jpg) center 26%;background-size: cover;">
        <div class="container aos-init aos-animate service">
          
          <div class="row">
            <div class="col-lg-12 mb-4"> 
              <h2 class="text-center title-a">Grape Office Lifestyle Platform</h2>
              
              </div> 
          </div>
        </div>
      </section>
 
    <section class="section-agents section-t3">
      <div class="container"> 
        <div class="row"> 
          <div class="container">  
            <!--1--> 
            <div class="business_mainbox pt-3">
              <div class="img100 mainbox_left  wow fade-in" data-aos="fade-up" style="visibility: visible; animation-name: fadeIn;">
                <div id="carouselExampleControls1" class="carousel slide" data-ride="carousel">

                  <ol class="carousel-indicators">
                    <li data-target="#carouselExampleControls1" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="1"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="2"></li>
                    <li data-target="#carouselExampleControls1" data-slide-to="3"></li>
                  </ol>
        
                  <div class="carousel-inner object_image">
                    <div class="carousel-item active">
                      <img class="d-block w-100" src="/img/about/space1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space2.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space3.jpg" alt="Third slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/space4.jpg" alt="4">
                    </div>
                  </div>
                  <a class="carousel-control-prev" href="#carouselExampleControls1" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleControls1" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
                  <!--썸네일-->
               
                  <!--//썸네일 슬라이드-->        
              </div>
              

              <div class="img100 mainbox_right wow fadeInUp" data-aos="fade-up" data-aos-delay="200" style="visibility: visible; animation-name: fadeInUp;">
                  <div class="pd30">
                      <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">SPACE
                      </div>
                    </div>
                      <span class=" colorsilver">
                        임차인의 만족도를 높여주는
                        공간을 제공합니다.<br/>
                        오피스 입주사 임직원들의 라이프스타일을 반영하여
                        사용도와 선호도가 높은 시설/공간을 배치하고
                        프리미엄 퀄리티의 인테리어를 구현하여 머무는 즐거움을 드립니다.
                      </span>
                  </div>
              </div>
          </div>

          <div style="clear: both"></div>
     
            <!--2-->
            <div class="business_mainbox">
              <div class="img100 mainbox_right wow fade-in" data-aos="fade-up" style="visibility: visible; animation-name: fadeIn;">
                <div id="carouselExampleControls2" class="carousel slide" data-ride="carousel">

                  <ol class="carousel-indicators">
                    <li data-target="#carouselExampleControls2" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="1"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="2"></li>
                    <li data-target="#carouselExampleControls2" data-slide-to="3"></li>
                  </ol>
        
                  <div class="carousel-inner object_image">
                    <div class="carousel-item active">
                      <img class="d-block w-100" src="/img/about/ex_4.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/ex_3.jpg"alt="Second slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/ex_2.jpg"alt="Third slide">
                    </div>
                    <div class="carousel-item">
                      <img class="d-block w-100" src="/img/about/office_space_img03.jpg" alt="4">
                    </div>
                  </div>
                  <a class="carousel-control-prev" href="#carouselExampleControls2" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleControls2" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
              </div>

              <div class="img100 mainbox_left  wow fadeInUp" data-aos="fade-up" data-aos-delay="200" style="visibility: visible; animation-name: fadeInUp;">
                  <div class="pd30">
                    <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">CONTENTS</h3>
                      </div>
                    </div> 
                      <span class=" colorsilver">    
                        다양한 영역의 최고 프로그램들을
                        가까운 곳으로 전해드립니다.<br/>
                        그레이프는 단순히 공간 운영에만 머무르지 않습니다.
                        유망 스타트업들과 제휴하여 다양한 컨텐츠와 프로그램을
                        입주사 임직원 및 지역 고객들에게 제공하여
                        공간과 서비스가 결합된 새로운 상품을 구현합니다.
                      </span>  
                  </div>
              </div>
            </div> 
 
                <div style="clear: both"></div>
                <hr/>


                <div class="title-wrap d-flex justify-content-between">
                  <div class="title-box">
                    <h2 class="title-a">BUSINESS VALUE </h2>
                  </div>
                </div>
                <p>그레이프는 건축주, 오피스 임차인, 컨텐츠 제공업체 등
                  오피스 공간을 소유하고, 임차하고, 사용하는 모든 이해 관계자들을 만족시킵니다.</p>

                <img src="/img/about/about_grape2.jpg" alt="" class="img-d img-fluid mb-3">
                
             </div> 
        </div>
      </div>
      
    </section> 


    <section class="section-agents section-t8"> 
      <div class="container">
        <div class="row">
          <div class="col-md-12"> 
        <hr/>
            <div class="title-wrap d-flex justify-content-between">
              <div class="title-box">
                <h2 class="title-a">CEO</h2>
              </div>
            </div>
          </div>
        </div>
            <div class="row"> 
			<div class="col-md-4 col-lg-4  aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
				<div class="row">
					 <img src="/img/about/team1_raeik.jpg" alt="" class="img-d img-fluid">
				</div> 
			</div>
			
			<!-- Contents -->
			<div class="col-md-8 col-lg-8 aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
                      <div class="agent-title">
                      <div class="title-box-d">
                        <h3 class="title-d">박래익 대표이사
                      </h3></div>
                    </div>
                      <span class=" colorsilver" style="word-break:keep-all">
					                      박래익대표는 그레이프에서 경영을 총괄하면서 사업기회 발굴 및 개발기획, 사업성 검토, 금융조달 등을 맡고 있습니다. <br/><br/>
					                      그레이프 전에는 부동산 투자 및 개발, 자산운용 등의 업무를 25년 이상 수행하였습니다. <br/><br/>
					                      주요한 경력으로는 싱가포르투자청(GIC) 한국 지사장, 코람코자산운용 대표이사, GE Real Estate 한국대표, 현대건설 리츠팀장 등이 있습니다. 
					                      <br/><br/>박래익대표는 서울대에서 건축공학 학사를 취득했으며, 
					              미국 메세추세츠 공과대학(MIT)에서 부동산 개발·도시계획 석사 학위를 받았습니다.
                      </span>
			</div> 
		</div> 
      </div>
    </section>

 
    
  </main><!-- End #main -->



<jsp:include page="common/footer.jsp" />
<jsp:include page="common/script.jsp" />




<!-- Initialize Swiper -->
<script>
  var swiper = new Swiper(".mySwiper", {
    spaceBetween: 10,
    slidesPerView: 4,
    freeMode: true,
   
    watchSlidesProgress: true,
    
  });
  var swiper2 = new Swiper(".mySwiper2", {
    spaceBetween: 10,
    autoplay: {
            delay: 5000,
            disableOnInteraction: false,
          },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    thumbs: {
      swiper: swiper,
    },
  });
  </script>


</body>

</html>
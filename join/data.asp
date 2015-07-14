<!-- #include file = "../inc/header.asp" -->
<%
Dim agree : agree = request("agree")
Dim length : length = Split(agree,",")
Dim agree1 : agree1 = 1
Dim agree2 : agree2 = 1

Dim arrList
Dim cntList : cntList  = -1

For i=0 To ubound(length)
	If Trim(length(i)) = "agree1" Then 
		agree1= 0
	End If
	If Trim(length(i)) = "agree2" Then 
		agree2= 0
	End If
Next

If agree1 <> 0 Or agree2 <> 0 Then
	Response.redirect "../join/"
End If

Call Expires()
Call dbopen()
	Dim optionEmail  : optionEmail  = setCodeOption( 11  , "select" , 1 , "" )
	Dim optionPhone  : optionPhone  = setCodeOption( 9  , "select" , 1 , "" )
	Dim optionhPhone : optionhPhone = setCodeOption( 10  , "select" , 1 , "" )

	Call GetList()

Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		.Parameters("@CHECK").value = 0
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap" style="border-bottom:2px solid #999a9d;padding-bottom:40px;">
			<h3 class="title"><span class="color_green">간단한 절차</span>로 가입하실 수 있습니다.</h3>
			<p>
				간단한 정보만 입력하시면<br>
				OCEAN의 다양한 서비스를 바로 이용하실 수 있습니다.
			</p>
		</div>
		<STYLE type="text/css">
			td.label{width:127px;height:60px;font-size:14px;}
			td.cont{width:343px;}
			td.cont2{width:813px;}
			

			.form_wrap{width:100%;border-bottom:1px solid #999a9d;padding-bottom:10px;text-align:center;margin-top:10px;}
			.form_wrap .table{width:940px;margin:0px auto;text-align:left;}
			.form_wrap .row{margin:0px;}
		</STYLE>

		<form name="mForm" id="mForm" method="post" action="join_proc.asp" enctype="multipart/form-data" onsubmit="return checkJoin()">
		<div class="form_wrap">
			<table cellpadding="0" cellspacing="0" class="table" align="center">
				<tr>
					<td class="label">아이디 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="userId" name="userId" class="input" style="width:300px;ime-mode:disabled;" maxlength="12">
						</div>
					</td>
					<td class="label">성명 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" class="input" id="userName" name="userName" maxlength="30" style="width:300px;ime-mode:active;">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">비밀번호 <span class="color_red">*</span></td>
					<td class="cont" style="font-size:14px;">
						<div class="row">
							<input type="password" id="userPwd" name="userPwd" class="input" style="width:300px;" maxlength="20">
						</div>
					</td>
					<td class="label">비밀번호 확인 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:300px;" maxlength="20">
						</div>
					</td>
				</tr>
				<tr>
					<td class="label" style="height:40px;">부서/직위 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="userPosition" name="userPosition" class="input" style="width:300px;ime-mode:active;" maxlength="100">
						</div>
					</td>
					<td class="label" style="height:40px;">휴대전화 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<select class="input" id="userhPhone1" name="userhPhone1" style="width:85px;height:32px;padding:5px;">
								<option value="">선택</option>
								<%=optionhPhone%>
							</select> -
							<input type="text" id="userhPhone2" name="userhPhone2" maxlength="4" class="input" style="width:86px;"> -
							<input type="text" id="userhPhone3" name="userhPhone3" maxlength="4" class="input" style="width:86px;"> 
						</div>
					</td>
				</tr>
				<tr>
					<td class="label" style="height:40px;">전화 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<select class="input" id="userPhone1" name="userPhone1" style="width:85px;height:32px;padding:5px;">
								<option value="">선택</option>
								<%=optionPhone%>
							</select> -
							<input type="text" id="userPhone2" name="userPhone2" maxlength="4" class="input" style="width:86px;"> -
							<input type="text" id="userPhone3" name="userPhone3" maxlength="4" class="input" style="width:86px;"> 
						</div>
					</td>
					<td class="label" style="height:40px;">팩스 <span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<select class="input" id="userfax1" name="userfax1" style="width:85px;height:32px;padding:5px;">
								<option value="">선택</option>
								<%=optionPhone%>
							</select> -
							<input type="text" id="userfax2" name="userfax2" maxlength="4" class="input" style="width:86px;"> -
							<input type="text" id="userfax3" name="userfax3" maxlength="4" class="input" style="width:86px;"> 
						</div>
					</td>
				</tr>
				<tr>
					<td class="label" style="padding-bottom:80px;">이메일 <span class="color_red">*</span></td>
					<td class="cont" style="padding-bottom:80px;">
						<div class="row">
							<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:80px;ime-mode:disabled" maxlength="100"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:80px;ime-mode:disabled" maxlength="100">
							<select class="input" id="userEmail3" style="width:100px;height:32px;padding:5px;">
								<option value="">직접입력</option>
								<%=optionEmail%>
							</select>
							<div class="color_red" style="font-size:11px;line-height:160%;position:absolute;bottom:-60px;left:0px;">
								입력하신 이메일은 아이디, 비밀번호 분실 시 찾기 위한 용도로 <br>사용되오니 신중하게 입력해 주세요.<br>
								미등록 회사 회원가입시 반드시 회사 이메일을 기입하여 주시기 바랍니다.
							</div>
						</div>
					</td>
					<td class="label" style="padding-bottom:80px;">회사명 <span class="color_red">*</span></td>
					<td class="cont" style="padding-bottom:80px;">
						<div class="row">
							<input type="hidden" id="companyName" name="companyName">
							<select class="input" id="companySelect" name="companySelect" style="width:320px;height:32px;padding:5px;">
								<option value="">선택</option>
								<%for iLoop = 0 to cntList%>
								<option value="<%=arrList(FI_idx,iLoop)%>"><%=arrList(FI_cName,iLoop)%></option>
								<%Next%>
								<option value="NEW">직접입력</option>
							</select>
							<div class="color_red" style="font-size:11px;line-height:160%;position:absolute;bottom:-75px;left:0px;">
							회사명은 반드시 선택되어야 하는 사항이며<br>
							기등록된 회사명을 선택하시거나, 회사명이 미등록되었경우는<br>
							반드시 직접입력을 선택하시어 상세 회사정보를 등록 신청하여 <br>주시기 바랍니다.<br>
							</div>
						</div>
					</td>
				</tr>
				
			</table>
		</div>
		
		<div id="company_input" style="display:none;">
			<div class="form_wrap">
				<table cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td class="label">업체명(상호)<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cName" name="cName" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
						<td class="label">대표자<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="ceo" name="ceo" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">사업자등록번호<span class="color_red">*</span></td>
						<td class="cont" style="font-size:14px;">
							<div class="row">
								<input type="text" id="userSaNo" name="userSaNo" class="input" style="width:300px;" maxlength="10">
							</div>
						</td>
						<td class="label">설립일<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cDate" name="cDate" class="input" style="width:300px;" maxlength="10" readonly>
							</div>
						</td>
					</tr>
					<tr>
						<td class="label" style="height:40px;">주소<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="addr1" name="addr1" class="input" style="width:300px;ime-mode:active;" maxlength="100" readonly onclick="openDaumPostcode()">
							</div>
						</td>
						<td class="label" style="height:40px;"> </td>
						<td class="cont">
							 
						</td>
					</tr>
					<tr>
						<td class="label" style="height:40px;">상세주소<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="addr2" name="addr2" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
						<td class="label" style="height:40px;"> </td>
						<td class="cont">
							 
						</td>
					</tr>
					<tr>
						<td class="label">기업 규모<span class="color_red">*</span></td>
						<td class="cont">
							<div class="radio_wrap">
								<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="1" checked></span></span>
								<label><b>대기업</b></label>
							</div>&nbsp;&nbsp;&nbsp;
							<div class="radio_wrap">
								<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="2"></span></span>
								<label><b>중소기업</b></label>
							</div>&nbsp;&nbsp;&nbsp;
							<div class="radio_wrap">
								<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="3"></span></span>
								<label><b>기관</b></label>
							</div>
						</td>
						<td class="label">대표전화<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cPhone" name="cPhone" class="input" style="width:300px;ime-mode:active;" maxlength="50" >
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">업종<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cSectors" name="cSectors" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
						<td class="label">홈페이지<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="homepage" name="homepage" class="input" style="width:300px;ime-mode:disabled;" maxlength="200" >
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">주생산품목<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cItems" name="cItems" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
						<td class="label">전년도매출액<span class="color_red">*</span><br><span style="font-size:12px;">(단위: 백만원)</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cSales" name="cSales" class="input" style="width:300px;ime-mode:disabled;" maxlength="50" >
							</div>
						</td>
					</tr>
					<tr>
						<td class="label">상시종업원수<span class="color_red">*</span><br><span style="font-size:12px;">(단위: 명)</span></td>
						<td class="cont">
							<div class="row">
								<input type="text" id="cStaff" name="cStaff" class="input" style="width:300px;ime-mode:active;" maxlength="50" >
							</div>
						</td>
						<td class="label">연구소<span class="color_red">*</span></td>
						<td class="cont">
							<div class="radio_wrap">
								<span name="_radio" class="off"><span class="blind"><input type="radio" name="cCenter" value="1" checked></span></span>
								<label><b>유</b></label>
							</div>&nbsp;&nbsp;&nbsp;
							<div class="radio_wrap">
								<span name="_radio" class="off"><span class="blind"><input type="radio" name="cCenter" value="2"></span></span>
								<label><b>무</b></label>
							</div>
						</td>
					</tr>
				</table>
			</div>

			<div class="form_wrap">
				<table cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td class="label">사업분야<span class="color_red">*</span></td>
						<td class="cont2">
							<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business1" class="business_check" value="1"></span></span>
								<label><b>LED</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business2" class="business_check" value="1"></span></span>
								<label><b>전기·전자</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business3" class="business_check" value="1"></span></span>
								<label><b>조선해양</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business4" class="business_check" value="1"></span></span>
								<label><b>정보통신</b></label>
							</div>
							<br><br>

							<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business5" class="business_check" value="1"></span></span>
								<label><b>나노·신소재</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business6" class="business_check" value="1"></span></span>
								<label><b>기계·자동차 부품소재</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business7" class="business_check" value="1"></span></span>
								<label><b>바이오·제약</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business8" class="business_check" value="1"></span></span>
								<label><b>섬유·화학</b></label>
							</div>
							<br><br>

							<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business9" class="business_check" value="1"></span></span>
								<label><b>식품생명</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business10" class="business_check" value="1"></span></span>
								<label><b>건축·토목</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business11" class="business_check" value="1"></span></span>
								<label><b>녹색에너지</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business12" class="business_check" value="1"></span></span>
								<label><b>기타</b></label>
							</div>
							<br><br>

							<div class="row">
								<input type="text" id="business" name="business" class="input" style="width:770px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
					</tr>
				</table>
			</div>

			<div class="form_wrap">
				<table cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td class="label">사물인터넷<br>사업분야<span class="color_red">*</span></td>
						<td class="cont2">
							<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business1" class="iot_business_check" value="1"></span></span>
								<label><b>사물인터넷 플랫폼</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business2" class="iot_business_check" value="1"></span></span>
								<label><b>연구 및 용역개발</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business3" class="iot_business_check" value="1"></span></span>
								<label><b>사물인터넷 서비스</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business4" class="iot_business_check" value="1"></span></span>
								<label><b>기술 및 경영자문</b></label>
							</div>
							<br><br>

							<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business5" class="iot_business_check" value="1"></span></span>
								<label><b>사물인터넷 기기 및 제품</b></label>
							</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
								<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business6" class="iot_business_check" value="1"></span></span>
								<label><b>기타</b></label>
							</div>
							<br><br>

							<div class="row">
								<input type="text" id="iot_business" name="iot_business" class="input" style="width:770px;ime-mode:active;" maxlength="100" >
							</div>
						</td>
					</tr>
				</table>
			</div>

			<div class="form_wrap">
				<table cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td class="label">사업자등록증<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="file" id="files1" name="files1" class="input" style="width:300px;">
							</div>
						</td>
						<td class="label">회사로고<span class="color_red">*</span></td>
						<td class="cont">
							<div class="row">
								<input type="file" id="files2" name="files2" class="input" style="width:300px;">
							</div>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3" style="font-size:11px;color:#000000;line-height:160%;">
							사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.<br>
							오류 문의시 브라우저명, 버전과 구체적 상황 또는 캡쳐화면을 첨부해주시면 신속하고 정확한 답변이 가능합니다.<br>
							파일의 크기가 3MB를 초과하거나 2개 이상의 파일을 첨부하실 경우 spweb@naver.com 으로 보내주시기 바랍니다. <br>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div style="margin:30px;line-height:40px;" class="btn_area">
			<button type="submit" class="btn">멤버신청 완료</button>
		</div>

		</form>



	</div>
</div>

<script type="text/JavaScript" src="../inc/js/member.js"></script>
<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	$userId.focus();

	$('#companySelect').change(function(){
		var v = $(this).val();
		var t = $('#companySelect option:selected').text();
		if(v == 'NEW'){
			$('#company_input').show();
			$('#companyName').val( '' );
		}else{
			$('#company_input').hide();
			$('#companyName').val( t );
		}
		setLeftHeight();
	});
});
function checkJoin(){

	var userId = checkFormUserId(true,false);
	if( userId == false ){$userId.focus();return false;}

	if(!$ajaxIdCheck){
		alert(member_msg.userId.m4);
		return false;
	}

	var userName = checkFormUserName(true);
	if( !userName ){$userName.focus();return false;}
	
	var userPwd = checkFormUserPwd(true);
	if( !userPwd ){$userPwd.focus();return false;}
	
	var userPwdConfirm = checkFormUserPwdConfirm(true);
	if( !userPwdConfirm ){$userPwdConfirm.focus();return false;}
	
	if( !$.trim( $('#userPosition').val() ) ){
		alert('부서/직위를 입력해 주시기 바랍니다.');$('#userPosition').focus();return false; 
	}

	//var userSaNo = checkFormUserSaNo(true,false);
	//if( !userSaNo ){$userSaNo.focus();return false;}

	//if( $('#userhPhone1').val() || $('#userhPhone2').val() || $('#userhPhone3').val() ){
		var userhPhone = checkFormUserphoen(true);
		if( !userhPhone ){return false;}
	//}
	//if( $('#userPhone1').val() || $('#userPhone2').val() || $('#userPhone3').val() ){
		var userPhone = checkFormUserphoen2(true);
		if( !userPhone ){return false;}
	//}
	//if( $('#userfax1').val() || $('#userfax2').val() || $('#userfax3').val() ){
		var userFax = checkFormUserFax(true);
		if( !userFax ){return false;}
	//}

	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}
	
	if( !$('#companySelect').val() ){
		alert('회사명을 선택해주세요.');return false;
	}
	if( $('#companySelect').val() == 'NEW' ){
	
		if( !$.trim( $('#cName').val() ) ){
			alert('업체명을 입력하세요.');
			return false;
		}
		if( !$.trim( $('#ceo').val() ) ){
			alert('대표자를 입력하세요.');
			return false;
		}
		
		var userSaNo = checkFormUserSaNo(true,false);
		if( !userSaNo ){$userSaNo.focus();return false;}

		if(!$ajaxSanoCheck){
			alert(member_msg.userSaNo.m4);
			return false;
		}

		if( !$.trim( $('#cDate').val() ) ){
			alert('설립일을 입력하세요.');
			return false;
		}
		if( !$.trim( $('#addr1').val() ) ){
			alert('주소를 입력하세요.');
			return false;
		}
		if( !$.trim( $('#addr2').val() ) ){
			alert('상세주소를 입력하세요.');
			return false;
		}
		if( !$.trim( $('#addr2').val() ) ){
			alert('상세주소를 입력하세요.');
			return false;
		}
		if( !$.trim( $('#cPhone').val() ) ){
			alert('대표전화를 입력하세요.');
			return false;
		}
		if( !$.trim( $('#cSectors').val() ) ){
			alert('업종을 입력하세요.');
			return false;
		}
		if( !$.trim( $('#homepage').val() ) ){
			alert('홈페이지를 입력하세요.');
			return false;
		}
		if( !$.trim( $('#cItems').val() ) ){
			alert('주생산품목을 입력하세요.');
			return false;
		}
		if( !$.trim( $('#cSales').val() ) ){
			alert('전년도매출액을 입력하세요.');
			return false;
		}
		if( !$.trim( $('#cStaff').val() ) ){
			alert('상시종업원수를 입력하세요.');
			return false;
		}
		if( $('.business_check:checked').length <= 0 ){
			alert('사업분야를 1개이상 선택해주세요.');
			return false;
		}
		if( $('input[name="business12"]:checked').length > 0 && !$.trim( $('#business').val() ) ){
			alert('사업분야 기타 내용을 입력해주세요.');
			return false;
		}
		if( $('.iot_business_check:checked').length <= 0 ){
			alert('사물인터넷 사업분야를 1개이상 선택해주세요.');
			return false;
		}
		if( $('input[name="iot_business6"]:checked').length > 0 && !$.trim( $('#iot_business').val() ) ){
			alert('사물인터넷 사업분야 기타 내용을 입력해주세요.');
			return false;
		}
		if( !$.trim( $('#files1').val() ) ){
			alert('사업자등록증을 등록해주세요.');
			return false;
		}
		if( !$.trim( $('#files2').val() ) ){
			alert('회사로고를 등록해주세요.');
			return false;
		}

	}

	$('.btn_area').html('처리 중입니다.');
}


function openDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
			//document.getElementById('post1').value = data.postcode1;
			//document.getElementById('post2').value = data.postcode2;
			//document.getElementById('addr').value = data.address;
			//전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
			//아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
			var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
			document.getElementById('addr1').value = addr;
			document.getElementById('addr2').focus();
		}
	}).open();
}

$(function() {
  $( "#cDate" ).datepicker({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    dayNames: ['일','월','화','수','목','금','토'],
    dayNamesShort: ['일','월','화','수','목','금','토'],
    dayNamesMin: ['일','월','화','수','목','금','토'],
    showMonthAfterYear: true,
    yearSuffix: '년',
	changeMonth : true,
	changeYear : true,
	//showOtherMonths:true,
	//selectOtherMonths: true,
	maxDate: "+0D",
	yearRange: 'c-100:c+0'
  });
});
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
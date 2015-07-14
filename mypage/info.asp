<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )

Call Expires()
Call dbopen()
	Call getView()
	
	Dim UserEmail    : UserEmail    = Split( IIF(FI_UserEmail="","@",FI_UserEmail) , "@" )
	Dim optionEmail  : optionEmail  = setCodeOption( 11  , "select" , 1 , UserEmail(1) )
	Dim optionFax    : optionFax    = setCodeOption( 9   , "select" , 1 , FI_UserFax1 )
	Dim optionPhone  : optionPhone  = setCodeOption( 9   , "select" , 1 , FI_UserPhone1 )
	Dim optionhPhone : optionhPhone = setCodeOption( 10  , "select" , 1 , FI_UserHPhone1 )

Call dbclose()

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@UserIdx").value = session("UserIdx")
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">회원정보 변경</h3>

			<form name="mForm" id="mForm" method="post" action="info_proc.asp" onsubmit="return checkJoin()">
			<div class="form_wrap" style="width:450px;">
				<div class="row">
					<label>성명 </label>
					<span style="font-size:20px;"><b><%=Session("UserName")%></b></span>
				</div>

				<div class="row">
					<label>회사명 </label>
					<span style="font-size:20px;"><b><%=FI_cName%></b></span>
				</div>

				<div class="row">
					<label>부서/직위 <span class="color_red">*</span></label>
					<input type="text" id="userPosition" name="userPosition" class="input" style="width:295px;ime-mode:active;" maxlength="100" value="<%=FI_UserPosition%>">
				</div>

				<div class="row">
					<label>휴대전화 <span class="color_red">*</span></label>
					<select class="input" id="userhPhone1" name="userhPhone1" style="width:85px;height:32px;padding:5px;">
						<option value="">선택</option>
						<%=optionhPhone%>
					</select> -
					<input type="text" id="userhPhone2" name="userhPhone2" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserHPhone2%>"> -
					<input type="text" id="userhPhone3" name="userhPhone3" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserHPhone3%>"> 
				</div>
				<div class="row">
					<label>전화 <span class="color_red">*</span></label>
					<select class="input" id="userPhone1" name="userPhone1" style="width:85px;height:32px;padding:5px;">
						<option value="">선택</option>
						<%=optionPhone%>
					</select> -
					<input type="text" id="userPhone2" name="userPhone2" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserPhone2%>"> -
					<input type="text" id="userPhone3" name="userPhone3" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserPhone3%>"> 
				</div>

				<div class="row">
					<label>팩스 <span class="color_red">*</span></label>
					<select class="input" id="userfax1" name="userfax1" style="width:85px;height:32px;padding:5px;">
						<option value="">선택</option>
						<%=optionFax%>
					</select> -
					<input type="text" id="userfax2" name="userfax2" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserFax2%>"> -
					<input type="text" id="userfax3" name="userfax3" maxlength="4" class="input" style="width:85px;" value="<%=FI_UserFax3%>"> 
				</div>


				<div class="row">
					<label>이메일 <span class="color_red">*</span></label>
					<div style="display:inline-block;">
						<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:80px;" maxlength="100" value="<%=UserEmail(0)%>"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:80px;" maxlength="100" value="<%=UserEmail(1)%>">
						<select class="input" id="userEmail3" style="width:100px;height:32px;padding:5px;">
							<option value="">직접입력</option>
							<%=optionEmail%>
						</select>
						<div class="color_red" style="font-size:11px;line-height:160%;margin-top:10px;">입력하신 이메일은 아이디, 비밀번호 분실 시 찾기 위한 용도로 <br>사용되오니 신중하게 입력해 주세요.</div>
					</div>
				</div>

			</div>
			
			<div style="margin:30px;text-align:center;">
				<button type="submit" class="btn">정보변경</button>
			</div>
			</form>


		</div>
		
	</div>
</div>

<script type="text/JavaScript" src="../inc/js/member.js"></script>
<SCRIPT type="text/javascript">
function checkJoin(){
	if( !$.trim( $('#userPosition').val() ) ){
		alert('부서/직위를 입력해 주시기 바랍니다.');$('#userPosition').focus();return false; 
	}
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

	$('.btn_area').html('처리 중입니다.');
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
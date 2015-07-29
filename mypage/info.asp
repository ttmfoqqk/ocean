<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )

Call Expires()
Call dbopen()
	Call getView()

	UserHPhone = IIF( FI_UserHPhone="",FI_UserHPhone1 &"-"& FI_UserHPhone2 &"-"& FI_UserHPhone3,FI_UserHPhone )
	UserPhone  = IIF( FI_UserPhone="",FI_UserPhone1 &"-"& FI_UserPhone2 &"-"& FI_UserPhone3,FI_UserPhone )

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
			<h3 class="title">Account Changes</h3>
			
			<%if Session("change_id") = "false" then %>
				<div style="width:450px;margin:0px auto;">
					<h1>리뉴얼전 사용자는 회원정보를 변경해주시기 바랍니다.</h1>
				</div>
			<%end if%>

			<form name="mForm" id="mForm" method="post" action="info_proc.asp" onsubmit="return checkJoin()">
			<div class="form_wrap" style="width:450px;">
				<div class="row">
					<span style="font-size:20px;"><b><%=FI_UserId%></b></span>
				</div>
				<div class="row">
					<span style="font-size:20px;"><b><%=FI_cName%></b></span>
				</div>
				
				<%if Session("change_id") = "false" then %>
				<div class="row">
					<input type="text" id="userId" name="userId" class="input" style="width:95%;ime-mode:disabled;" value="<%=FI_UserEmail%>" maxlength="320" placeholder="Company Email ( User Account )">
					<span>아이디로 변경할 이메일 안내</span>
				</div>
				<%end if%>

				<div class="row">
					<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;vertical-align:middle;">
						<input type="text" class="input" id="FirstName" name="FirstName" maxlength="30" style="width:90%;" placeholder="First Name" value="<%=FI_UserName%>">
					</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;vertical-align:middle;">
						<input type="text" class="input" id="LastName" name="LastName" maxlength="30" style="width:90%;" placeholder="Last Name" value="<%=FI_UserNameLast%>">
					</div>
				</div>

				<div class="row">
					<input type="text" id="userPosition" name="userPosition" class="input" style="width:95%;" maxlength="100" value="<%=FI_UserPosition%>" placeholder="Department/Position">
				</div>
				<div class="row">
					<input type="text" id="userhPhone" name="userhPhone" class="input" style="width:95%;" maxlength="30" value="<%=UserHPhone%>" placeholder="Mobile. No">
				</div>
				<div class="row">
					<input type="text" id="userPhone" name="userPhone" class="input" style="width:95%;" maxlength="30" value="<%=UserPhone%>" placeholder="Tel. No">
				</div>

				<div style="margin:30px;text-align:center;" class="btn_area">
					<button type="submit" class="btn">Submit</button>
				</div>

				</div>
			</div>
			</form>


		</div>
		
	</div>
</div>


<%if Session("change_id") = "true" then %>
<SCRIPT type="text/javascript">
function checkJoin(){
	var data = [
		 ['FirstName','length','Please enter First Name']
		,['LastName','length','Please enter Last Name']
		,['userPosition','length','Please enter Department/Position']
		,['userhPhone','length','Please enter Mobile. No']
		,['userPhone','length','Please enter Tel. No']
	];

	var checkform = checkInputValue(data);
	if(!checkform){return false;}
}
</SCRIPT>
<%else%>
<SCRIPT type="text/javascript">
function checkJoin(){
	var data = [
		 ['userId','length','Please enter id.']
		,['userId','mail','E-mail format is incorrect.']
		,['FirstName','length','Please enter First Name']
		,['LastName','length','Please enter Last Name']
		,['userPosition','length','Please enter Department/Position']
		,['userhPhone','length','Please enter Mobile. No']
		,['userPhone','length','Please enter Tel. No']
	];

	var checkform = checkInputValue(data);
	if(!checkform){return false;}
}
</SCRIPT>
<%end if%>
<!-- #include file = "../inc/footer.asp" -->
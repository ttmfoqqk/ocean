<!-- #include file = "../inc/header.asp" -->
<%
d = request("d")

complete_code = Base64decode( d )
temp_array    = split(complete_code,",")
error_code    = 1

If ( UBound(temp_array)<1 ) Then
	'Response.Write("error")
else
	user_idx   = temp_array(0)
	user_email = temp_array(1)

	If ( IsNumeric( user_idx ) = false ) Then
		'Response.Write("error")
	End if
	
	If ( isValidEmail( user_email ) = false ) Then
		'Response.Write("error")
	End if
	
	user_idx = user_idx / len(user_email)

	Call Expires()
	Call dbopen()
	
	Call getList()

	error_code = FI_RESULT
	
	'이메일 발송
	if FI_EMAIL_FG = 0 then
		dim admin_email_addr
		call admin_email()
		call getView()

		email_result1 = sendSmsEmail( "join_ceo" , user_email , "" , user_email , "" , "" )
		email_result2 = sendSmsEmail_state( "join_state_admin" , admin_email_addr , FV_cName , "CEO" , FV_UserPOsition , FV_UserName &" "& FV_UserNameLast , FV_UserHPhone , user_email , "" )
	end if


	Call dbclose()


End if




Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "ocean_user_member_search"
		.Parameters("@actType").value = "complete"
		.Parameters("@id").value      = user_email
		.Parameters("@cIdx").value    = user_idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@UserIdx").value = user_idx
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FV")
	objRs.close	: Set objRs = Nothing
End Sub


Sub admin_email()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("ADODB.Command")

	SQL = "SELECT top 1 [email]  "  &_
	" FROM [OCEAN_ADMIN_MEMBER] WHERE [Id] = 'admin' "
   
	call cmdopen()
	with objCmd
		.CommandText = SQL
		set objRs = .Execute
	End with
	call cmdclose()
	
	If NOT(objRs.BOF or objRs.EOF) Then
		admin_email_addr  = objRs(0)
	End If

	Set objRs = Nothing
End Sub

%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	
	<div class="wrap">
		<h2 class="page_title">Verification email for the OCEAN membership application</h2>
		<p class="page_contants" style="text-align:center;">
			<%if error_code = 0 then %>
			<b class="color_green">인증성공</b><br><br>
			관리자 승인 후 멤버 가입이 이루어집니다.
			<%else%>
			<b class="color_green">인증실패</b><br><br>
			관리자에게 문의하세요. <br>
			araha@keti.re.kr
			<%end if%>
		</p>

		<div style="margin:30px;">
			<button type="button" class="btn" onclick="location.href='../login/';">Login</button>
		</div>

		
	</div>

</div>
<!-- #include file = "../inc/footer.asp" -->
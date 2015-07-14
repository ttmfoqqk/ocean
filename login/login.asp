<!-- #include file="../inc/header.asp" -->
<%
If Session("UserIdx") <> "" Then 
	Response.redirect "../mypage/"
End If

Dim GoUrl   : GoUrl   = IIF(Request("GoUrl")="","../",Request("GoUrl"))
Dim UserId  : UserId  = Request("UserId")
Dim UserPwd : UserPwd = Request("UserPwd")
Dim SaveLog : SaveLog = Request("SaveLog")

if UserId="" Or  UserPwd = "" Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.\n\n대소문자 확인 후 입력해주세요!');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Call Expires()
Call dbopen()
	Call Check()

	If FI_Pass = "1" Then
		If FI_state > 0 Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('승인 대기 중입니다.\n\n관리자 승인 후 멤버 가입이 이루어집니다.');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If

		' 쿠키 생성
		If SaveLog = "Y" Then 
			response.cookies("UserIdSave")("id")    = UserId
			response.cookies("UserIdSave")("pwd")   = UserPwd
			response.cookies("UserIdSave")("check") = "Y"
			Response.Cookies("UserIdSave").domain   = Request.ServerVariables("SERVER_NAME")
			response.cookies("UserIdSave").expires  = Now() + 365
		Else
			response.cookies("UserIdSave").expires  = Now() - 1
		End If

		Session("UserIdx")   = FI_UserIdx
		Session("UserId")    = FI_UserId
		Session("UserName")  = FI_UserName
		Session("UserCIdx")  = FI_companyIdx
		Session("UserCeoFg") = FI_ceo

		response.redirect GoUrl
	Else
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.\n\n대소문자 확인 후 입력해주세요!');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

Call dbclose()

'로그인 조회
Sub Check()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_LOGIN"
		.Parameters("@UserId").value    = UserId
		.Parameters("@UserPass").value  = UserPwd
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
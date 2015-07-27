<!-- #include file = "../inc/header.asp" -->
<%
Dim userId        : userId        = request.Form("userId")
Dim FirstName     : FirstName     = request.Form("FirstName")
Dim LastName      : LastName      = request.Form("LastName")
Dim companySelect : companySelect = request.Form("companySelect")

If userId = "" Or FirstName = "" Or LastName = "" Or companySelect = "" Then 
	Response.redirect "find_pwd.asp"
End If

Call Expires()
Call dbopen()
	Call getList()

	If FI_UserId = "" Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('입력하신 정보와 일치하는 정보가 없습니다.');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	' 난수발생 비밀번호변경 -> 이메일 발송.
	Dim tpm_rand : tpm_rand = RandomNumber(10,"")
	Dim result   : result   = sendSmsEmail( "pwd_search" , userId , "" , userId , tpm_rand , "" )

	Call update()

	session("search_pwd_email") = userId

Call dbclose()

Response.redirect "find_pwd_result.asp"

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "ocean_user_member_search"
		.Parameters("@actType").value   = "pwd"
		.Parameters("@id").value        = userId
		.Parameters("@FirstName").value = FirstName
		.Parameters("@LastName").value  = LastName
		.Parameters("@cIdx").value      = companySelect
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub update()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value     = "S_PWD"
		.Parameters("@NewUserPass").value = tpm_rand
		.Parameters("@UserIdx").value     = FI_UserIdx
		.Execute
	End with
	set objCmd = nothing
End Sub
%>
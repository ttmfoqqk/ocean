<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & BASE_PATH & "mypage/info.asp" )

Dim userId       : userId       = Trim( request.Form("userId") )
Dim FirstName    : FirstName    = Trim( request.Form("FirstName") )
Dim LastName     : LastName     = Trim( request.Form("LastName") )
Dim userhPhone   : userhPhone   = Trim( request.Form("userhPhone") )
Dim userPhone    : userPhone    = Trim( request.Form("userPhone") )
Dim userPosition : userPosition = Trim( request.Form("userPosition") )

Call Expires()
Call dbopen()
	Call update()
Call dbclose()



if Session("change_id") = false then
	
	If FI_IN_CNT > 0 Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('현재 사용중인 아이디입니다.');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Session("UserId")    = userId
	Session("UserName")  = FirstName & " " & LastName
	Session("change_id") = isValidEmail(userId)

end if

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('변경 되었습니다.');"
 .Write "location.href='info.asp';"
 .Write "</script>"
 .End
End With


Sub update()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value      = IIF(Session("change_id")= true,"INFO_UPDATE","ID_UPDATE")
		.Parameters("@UserIdx").value      = session("userIdx")
		.Parameters("@UserId").value       = userId
		.Parameters("@FirstName").value    = FirstName
		.Parameters("@LastName").value     = LastName
		.Parameters("@UserHPhone").value   = userhPhone
		.Parameters("@UserPhone").value    = userPhone
		.Parameters("@userPosition").value = userPosition
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
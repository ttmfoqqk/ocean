<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & BASE_PATH & "mypage/info.asp" )

Dim userId       : userId       = Trim( request.Form("userId") )
Dim FirstName    : FirstName    = Trim( request.Form("FirstName") )
Dim LastName     : LastName     = Trim( request.Form("LastName") )
Dim userhPhone   : userhPhone   = Trim( request.Form("userhPhone") )
Dim userPhone    : userPhone    = Trim( request.Form("userPhone") )
Dim userPosition : userPosition = Trim( request.Form("userPosition") )

if Session("change_id") = "false" then
	
	If userId = "" Or FirstName = "" Or LastName = "" Or userhPhone = "" Or userPhone = "" Or userPosition = "" Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('You are missing list');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

else
	
	If FirstName = "" Or LastName = "" Or userhPhone = "" Or userPhone = "" Or userPosition = "" Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('You are missing list');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

end if

Call Expires()
Call dbopen()
	Call update()
Call dbclose()



if Session("change_id") = "false" then
	
	If FI_IN_CNT > 0 Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('The ID is currently in use');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	Session("UserId")    = userId
	Session("UserName")  = FirstName & " " & LastName
	if isValidEmail(userId) then
		Session("change_id") = "true"
	else
		Session("change_id") = "false"
	end if	

end if

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('edited completed');"
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
		.Parameters("@actType").value      = IIF(Session("change_id")= "true","INFO_UPDATE","ID_UPDATE")
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
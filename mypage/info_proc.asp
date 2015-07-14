<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & "/ocean/mypage/info.asp" )
Dim userhPhone1    : userhPhone1    = Trim( request.Form("userhPhone1") )
Dim userhPhone2    : userhPhone2    = Trim( request.Form("userhPhone2") )
Dim userhPhone3    : userhPhone3    = Trim( request.Form("userhPhone3") )
Dim userPhone1     : userPhone1     = Trim( request.Form("userPhone1") )
Dim userPhone2     : userPhone2     = Trim( request.Form("userPhone2") )
Dim userPhone3     : userPhone3     = Trim( request.Form("userPhone3") )
Dim userfax1       : userfax1       = Trim( request.Form("userfax1") )
Dim userfax2       : userfax2       = Trim( request.Form("userfax2") )
Dim userfax3       : userfax3       = Trim( request.Form("userfax3") )
Dim userEmail1     : userEmail1     = Trim( request.Form("userEmail1") )
Dim userEmail2     : userEmail2     = Trim( request.Form("userEmail2") )
Dim userPosition   : userPosition   = Trim( request.Form("userPosition") )

If userEmail1 = "" Or userEmail2 = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 목록이 있습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If


Call Expires()
Call dbopen()
	Call update()
Call dbclose()

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
		.Parameters("@actType").value     = "INFO_UPDATE"
		.Parameters("@UserIdx").value     = session("userIdx")
		.Parameters("@UserHPhone1").value = userhPhone1
		.Parameters("@UserHPhone2").value = userhPhone2
		.Parameters("@UserHPhone3").value = userhPhone3
		.Parameters("@UserPhone1").value  = userPhone1
		.Parameters("@UserPhone2").value  = userPhone2
		.Parameters("@UserPhone3").value  = userPhone3
		.Parameters("@UserFax1").value    = userfax1
		.Parameters("@UserFax2").value    = userfax2
		.Parameters("@UserFax3").value    = userfax3
		.Parameters("@UserEmail").value   = userEmail1 & "@" & userEmail2
		.Parameters("@userPosition").value = userPosition
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
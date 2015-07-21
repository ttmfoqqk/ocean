<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & "/ocean/mypage/info.asp" )
Dim userhPhone   : userhPhone   = Trim( request.Form("userhPhone") )
Dim userPhone    : userPhone    = Trim( request.Form("userPhone") )
Dim userPosition : userPosition = Trim( request.Form("userPosition") )

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
		.Parameters("@actType").value      = "INFO_UPDATE"
		.Parameters("@UserIdx").value      = session("userIdx")
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
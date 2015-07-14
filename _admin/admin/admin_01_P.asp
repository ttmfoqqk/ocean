<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin( g_host & g_url )
Dim alertMsg : alertMsg = ""
Dim Agree1   : Agree1   = Trim( Request.Form("Agree1") )
Dim Agree2   : Agree2   = Trim( Request.Form("Agree2") )

Call Expires()
Call dbopen()
	Call AgreeProc()
	alertMsg = "정상처리 되었습니다."
Call dbclose()

Sub AgreeProc()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_AGREE_P"
		.Parameters("@Agree1").value  = Agree1
		.Parameters("@Agree2").value  = Agree2
		Set objRs = .Execute
	End with
	set objCmd = nothing
End Sub
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
</head>
<script language=javascript>
	if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
	top.location.href = "Admin_01_L.asp";
</script>
</html>
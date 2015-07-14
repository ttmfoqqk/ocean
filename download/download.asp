<!-- #include file = "../inc/header.asp" -->
<%
On Error Resume Next

checkLogin( g_host & "/ocean/download/" )
Dim idx  : idx  = request("idx")
Dim file : file = unescape(request("file"))

Call Expires()
Call dbopen()
	
	Call Check()
	If CHECK_CNT <= 0 Then
		Response.redirect "../download/"
	End If
	
	Call getDate()
	If FI_Idx = "" Then 
		Response.redirect "../download/"
	End If

	Call downloadLog()
Call dbclose()



Sub Check()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_CHECK"
		.Parameters("@idx").value = IIF( session("UserIdx")="" ,0,session("UserIdx") )
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "CHECK")
	objRs.close	: Set objRs = Nothing
End Sub

Sub getDate()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_V"
		.Parameters("@Idx").value      = idx
		.Parameters("@BoardKey").value = 1
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub downloadLog()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_DOWNLOAD_LOG_INSERT"
		.Parameters("@bidx").value = FI_Idx
		.Parameters("@uidx").value = session("UserIdx")
		.Parameters("@ip").value   = g_uip
		.Execute
	End with
	set objCmd = Nothing
End Sub

'파일 이름
pach = Server.MapPath("/ocean/upload/keti.ocean.download/")
'file = FI_File_name

Response.ContentType = "application/unknown"

Dim OsInformation : OsInformation = Request.ServerVariables("HTTP_USER_AGENT")

If instr(OsInformation, "MSIE" ) > 0 Then
	Response.AddHeader "Content-Disposition","attachment; filename=""" & Server.URLPathEncode( file ) & ""
End If

Set objDownload = Server.CreateObject("DEXT.FileDownload")
objDownload.Download pach & "\" & file
Set objDownload = Nothing 

If Err Then
	Response.Write "File not found"
	'Response.Write Err.Description
End If
%>

<?xml version="1.0" encoding="utf-8" ?>
<!-- #include file = "../inc/header.asp" -->
<%response.ContentType = "text/xml"%>
<%
Dim DataMsg : DataMsg = "<data><admin_login>login</admin_login></data>"
Dim arrList
Dim actType  : actType  = "VIEW"
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim CodeNum  : CodeNum  = Trim( Request.Form("CodeNum") )
Dim Idx      : Idx      = Trim( Request.Form("Idx") )
Dim code2_Idx: code2_Idx= Trim( Request.Form("code2_Idx") )
Dim tmp_Bigo

If Session("Admin_Idx") <> "" Then
	Call Expires()
	Call dbopen()
		If CodeNum = "1" Then 
			Call getViewCode1()
		Else
			Call getViewCode2()
		End If
		DataMsg = "<data>"
		DataMsg = DataMsg &  "<admin_login>success</admin_login>"
		For iLoop = 0 To cntList
			DataMsg = DataMsg &  "<item>"
			DataMsg = DataMsg &  "<code_idx><![CDATA["   & arrList(FI_Idx,iLoop)    & "]]></code_idx>"
			DataMsg = DataMsg &  "<code_name><![CDATA["  & TagDecode( Trim( arrList(FI_Name,iLoop) ) )   & "]]></code_name>"
			DataMsg = DataMsg &  "<code_order><![CDATA[" & arrList(FI_Order,iLoop)  & "]]></code_order>"
			DataMsg = DataMsg &  "<code_bigo><![CDATA["  & TagDecode( Trim( arrList(FI_Bigo,iLoop) ) )   & "]]></code_bigo>"
			DataMsg = DataMsg &  "<code_usfg><![CDATA["  & arrList(FI_UsFg,iLoop) & "]]></code_usfg>"
			DataMsg = DataMsg &  "</item>"
		Next
		DataMsg = DataMsg &  "</data>"
	Call dbclose()
End If

Response.write DataMsg

Sub getViewCode1()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_CODE1_P"
		.Parameters("@actType").value = actType
		.Parameters("@Idx").value    = Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub getViewCode2()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_CODE2_P"
		.Parameters("@actType").value = actType
		.Parameters("@PIdx").value    = Idx
		.Parameters("@Idx").value    = code2_Idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
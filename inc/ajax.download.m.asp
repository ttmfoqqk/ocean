<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList
Dim cntList  : cntList  = -1
Dim boardKey : boardKey = IIF(request("boardKey")="",-1,request("boardKey"))
Dim parent   : parent = IIF(request("parent")="",-1,request("parent"))

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_S"
		.Parameters("@Key").value = boardKey
		.Parameters("@tab").value = parent
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

Dim temp

Dim xmlStart : xmlStart = "<?xml version=""1.0"" encoding=""utf-8""?><rss version=""2.0""><channel>"
Dim xmlEnd   : xmlEnd   = "</channel></rss>"

For iLoop = 0 To cntList
	temp = temp & "<item>"
	temp = temp & "	<idx><![CDATA["  & arrList(FI_idx, iLoop) & "]]></idx>"
	temp = temp & "	<name><![CDATA[" & arrList(FI_name, iLoop)  & "]]></name>"
	temp = temp & "</item>"
Next

response.ContentType = "text/xml"
Response.write xmlStart & cnt & temp & xmlEnd
Set objDom = Nothing
%>
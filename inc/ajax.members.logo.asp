<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList
Dim cntList : cntList = -1

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
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		.Parameters("@CHECK").value = 1
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

'----------------------------------------------------------------------------------------------
' 파일확장자 체크
'----------------------------------------------------------------------------------------------
Function FILE_CHECK_TEMP(ByVal filePath)
	Dim fileExt,temp
	fileExt = LCase(Mid(filePath, InStrRev(filePath, ".") + 1))
	If fileExt = "jpg" Or fileExt = "gif" Or fileExt = "jpeg" Or fileExt = "png" Or fileExt = "bmp" Then 
		temp = true
	Else
		temp = false
	End If
	FILE_CHECK_TEMP = temp
End Function 


Dim xmlStart : xmlStart = "<?xml version=""1.0"" encoding=""utf-8""?><rss version=""2.0""><channel>"
Dim xmlEnd   : xmlEnd   = "</channel></rss>"

For iLoop = 0 To cntList

	If FILE_CHECK_TEMP( arrList(FI_files2, iLoop) ) = True Then
		
		' test code
		temp = temp & "<item>"
		temp = temp & "<name><![CDATA["   & arrList(FI_cName, iLoop)   & "]]></name>"
		temp = temp & "<image><![CDATA[ http://iotocean.org/upload/board/" & arrList(FI_files2, iLoop) & "]]></image>"
		temp = temp & "</item>"
		' test code

		Set FSO = CreateObject("Scripting.FileSystemObject")
		If FSO.FileExists(UPLOAD_BASE_PATH & "/board/s_" & arrList(FI_files2, iLoop) ) Then
			temp = temp & "<item>"
			temp = temp & "<name><![CDATA["   & arrList(FI_cName, iLoop)   & "]]></name>"
			temp = temp & "<image><![CDATA["  & BASE_PATH & "upload/board/" & "s_" & arrList(FI_files2, iLoop)   & "]]></image>"
			temp = temp & "</item>"
		else
			If FSO.FileExists(UPLOAD_BASE_PATH & "/board/" & arrList(FI_files2, iLoop) ) Then
				temp = temp & "<item>"
				temp = temp & "<name><![CDATA["   & arrList(FI_cName, iLoop)   & "]]></name>"
				temp = temp & "<image><![CDATA["  & BASE_PATH & "upload/board/" & arrList(FI_files2, iLoop)   & "]]></image>"
				temp = temp & "</item>"
			end if
		End If
		set FSO = Nothing
	
	end if

Next

response.ContentType = "text/xml"
Response.write xmlStart & temp & xmlEnd
Set objDom = Nothing
%>
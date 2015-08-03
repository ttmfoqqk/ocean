<!--METADATA TYPE="typelib" NAME=" ADODB Type Library" UUID="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
'On Error Resume Next
Dim objConn,objRs,objCmd,SQL,iLoop

Const C_CONN_STRING = "provider=sqloledb;database=keti;server=localhost\SQLEXPRESS;uid=sa;pwd=keti,123;"

Dim g_uip	: g_uip		= Request.ServerVariables("REMOTE_ADDR")
Dim g_host	: g_host	= "http://" & Request.ServerVariables("SERVER_NAME")
Dim g_url	: g_url		= Request.ServerVariables("PATH_INFO")
Dim ref_url	: ref_url	= Request.ServerVariables("HTTP_REFERER")
Dim BASE_PATH : BASE_PATH = "/"
Dim UPLOAD_BASE_PATH : UPLOAD_BASE_PATH = server.mapPath( BASE_PATH & "upload" )

'------------------------------------------------------------------------------------
' DB Open/Close
'------------------------------------------------------------------------------------
Sub dbopen()
	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.ConnectionString = C_CONN_STRING
	objConn.CommandTimeOut = 30 '초
	objConn.Open
End Sub

Sub dbclose()
	If IsObject(objConn) Then
		objConn.close() : Set objConn = Nothing
	End If
End Sub

'------------------------------------------------------------------------------------
' DB Open/Close
'------------------------------------------------------------------------------------
Sub cmdopen()
	SET objCmd	= Server.CreateObject("ADODB.Command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdText
	End with
End Sub

Sub cmdclose()
	If IsObject(objCmd) Then Set objCmd = Nothing
End Sub
'------------------------------------------------------------------------------------
' RS 레코드셋의 필드 Index 변수를 만든다.예) FI_fieldName = 1   FI는 prefix.
'------------------------------------------------------------------------------------
Sub setFieldIndex(rs, prefix)
	Dim fld
	Dim i : i = 0
	
	for each fld in rs.fields
		Execute(prefix & "_" & fld.name & "=" & i)
		i = i + 1
	next
End Sub
'------------------------------------------------------------------------------------
' RS 레코드셋의 필드 Index 변수를 만든다. 예) FV_fieldName   FV는 prefix.
'------------------------------------------------------------------------------------
Sub setFieldValue(rs, prefix)
	Dim fld
	Dim i : i = 0
	
	' 무조건 변수 선언.
	for each fld in rs.fields
		Execute(prefix & "_" & fld.name & "=""""")
	next
	
	if NOT(rs.EOF) Then
		Dim temp
		for each fld in rs.fields

			temp = fld.value & ""
			'temp = replace(temp,Chr(13),Chr(10))
			'temp = replace(temp,Chr(10),vbcrlf)
			temp = replace(temp,"""","""""")
			temp = replace(temp,vbcrlf,""" & vbcrlf & """)
			
			

			Execute(prefix & "_" & fld.name & "=""" &           temp            & """" )
		next
	end if
End Sub
'----------------------------------------------------------------------------------------------
' FORM 값 데이타들을 화면에 출력한다.
'----------------------------------------------------------------------------------------------
Sub showFormData()
	Dim item
	For Each item in Request.Form
		  Response.write "<BR>" & item & "..." & Request.Form(item).count & "..." & Request.Form(item)
	Next
End Sub
'------------------------------------------------------------------------------------
' 캐쉬 설정.
'------------------------------------------------------------------------------------
Sub Expires()
	Response.Buffer = true
	Response.Expires = -1
	Response.Expiresabsolute = Now() - 1 
	Response.AddHeader "pragma","no-cache" 
	Response.AddHeader "cache-control","private" 
	'Response.CacheControl = "no-cache"
End Sub

'------------------------------------------------------------------------------------
' "IF...ELSE...END IF"문.
'------------------------------------------------------------------------------------
Function IIF(Expression, TruePart, FalsePart)
	If Expression Then 
		IIF = TruePart
	Else
		IIF = FalsePart
	End If
End Function
'------------------------------------------------------------------------------------
' 업로드 관련 변수.
'------------------------------------------------------------------------------------
Dim UPLOAD__FORM
'------------------------------------------------------------------------------------
' 업로드 관련인지 판단.
'------------------------------------------------------------------------------------
Function isMultipart()
	isMultipart = IIF(InStr(request.serverVariables("HTTP_CONTENT_TYPE"),"multipart/form-data")=1, True, False)
End Function
%>

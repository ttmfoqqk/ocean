<!-- #include file = "../inc/header.asp" -->
<%
Session.Timeout = 600
Server.ScriptTimeOut = 60*60*60 '초

Dim arrList
Dim cntList  : cntList  = -1

Dim UserId   : UserId   = request("UserId")
Dim UserName : UserName = request("UserName")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")

Dim Title    : Title    = request("Title")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )


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
		.CommandText      = "OCEAN_DOWNLOAD_LOG_EXCEL"
		.Parameters("@title").value   = Title
		.Parameters("@id").value      = UserId
		.Parameters("@name").value    = UserName
		.Parameters("@Indate").value  = Indate
		.Parameters("@Outdate").value = Outdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
End Sub


Dim tmp_html : tmp_html = "" &_
"<?xml version=""1.0"" encoding=""utf-8""?>" &_
"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_





"<Worksheet ss:Name=""다운로드 로그""> " &_
"<Table> " &_
"	<Column ss:Width='400'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Column ss:Width='200'/> " &_
"	<Column ss:Width='200'/> " &_
"	<Row> "&_
"		<Cell><Data ss:Type=""String"">제목</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">ID</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">다운로드 일자</Data></Cell> "&_
"	</Row> "

If cntList > -1 Then 
	for iLoop = 0 to cntList

		tmp_html = tmp_html & "" &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_Title,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_userName,iLoop) & " " & arrList(FI_userNameLast,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_userId,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_date,iLoop) & "</Data></Cell>"&_
		"	</Row> "
	Next
Else
	tmp_html = tmp_html & "<Row><Cell><Data ss:Type=""String"">등록된 내용이 없습니다.</Data></Cell></Row>"
End If

tmp_html = tmp_html & "</Table></Worksheet></Workbook>"


Response.write tmp_html


Response.Buffer = True
Response.ContentType = "appllication/vnd.ms-excel" '// 엑셀로 지정
Response.CacheControl = "public"
Response.AddHeader "Content-Disposition","attachment; filename=다운로드 로그 " & Now() & ".xls"
%>
<!-- #include file = "../inc/header.asp" -->
<%
Session.Timeout = 600
Server.ScriptTimeOut = 60*60*60 '초

Dim arrList
Dim cntList  : cntList  = -1

Dim cName    : cName    = request("cName")
Dim sano     : sano     = request("sano")
Dim ceo      : ceo      = request("ceo")
Dim State    : State    = request("State")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim country  : country  = request("Country")
Dim noCountry : noCountry = request("noCountry")


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
		.CommandText      = "OCEAN_MEMBERSHIP_EXCEL"
		.Parameters("@cName").value   = cName
		.Parameters("@ceo").value     = ceo
		.Parameters("@sano").value    = sano
		.Parameters("@State").value   = State
		.Parameters("@Indate").value  = Indate
		.Parameters("@Outdate").value = Outdate
		.Parameters("@Country").value = country
		.Parameters("@noCountry").value = noCountry
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





"<Worksheet ss:Name=""멤버사 목록""> " &_
"<Table> " &_
"	<Column ss:Width='100'/> " &_
"	<Column ss:Width='200'/> " &_
"	<Column ss:Width='400'/> " &_
"	<Column ss:Width='200'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Row> "&_
"		<Cell><Data ss:Type=""String"">가입일자</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">상호</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">주소</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">국가</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">탈퇴</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">순서</Data></Cell> "&_
"	</Row> "

If cntList > -1 Then 
	for iLoop = 0 to cntList

		addr = ""
		addr = IIF( arrList(FI_addr,iLoop) = "", arrList(FI_addr1,iLoop) & " " & arrList(FI_addr2,iLoop) ,arrList(FI_addr,iLoop) )

		tmp_html = tmp_html & "" &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_Indate,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_cName,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & addr & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_CountryName,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & IIF( arrList(FI_state,iLoop)="0","사용","탈퇴" ) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_order,iLoop) & "</Data></Cell>"&_
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
Response.AddHeader "Content-Disposition","attachment; filename=멤버사 목록 " & Now() & ".xls"
%>
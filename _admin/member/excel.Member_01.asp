<!-- #include file = "../inc/header.asp" -->
<%
Session.Timeout = 600
Server.ScriptTimeOut = 60*60*60 '초

Dim arrList
Dim cntList  : cntList  = -1

Dim UserName   : UserName = request("UserName")
Dim UserId     : UserId   = request("UserId")
Dim Hphone3    : Hphone3  = request("Hphone3")
Dim delFg      : delFg    = request("delFg")
Dim State      : State    = request("State")
Dim ceoFg      : ceoFg    = request("ceoFg")
Dim companyIdx : companyIdx = request("companyIdx")
Dim Indate     : Indate   = request("Indate")
Dim Outdate    : Outdate  = request("Outdate")


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
		.CommandText      = "OCEAN_USER_MEMBER_EXCEL"
		.Parameters("@UserName").value   = UserName
		.Parameters("@UserId").value     = UserId
		.Parameters("@Hphone3").value    = Hphone3
		.Parameters("@delFg").value      = delFg
		.Parameters("@State").value      = State
		.Parameters("@companyIdx").value = companyIdx
		.Parameters("@Indate").value     = Indate
		.Parameters("@Outdate").value    = Outdate
		.Parameters("@ceoFg").value      = ceoFg
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





"<Worksheet ss:Name=""회원 목록""> " &_
"<Table> " &_
"	<Column ss:Width='50'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Column ss:Width='150'/> " &_
"	<Column ss:Width='300'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Column ss:Width='100'/> " &_
"	<Row> "&_
"		<Cell><Data ss:Type=""String"">대표</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">가입일자</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">아이디</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">승인여부</Data></Cell> "&_
"		<Cell><Data ss:Type=""String"">탈퇴여부</Data></Cell> "&_
"	</Row> "

If cntList > -1 Then 
	for iLoop = 0 to cntList
		
		If arrList(FI_state,iLoop) = "0" Then 
			stateTxt = "관리자승인완료"
		ElseIf arrList(FI_state,iLoop) = "1" Then
			stateTxt = "승인요청"
		ElseIf arrList(FI_state,iLoop) = "2" Then
			stateTxt = "대표자승인완료"
		ElseIf arrList(FI_state,iLoop) = "3" Then
			stateTxt = "대표자 인증전"
		Else
			stateTxt = ""
		End If
		
		tmp_UserId    = arrList(FI_UserId,iLoop)
		tmp_UserEmail = arrList(FI_UserEmail,iLoop)
		tmp_UserId    = IIF( isValidEmail(tmp_UserId),tmp_UserId, tmp_UserId &" [ "& tmp_UserEmail & " ] " )

		tmp_html = tmp_html & "" &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">" & IIF( arrList(FI_ceo,iLoop)="1" , "v" , "" ) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_UserIndate,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & arrList(FI_UserName,iLoop) &" "& arrList(FI_UserNameLast,iLoop) & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & tmp_UserId & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & stateTxt & "</Data></Cell>"&_
		"		<Cell><Data ss:Type=""String"">" & IIF( arrList(FI_UserDelFg,iLoop)="0","사용중","탈퇴" ) & "</Data></Cell>"&_
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
Response.AddHeader "Content-Disposition","attachment; filename=회원 목록 " & Now() & ".xls"
%>
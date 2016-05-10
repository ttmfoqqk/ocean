<!-- #include file = "../inc/header.asp" -->
<%
Session.Timeout = 600
Server.ScriptTimeOut = 60*60*60 '초

Response.Write("발송중입니다.")

Dim arrList
Dim cntList    : cntList    = -1

Dim SelectType : SelectType = request("SelectType")
Dim Idx        : Idx        = request("Idx")
Dim UserName   : UserName   = request("UserName")
Dim UserId     : UserId     = request("UserId")
Dim Hphone3    : Hphone3    = request("Hphone3")
Dim delFg      : delFg      = request("delFg")
Dim State      : State      = request("State")
Dim ceoFg      : ceoFg      = request("ceoFg")
Dim companyIdx : companyIdx = request("companyIdx")
Dim Indate     : Indate     = request("Indate")
Dim Outdate    : Outdate    = request("Outdate")

Dim mailFrom   : mailFrom   = Trim( request("mailFrom") )
Dim Title      : Title      = Trim( request("Title") )
Dim Contants   : Contants   = Trim( request("Contants") )
Dim PageParams : PageParams = URLDecode(request("PageParams"))



Call Expires()
Call dbopen()
	Call getList()	' List.
Call dbclose()

for iLoop = 0 to cntList

	tmp_UserId    = arrList(FI_UserId,iLoop)
	tmp_UserEmail = arrList(FI_UserEmail,iLoop)
	tmp_UserEmail = IIF( isValidEmail(tmp_UserId),tmp_UserId, tmp_UserEmail )

	tmp_UserName = arrList(FI_UserName,iLoop) & IIF( arrList(FI_UserNameLast,iLoop)="",""," " & arrList(FI_UserNameLast,iLoop) )

	result = sendSmsEmails(mailFrom , tmp_UserEmail , tmp_UserName , Title , Contants , "" )
	'response.write tmp_UserEmail &"<br>"
Next
'response.end


'-----------------------------------------------
' member list
'-----------------------------------------------
Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "OCEAN_USER_MEMBER_MAIL_L"
		.Parameters("@actType").value    = SelectType
		.Parameters("@idx").value        = Idx
		.Parameters("@UserId").value     = UserId
		.Parameters("@Hphone3").value    = Hphone3
		.Parameters("@UserName").value   = UserName
		.Parameters("@delFg").value      = delFg
		.Parameters("@State").value      = State
		.Parameters("@Indate").value     = Indate
		.Parameters("@Outdate").value    = Outdate
		.Parameters("@companyIdx").value = companyIdx
		.Parameters("@ceoFg").value      = ceoFg
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
'-----------------------------------------------
' Email 전송
'-----------------------------------------------
function sendSmsEmails( mailFrom , userEmail , userName , title , contants , attachPath )
	Dim strFile,strTitle

	strFile = server.mapPath(BASE_PATH & "common/mailform/default.html")
	strTitle = title

	Dim mfrom		: mfrom		= mailFrom
	Dim mto			: mto		= userEmail
	Dim mtitle		: mtitle	= strTitle
	Dim mcontents	: mcontents	= ReadFile(strFile)
		
	mcontents = replace(mcontents, "#TITLE#"    , title )
	mcontents = replace(mcontents, "#CONTANTS#", contants )
	mcontents = replace(mcontents, "#DOMAIN#"  , g_host & BASE_PATH )

	Dim mailMessage : mailMessage = MailSend(mtitle, mcontents, mto, mfrom, attachPath)
	sendSmsEmails = mailMessage
End Function
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=utf-8">
	<script language=javascript>
		alert("발송을 완료 했습니다.");
		top.location.href = "Member_03_L.asp?<%=PageParams%>";
	</script>
</head>
<body></body>
</html>
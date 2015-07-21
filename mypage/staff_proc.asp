<!-- #include file = "../inc/header.asp" -->

<%
checkLogin( g_host & "/ocean/mypage/staff.asp" )

Dim arrList
Dim cntList : cntList = -1
Dim Idx     : Idx     = Trim( request.Form("Idx") )

If Session("UserCeoFg") <> "1" Or Session("UserCIdx") = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 경로입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If Len(Idx) <= 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 경로입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim admin_email_addr
Call Expires()
Call dbopen()
	Call update()
	Call admin_email()
Call dbclose()

for iLoop = 0 to cntList
	userCname    = arrList(FI_cName,iLoop)
	userPosition = arrList(FI_UserPosition,iLoop)
	userPhone    = IIF( arrList(FI_UserHPhone,iLoop)="",arrList(FI_UserHPhone1,iLoop) &"-"& arrList(FI_UserHPhone2,iLoop) &"-"& arrList(FI_UserHPhone3,iLoop) ,arrList(FI_UserHPhone,iLoop) )
	userName     = arrList(FI_UserName,iLoop) & " " & arrList(FI_UserNameLast,iLoop)
	
	email_result = sendSmsEmail_state( "join_state_admin" , admin_email_addr , userCname , "일반가입자" , userPosition , userName , userPhone , now() , "" )
Next 

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('승인 되었습니다.');"
 .Write "location.href='staff.asp';"
 .Write "</script>"
 .End
End With


Sub update()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_CEO_STATE"
		.Parameters("@idx").value        = Idx
		.Parameters("@companyIdx").value = Session("UserCIdx")
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub admin_email()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("ADODB.Command")

	SQL = "SELECT top 1 [email]  "  &_
	" FROM [OCEAN_ADMIN_MEMBER] WHERE [Id] = 'admin' "
   
	call cmdopen()
	with objCmd
		.CommandText = SQL
		set objRs = .Execute
	End with
	call cmdclose()
	
	If NOT(objRs.BOF or objRs.EOF) Then
		admin_email_addr  = objRs(0)
	End If

	Set objRs = Nothing
End Sub
%>
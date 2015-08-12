<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 3 * 1024 * 1024 '3메가


Dim userId         : userId         = Trim( UPLOAD__FORM("userId") )
Dim userPwd        : userPwd        = Trim( UPLOAD__FORM("userPwd") )
Dim userPwdConfirm : userPwdConfirm = Trim( UPLOAD__FORM("userPwdConfirm") )
Dim FirstName      : FirstName      = Trim( UPLOAD__FORM("FirstName") )
Dim LastName       : LastName       = Trim( UPLOAD__FORM("LastName") )
Dim userhPhone     : userhPhone     = Trim( UPLOAD__FORM("userhPhone") )
Dim userPhone      : userPhone      = Trim( UPLOAD__FORM("userPhone") )
Dim userPosition   : userPosition   = Trim( UPLOAD__FORM("userPosition") )

Dim companySelect  : companySelect  = Trim( UPLOAD__FORM("companySelect") )
Dim companyName    : companyName    = Trim( UPLOAD__FORM("companyName") )

Dim cName          : cName          = TagEncode( Trim( UPLOAD__FORM("cName") ) )
Dim Country        : Country        = Trim( UPLOAD__FORM("Country") )
Dim addr           : addr           = TagEncode( Trim( UPLOAD__FORM("addr") ) )
Dim cPhone         : cPhone         = TagEncode( Trim( UPLOAD__FORM("cPhone") ) )
Dim homepage       : homepage       = TagEncode( Trim( UPLOAD__FORM("homepage") ) )
Dim cStaff         : cStaff         = TagEncode( Trim( UPLOAD__FORM("cStaff") ) )
Dim business       : business       = TagEncode( Trim( UPLOAD__FORM("business") ) )
Dim business1      : business1      = UPLOAD__FORM("business1")
Dim business2      : business2      = UPLOAD__FORM("business2")
Dim business3      : business3      = UPLOAD__FORM("business3")
Dim business4      : business4      = UPLOAD__FORM("business4")
Dim business5      : business5      = UPLOAD__FORM("business5")
Dim business6      : business6      = UPLOAD__FORM("business6")
Dim business7      : business7      = UPLOAD__FORM("business7")
Dim business8      : business8      = UPLOAD__FORM("business8")
Dim business9      : business9      = UPLOAD__FORM("business9")
Dim business10     : business10     = UPLOAD__FORM("business10")
Dim business11     : business11     = UPLOAD__FORM("business11")
Dim business12     : business12     = UPLOAD__FORM("business12")
Dim files2         : files2         = UPLOAD__FORM("files2")
dim other_infor    : other_infor    = TagEncode( Trim( UPLOAD__FORM("other_infor") ) )




If userId = "" Or userPwd = "" Or userPwdConfirm = "" Or FirstName = "" Or LastName = "" Or userhPhone = "" Or userPhone = "" Or userPosition = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('You are missing list');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If userPwd <> userPwdConfirm Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('Please check your password');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If companySelect = "NEW" Then
		If cName="" Or addr="" Or cPhone="" Or homepage="" or cStaff="" Or files2="" Or (business="" And business1="" And business2="" And business3="" And business4="" And business5="" And business6="" And business7="" And business8="" And business9="" And business10="" And business11="" And business12="") Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('You are missing list');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If
End If


If files2 <>"" Then 
	If FILE_CHECK_TEMP(files2) = True Then
		If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("files2").FileLen Then 
			files2 = DextFileUpload("files2",UPLOAD_BASE_PATH & savePath,300)
		Else
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('The size of the file can not be passed to 3MB');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	Else
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('you can register [jpg, bmp, gif, png]');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If
End If

Dim admin_email_addr
Call Expires()
Call dbopen()
	Call insert()
	Call admin_email()
Call dbclose()

If FI_IN_CNT > 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The ID is currently in use');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If FI_CO_CNT > 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The company name is currently in use');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim email_result1 , email_result2
Dim complete_code
If FI_CEO_FG > 0 Then
	'대표자 인증 메일 발송
	complete_code = Base64encode( (FI_USER_IDENTITY * len(userId)) & "," & userId )
	email_result1 = sendSmsEmail( "join_complete" , userId , "" , userId , complete_code , "" )
	Session("temp_join_result") = "CEO"
Else
	email_result1 = sendSmsEmail( "join_staff" , userId , "" , userId , "" , "" )
	email_result2 = sendSmsEmail_state( "join_state_ceo" , FI_EMAIL , companyName , "" , userPosition , FirstName &" "& LastName , userhPhone , userId , "" )
	Session("temp_join_result") = "STAFF"
End If

response.redirect "result.asp"

'Dim result : result = sendSmsEmail( "join" , userId , userEmail1 & "@" & userEmail2 , now() , "" )




Sub insert()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value       = "INSERT"
		.Parameters("@UserId").value        = userId
		.Parameters("@UserPass").value      = userPwd
		.Parameters("@FirstName").value     = FirstName
		.Parameters("@LastName").value      = LastName
		.Parameters("@UserHPhone").value    = userhPhone
		.Parameters("@UserPhone").value     = userPhone
		.Parameters("@userPosition").value  = userPosition
		.Parameters("@companySelect").value = companySelect
		
		If companySelect = "NEW" Then
		.Parameters("@cName").value         = cName
		.Parameters("@Country").value       = Country
		.Parameters("@addr").value          = addr
		.Parameters("@cPhone").value        = cPhone
		.Parameters("@homepage").value      = homepage
		.Parameters("@cStaff").value        = cStaff
		.Parameters("@business").value      = business
		.Parameters("@business1").value     = IIF(business1="",0,business1)
		.Parameters("@business2").value     = IIF(business2="",0,business2)
		.Parameters("@business3").value     = IIF(business3="",0,business3)
		.Parameters("@business4").value     = IIF(business4="",0,business4)
		.Parameters("@business5").value     = IIF(business5="",0,business5)
		.Parameters("@business6").value     = IIF(business6="",0,business6)
		.Parameters("@business7").value     = IIF(business7="",0,business7)
		.Parameters("@business8").value     = IIF(business8="",0,business8)
		.Parameters("@business9").value     = IIF(business9="",0,business9)
		.Parameters("@business10").value    = IIF(business10="",0,business10)
		.Parameters("@business11").value    = IIF(business11="",0,business11)
		.Parameters("@business12").value    = IIF(business12="",0,business12)
		.Parameters("@files2").value        = files2
		.Parameters("@bigo").value          = other_infor
		.Parameters("@order").value         = 100
		End If
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
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
%>
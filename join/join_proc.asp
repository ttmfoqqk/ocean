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

Dim userName       : userName       = Trim( UPLOAD__FORM("userName") )
Dim userhPhone1    : userhPhone1    = Trim( UPLOAD__FORM("userhPhone1") )
Dim userhPhone2    : userhPhone2    = Trim( UPLOAD__FORM("userhPhone2") )
Dim userhPhone3    : userhPhone3    = Trim( UPLOAD__FORM("userhPhone3") )

Dim userPhone1     : userPhone1     = Trim( UPLOAD__FORM("userPhone1") )
Dim userPhone2     : userPhone2     = Trim( UPLOAD__FORM("userPhone2") )
Dim userPhone3     : userPhone3     = Trim( UPLOAD__FORM("userPhone3") )

Dim userfax1       : userfax1       = Trim( UPLOAD__FORM("userfax1") )
Dim userfax2       : userfax2       = Trim( UPLOAD__FORM("userfax2") )
Dim userfax3       : userfax3       = Trim( UPLOAD__FORM("userfax3") )

Dim userEmail1     : userEmail1     = Trim( UPLOAD__FORM("userEmail1") )
Dim userEmail2     : userEmail2     = Trim( UPLOAD__FORM("userEmail2") )

Dim userPosition   : userPosition   = Trim( UPLOAD__FORM("userPosition") )

Dim companySelect  : companySelect  = Trim( UPLOAD__FORM("companySelect") )
Dim companyName    : companyName    = Trim( UPLOAD__FORM("companyName") )

Dim cName          : cName          = TagEncode( Trim( UPLOAD__FORM("cName") ) )
Dim ceo            : ceo            = TagEncode( Trim( UPLOAD__FORM("ceo") ) )
Dim sano           : sano           = Trim( UPLOAD__FORM("userSaNo") )
Dim cDate          : cDate          = Trim( UPLOAD__FORM("cDate") )
Dim addr1          : addr1          = TagEncode( Trim( UPLOAD__FORM("addr1") ) )
Dim addr2          : addr2          = TagEncode( Trim( UPLOAD__FORM("addr2") ) )
Dim cScale         : cScale         = Trim( UPLOAD__FORM("cScale") )
Dim cPhone         : cPhone         = TagEncode( Trim( UPLOAD__FORM("cPhone") ) )
Dim cSectors       : cSectors       = TagEncode( Trim( UPLOAD__FORM("cSectors") ) )
Dim homepage       : homepage       = TagEncode( Trim( UPLOAD__FORM("homepage") ) )
Dim cItems         : cItems         = TagEncode( Trim( UPLOAD__FORM("cItems") ) )
Dim cSales         : cSales         = TagEncode( Trim( UPLOAD__FORM("cSales") ) )
Dim cStaff         : cStaff         = TagEncode( Trim( UPLOAD__FORM("cStaff") ) )
Dim cCenter        : cCenter        = UPLOAD__FORM("cCenter")

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

Dim iot_business   : iot_business   = TagEncode( Trim( UPLOAD__FORM("iot_business") ) )
Dim iot_business1  : iot_business1  = UPLOAD__FORM("iot_business1")
Dim iot_business2  : iot_business2  = UPLOAD__FORM("iot_business2")
Dim iot_business3  : iot_business3  = UPLOAD__FORM("iot_business3")
Dim iot_business4  : iot_business4  = UPLOAD__FORM("iot_business4")
Dim iot_business5  : iot_business5  = UPLOAD__FORM("iot_business5")
Dim iot_business6  : iot_business6  = UPLOAD__FORM("iot_business6")

Dim files1        : files1          = Trim( UPLOAD__FORM("files1") )
Dim files2        : files2          = Trim( UPLOAD__FORM("files2") )





If userId = "" Or userPwd = "" Or userPwdConfirm = "" Or userName = "" Or userEmail1 = "" Or userEmail2 = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 목록이 있습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If userPwd <> userPwdConfirm Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('비밀번호를 확인해주세요.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If companySelect = "NEW" Then
		If cName="" Or ceo="" Or Len(sano)<10 Or addr1="" Or addr2="" Or cScale="" Or cPhone="" Or cSectors="" Or homepage="" Or cItems="" Or cSales="" Or cStaff="" Or cCenter="" Or files1="" Or files2="" Or (business="" And business1="" And business2="" And business3="" And business4="" And business5="" And business6="" And business7="" And business8="" And business9="" And business10="" And business11="" And business12="") Or (iot_business="" And iot_business1="" And iot_business2="" And iot_business3="" And iot_business4="" And iot_business5="" And iot_business6="") Then 
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('누락된 내용이 있습니다.');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If
End If


If files1 <>"" Then 
	If FILE_CHECK_EXT(files1) = True Then
		If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("files1").FileLen Then 
			files1 = DextFileUpload("files1",UPLOAD_BASE_PATH & savePath,0)
		Else
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 3MB 를 넘길수 없습니다.');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	Else
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.');"
		 .Write "history.go(-1);"
		 .Write "</script>"
		 .End
		End With
	End If
End If

If files2 <>"" Then 
	If FILE_CHECK_EXT(files2) = True Then
		If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("files2").FileLen Then 
			files2 = DextFileUpload("files2",UPLOAD_BASE_PATH & savePath,0)
		Else
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 3MB 를 넘길수 없습니다.');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	Else
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.');"
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
	 .Write "alert('현재 사용중인 아이디입니다');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If FI_CO_CNT > 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('현재 등록된 사업자등록번호 입니다');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim email_result1 , email_result2
If FI_CEO_FG > 0 Then
	email_result1 = sendSmsEmail( "join_ceo" , userId , userEmail1 & "@" & userEmail2 , now() , "" )
	email_result2 = sendSmsEmail_state( "join_state_admin" , admin_email_addr , cName , "대표자" , userPosition , userName , userhPhone1&"-"&userhPhone2&"-"&userhPhone3 , now() , "" )
Else
	email_result1 = sendSmsEmail( "join_staff" , userId , userEmail1 & "@" & userEmail2 , now() , "" )
	email_result2 = sendSmsEmail_state( "join_state_ceo" , FI_EMAIL , companyName , "" , userPosition , userName , userhPhone1&"-"&userhPhone2&"-"&userhPhone3 , now() , "" )
End If

'Dim result : result = sendSmsEmail( "join" , userId , userEmail1 & "@" & userEmail2 , now() , "" )
response.redirect "result.asp"


Sub insert()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value     = "INSERT"
		.Parameters("@UserId").value      = userId
		.Parameters("@UserPass").value    = userPwd
		.Parameters("@UserName").value    = userName
		.Parameters("@UserHPhone1").value = userhPhone1
		.Parameters("@UserHPhone2").value = userhPhone2
		.Parameters("@UserHPhone3").value = userhPhone3
		.Parameters("@UserPhone1").value  = userPhone1
		.Parameters("@UserPhone2").value  = userPhone2
		.Parameters("@UserPhone3").value  = userPhone3
		.Parameters("@UserFax1").value    = userfax1
		.Parameters("@UserFax2").value    = userfax2
		.Parameters("@UserFax3").value    = userfax3
		.Parameters("@UserEmail").value   = userEmail1 & "@" & userEmail2
		.Parameters("@userPosition").value = userPosition
		.Parameters("@companySelect").value = companySelect
		
		If companySelect = "NEW" Then
		.Parameters("@cName").value         = cName
		.Parameters("@ceo").value           = ceo
		.Parameters("@sano").value          = sano
		.Parameters("@CDate").value         = CDate
		.Parameters("@addr1").value         = addr1
		.Parameters("@addr2").value         = addr2
		.Parameters("@cScale").value        = IIF(cScale="",0,cScale)
		.Parameters("@cPhone").value        = cPhone
		.Parameters("@cSectors").value      = cSectors
		.Parameters("@homepage").value      = homepage
		.Parameters("@cItems").value        = cItems
		.Parameters("@cSales").value        = cSales
		.Parameters("@cStaff").value        = cStaff
		.Parameters("@cCenter").value       = IIF(cCenter="",0,cCenter)
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
		.Parameters("@iot_business").value  = iot_business
		.Parameters("@iot_business1").value = IIF(iot_business1="",0,iot_business1)
		.Parameters("@iot_business2").value = IIF(iot_business2="",0,iot_business2)
		.Parameters("@iot_business3").value = IIF(iot_business3="",0,iot_business3)
		.Parameters("@iot_business4").value = IIF(iot_business4="",0,iot_business4)
		.Parameters("@iot_business5").value = IIF(iot_business5="",0,iot_business5)
		.Parameters("@iot_business6").value = IIF(iot_business6="",0,iot_business6)
		.Parameters("@files1").value        = files1
		.Parameters("@files2").value        = files2
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
%>
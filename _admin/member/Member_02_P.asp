<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
checkAdminLogin( g_host & BASE_PATH & "_admin/member/member_02_L.asp" )

Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 3 * 1024 * 1024 '3메가

Dim actType       : actType       = UPLOAD__FORM("actType")
Dim idx           : idx           = UPLOAD__FORM("idx")
Dim cName         : cName         = TagEncode( UPLOAD__FORM("cName") )
Dim Country       : Country       = UPLOAD__FORM("Country")
Dim addr          : addr          = TagEncode( UPLOAD__FORM("addr") )
Dim cPhone        : cPhone        = TagEncode( UPLOAD__FORM("cPhone") )
Dim homepage      : homepage      = TagEncode( UPLOAD__FORM("homepage") )
Dim cStaff        : cStaff        = TagEncode( UPLOAD__FORM("cStaff") )
Dim business      : business      = TagEncode( UPLOAD__FORM("business") )
Dim business1     : business1     = UPLOAD__FORM("business1")
Dim business2     : business2     = UPLOAD__FORM("business2")
Dim business3     : business3     = UPLOAD__FORM("business3")
Dim business4     : business4     = UPLOAD__FORM("business4")
Dim business5     : business5     = UPLOAD__FORM("business5")
Dim business6     : business6     = UPLOAD__FORM("business6")
Dim business7     : business7     = UPLOAD__FORM("business7")
Dim business8     : business8     = UPLOAD__FORM("business8")
Dim business9     : business9     = UPLOAD__FORM("business9")
Dim business10    : business10    = UPLOAD__FORM("business10")
Dim business11    : business11    = UPLOAD__FORM("business11")
Dim business12    : business12    = UPLOAD__FORM("business12")
Dim bigo          : bigo          = TagEncode(UPLOAD__FORM("bigo"))
Dim State         : State         = IIF( UPLOAD__FORM("State") = "" , 0 , UPLOAD__FORM("State") )
dim order         : order         = IIF( UPLOAD__FORM("order") = "" , 0 , UPLOAD__FORM("order") )


Dim files2        : files2        = Trim( UPLOAD__FORM("files2") )
Dim oldFileName2  : oldFileName2  = Trim( UPLOAD__FORM("oldFileName2") )
Dim DellFileFg2   : DellFileFg2   = UPLOAD__FORM("DellFileFg2")

Dim PageParams    : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))

'==================================

'Response.write "cName : "         & cName & "<br>"
'Response.write "ceo : "           & ceo & "<br>"
'Response.write "sano : "          & sano & "<br>"
'Response.write "cDate : "         & cDate & "<br>"
'Response.write "addr1 : "         & addr1 & "<br>"
'Response.write "addr2 : "         & addr2 & "<br>"
'Response.write "cScale : "        & cScale & "<br>"
'Response.write "cPhone : "        & cPhone & "<br>"
'Response.write "cSectors : "      & cSectors & "<br>"
'Response.write "homepage : "      & homepage & "<br>"
'Response.write "cItems : "        & cItems & "<br>"
'Response.write "cSales : "        & cSales & "<br>"
'Response.write "cStaff : "        & cStaff & "<br>"
'Response.write "cCenter : "       & cCenter & "<br>"
'Response.write "business : "      & business & "<br>"
'Response.write "business1 : "     & business1 & "<br>"
'Response.write "business2 : "     & business2 & "<br>"
'Response.write "business3 : "     & business3 & "<br>"
'Response.write "business4 : "     & business4 & "<br>"
'Response.write "business5 : "     & business5 & "<br>"
'Response.write "business6 : "     & business6 & "<br>"
'Response.write "business7 : "     & business7 & "<br>"
'Response.write "business8 : "     & business8 & "<br>"
'Response.write "business9 : "     & business9 & "<br>"
'Response.write "business10 : "    & business10 & "<br>"
'Response.write "business11 : "    & business11 & "<br>"
'Response.write "business12 : "    & business12 & "<br>"
'Response.write "iot_business : "  & iot_business & "<br>"
'Response.write "iot_business1 : " & iot_business1 & "<br>"
'Response.write "iot_business2 : " & iot_business2 & "<br>"
'Response.write "iot_business3 : " & iot_business3 & "<br>"
'Response.write "iot_business4 : " & iot_business4 & "<br>"
'Response.write "iot_business5 : " & iot_business5 & "<br>"
'Response.write "iot_business6 : " & iot_business6 & "<br>"
'Response.write "files1 : "        & files1 & "<br>"
'Response.write "files2 : "        & files2 & "<br>"
'Response.End

'==================================

If cName="" Or Country="" Or addr="" Or cPhone="" Or homepage="" Or cStaff="" Or (business="" And business1="" And business2="" And business3="" And business4="" And business5="" And business6="" And business7="" And business8="" And business9="" And business10="" And business11="" And business12="") Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('누락된 내용이 있습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If



If files1 <>"" Then 
	If FILE_CHECK_EXT(files1) = True Then
		If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("files1").FileLen Then 
			files1 = DextFileUpload("files1",UPLOAD_BASE_PATH & savePath,300)
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

	If oldFileName1 <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
			If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName1)) Then	' 같은 이름의 파일이 있을 때 삭제
				fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName1)
			End If
		set FSO = Nothing
	End If
Else
	files1 = oldFileName1
End If

If files2 <>"" Then 
	If FILE_CHECK_EXT(files2) = True Then
		If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("files2").FileLen Then 
			files2 = DextFileUpload("files2",UPLOAD_BASE_PATH & savePath,300)
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

	If oldFileName2 <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
			If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then	' 같은 이름의 파일이 있을 때 삭제
				fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
			End If
		set FSO = Nothing
	End If
Else
	files2 = oldFileName2
End If

If DellFileFg1 = "1" Then 
	If oldFileName1 <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
			If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName1)) Then	' 같은 이름의 파일이 있을 때 삭제
				fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName1)
			End If
		set FSO = Nothing
	End If

	files1 = ""
End If

If DellFileFg2 = "1" Then 
	If oldFileName2 <> "" Then
		Set FSO = CreateObject("Scripting.FileSystemObject")
			If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then	' 같은 이름의 파일이 있을 때 삭제
				fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
			End If
		set FSO = Nothing
	End If

	files2 = ""
End If


Call Expires()
Call dbopen()
	Call insert()
Call dbclose()

If FI_CNT > 0 Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('이미 등록된 회사명 입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If actType = "UPDATE" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('수정 되었습니다.');"
	 .Write "location.href='Member_02_V.asp?" & pageParams & "&Idx="& idx &"';"
	 .Write "</script>"
	 .End
	End With
Else
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('입력 되었습니다.');"
	 .Write "location.href='Member_02_L.asp?" & pageParams & "';"
	 .Write "</script>"
	 .End
	End With
End If


Sub insert()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_P"
		.Parameters("@actType").value       = actType
		.Parameters("@idx").value           = IIF(idx="",0,idx)
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
		.Parameters("@bigo").value          = bigo
		.Parameters("@State").value         = State
		.Parameters("@order").value         = order
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
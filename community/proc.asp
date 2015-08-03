<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../common/uploadUtil2.asp" -->
<%
checkLogin( g_host & BASE_PATH & "download/" )

Dim arrList
Dim cntList   : cntList   = -1

Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.CodePage       = 65001
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath    = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 600 * 1024 * 1024 '60메가


Dim alertMsg

	
Dim actType       : actType      = Trim( UPLOAD__FORM("actType") )
Dim actType2      : actType2     = Trim( UPLOAD__FORM("actType2") )
Dim Idx           : Idx          = IIF( UPLOAD__FORM("Idx")="" , "0" , UPLOAD__FORM("Idx") )
Dim BoardKey      : BoardKey     = 3
Dim UserIdx       : UserIdx      = session("UserIdx")
Dim Title         : Title        = TagEncode( Trim( UPLOAD__FORM("title") ) )
Dim Contants      : Contants     = Trim( UPLOAD__FORM("contants") )

Dim FileName      : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg    : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName   : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )

Dim FileName2     : FileName2    = Trim( UPLOAD__FORM("FileName2") )
Dim DellFileFg2   : DellFileFg2  = UPLOAD__FORM("DellFileFg2")
Dim oldFileName2  : oldFileName2 = Trim( UPLOAD__FORM("oldFileName2") )

Dim FileName3     : FileName3    = Trim( UPLOAD__FORM("FileName3") )
Dim DellFileFg3   : DellFileFg3  = UPLOAD__FORM("DellFileFg3")
Dim oldFileName3  : oldFileName3 = Trim( UPLOAD__FORM("oldFileName3") )

Dim FileName4     : FileName4    = Trim( UPLOAD__FORM("FileName4") )
Dim DellFileFg4   : DellFileFg4  = UPLOAD__FORM("DellFileFg4")
Dim oldFileName4  : oldFileName4 = Trim( UPLOAD__FORM("oldFileName4") )

Dim FileName5     : FileName5    = Trim( UPLOAD__FORM("FileName5") )
Dim DellFileFg5   : DellFileFg5  = UPLOAD__FORM("DellFileFg5")
Dim oldFileName5  : oldFileName5 = Trim( UPLOAD__FORM("oldFileName5") )

Dim FileName6     : FileName6    = Trim( UPLOAD__FORM("FileName6") )
Dim DellFileFg6   : DellFileFg6  = UPLOAD__FORM("DellFileFg6")
Dim oldFileName6  : oldFileName6 = Trim( UPLOAD__FORM("oldFileName6") )

Dim FileName7     : FileName7    = Trim( UPLOAD__FORM("FileName7") )
Dim DellFileFg7   : DellFileFg7  = UPLOAD__FORM("DellFileFg7")
Dim oldFileName7  : oldFileName7 = Trim( UPLOAD__FORM("oldFileName7") )

Dim FileName8     : FileName8    = Trim( UPLOAD__FORM("FileName8") )
Dim DellFileFg8   : DellFileFg8  = UPLOAD__FORM("DellFileFg8")
Dim oldFileName8  : oldFileName8 = Trim( UPLOAD__FORM("oldFileName8") )

Dim FileName9     : FileName9    = Trim( UPLOAD__FORM("FileName9") )
Dim DellFileFg9   : DellFileFg9  = UPLOAD__FORM("DellFileFg9")
Dim oldFileName9  : oldFileName9 = Trim( UPLOAD__FORM("oldFileName9") )

Dim FileName10    : FileName10    = Trim( UPLOAD__FORM("FileName10") )
Dim DellFileFg10  : DellFileFg10  = UPLOAD__FORM("DellFileFg10")
Dim oldFileName10 : oldFileName10 = Trim( UPLOAD__FORM("oldFileName10") )

Dim tab1          : tab1         = IIF( UPLOAD__FORM("tab1")="" , 0 , UPLOAD__FORM("tab1") )
Dim tab2          : tab2         = IIF( UPLOAD__FORM("tab2")="" , 0 , UPLOAD__FORM("tab2") )

Dim PageParams    : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))

dim category      : category     = UPLOAD__FORM("category")


Call Expires()
Call dbopen()
	Call BoardCodeView()
	If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then
		
		Call dbclose()
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('The wrong path.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If


	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		FileName   = fileUpload_proc( FileName  , "FileName"   , oldFileName   , DellFileFg )
		FileName2  = fileUpload_proc( FileName2 , "FileName2"  , oldFileName2  , DellFileFg2 )
		FileName3  = fileUpload_proc( FileName3 , "FileName3"  , oldFileName3  , DellFileFg3 )
		FileName4  = fileUpload_proc( FileName4 , "FileName4"  , oldFileName4  , DellFileFg4 )
		FileName5  = fileUpload_proc( FileName5 , "FileName5"  , oldFileName5  , DellFileFg5 )
		FileName6  = fileUpload_proc( FileName5 , "FileName6"  , oldFileName6  , DellFileFg6 )
		FileName7  = fileUpload_proc( FileName5 , "FileName7"  , oldFileName7  , DellFileFg7 )
		FileName8  = fileUpload_proc( FileName5 , "FileName8"  , oldFileName8  , DellFileFg8 )
		FileName9  = fileUpload_proc( FileName5 , "FileName9"  , oldFileName9  , DellFileFg9 )
		FileName10 = fileUpload_proc( FileName5 , "FileName10" , oldFileName10 , DellFileFg10 )
		
		call admin_email()
		Call insert()
		alertMsg = "Enter complete"
		
		for iLoop = 0 to cntList
			email_result2 = sendSmsEmail_state( "alarm" , arrList(FI_email,iLoop) , session("UserName") , "" , IIF(category="","Community",category) , Title, "" , replace(Contants,"<img","<img style=""max-width:100%;""") , "" )
		next


	ElseIf (actType = "UPDATE") Then	'글수정
		
		FileName   = fileUpload_proc( FileName  , "FileName"   , oldFileName   , DellFileFg )
		FileName2  = fileUpload_proc( FileName2 , "FileName2"  , oldFileName2  , DellFileFg2 )
		FileName3  = fileUpload_proc( FileName3 , "FileName3"  , oldFileName3  , DellFileFg3 )
		FileName4  = fileUpload_proc( FileName4 , "FileName4"  , oldFileName4  , DellFileFg4 )
		FileName5  = fileUpload_proc( FileName5 , "FileName5"  , oldFileName5  , DellFileFg5 )
		FileName6  = fileUpload_proc( FileName5 , "FileName6"  , oldFileName6  , DellFileFg6 )
		FileName7  = fileUpload_proc( FileName5 , "FileName7"  , oldFileName7  , DellFileFg7 )
		FileName8  = fileUpload_proc( FileName5 , "FileName8"  , oldFileName8  , DellFileFg8 )
		FileName9  = fileUpload_proc( FileName5 , "FileName9"  , oldFileName9  , DellFileFg9 )
		FileName10 = fileUpload_proc( FileName5 , "FileName10" , oldFileName10 , DellFileFg10 )


		Call insert()
		alertMsg = "edited completed"
	ElseIf (actType = "DELETE") Then	'글삭제
		
		'글 삭제시 파일 삭제
		'If FI_FileName <> "" Then
		'	Set FSO = CreateObject("Scripting.FileSystemObject")
		'		If (FSO.FileExists(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)) Then	' 파일삭제
		'			fso.deletefile(ETING_UPLOAD_BASE_PATH & savePath & FI_File_name)
		'		End If
		'	set FSO = Nothing
		'End If

		Call insert()
		alertMsg = "deleted Complete"
	else
		alertMsg = "The wrong path."
	end If

Call dbclose()

Sub insert()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection	= objConn
		.prepared				= true
		.CommandType		= adCmdStoredProc
		.CommandText		= "OCEAN_BOARD_CONT_P"
		.Parameters("@actType").value     = actType
		.Parameters("@Idx").value         = Idx
		.Parameters("@Key").value         = BoardKey
		.Parameters("@UserIdx").value     = UserIdx
		.Parameters("@Title").value       = Title
		.Parameters("@Contants").value    = Contants
		.Parameters("@File_name").value   = FileName
		.Parameters("@File_name2").value  = FileName2
		.Parameters("@File_name3").value  = FileName3
		.Parameters("@File_name4").value  = FileName4
		.Parameters("@File_name5").value  = FileName5
		.Parameters("@File_name6").value  = FileName6
		.Parameters("@File_name7").value  = FileName7
		.Parameters("@File_name8").value  = FileName8
		.Parameters("@File_name9").value  = FileName9
		.Parameters("@File_name10").value = FileName10
		.Parameters("@Ip").value          = g_uip
		.Parameters("@tab").value         = tab1
		.Parameters("@tab2").value        = tab2
		if actType2 <> "ANS" THEN 
		.Parameters("@status").value      = 0
		END IF
		.Parameters("@user").value        = "user"
		.Execute
	End with
	set objCmd = nothing
End Sub

Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub


Sub admin_email()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_ADMIN_MEMBER_EMAIL_L"
		.Parameters("@key").value = BoardKey
		.Parameters("@tab").value = tab1
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


function fileUpload_proc( file , input , oldFile , delfg )
	dim return_fileName

	If file <>"" Then 
		If FILE_CHECK_EXT(file) = True Then
			If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM(input).FileLen Then 
				return_fileName = DextFileUpload(input,UPLOAD_BASE_PATH & savePath , 0)
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('The size of the file can not be passed to 60MB');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		Else
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('Invalid file [asp,php,jsp,html,js] files can not be uploaded');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If

		If oldFile <> "" Then
			Set FSO = CreateObject("Scripting.FileSystemObject")
				If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFile)) Then	' 같은 이름의 파일이 있을 때 삭제
					fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFile)
				End If
			set FSO = Nothing
		End If
	Else
		If delfg = "1" Then 
			If oldFile <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFile)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFile)
					End If
				set FSO = Nothing
			End If

			return_fileName = ""
		else
			return_fileName = oldFile
		End If		
	End If

	fileUpload_proc = return_fileName
end function
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	<!--
		if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
		if("<%=actType%>" == "UPDATE"){
			top.location.href = "../community/view.asp?<%=pageParams%>&Idx=<%=Idx%>";
		}else{
			top.location.href = "../community/?<%=pageParams%>";
		}
	//-->
	</script>
</head>
<body></body>
</html>
<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../common/uploadUtil2.asp" -->
<%
checkLogin( g_host & BASE_PATH & "download/" )

Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.CodePage       = 65001
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath    = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 600 * 1024 * 1024 '5메가


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


Call Expires()
Call dbopen()
	Call BoardCodeView()
	If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then
		
		Call dbclose()
		With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('잘못된 게시판 코드 입니다.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If

	If FileName <>"" Then 
		If FILE_CHECK_EXT(FileName) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName2 <>"" Then 
		If FILE_CHECK_EXT(FileName2) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName2").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName3 <>"" Then 
		If FILE_CHECK_EXT(FileName3) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName3").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName4 <>"" Then 
		If FILE_CHECK_EXT(FileName4) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName4").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName5 <>"" Then 
		If FILE_CHECK_EXT(FileName5) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName5").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName6 <>"" Then 
		If FILE_CHECK_EXT(FileName6) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName6").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName7 <>"" Then 
		If FILE_CHECK_EXT(FileName7) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName7").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName8 <>"" Then 
		If FILE_CHECK_EXT(FileName8) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName8").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName9 <>"" Then 
		If FILE_CHECK_EXT(FileName9) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName9").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	If FileName10 <>"" Then 
		If FILE_CHECK_EXT(FileName10) = False Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		If UPLOAD__FORM.MaxFileLen < UPLOAD__FORM("FileName10").FileLen Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
	End If

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성

		FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
		FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
		FileName3 = DextFileUpload("FileName3",UPLOAD_BASE_PATH & savePath,0)
		FileName4 = DextFileUpload("FileName4",UPLOAD_BASE_PATH & savePath,0)
		FileName5 = DextFileUpload("FileName5",UPLOAD_BASE_PATH & savePath,0)
		FileName6 = DextFileUpload("FileName6",UPLOAD_BASE_PATH & savePath,0)
		FileName7 = DextFileUpload("FileName7",UPLOAD_BASE_PATH & savePath,0)
		FileName8 = DextFileUpload("FileName8",UPLOAD_BASE_PATH & savePath,0)
		FileName9 = DextFileUpload("FileName9",UPLOAD_BASE_PATH & savePath,0)
		FileName10 = DextFileUpload("FileName10",UPLOAD_BASE_PATH & savePath,0)
		
		Call insert()
		alertMsg = "입력 되었습니다."

	ElseIf (actType = "UPDATE") Then	'글수정
		
		If FileName <>"" Then 
			FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If
		Else
			FileName = oldFileName
		End If

		If FileName2 <>"" Then 
			FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName2 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
					End If
				set FSO = Nothing
			End If
		Else
			FileName2 = oldFileName2
		End If

		If FileName3 <>"" Then 
			FileName3 = DextFileUpload("FileName3",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName3 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName3)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName3)
					End If
				set FSO = Nothing
			End If
		Else
			FileName3 = oldFileName3
		End If

		If FileName4 <>"" Then 
			FileName4 = DextFileUpload("FileName4",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName4 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName4)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName4)
					End If
				set FSO = Nothing
			End If
		Else
			FileName4 = oldFileName4
		End If

		If FileName5 <>"" Then 
			FileName5 = DextFileUpload("FileName5",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName5 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName5)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName5)
					End If
				set FSO = Nothing
			End If
		Else
			FileName5 = oldFileName5
		End If

		If FileName6 <>"" Then 
			FileName6 = DextFileUpload("FileName6",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName6 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName6)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName6)
					End If
				set FSO = Nothing
			End If
		Else
			FileName6 = oldFileName6
		End If

		If FileName7 <>"" Then 
			FileName7 = DextFileUpload("FileName7",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName7 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName7)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName7)
					End If
				set FSO = Nothing
			End If
		Else
			FileName7 = oldFileName7
		End If

		If FileName8 <>"" Then 
			FileName8 = DextFileUpload("FileName8",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName8 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName8)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName8)
					End If
				set FSO = Nothing
			End If
		Else
			FileName8 = oldFileName8
		End If

		If FileName9 <>"" Then 
			FileName9 = DextFileUpload("FileName9",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName9 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName9)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName9)
					End If
				set FSO = Nothing
			End If
		Else
			FileName9 = oldFileName9
		End If

		If FileName10 <>"" Then 
			FileName10 = DextFileUpload("FileName10",UPLOAD_BASE_PATH & savePath,0)
			If oldFileName10 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName10)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName10)
					End If
				set FSO = Nothing
			End If
		Else
			FileName10 = oldFileName10
		End If


		If DellFileFg = "1" Then 
			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If

			FileName = ""
		End If

		If DellFileFg2 = "1" Then 
			If oldFileName2 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
					End If
				set FSO = Nothing
			End If

			FileName2 = ""
		End If

		If DellFileFg3 = "1" Then 
			If oldFileName3 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName3)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName3)
					End If
				set FSO = Nothing
			End If

			FileName3 = ""
		End If

		If DellFileFg4 = "1" Then 
			If oldFileName4 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName4)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName4)
					End If
				set FSO = Nothing
			End If

			FileName4 = ""
		End If

		If DellFileFg5 = "1" Then 
			If oldFileName5 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName5)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName5)
					End If
				set FSO = Nothing
			End If

			FileName5 = ""
		End If

		If DellFileFg6 = "1" Then 
			If oldFileName6 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName6)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName6)
					End If
				set FSO = Nothing
			End If

			FileName6 = ""
		End If

		If DellFileFg7 = "1" Then 
			If oldFileName7 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName7)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName7)
					End If
				set FSO = Nothing
			End If

			FileName7 = ""
		End If

		If DellFileFg8 = "1" Then 
			If oldFileName8 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName8)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName8)
					End If
				set FSO = Nothing
			End If

			FileName8 = ""
		End If

		If DellFileFg9 = "1" Then 
			If oldFileName9 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName9)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName9)
					End If
				set FSO = Nothing
			End If

			FileName9 = ""
		End If

		If DellFileFg10 = "1" Then 
			If oldFileName10 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName10)) Then
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName10)
					End If
				set FSO = Nothing
			End If

			FileName10 = ""
		End If


		Call insert()
		alertMsg = "수정 되었습니다."
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
		alertMsg = "삭제 되었습니다."
	else
		alertMsg = "actType[" & actType & "]이 정의되지 않았습니다."
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
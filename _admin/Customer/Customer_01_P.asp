<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath = "\board/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 600 * 1024 * 1024 '5메가


Dim alertMsg

	
Dim actType       : actType      = Trim( UPLOAD__FORM("actType") )
Dim Idx           : Idx          = IIF( UPLOAD__FORM("Idx")="" , "0" , UPLOAD__FORM("Idx") )
Dim BoardKey      : BoardKey     = UPLOAD__FORM("BoardKey")
Dim UserIdx       : UserIdx      = IIF( UPLOAD__FORM("UserIdx")="" , 0 , UPLOAD__FORM("UserIdx") )
Dim Title         : Title        = TagEncode( Trim( UPLOAD__FORM("Title") ) )
Dim Contants      : Contants     = Trim( UPLOAD__FORM("Contants") )
Dim FileName      : FileName     = Trim( UPLOAD__FORM("FileName") )
Dim DellFileFg    : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName   : oldFileName  = Trim( UPLOAD__FORM("oldFileName") )
Dim FileName2     : FileName2    = Trim( UPLOAD__FORM("FileName2") )
Dim DellFileFg2   : DellFileFg2  = UPLOAD__FORM("DellFileFg2")
Dim oldFileName2  : oldFileName2 = Trim( UPLOAD__FORM("oldFileName2") )
Dim tag           : tag          = TagEncode( Trim( UPLOAD__FORM("tag") ) )
Dim tab           : tab          = IIF( UPLOAD__FORM("tab")="" , 0 , UPLOAD__FORM("tab") )
Dim tab2          : tab2         = IIF( UPLOAD__FORM("tab2")="" , 0 , UPLOAD__FORM("tab2") )
Dim website       : website      = TagEncode( Trim( UPLOAD__FORM("website") ) )
Dim Notice        : Notice       = IIF( UPLOAD__FORM("Notice")="" , 0 , UPLOAD__FORM("Notice") )
Dim Secret        : Secret       = IIF( UPLOAD__FORM("Secret")="",0,UPLOAD__FORM("Secret") )
Dim userEmail     : userEmail    = UPLOAD__FORM("userEmail")
Dim AdminIdx      : AdminIdx     = Session("Admin_Idx")
dim status        : status       = IIF( UPLOAD__FORM("Status")="",NULL,UPLOAD__FORM("Status") )

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

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		End If

		If FileName2 <>"" Then 
			If FILE_CHECK_EXT(FileName2) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName2").FileLen Then 
					FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		End If
		
		Call insert()
		alertMsg = "입력 되었습니다."

	ElseIf (actType = "UPDATE") Then	'글수정
		
		If FileName <>"" Then 
			If FILE_CHECK_EXT(FileName) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName").FileLen Then 
					FileName = DextFileUpload("FileName",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If

			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If
		Else
			FileName = oldFileName
		End If

		If FileName2 <>"" Then 
			If FILE_CHECK_EXT(FileName2) = True Then
				If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM("FileName2").FileLen Then 
					FileName2 = DextFileUpload("FileName2",UPLOAD_BASE_PATH & savePath,0)
				Else
					With Response
					 .Write "<script language='javascript' type='text/javascript'>"
					 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다.');"
					 .Write "history.go(-1);"
					 .Write "</script>"
					 .End
					End With
				End If
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('잘못된 파일입니다. [asp,php,jsp,html,js] 파일은 업로드 할수 없습니다.');"
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
			FileName2 = oldFileName2
		End If

		If DellFileFg = "1" Then 
			If oldFileName <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName)
					End If
				set FSO = Nothing
			End If

			FileName = ""
		End If

		If DellFileFg2 = "1" Then 
			If oldFileName2 <> "" Then
				Set FSO = CreateObject("Scripting.FileSystemObject")
					If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFileName2)) Then	' 같은 이름의 파일이 있을 때 삭제
						fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFileName2)
					End If
				set FSO = Nothing
			End If

			FileName2 = ""
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
		.Parameters("@actType").value   = actType
		.Parameters("@Idx").value       = Idx
		.Parameters("@Key").value       = BoardKey
		.Parameters("@UserIdx").value   = UserIdx
		.Parameters("@Title").value     = Title
		.Parameters("@Contants").value  = Contants
		.Parameters("@File_name").value = FileName
		.Parameters("@File_name2").value= FileName2
		.Parameters("@Notice").value    = Notice
		.Parameters("@Secret").value    = Secret
		.Parameters("@Ip").value        = g_uip
		.Parameters("@AdminIdx").value  = AdminIdx
		.Parameters("@website").value   = website
		.Parameters("@tag").value       = tag
		.Parameters("@tab").value       = tab
		.Parameters("@tab2").value      = tab2
		.Parameters("@status").value    = status
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
			top.location.href = "Customer_01_V.asp?<%=pageParams%>&Idx=<%=Idx%>";
		}else{
			top.location.href = "Customer_01_L.asp?<%=pageParams%>";
		}
	//-->
	</script>
</head>
<body></body>
</html>
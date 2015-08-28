<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../../common/uploadUtil.asp" -->
<%
Dim savePath : savePath    = "\board/"

Set UPLOAD__FORM            = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.DefaultPath    = UPLOAD_BASE_PATH & savePath
UPLOAD__FORM.MaxFileLen		= 60 * 1024 * 1024

Dim alertMsg
	
Dim actType       : actType      = UPLOAD__FORM("actType")
Dim idx           : idx          = IIF( UPLOAD__FORM("idx")="" , "0" , UPLOAD__FORM("idx") )
Dim position      : position     = IIF( UPLOAD__FORM("position")="" , "0" , UPLOAD__FORM("position") )
Dim Title         : Title        = TagEncode( Trim( UPLOAD__FORM("Title") ) )
Dim link          : link         = TagEncode( Trim( UPLOAD__FORM("link") ) )
Dim target        : target       = IIF( UPLOAD__FORM("target")="" , 0 , UPLOAD__FORM("target") )
Dim is_use        : is_use       = IIF( UPLOAD__FORM("is_use")="" , 1 , UPLOAD__FORM("is_use") )
Dim order         : order        = IIF( isNumeric(UPLOAD__FORM("order")) , UPLOAD__FORM("order") , 100 )

Dim FileName      : FileName     = UPLOAD__FORM("FileName")
Dim DellFileFg    : DellFileFg   = UPLOAD__FORM("DellFileFg")
Dim oldFileName   : oldFileName  = UPLOAD__FORM("oldFileName")

Dim PageParams    : PageParams   = URLDecode(UPLOAD__FORM("PageParams"))


Call Expires()
Call dbopen()

	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		
		FileName   = fileUpload_proc( FileName  , "FileName"   , oldFileName   , DellFileFg )
		Call insert()
		alertMsg = "입력 되었습니다."

	ElseIf (actType = "UPDATE") Then	'글수정
		
		FileName   = fileUpload_proc( FileName  , "FileName"   , oldFileName   , DellFileFg )
		Call insert()
		alertMsg = "수정 되었습니다."

	ElseIf (actType = "DELETE") Then	'글삭제
		
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
		.CommandText		= "OCEAN_BANNER_P"
		.Parameters("@actType").value  = actType
		.Parameters("@idx").value      = idx
		.Parameters("@position").value = position
		.Parameters("@name").value     = Title
		.Parameters("@image").value    = FileName
		.Parameters("@link").value     = link
		.Parameters("@target").value   = target
		.Parameters("@order").value    = order
		.Parameters("@is_use").value   = is_use
		.Execute
	End with
	set objCmd = nothing
End Sub



function fileUpload_proc( file , input , oldFile , delfg )
	dim return_fileName

	If file <>"" Then 
		If FILE_CHECK_TEMP(file) = True Then
			If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM(input).FileLen Then 
				return_fileName = DextFileUpload(input,UPLOAD_BASE_PATH & savePath , 300)
			Else
				With Response
				 .Write "<script language='javascript' type='text/javascript'>"
				 .Write "alert('파일의 크기는 60MB 를 넘길수 없습니다');"
				 .Write "history.go(-1);"
				 .Write "</script>"
				 .End
				End With
			End If
		Else
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('사용가능한 확장자 는 [jpg, bmp, gif, png] 입니다.') ;"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If

		If oldFile <> "" Then
			Set FSO = Server.CreateObject("DEXT.FileUpload")
				If (FSO.FileExists(UPLOAD_BASE_PATH & savePath & oldFile)) Then	' 같은 이름의 파일이 있을 때 삭제
					fso.deletefile(UPLOAD_BASE_PATH & savePath & oldFile)
				End If
			set FSO = Nothing
		End If
	Else
		If delfg = "1" Then 
			If oldFile <> "" Then
				Set FSO = Server.CreateObject("DEXT.FileUpload")
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
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	<!--
		if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
		if("<%=actType%>" == "UPDATE"){
			top.location.href = "Admin_04_L.asp?<%=pageParams%>&Idx=<%=Idx%>";
		}else{
			top.location.href = "Admin_04_L.asp?<%=pageParams%>";
		}
	//-->
	</script>
</head>
<body></body>
</html>
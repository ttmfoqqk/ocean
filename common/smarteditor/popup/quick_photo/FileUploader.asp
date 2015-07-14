<!-- #include file = "../../../Carset_utf8.asp" -->
<!-- #include file = "../../../connectdb.asp" -->
<!-- #include file = "../../../uploadUtil.asp" -->
<%
Dim savePath : savePath = "\SmtEdit/" '첨부 저장경로.
Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.CodePage = 65001
UPLOAD__FORM.DefaultPath = UPLOAD_BASE_PATH & savePath

Dim upload_file   : upload_file   = UPLOAD__FORM("uploadInputBox")
Dim callback_func : callback_func = UPLOAD__FORM("callback_func")

If upload_file <> "" Then
	upload_file = DextFileUpload("uploadInputBox",UPLOAD_BASE_PATH & savePath,0)
End If

Dim url : url = g_host & "/ocean/upload/SmtEdit/" & upload_file

Response.redirect "callback.html?callback_func=" & callback_func & "&bNewLine=true&sFileName=" & upload_file & "&sFileURL=" & url
%>
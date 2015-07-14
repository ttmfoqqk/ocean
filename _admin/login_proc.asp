<!-- #include file = "inc/header.asp" -->
<%
Dim AdminId  : AdminId  = request("AdminId")
Dim pass     : pass     = request("pass")
Dim GoUrl    : GoUrl    = request("GoUrl")
Dim firstURL : firstURL = IIF( GoUrl="" , "admin/admin_01_L.asp" , GoUrl )

Call Expires()
Call dbopen()
	Call Check()
Call dbclose()

Sub Check()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("ADODB.Command")

	SQL = "SELECT Idx, Id , Name  "  &_
	" FROM [OCEAN_ADMIN_MEMBER] WHERE [Id] = ? "  &_
	" AND [Pwd] = ? "
   
	call cmdopen()
	with objCmd
		.CommandText       = SQL
		.Parameters.Append .CreateParameter( ,advarchar , adParamInput,   20, AdminId  )
		.Parameters.Append .CreateParameter( ,advarchar , adParamInput,   20, pass )
		set objRs = .Execute
	End with
	call cmdclose()
	
	If NOT(objRs.BOF or objRs.EOF) Then
		Session("Admin_Idx")  = objRs(0)
		Session("Admin_Id")   = objRs(1)
		Session("Admin_Name") = objRs(2)
		response.redirect firstURL
	Else
	With Response
		 .Write "<script language='javascript' type='text/javascript'>"
		 .Write "alert('로그인실패.');"
		 .Write "history.back(-1);"
		 .Write "</script>"
		 .End
		End With
	End If
	Set objRs = Nothing
End Sub
%>
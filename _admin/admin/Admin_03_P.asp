<!-- #include file = "../inc/header_utf8.asp" -->
<%
Dim DataMsg : DataMsg = "login"
Dim actType : actType = Trim( Request.Form("actType") )
Dim CodeNum : CodeNum = Request.Form("CodeNum")
Dim Name    : Name    = Trim( TagEncode(Request.Form("Name")) )
Dim Ord     : Ord     = IIF( Request.Form("Ord")="",0,Request.Form("Ord") )
Dim Idx     : Idx     = Trim( Request.Form("Idx") )
Dim UsFg    : UsFg    = IIF( Request.Form("UsFg")="",0,Request.Form("UsFg") )
Dim Bigo    : Bigo    = Trim( TagEncode(Request.Form("Bigo")) )

Bigo = Replace(Bigo,vbLf,"<br>")

Call Expires()
Call dbopen()
	If CodeNum = "1" Then 
		Call Code_p1()
	Else
		Call Code_p2()
	End If
	
	If err.number <> 0 Then 
		DataMsg = "error"
	Else
		DataMsg = "success"
	End If
Call dbclose()

Response.write DataMsg

Sub Code_p1()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_CODE1_P"
		.Parameters("@actType").value  = actType
		.Parameters("@Ord").value   = Ord
		.Parameters("@Idx").value   = Idx
		.Parameters("@UsFg").value  = UsFg
		.Parameters("@Name").value  = Name
		.Parameters("@Bigo").value  = Bigo
		Set objRs = .Execute
	End with
	set objCmd = nothing
End Sub

Sub Code_p2()
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_CODE2_P"
		.Parameters("@actType").value  = actType
		.Parameters("@Ord").value   = Ord
		.Parameters("@Idx").value   = Idx
		.Parameters("@UsFg").value  = UsFg
		.Parameters("@Name").value  = Name
		.Parameters("@Bigo").value  = Bigo
		.Parameters("@PIdx").value  = 0
		Set objRs = .Execute
	End with
	set objCmd = nothing
End Sub
%>
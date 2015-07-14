<!-- #include file = "../inc/header.asp" -->
<%
Dim userName  : userName  = request.Form("userName")
Dim userEmail : userEmail = request.Form("userEmail")
Dim userId    : userId    = request.Form("userId")

If userEmail = "" Or userId = "" Then 
	Response.Write "1"
	Response.End
End If

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

If FI_id = "" Then 
	Response.Write "2"
	Response.End
End If

Dim result : result = sendSmsEmail( "id_search" , FI_id , userEmail , now() , "" )

Response.Write "0"
Response.End

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "M_user_member_find_info"
		.Parameters("@actType").value = "id"
		.Parameters("@name").value    = userName
		.Parameters("@id").value      = userId
		.Parameters("@email").value   = userEmail
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

%>
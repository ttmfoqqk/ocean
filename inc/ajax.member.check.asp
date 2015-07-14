<!-- #include file = "../inc/header.asp" -->
<%
Dim actType : actType = request("actType")
Dim search  : search  = request("search")
Dim id      : id      = request("id")
Dim idx     : idx     = IIF(request("idx")="",-1,request("idx"))

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

response.write FI_check

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "ocean_user_member_check"
		.Parameters("@actType").value = actType
		.Parameters("@search").value  = search
		.Parameters("@id").value      = id
		.Parameters("@idx").value     = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
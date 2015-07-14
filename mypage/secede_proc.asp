<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & "/ocean/mypage/secede.asp" )

Dim agree : agree = request.Form("agree")

If agree = "" Then 
	Response.redirect "secede.asp"
End If


Call Expires()
Call dbopen()
	Call secede()
Call dbclose()


Dim result : result = sendSmsEmail( "secede" , session("userId") , FI_UserEmail , now() , "" )

Session("UserIdx")  = ""
Session("UserId")   = ""
Session("UserName") = ""
Session("UserSano") = ""



With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('탈퇴 되었습니다.');"
 .Write "location.href='../';"
 .Write "</script>"
 .End
End With


Sub secede()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value = "DELETE"
		.Parameters("@UserIdx").value = session("userIdx")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
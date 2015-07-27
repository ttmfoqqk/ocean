<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & BASE_PATH & "mypage/pwdChange.asp" )

Dim oldUserPwd     : oldUserPwd     = request.Form("oldUserPwd")
Dim userPwd        : userPwd        = request.Form("userPwd")
Dim userPwdConfirm : userPwdConfirm = request.Form("userPwdConfirm")

If oldUserPwd = "" Or userPwd = "" Or userPwdConfirm = "" Then 
	Response.redirect "pwdChange.asp"
End If

If userPwd <> userPwdConfirm Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('정보가 일치하지 않습니다. 새로운 비밀번호를 다시 입력 해주세요.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

If FI_IN_CNT = 0 Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('정보가 일치하지 않습니다. 비밀번호를 다시 입력 해주세요.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim result   : result   = sendSmsEmail( "pwd_change" , session("userId"), session("userName") , FI_EMAIL , "" , "" )

With Response
 .Write "<script language='javascript' type='text/javascript'>"
 .Write "alert('변경 되었습니다.');"
 .Write "location.href='pwdChange.asp';"
 .Write "</script>"
 .End
End With

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value = "PWUPDATE"
		.Parameters("@UserPass").value    = oldUserPwd
		.Parameters("@NewUserPass").value = userPwd
		.Parameters("@UserIdx").value     = session("userIdx")
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim alertMsg        : alertMsg        = ""
Dim actType         : actType         = Trim( Request.Form("actType") )
Dim user_idx        : user_idx        = IIF( Request.Form("user_idx")="",0,Request.Form("user_idx") )
Dim user_id         : user_id         = Request.Form("user_id_hidden")
Dim user_hphone     : user_hphone     = Trim( Request.Form("user_hphone") )
Dim user_phone      : user_phone      = Trim( Request.Form("user_phone") )
Dim user_bigo       : user_bigo       = TagEncode( Trim( Request.Form("user_bigo")) )
Dim user_delFg      : user_delFg      = IIF( Request.Form("user_delFg")="",0,Request.Form("user_delFg") )
Dim user_state      : user_state      = IIF( Request.Form("user_state")="",0,Request.Form("user_state") )
Dim user_state_old  : user_state_old  = IIF( Request.Form("user_state_old")="",0,Request.Form("user_state_old") )
Dim user_ceoFg      : user_ceoFg      = IIF( Request.Form("user_ceoFg")="",0,Request.Form("user_ceoFg") )
Dim user_companyIdx : user_companyIdx = IIF( Request.Form("user_companyIdx")="",0,Request.Form("user_companyIdx") )
Dim user_position   : user_position   = Trim( Request.Form("user_position") )
Dim user_pass       : user_pass       = Trim( Request.Form("user_pass") )
Dim user_pass_ch    : user_pass_ch    = Trim( Request.Form("user_pass_ch") )

Dim pageNo          : pageNo          = IIF( Request.Form("pageNo")="",1,Request.Form("pageNo") )
Dim sUserName       : sUserName       = Request.Form("sUserName")
Dim sUserId         : sUserId         = Request.Form("sUserId")
Dim sHphone3        : sHphone3        = Request.Form("sHphone3")
Dim sIndate         : sIndate         = Request.Form("sIndate")
Dim sOutdate        : sOutdate        = Request.Form("sOutdate")
Dim sState          : sState          = Request.Form("sState")
Dim sdelFg          : sdelFg          = Request.Form("sdelFg")
Dim scompanyIdx     : scompanyIdx     = Request.Form("scompanyIdx")
Dim sceoFg          : sceoFg          = Request.Form("sceoFg")

Dim pageURL
pageURL	= "pageNo="   & pageNo &_
		"&UserName="  & sUserName &_
		"&UserId="    & sUserId &_
		"&Hphone3="   & sHphone3 &_
		"&delFg="     & sdelFg &_
		"&State="     & sState &_
		"&ceoFg="     & sceoFg &_
		"&companyIdx="& scompanyIdx &_
		"&Indate="    & sIndate &_
		"&Outdate="   & sOutdate




Call Expires()
Call dbopen()
	If actType = "UPDATE" Then 

		if user_pass <> user_pass_ch Then
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('비밀번호를 확인해주세요.');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If

		Call Insert()

		If FI_IN_CNT > 0 Then 
			With Response
			 .Write "<script language='javascript' type='text/javascript'>"
			 .Write "alert('이미 설정된 대표자가 있습니다.');"
			 .Write "history.go(-1);"
			 .Write "</script>"
			 .End
			End With
		End If
		
		'가입완료
		If user_state_old > 0 And user_state = 0 Then 
			email_result = sendSmsEmail( "join" , user_id , user_id , "" , "" )
		End If

		alertMsg = "수정되었습니다."
	ElseIf actType = "DELETE" Then 
		Call Insert()
		alertMsg = "탈퇴되었습니다."
	Else
		alertMsg = "[actType] 이 없습니다."
	End If	
Call dbclose()

Sub Insert()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_P"
		.Parameters("@actType").value          = actType
		.Parameters("@UserIdx").value          = user_idx
		.Parameters("@NewUserPass").value      = user_pass
		.Parameters("@UserHPhone").value       = user_hphone
		.Parameters("@UserPhone").value        = user_phone
		.Parameters("@companySelect").value    = user_companyIdx
		.Parameters("@UserBigo").value         = user_bigo
		.Parameters("@UserDelFg").value        = user_delFg
		.Parameters("@userState").value        = user_state
		.Parameters("@ceoFg").value            = user_ceoFg
		.Parameters("@userPosition").value     = user_position
		.Parameters("@DELETE_ADMIN_KEY").value = 0
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
  <meta name="Generator" content="EditPlus">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
 </head>

 <body>
  <script type="text/javascript">
  if("<%=alertMsg%>")alert("<%=alertMsg%>");
  location.href="MEMBER_01_L.asp?<%=pageURL%>"
  </script>
 </body>
</html>
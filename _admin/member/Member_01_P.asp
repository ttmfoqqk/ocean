<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim alertMsg        : alertMsg        = ""
Dim actType         : actType         = Trim( Request.Form("actType") )
Dim user_idx        : user_idx        = IIF( Request.Form("user_idx")="",0,Request.Form("user_idx") )
Dim user_id         : user_id         = Request.Form("user_id_hidden")
Dim user_name       : user_name       = Request.Form("user_name")
Dim user_hphone1    : user_hphone1    = Trim( Request.Form("user_hphone1") )
Dim user_hphone2    : user_hphone2    = Trim( Request.Form("user_hphone2") )
Dim user_hphone3    : user_hphone3    = Trim( Request.Form("user_hphone3") )
Dim user_phone1     : user_phone1     = Trim( Request.Form("user_phone1") )
Dim user_phone2     : user_phone2     = Trim( Request.Form("user_phone2") )
Dim user_phone3     : user_phone3     = Trim( Request.Form("user_phone3") )
Dim user_fax1       : user_fax1       = Trim( Request.Form("user_fax1") )
Dim user_fax2       : user_fax2       = Trim( Request.Form("user_fax2") )
Dim user_fax3       : user_fax3       = Trim( Request.Form("user_fax3") )
Dim user_zcode1     : user_zcode1     = Trim( Request.Form("user_zcode1") )
Dim user_zcode2     : user_zcode2     = Trim( Request.Form("user_zcode2") )
Dim user_addr1      : user_addr1      = Trim( Request.Form("user_addr1") )
Dim user_addr2      : user_addr2      = Trim( Request.Form("user_addr2") )
Dim user_mail1      : user_mail1      = Trim( Request.Form("user_mail1") )
Dim user_mail3      : user_mail3      = Trim( Request.Form("user_mail3") )
Dim user_bigo       : user_bigo       = TagEncode( Trim( Request.Form("user_bigo")) )
Dim user_efg        : user_efg        = IIF( Request.Form("user_efg")="",0,Request.Form("user_efg") )
Dim user_delFg      : user_delFg      = IIF( Request.Form("user_delFg")="",0,Request.Form("user_delFg") )
Dim user_state      : user_state      = IIF( Request.Form("user_state")="",0,Request.Form("user_state") )
Dim user_state_old  : user_state_old  = IIF( Request.Form("user_state_old")="",0,Request.Form("user_state_old") )
Dim user_ceoFg      : user_ceoFg      = IIF( Request.Form("user_ceoFg")="",0,Request.Form("user_ceoFg") )
Dim user_companyIdx : user_companyIdx = IIF( Request.Form("user_companyIdx")="",0,Request.Form("user_companyIdx") )
Dim user_position   : user_position   = Trim( Request.Form("user_position") )
Dim companyName     : companyName     = Trim( Request.Form("companyName") )

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

		If user_state_old > 0 And user_state = 0 Then 
			email_result = sendSmsEmail( "join" , user_id , user_mail1  & "@" & user_mail3 , now() , "" )
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
		.Parameters("@UserId").value           = user_id
		.Parameters("@UserName").value         = user_name
		.Parameters("@NewUserPass").value      = user_pass

		.Parameters("@UserHPhone1").value      = user_hphone1
		.Parameters("@UserHPhone2").value      = user_hphone2
		.Parameters("@UserHPhone3").value      = user_hphone3
		.Parameters("@UserPhone1").value       = user_phone1
		.Parameters("@UserPhone2").value       = user_phone2
		.Parameters("@UserPhone3").value       = user_phone3
		.Parameters("@UserFax1").value         = user_fax1
		.Parameters("@UserFax2").value         = user_fax2
		.Parameters("@UserFax3").value         = user_fax3
		.Parameters("@UserEmail").value        = user_mail1  & "@" & user_mail3

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
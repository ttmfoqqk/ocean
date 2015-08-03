<!-- #include file = "../inc/header.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim alertMsg      : alertMsg      = ""
Dim actType       : actType       = Trim( Request.Form("actType") )
Dim admin_id      : admin_id      = Trim( Request.Form("admin_id") )
Dim admin_pass    : admin_pass    = Trim( Request.Form("admin_pass") )
Dim admin_pass_ch : admin_pass_ch = Trim( Request.Form("admin_pass_ch") )
Dim admin_name    : admin_name    = Trim( Request.Form("admin_name") )
Dim admin_phone1  : admin_phone1  = Trim( Request.Form("admin_phone1") )
Dim admin_phone2  : admin_phone2  = Trim( Request.Form("admin_phone2") )
Dim admin_phone3  : admin_phone3  = Trim( Request.Form("admin_phone3") )
Dim admin_hphone1 : admin_hphone1 = Trim( Request.Form("admin_hphone1") )
Dim admin_hphone2 : admin_hphone2 = Trim( Request.Form("admin_hphone2") )
Dim admin_hphone3 : admin_hphone3 = Trim( Request.Form("admin_hphone3") )
Dim admin_ext     : admin_ext     = Trim( Request.Form("admin_ext") )
Dim admin_dir     : admin_dir     = Trim( Request.Form("admin_dir") )
Dim admin_mail1   : admin_mail1   = Trim( Request.Form("admin_mail1") )
Dim admin_mail3   : admin_mail3   = Trim( Request.Form("admin_mail3") )
Dim admin_msg1    : admin_msg1    = Trim( Request.Form("admin_msg1") )
Dim admin_msg3    : admin_msg3    = Trim( Request.Form("admin_msg3") )
Dim admin_bigo    : admin_bigo    = Trim( TagEncode(Request.Form("admin_bigo")) )
Dim pageNo        : pageNo        = Request.Form("pageNo")

Dim admin_idx     : admin_idx     = Request.Form("admin_idx")
Dim check_idx     : check_idx     = Request.Form("check_idx")
Dim Idx           : Idx           = IIF( admin_idx = "" , check_idx , admin_idx  )

dim cumunity_key  : cumunity_key  = 3
dim cumunity_tab  : cumunity_tab  = Request.Form("cumunity_tab")

If admin_pass <> admin_pass_ch Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('비밀번호를 확인해주세요.');"
	 .Write "history.back(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	If actType = "INSERT" Then 
		Call Insert()
		If FI_IN_CNT > 0 Then 
			alertMsg = "중복된 아이디는 사용하실수 없습니다."
		Else
			alertMsg = "입력되었습니다."
		End If
	ElseIf actType = "UPDATE" Then 
		Call Insert()
		alertMsg = "수정되었습니다."
	ElseIf actType = "DELETE" Then 
		Call Insert()
		alertMsg = "삭제되었습니다."
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
		.CommandText      = "OCEAN_ADMIN_MEMBER_P"
		.Parameters("@actType").value = actType
		.Parameters("@Idx").value     = Idx
		.Parameters("@Id").value      = admin_Id
		.Parameters("@Pwd").value     = admin_pass
		.Parameters("@Name").value    = admin_name
		.Parameters("@pHone1").value  = admin_phone1
		.Parameters("@pHone2").value  = admin_phone2
		.Parameters("@pHone3").value  = admin_phone3
		.Parameters("@Hphone1").value = admin_hphone1
		.Parameters("@Hphone2").value = admin_hphone2
		.Parameters("@Hphone3").value = admin_hphone3
		.Parameters("@ExtNum").value  = admin_ext
		.Parameters("@DirNum").value  = admin_dir
		.Parameters("@email").value   = admin_mail1 & "@" & admin_mail3
		.Parameters("@MsgAddr").value = admin_msg1  & "@" & admin_msg3
		.Parameters("@Bigo").value    = admin_bigo
		.Parameters("@cumunity_key").value = cumunity_key
		.Parameters("@cumunity_tab").value = cumunity_tab
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
  location.href="Admin_02_L.asp?pageNo=<%=pageNo%>"
  </script>
 </body>
</html>
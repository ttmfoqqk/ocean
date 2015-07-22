<!-- #include file = "../inc/header.asp" -->
<%
Dim FirstName     : FirstName     = request.Form("FirstName")
Dim LastName      : LastName      = request.Form("LastName")
Dim companySelect : companySelect = request.Form("companySelect")

If FirstName = "" Or FirstName = "" Or companySelect = "" Then 
	Response.redirect "find_id.asp"
End If

Call Expires()
Call dbopen()
	Call getList()
Call dbclose()

If FI_UserId = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('입력하신 정보와 일치하는 정보가 없습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Sub getList()
	SET objRs	= Server.CreateObject("ADODB.RecordSet")
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection  = objConn
		.prepared          = true
		.CommandType       = adCmdStoredProc
		.CommandText       = "ocean_user_member_search"
		.Parameters("@actType").value = "id"
		.Parameters("@FirstName").value = FirstName
		.Parameters("@LastName").value  = LastName
		.Parameters("@cIdx").value      = companySelect
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Find ID</h2>
		
		<div style="font-size:14px;line-height:180%;">
			<h3>입력하신 회원정보로 가입된 <span class="color_blue">아이디</span>를 알려드립니다.</h3>
		</div>
		
		<center>
		<div style="display:inline-block;margin-top:30px;">
			<div style="line-height:200%;display:inline-block;text-align:left;">
			<label><h2 class="color_blue" style="display:inline-block;"><%=FI_userId%></h4> (<%=FI_UserIndate%> 가입) </label><br>
			</div>
		</div>
		</center>
		
		<div style="margin:30px;text-align:center;">
			<button class="btn" onclick="location.href='../login/'">Login</button>
		</div>

		

	</div>
</div>
<!-- #include file = "../inc/footer.asp" -->
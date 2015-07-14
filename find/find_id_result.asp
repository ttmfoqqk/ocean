<!-- #include file = "../inc/header.asp" -->
<%
Dim userName   : userName   = request.Form("userName")
Dim userEmail1 : userEmail1 = request.Form("userEmail1")
Dim userEmail2 : userEmail2 = request.Form("userEmail2")

If userName = "" Or userEmail1 = "" Or userEmail2 = "" Then 
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
		.Parameters("@name").value    = userName
		.Parameters("@email").value   = userEmail1 & "@" & userEmail2
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
		<h2 class="page_title">아이디찾기</h2>
		
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
			<button class="btn" onclick="location.href='../login/'">로그인</button>
		</div>

		<div style="padding:25px;border:1px solid #bfbfbf;background-color:#fafafa;line-height:160%;text-align:left;">
			만약 자신이 만든 아이디가 아니라면 개인정보 도용 신고 절차에 따라 신고해 주시기 바랍니다.<br>
			위의 방법으로 아이디 찾을 수 없을 경우 별도 확인이 불가능하오니, 새로운 아이디로 가입하여 주시기 바랍니다.<br>
		</div>


	</div>
</div>
<!-- #include file = "../inc/footer.asp" -->
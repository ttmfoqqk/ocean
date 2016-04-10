<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim Title    : Title    = request("Title")
Dim BoardKey : BoardKey = request("BoardKey")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )
Dim Idx      : Idx      = IIF( request("Idx")="" , 0 , request("Idx") )
Dim actType  : actType  = request("actType")

Dim arrMenuList
Dim cntMenuList : cntMenuList = -1

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&tab="      & tab &_
		"&Title="    & Title


Call Expires()
Call dbopen()
	Call GetList()
	if BoardKey = "1" then
		Call GetMenuDownloadList()
	elseif BoardKey = "3" then
		Call GetMenuCommunityList()
	end if
Call dbclose()


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_V"
		.Parameters("@Idx").value = Idx
		.Parameters("@Key").value = BoardKey
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetMenuDownloadList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_DOWNLOAD_S"
		.Parameters("@Key").value = BoardKey
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI2")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrMenuList = objRs.GetRows()
		cntMenuList = UBound(arrMenuList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub GetMenuCommunityList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_COMMUNITY_S"
		.Parameters("@Key").value = BoardKey
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI2")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrMenuList = objRs.GetRows()
		cntMenuList = UBound(arrMenuList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 다운로드 분류관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="Customer_03_P.asp" onsubmit="return check()">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">
				<input type="hidden" name="Idx" value="<%=FI_Idx%>">
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , "UPDATE" )%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<select id="tab" name="tab">
										<option value="">선택</option>
										<%For iLoop = 0 To cntMenuList%>
										<option value="<%=arrMenuList(FI2_idx, iLoop)%>" <%=IIF(IIF(FI_tap="",tab,FI_tap) = cstr(arrMenuList(FI2_idx, iLoop)),"selected","")%>><%=arrMenuList(FI2_name, iLoop)%></option>
										<%next%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" id="Title" name="Title" class="input" value="<%=TagDecode( FI_name )%>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">링크</td>
								<td class="line_box">
									<input type="text" style="width:100%" id="Link" name="Link" class="input" value="<%=FI_Link%>" maxlength="200">
									<div style="line-height:180%;">전체주소 ex : https://www.google.co.kr</div>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box"><input type="text" id="order" name="order" class="input" value="<%=IIF(FI_order="",0,FI_order)%>" size="4" maxlength="4"></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<input type="image" src="../img/center_btn_write_ok.gif" style="vertical-align:top;">
						<a href="Customer_03_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif" style="vertical-align:top;"></a>
						
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
</form>
</table>
<script type="text/javascript">
function check(){
	if( !$('#tab').val() ){
		alert('분류를 선택해 주세요.');return false;
	}
	if( !$.trim( $('#Title').val() ) ){
		alert('제목을 입력해 주세요.');return false;
	}
	if( !$.trim( $('#order').val() ) ){
		alert('순서를 입력해 주세요.');return false;
	}
}
</script>
<!-- #include file = "../inc/bottom.asp" -->
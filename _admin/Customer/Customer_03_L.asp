<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim Title    : Title    = request("Title")
Dim BoardKey : BoardKey = request("BoardKey")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )

Dim arrMenuList
Dim cntMenuList : cntMenuList = -1

Call Expires()
Call dbopen()
	Call GetList()
	if BoardKey = "1" then
		Call GetMenuDownloadList()
	elseif BoardKey = "3" then
		Call GetMenuCommunityList()
	end if
Call dbclose()

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&BoardKey=" & BoardKey &_
		"&tab="      & tab &_
		"&Title="    & Title

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&tab="      & tab &_
		"&Title="    & Title


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@Key").value    = BoardKey
		.Parameters("@Title").value  = Title
		.Parameters("@tab").value    = tab
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
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
<script type="text/javascript">
$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=Idx]').attr({"checked":"checked"}) : $('input[name=Idx]').attr({"checked":""});
	});
} );
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='Idx']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 분류관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" class="input" name="Title" value="<%=Title%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box" width="250">
									<select name="tab">
										<option value="">선택</option>
										<%For iLoop = 0 To cntMenuList%>
										<option value="<%=arrMenuList(FI2_idx, iLoop)%>" <%=IIF(tab = cstr(arrMenuList(FI2_idx, iLoop)),"selected","")%>><%=arrMenuList(FI2_name, iLoop)%></option>
										<%next%>
									</select>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align=center colspan=2><input type="image" src="../img/center_btn_Search.gif"></td>
				</tr>

				</form>
				<tr>
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
						<form name="AdminForm" method="post" action="Customer_03_P.asp">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="50">번호</td>
								<td class="line_box" width="20%">분류</td>
								<td class="line_box">제목</td>
								<td class="line_box" width="25%">링크</td>
								<td class="line_box" width="7%">순서</td>
							</tr>
							<%
							for iLoop = 0 to cntList
							PageLink = "location.href='Customer_03_W.asp?" & PageParams & "&Idx=" & arrList(FI_Idx,iLoop) & "'"
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;" ><input type="checkbox" name="Idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand">
									<%
									If (BoardKey="1") Then
										Response.Write(arrList(FI_tapNameD,iLoop))
									elseif (BoardKey="3") then 
										Response.Write(arrList(FI_tapNameC,iLoop))
									End if
									%>
								</td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left><%=arrList(FI_name,iLoop)%></td>								
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_link,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_order,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="5" align=center>등록된 내용이 없습니다.</td>
							</tr>
							<%end if%>
						</table>

						</form>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="Customer_03_W.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		
		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->
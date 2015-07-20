<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim cName    : cName    = request("cName")
Dim sano     : sano     = request("sano")
Dim ceo      : ceo      = request("ceo")
Dim State    : State    = request("State")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&cName="   & cName &_
		"&sano="    & sano &_
		"&ceo="     & ceo &_
		"&State="   & State &_
		"&Indate="  & Indate &_
		"&Outdate=" & Outdate

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&cName="   & cName &_
		"&sano="    & sano &_
		"&ceo="     & ceo &_
		"&State="   & State &_
		"&Indate="  & Indate &_
		"&Outdate=" & Outdate

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_L"
		.Parameters("@rows").value    = rows 
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@cName").value   = cName
		.Parameters("@ceo").value     = ceo
		.Parameters("@sano").value    = sano
		.Parameters("@State").value   = State
		.Parameters("@Indate").value  = Indate
		.Parameters("@Outdate").value = Outdate
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
					<td width="50%"><img src="../img/center_title_04_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 멤버사관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">가입일자</td>
								<td class="line_box" colspan=3>
								<input type="text" class="input" id="Indate" name="Indate" readonly value="<%=Indate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Indate);"> - 
								<input type="text" class="input" id="Outdate" name="Outdate" readonly value="<%=Outdate%>" size=15> 
								<img src="../img/center_icon_carender.gif" onclick="callCalendar(SearchForm.Outdate);"> 
								<a href="javascript:date_input('Indate','Outdate','<%=Date%>','<%=Date%>')">[오늘]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("d",-7,date)%>','<%=Date%>')">[7일전]</a>
								<a href="javascript:date_input('Indate','Outdate','<%=DateAdd("m",-1,date)%>','<%=Date%>')">[30일전]</a>
								&nbsp;
								<a href="javascript:date_input('Indate','Outdate','','')">[날짜초기화]</a>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">상호</td>
								<td class="line_box"><input type="text" class="input" name="cName" value="<%=cName%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사업자등록번호</td>
								<td class="line_box" width="250"><input type="text" class="input" name="sano" value="<%=sano%>" maxlength="10"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">대표자</td>
								<td class="line_box"><input type="text" class="input" name="ceo" value="<%=ceo%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">탈퇴여부</td>
								<td class="line_box" width="250">
									<select name="State">
										<option value="">선택</option>
										<option value="0" <%=IIF(State="0","selected","")%>>사용중</option>
										<option value="1" <%=IIF(State="1","selected","")%>>탈퇴</option>
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
						
						<form name="AdminForm" method="post" action="Customer_01_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50">번호</td>
								<td class="line_box" width="10%">가입일자</td>
								<td class="line_box" width="20%">상호</td>
								<!--td class="line_box" width="15%">대표자</td-->
								<td class="line_box">주소</td>
								<td class="line_box" width="8%">탈퇴여부</td>
							
							</tr>
							<%
							Dim PageLink,UserHphone
							for iLoop = 0 to cntList
								PageLink = "location.href='Member_02_V.asp?" & PageParams & "&Idx=" & arrList(FI_Idx,iLoop) & "'"
								addr = ""
								addr = IIF( arrList(FI_addr,iLoop) = "", arrList(FI_addr1,iLoop) & " " & arrList(FI_addr2,iLoop) ,arrList(FI_addr,iLoop) )
							%>
							<tr height="30" align=center>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Indate,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_cName,iLoop)%></td>
								<!--td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_ceo,iLoop)%></td-->
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand;text-align:left;padding-left:10px;"><%=addr%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=IIF( arrList(FI_state,iLoop)="0","사용중","<font color=red>탈퇴</font>" )%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="7" align=center>등록된 멤버사가 없습니다.</td>
							</tr>
							<%end if%>
						</table>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="Member_02_V.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
					</td>
				</tr>
			</table>

		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->
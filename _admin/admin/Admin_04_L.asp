<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrList
Dim cntList  : cntList  = -1

Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim Title    : Title    = request("Title")
dim position : position = request("position")
dim use      : use      = request("use")


Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&Title="    & Title &_
		"&position=" & position &_
		"&use="      & use

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&Title="    & Title &_
		"&position=" & position &_
		"&use="      & use


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BANNER_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@Indate").value   = Indate
		.Parameters("@Outdate").value  = Outdate
		.Parameters("@name").value     = Title
		.Parameters("@position").value = position
		.Parameters("@is_use").value   = use
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList  = objRs.GetRows()
		cntList  = UBound(arrList, 2)
		cntTotal = arrList(FI_tcount, 0)
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
					<td width="50%" style="line-height:22px;font-size:15px;">■ <b>팝업관리</b></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 팝업관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<form name="SearchForm" method="get">

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성일</td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">위치</td>
								<td class="line_box">
									<select id="position" name="position">
										<option value="">선택</option>
										<option value="1" <%=IIF(position="1","selected","")%>>왼쪽</option>
										<option value="2" <%=IIF(position="2","selected","")%>>오른쪽</option>
									</select>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box" width="250">
									<select id="use" name="use">
										<option value="">선택</option>
										<option value="0" <%=IIF(use="0","selected","")%>>사용</option>
										<option value="1" <%=IIF(use="1","selected","")%>>비사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" class="input" name="Title" value="<%=Title%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140"> </td>
								<td class="line_box" width="250"> </td>
							</tr>
							<tr><td height="10"></td></tr>
							<tr>
								<td align=center colspan="4"><input type="image" src="../img/center_btn_Search.gif"></td>
							</tr>
						</table>

						</form>

					</td>
				</tr>
				<tr>
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
						<form name="AdminForm" method="post" action="Admin_04_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed;">
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="40">번호</td>
								<td class="line_box" width="120">위치</td>
								<td class="line_box">제목</td>
								<td class="line_box" width="100">작성일</td>
								<td class="line_box" width="40">순서</td>
								<td class="line_box" width="50">사용</td>
							</tr>

							<%
							for iLoop = 0 to cntList
							PageLink = "location.href='Admin_04_V.asp?" & PageParams & "&idx=" & arrList(FI_idx,iLoop) & "'"

							if arrList(FI_position,iLoop) = "1" then 
								position_t = "왼쪽"
							elseif arrList(FI_position,iLoop) = "2" then 
								position_t = "오른쪽"
							else
								position_t = ""
							end if

							if arrList(FI_is_use,iLoop) = "0" then 
								use_t = "사용"
							elseif arrList(FI_is_use,iLoop) = "1" then 
								use_t = "비사용"
							else
								use_t = ""
							end if
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;"><input type="checkbox" name="idx" value="<%=arrList(FI_idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=position_t%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<div class="ellipsis"><%=arrList(FI_name,iLoop)%></div>
								</td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_created,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_order,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=use_t%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="7" align=center>등록된 내용이 없습니다.</td>
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
						<a href="Admin_04_V.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		
		</td>
	</tr>

</table>

<SCRIPT type="text/javascript">

$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=idx]').attr({"checked":"checked"}) : $('input[name=idx]').attr({"checked":""});
	});
});

function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='idx']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}
</SCRIPT>
<!-- #include file = "../inc/bottom.asp" -->
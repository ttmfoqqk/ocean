<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrList , arrNoti
Dim cntList  : cntList  = -1
Dim cntNoti  : cntNoti  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName : UserName = request("UserName")
Dim UserId   : UserId   = request("UserId")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim BoardKey : BoardKey = request("BoardKey")
Dim Title    : Title    = request("Title")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )
Dim tab2     : tab2     = IIF( request("tab2")="",0,request("tab2") )
dim sstatus  : sstatus  = request("status")


Dim arrMenuList
Dim cntMenuList : cntMenuList = -1


Call Expires()
Call dbopen()
	Call BoardCodeList()
	BoardKey = IIF( BoardKey="" , BC_FIRST_KEY , BoardKey )
	Call BoardCodeView()
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
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&tab="      & tab &_
		"&tab2="     & tab2 &_
		"&Title="    & Title &_
		"&sstatus="  & sstatus

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&tab="      & tab &_
		"&tab2="     & tab2 &_
		"&Title="    & Title &_
		"&sstatus="  & sstatus


Sub BoardCodeList()
'왼쪽메뉴용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CODE_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "BoardCode")
	If NOT(objRs.BOF or objRs.EOF) Then
		BC_ARRY_LIST = objRs.GetRows()
		BC_CNT_LIST  = UBound(BC_ARRY_LIST, 2)
		BC_FIRST_KEY = BC_ARRY_LIST(BoardCode_Idx, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@pageNo").value   = pageNo
		.Parameters("@Key").value      = BoardKey
		.Parameters("@UserName").value = UserName
		.Parameters("@UserId").value   = UserId
		.Parameters("@Indate").value   = Indate
		.Parameters("@Outdate").value  = Outdate
		.Parameters("@tab").value      = tab
		.Parameters("@tab2").value     = tab2
		.Parameters("@status").value   = sstatus
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	'공지사항
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "NOTICE")
	If Not(objRs.Eof or objRs.Bof) Then
		arrNoti		= objRs.GetRows()
		cntNoti		= UBound(arrNoti, 2)
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

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		<%
		If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then 
			Response.write "잘못된 게시판 코드 입니다."
		Else
		%>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성자</td>
								<td class="line_box"><input type="text" class="input" name="UserName" value="<%=UserName%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">아이디</td>
								<td class="line_box" width="250"><input type="text" class="input" name="UserId" value="<%=UserId%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" class="input" name="Title" value="<%=Title%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">진행상황</td>
								<td class="line_box" width="250">
									<%If BoardKey="1" Then%>
									<select id="status" name="status">
										<option value="">선택</option>
										<option value="0" <%=IIF(sstatus="0","selected","")%>>게시요청</option>
										<option value="1" <%=IIF(sstatus="1","selected","")%>>검토중</option>
										<option value="2" <%=IIF(sstatus="2","selected","")%>>완료</option>
									</select>
									<%elseIf BoardKey="3" Then%>
									<select id="status" name="status">
										<option value="">선택</option>
										<option value="0" <%=IIF(sstatus="0","selected","")%>>접수</option>
										<option value="1" <%=IIF(sstatus="1","selected","")%>>처리중</option>
										<option value="2" <%=IIF(sstatus="2","selected","")%>>완료</option>
									</select>
									<%End If%>
								</td>
								
							</tr>
							<%if BoardKey="1" or BoardKey="3" then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box" colspan="3">
									<select id="tab" name="tab">
										<option value="">선택</option>
										<%For iLoop = 0 To cntMenuList%>
										<option value="<%=arrMenuList(FI2_idx, iLoop)%>" <%=IIF(tab = cstr(arrMenuList(FI2_idx, iLoop)),"selected","")%>><%=arrMenuList(FI2_name, iLoop)%></option>
										<%next%>
									</select>

									<%if BoardKey="1" then %>
									<select id="tab2" name="tab2">
										<option value="">중분류 선택</option>
									</select>
									<%end if%>
								</td>
							</tr>
							<%end if%>
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
						<form name="AdminForm" method="post" action="Customer_01<%=IIF(BoardKey="1" ,"_D","")%>_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="BoardKey" value="<%=BoardKey%>">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed;">
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" style="padding:0px;" width="30"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="40">번호</td>
								<td class="line_box">제목</td>
								<%If BoardKey = "1" or BoardKey = "3" Then %>
								<td class="line_box" width="20%">분류</td>
								<%End If%>
								<td class="line_box" width="10%">작성자</td>
								<td class="line_box" width="15%">등록일</td>
								<%If BoardKey = "1" or BoardKey = "3" Then %>
								<td class="line_box" width="8%">진행상황</td>
								<%End If%>
								<td class="line_box" width="6%">조회</td>
							</tr>
							<%
							Dim PageLink,nbsp
							for iLoop = 0 to cntNoti
								PageLink = "location.href='Customer_01_V.asp?" & PageParams & "&Idx=" & arrNoti(NOTICE_Idx,iLoop) & "'"

								statusText = ""
								if arrNoti(NOTICE_status,iLoop)="0" then 
									statusText = "요청"
								elseif arrNoti(NOTICE_status,iLoop)="1" then 
									statusText = "검토중"
								elseif arrNoti(NOTICE_status,iLoop)="2" then 
									statusText = "완료"
								end if
							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;" ><input type="checkbox" name="Idx" value="<%=arrNoti(NOTICE_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand;color:red"><b>[공지]</b></td>
								<td class="line_box ellipsis" onclick="<%=PageLink%>" style="cursor:hand" align=left><%=HtmlTagRemover( arrNoti(NOTICE_Title,iLoop) , 60 )%></td>
								<%If BoardKey = "1" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<%=arrNoti(NOTICE_DownloadName,iLoop)%>
									<%=IIF(arrNoti(NOTICE_tab2Name,iLoop)<>""," > " & arrNoti(NOTICE_tab2Name,iLoop),"")%>
								</td>
								<%elseIf BoardKey = "3" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<%=arrNoti(NOTICE_CommunityName,iLoop)%>
								</td>
								<%End If%>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrNoti(NOTICE_ContName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrNoti(NOTICE_Indate,iLoop)%></td>
								<%If BoardKey = "1" or BoardKey = "3" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=statusText%></td>
								<%end if%>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrNoti(NOTICE_Read_cnt,iLoop)%></td>
							</tr>
							<%next%>
							<%
							for iLoop = 0 to cntList
							PageLink = "location.href='Customer_01_V.asp?" & PageParams & "&Idx=" & arrList(FI_Idx,iLoop) & "'"
							
							nbsp = ""
							margin = 0
							If arrList(FI_Depth_no, iLoop) > 0 Then 
								for Depth = 2 to arrList(FI_Depth_no, iLoop)
									'nbsp = nbsp & "&nbsp;&nbsp;&nbsp;&nbsp;"
									margin = arrList(FI_Depth_no, iLoop) * 10
								Next
								nbsp = nbsp & "└> RE : "
							End If

							if arrList(FI_Dellfg,iLoop) <> "0" then 
								title = "삭제된 글 입니다."
							else
								title = HtmlTagRemover( arrList(FI_Title,iLoop) , 60 )
							end if


							statusText = ""
							if (BoardKey = "1" and arrList(FI_tab,iLoop) = "3") or BoardKey = "3" then 
								if arrList(FI_status,iLoop)="0" then 
									statusText = IIF(BoardKey="1", "게시요청" ,"접수" )
								elseif arrList(FI_status,iLoop)="1" then 
									statusText = IIF(BoardKey="1", "검토중" , "처리중")
								elseif arrList(FI_status,iLoop)="2" then 
									statusText = "완료"
								end if
							end if

							%>
							<tr height="30" align=center>
								<td class="line_box" style="padding:0px;" ><input type="checkbox" name="Idx" value="<%=arrList(FI_Idx,iLoop)%>"></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<div class="ellipsis" style="margin-left:<%=margin%>px;"><%=nbsp & title %></div>
								</td>
								<%If BoardKey = "1" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<%=arrList(FI_DownloadName,iLoop)%>
									<%=IIF(arrList(FI_tab2Name,iLoop)<>""," > " & arrList(FI_tab2Name,iLoop),"")%>
								</td>
								<%elseIf BoardKey = "3" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand" align=left>
									<%=arrList(FI_CommunityName,iLoop)%>
								</td>
								<%End If%>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_ContName,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Indate,iLoop)%></td>
								<%If BoardKey = "1" or BoardKey = "3" Then %>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=statusText%></td>
								<%end if%>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_Read_cnt,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>등록된 내용이 없습니다.</td>
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
						<a href="Customer_01_W.asp?<%=PageParams%>"><img src="../img/center_btn_write_ok.gif"></a>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		<%End If%>
		</td>
	</tr>

</table>

<SCRIPT type="text/javascript">

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

$tab = $('#tab');
$tab2 = $('#tab2');

var temp1 = '<%=tab%>';
var temp2 = '<%=tab2%>';

$tab.change(function(){
	call_depth( $tab2 , $(this).val() , temp2 );
});

call_depth( $tab2 , temp1 , temp2 );

function call_depth(obj,parent,value){
	if(!parent){return false;}
	var param  = 'parent='+parent+'&boardKey=<%=BoardKey%>';

	obj.html( '<option value="">로딩 중입니다.</option>' );
	$.ajax({
		type    : 'GET',
		url     : '../../inc/ajax.download.m.asp',
		data    : param,
		dataType: 'xml',
		cache: false,
		scriptCharset:'utf-8',
		success: function(xml){
			var $xml  = $(xml);
			var $item = $xml.find('item');
			var html  = '<option value="">중분류 선택</option>';

			$item.each(function(index){
				var idx  = $(this).find('idx').text();
				var name = $(this).find('name').text();
				
				html += '<option value="'+idx+'">'+name+'</option>';
			});
			obj.html( html );
			obj.find('option[value="'+value+'"]').attr('selected',true);
		},error:function(err){
			alert(err.responseText)
			obj.html( '<option value="">에러: 잠시 후에 다시 시도해주세요.</option>' );
		}
	});
}

</SCRIPT>
<!-- #include file = "../inc/bottom.asp" -->
<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrList , arrComment
Dim cntList    : cntList    = -1
Dim cntComment : cntComment = -1
Dim cntTotal   : cntTotal   = 0
Dim rows       : rows       = 20
Dim pageNo     : pageNo     = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName   : UserName   = request("UserName")
Dim UserId     : UserId     = request("UserId")
Dim Indate     : Indate     = request("Indate")
Dim Outdate    : Outdate    = request("Outdate")
Dim BoardKey   : BoardKey   = request("BoardKey")
Dim Title      : Title      = request("Title")
Dim tab        : tab        = IIF( request("tab")="",0,request("tab") )
Dim tab2       : tab2       = IIF( request("tab2")="",0,request("tab2") )
dim sstatus    : sstatus    = request("status")

Dim Idx        : Idx        = IIF( request("Idx")="" , 0 , request("Idx") )

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


Call Expires()
Call dbopen()
	Call BoardCodeList()
	BoardKey = IIF( BoardKey="" , BC_FIRST_KEY , BoardKey )
	Call BoardCodeView()
	Call GetList()
Call dbclose()


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
		.CommandText      = "OCEAN_BOARD_CONT_V"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = BoardKey
		.Parameters("@Comment").value  = BoardCodeView_CommentFg
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<style type="text/css">
.Commonbox{clear:both;width:100%;border-bottom:1px solid #dbdbdb;}
.repArea{clear:both;width:100%;}
</style>
<script type="text/javascript">
function del_fm_checkbox(){
	var fm = document.AdminForm;
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
		<%
		If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then 
			Response.write "잘못된 게시판 코드 입니다."
		ElseIf FI_Idx = "" Then 
			Response.write "내용이 없습니다."
		Else 
		%>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="Customer_01<%=IIF(BoardKey="1","_D","")%>_P.asp" enctype="multipart/form-data">
				<input type="hidden" name="actType" value="">
				<input type="hidden" name="Idx" value="<%=FI_Idx%>">
				<input type="hidden" name="UserIdx" value="<%=FI_UserIdx%>">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">
				<input type="hidden" name="tab" value="<%=tab%>">
				<input type="hidden" name="tab2" value="<%=tab2%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%" style="table-layout:fixed">
							<%If BoardKey = "1" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<%=IIF(FI_tab="1","Mobius","")%>
									<%=IIF(FI_tab="2","&CUBE","")%>
									<%=IIF(FI_tab="3","Open Contribution","")%>

									<%=IIF(FI_tab2Name<>""," > " & FI_tab2Name,"")%>
								</td>
							</tr>
							<%elseIf BoardKey = "3" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<%=IIF(FI_tab="1","community 1","")%>
									<%=IIF(FI_tab="2","community 2","")%>
									<%=IIF(FI_tab="3","community 3","")%>

									<%=IIF(FI_tab2Name<>""," > " & FI_tab2Name,"")%>
								</td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">작성자</td>
								<td class="line_box" style="word-break:break-all"><%=FI_ContName%></td>
							</tr>													
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box" style="word-break:break-all"><%=TagDecode( FI_Title )%></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box" style="word-break:break-all" height="300" valign=top><%=FI_Contants%></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">첨부파일</td>
								<td class="line_box" style="word-break:break-all;line-height:200%;">
								<%If BoardKey = "1" Then %>
									<%If FI_File_name <>"" Then %><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name%>"><%=FI_File_name%></a><%End If%>
									<%If FI_File_name2 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name2%>"><%=FI_File_name2%></a><%End If%>
									<%If FI_File_name3 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name3%>"><%=FI_File_name3%></a><%End If%>
									<%If FI_File_name4 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name4%>"><%=FI_File_name4%></a><%End If%>
									<%If FI_File_name5 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name5%>"><%=FI_File_name5%></a><%End If%>
									<%If FI_File_name6 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name6%>"><%=FI_File_name6%></a><%End If%>
									<%If FI_File_name7 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name7%>"><%=FI_File_name7%></a><%End If%>
									<%If FI_File_name8 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name8%>"><%=FI_File_name8%></a><%End If%>
									<%If FI_File_name9 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name9%>"><%=FI_File_name9%></a><%End If%>
									<%If FI_File_name10 <>"" Then %><br><a href="../../common/download.asp?pach=/ocean/upload/keti.ocean.download/&file=<%=FI_File_name10%>"><%=FI_File_name10%></a><%End If%>
								<%else%>
									<a href="../../common/download.asp?pach=/ocean/upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
								<%End If%>
								</td>
							</tr>
							<%If (BoardKey = "1" and FI_tab = "3") or BoardKey = "3" Then 
							statusText = ""
							if FI_status="0" then 
								statusText = IIF(BoardKey="1","게시요청","접수")
							elseif FI_status="1" then 
								statusText = IIF(BoardKey="1","검토중","처리중")
							elseif FI_status="2" then 
								statusText = "완료"
							end if
							%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">진행상황</td>
								<td class="line_box" style="word-break:break-all"><%=statusText%></td>
							</tr>	
							<%end if%>
							
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">등록일</td>
								<td class="line_box" style="word-break:break-all"><%=FI_Indate%></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<a href="Customer_01_W.asp?<%=PageParams%>&Idx=<%=Idx%>"><img src="../img/center_btn_edite.gif"></a>
						<%If BoardCodeView_Replylfg = "1" Then %>
						<a href="Customer_01_W.asp?<%=PageParams%>&Idx=<%=Idx%>&actType=ANS"><img src="../img/center_btn_Replyl.gif"></a>
						<%End If%>
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
						<a href="Customer_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>

			</table>
		<%End If%>
		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->
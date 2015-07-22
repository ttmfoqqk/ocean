<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )

Dim arrListMenu
Dim cntListMenu : cntListMenu  = -1
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )
Dim tab3        : tab3         = IIF( request("tab3")="","all",request("tab3") )
Dim Idx         : Idx          = IIF( request("Idx")="" , 0 , request("Idx") )
Dim pageNo      : pageNo       = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3

If tab1 <> "" And IsNumeric( tab1 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 경로 입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If tab2 <> "" And IsNumeric( tab2 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('잘못된 경로 입니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	Call GetListMenu()
	If cntListMenu >= 0 Then
		tab2 = IIF( tab2=0,arrListMenu(MENU_idx,0),tab2 )
	End If

	Call View()
	call Check()
Call dbclose()

' 3번탭 게시글 읽기 제한
If (FI_status <> "2" and session("UserIdx") <> FI_UserIdx and tab1 = "3") Then
	With Response
	    .Write "<script language='javascript' type='text/javascript'>"
	    .Write "alert('게시완료후 읽기 가능합니다.');"
	    .Write "history.go(-1);"
	    .Write "</script>"
	    .End
	End With
End if

If CHECK_CNT = 0 Then
	onclick = "alert('관리자 승인 후 다운로드가 가능합니다.');return false;"
Else
	onclick = ""
End If

Sub View()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_V"
		.Parameters("@actType").value  = "VIEW"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = 1
		
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub GetListMenu()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_S"
		.Parameters("@Key").value  = 1
		.Parameters("@tab").value  = tab1
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "MENU")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrListMenu = objRs.GetRows()
		cntListMenu = UBound(arrListMenu, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub



Sub Check()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_CHECK"
		.Parameters("@idx").value = IIF( session("UserIdx")="" ,0,session("UserIdx") )
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "CHECK")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title" id="page_title"><!-- script 에서 작성 --></h3>
			
			<%If(tab1="3") Then%>
			<div class="board_tap">
				<a href="../download/?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=all" class="<%=IIF(tab3="all","on","")%>">전체</a>
				<a href="../download/?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=my" class="<%=IIF(tab3="my","on","")%>">나의질문내역</a>
				<a href="../download/?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=<%=tab3%>">질문하기</a>
				<div class="underline"><!-- underline --></div>
			</div>
			<%end if%>
			
			<style type="text/css">
				#board_wrap .cell_title{text-align:left;padding:0px 20px 0px 20px;}
				#board_wrap .cell_cont{text-align:left;padding:0px 0px 0px 20px;}
				#board_wrap a{display:inline-block;width:165px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;vertical-align:top;}
			</style>
			<div id="board_wrap">
				<table cellpadding=0 cellspacing=0 width="100%" class="table_wrap">
					<tr>
						<td class="cell_title" colspan="2"><%=FI_title%></td>
					</tr>
					<tr>
						<td class="cell_cont" style="width:490px;line-height:40px;vertical-align:top;">
							<%=FI_ContName%> | 
							<%=FI_Indate%> | 
							Views <%=FI_Read_cnt%> | 
							<%
							If FI_status = "0" Then
								Response.Write("게시요청")								
							elseif FI_status= "1" Then
								Response.Write("검토중")								
							elseif FI_status= "2" Then
								Response.Write("완료")								
							End if
							%>
						</td>
						<td class="cell_cont">
							<div style="vertical-align:top;margin:10px 0px 10px 0px;">
							<%
							For i=1 to 10
								fileName = ""
								execute("fileName =" & "FI_File_name" & IIF(i=1,"",i) )

								if fileName <> "" then 
									response.Write "File ㅣ <a href=""download.asp?file=" & escape(fileName) & "&idx=" & FI_idx & """ onclick=""" & onclick & """>"& fileName & "</a><br>"
								end if
							Next
							%>
							</div>
						</td>
					</tr>
					<tr>
						<td class="cell_cont" colspan="2">
							<div style="padding:20px 0px 20px 0px;line-height:160%;"><%=FI_Contants%></div>
						</td>
					</tr>
				</table>
				<div class="btn_area">
					<input type="button" class="btn" value="List" onclick="location.href='../download/?<%=PageParams%>'" style="float:left;">
					<%if session("UserIdx") = FI_UserIdx and FI_status = "0" then %>
					<input type="button" class="btn" value="Edit" onclick="location.href='../download/write.asp?<%=PageParams%>&Idx=<%=FI_Idx%>'">
					<%end if%>
				</div>
				
			</div>

		</div>


	</div>
</div>
<SCRIPT type="text/javascript">
$(function(){
	$page_title = $('#page_title');
	$left_menu  = $('#left_menu');
	var left_title = '';
	if( $left_menu.find('ul.sub').find('a.over').length > 0 ){
		left_title = $left_menu.find('ul.sub').find('a.over').text();
	}else{
		left_title = $left_menu.find('a.over').text();
	}
	$page_title.text(left_title);
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
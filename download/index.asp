<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList , arrListMenu
Dim cntList     : cntList     = -1
dim cntTotal    : cntTotal     = 0
Dim cntListMenu : cntListMenu  = -1
Dim rows        : rows         = 10
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )
Dim tab3        : tab3         = IIF( request("tab3")="","all",request("tab3") )
Dim pageNo      : pageNo       = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3

Dim pageUrl 
pageUrl = g_url & "?" & "pageNo=__PAGE__" &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3



If(tab3="write" or tab3="view" or tab3="my") Then
	checkLogin( g_host & g_url )
End if



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
	
	Call GetList1()
Call dbclose()

Sub GetList1()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@Key").value    = 1
		.Parameters("@tab").value    = tab1
		.Parameters("@tab2").value   = tab2
		If(tab3="my") Then
		.Parameters("@UserIdx").value = IIF( session("UserIdx")="" ,0,session("UserIdx") )
		End if
		
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI1")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
		cntTotal = arrList(FI1_tcount, 0)
	End If
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
				<a href="../download/?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=all" class="<%=IIF(tab3="all","on","")%>">All</a>
				<a href="../download/?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=my" class="<%=IIF(tab3="my","on","")%>">My Contribution</a>
				<a href="../download/write.asp?tab1=<%=tab1%>&tab2=<%=tap2%>&tab3=<%=tab3%>">Contribution</a>
				<div class="underline"><!-- underline --></div>
			</div>
			<%end if%>
			
			<div id="board_wrap">

				<table cellpadding=0 cellspacing=0 width="100%" class="table_wrap">
					<tr>
						<td class="cell_title" width="60">번호</td>
						<td class="cell_title">제목</td>
						<td class="cell_title" width="75">등록자</td>
						<td class="cell_title" width="100">등록일자</td>
						<%If(tab1=3) Then%><td class="cell_title" width="85">진행상황</td><%end if%>
					</tr>
					<%for iLoop = 0 to cntList
						onclick = "view.asp?" & PageParams & "&idx=" & arrList(FI1_Idx,iLoop)

						statusTxt = ""

						If arrList(FI1_status,iLoop) = "0" Then
							statusTxt = "게시요청"
						elseif arrList(FI1_status,iLoop) = "1" Then
							statusTxt = "검토중"
						elseif arrList(FI1_status,iLoop) = "2" Then
							statusTxt = "완료"
						End if
					%>
					<tr>
						<td class="cell_cont"><%=arrList(FI1_rownum,iLoop)%></td>
						<td class="cell_cont" style="text-align:left;"><a href="<%=onclick%>"><%=arrList(FI1_Title,iLoop)%></a></td>
						<td class="cell_cont"><a href="<%=onclick%>"><%=arrList(FI1_ContName,iLoop)%></a></td>
						<td class="cell_cont"><a href="<%=onclick%>"><%=arrList(FI1_Indate,iLoop)%></a></td>
						<%If(tab1=3) Then%><td class="cell_cont"><a href="<%=onclick%>"><%=statusTxt%></a></td><%end if%>
					</tr>
					<%Next%>
					<%If cntList < 0 Then %>
					<tr>
						<td class="cell_cont" colspan="5">등록된 내용이 없습니다.</td>
					</tr>
					<%End If%>
				</table>
				<div class="btn_area"></div>
				<div class="page_list_area">
					<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageUrl)%></div>
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
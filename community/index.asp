<!-- #include file = "../inc/header.asp" -->
<%
dim BoardKey : BoardKey  = 3
Dim arrList , arrListMenu 
Dim cntList : cntList  = -1
Dim cntListMenu : cntListMenu  = -1

dim cntTotal : cntTotal = 0
Dim rows     : rows      = 10
Dim idx      : idx       = request("idx")
Dim tab1     : tab1      = IIF( request("tab1")="",1,request("tab1") )
Dim tab2     : tab2      = IIF( request("tab2")="",0,request("tab2") )
Dim tab3     : tab3      = IIF( request("tab3")="","all",request("tab3") )
dim sType    : sType     = request("sType")
dim word     : word      = request("word")
Dim pageNo   : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3 &_
		"&sType" & sType &_
		"&word=" & word

Dim pageUrl 
pageUrl = g_url & "?" & "pageNo=__PAGE__" &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3 &_
		"&sType" & sType &_
		"&word=" & word

If(tab3="my") Then
	checkLogin( g_host & g_url )
End if

If tab1 <> "" And IsNumeric( tab1 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The wrong path.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If tab2 <> "" And IsNumeric( tab2 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The wrong path.');"
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
	
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value   = rows 
		.Parameters("@pageNo").value = pageNo
		.Parameters("@Key").value    = BoardKey
		.Parameters("@tab").value    = tab1
		.Parameters("@tab2").value   = tab2
		If(tab3="my") Then
		.Parameters("@UserIdx").value = IIF( session("UserIdx")="" ,0,session("UserIdx") )
		.Parameters("@adminIdx").value = "0"
		End if
		If (sType="t") Then
		.Parameters("@sTitle").value = 1
		elseif (sType="c") then 
		.Parameters("@sContant").value = 1
		End if
		.Parameters("@sWord").value = word
		
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

Sub GetListMenu()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_S"
		.Parameters("@Key").value  = BoardKey
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

			<div class="board_tap">
				<a href="../Community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=all" class="<%=IIF(tab3="all","on","")%>">All</a>
				<a href="../Community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=my" class="<%=IIF(tab3="my","on","")%>">My question</a>
				<a href="../Community/write.asp?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=<%=tab3%>">Ask a Question</a>
				<div class="underline"><!-- underline --></div>
			</div>

			<div class="board_search">
			<form method="get">
				<input type="hidden" name="tab1" value="<%=tab1%>">
				<input type="hidden" name="tab2" value="<%=tab2%>">
				<input type="hidden" name="tab3" value="<%=tab3%>">
				
				<select name="sType" class="input" style="padding:6px;width:100px;">
					<option value="t" <%=IIF( sType="t","selected","" )%>>Title</option>
					<option value="c" <%=IIF( sType="c","selected","" )%>>Contents</option>
				</select>
				<input name="word" type="text" class="input" value="<%=word%>" style="width:485px;padding:7px;margin-left:5px;">
				<button type="submit" class="btn">Search</button>
			</form>
			</div>

			<div id="board_wrap">

				<table cellpadding=0 cellspacing=0 width="100%" class="table_wrap">
					<tr>
						<td class="cell_title" style="width:60px;">No</td>
						<td class="cell_title">TItle</td>
						<td class="cell_title" style="width:140px;">Name</td>
						<td class="cell_title" style="width:140px;">Date</td>
						<td class="cell_title" style="width:70px;">Status</td>
					</tr>
					<%for iLoop = 0 to cntList
						

						statusTxt = ""

						If arrList(FI_status,iLoop) = "0" Then
							statusTxt = "New"
						elseif arrList(FI_status,iLoop) = "1" Then
							statusTxt = "Inprogress"
						elseif arrList(FI_status,iLoop) = "2" Then
							statusTxt = "Closed"
						End if

						nbsp   = ""
						margin = 0
						If arrList(FI_Depth_no, iLoop) > 0 and tab3="all" Then 
							for Depth = 2 to arrList(FI_Depth_no, iLoop)
								margin = arrList(FI_Depth_no, iLoop) * 10
							Next
							nbsp = nbsp & "<b>└</b>> RE : "
						End If

						if arrList(FI_Dellfg,iLoop) <> "0" then 
							title = "The deleted article"
							onclick = "javascript:alert('The deleted article');"
						else
							title = arrList(FI_Title,iLoop)
							onclick = "view.asp?" & PageParams & "&idx=" & arrList(FI_Idx,iLoop)
						end if
					%>
					<tr>
						<td class="cell_cont"><%=arrList(FI_rownum,iLoop)%></td>
						<td class="cell_cont" style="text-align:left;">
							<div style="margin-left:<%=margin%>px;"><a href="<%=onclick%>"><%= nbsp & title%></a></div>
						</td>
						<td class="cell_cont"><a href="<%=onclick%>"><%=arrList(FI_ContName,iLoop)%></a></td>
						<td class="cell_cont"><a href="<%=onclick%>"><%=arrList(FI_Indate,iLoop)%></a></td>
						<td class="cell_cont"><a href="<%=onclick%>"><%=statusTxt%></a></td>
					</tr>
					<%Next%>
					<%If cntList < 0 Then %>
					<tr>
						<td class="cell_cont" colspan="5">NO DATA</td>
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
	var setIdx = "<%=idx%>";
	$dowunload_list = $('.dowunload_list');
	$dowunload_list.find('a.link').click(function(e){
		e.preventDefault();
		$(this).next().toggle();
		setLeftHeight();
	});

	if(setIdx){
		$dowunload_list.find('a.link[data-idx="'+setIdx+'"]').click();
	}

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
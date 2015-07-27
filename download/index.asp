<!-- #include file = "../inc/header.asp" -->
<%
Dim arrListMenu
Dim cntListMenu : cntListMenu  = -1
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )
Dim tab3        : tab3         = IIF( request("tab3")="","all",request("tab3") )

If (tab3="my") Then
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
Call dbclose()

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
			
			<div class="dowunload_list">
				<div id="board_list"></div>
				<input type="button" class="btn more_button" id="btn_board_more" value="+ MORE">
			</div>

		</div>

		<form name="mForm" id="mForm" method="POST" action="proc.asp" enctype="multipart/form-data">
			<input type="hidden" id="Idx" name="Idx" value="">
			<input type="hidden" id="actType" name="actType" value="DELETE">
			<input type="hidden" id="PageParams" name="PageParams" value="">
		</form>


	</div>
</div>
<script src="../inc/js/board.js"></script>
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

	ajax_board_list([1,'<%=tab1%>','<%=tab2%>','<%=tab3%>'],1,10,'board_list','btn_board_more');
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
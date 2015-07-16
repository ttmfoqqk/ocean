<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList , arrListMenu 
Dim cntList : cntList  = -1
Dim cntListMenu : cntListMenu  = -1
Dim rows     : rows      = 1000
Dim idx      : idx       = request("idx")

Dim tab1     : tab1      = IIF( request("tab1")="",1,request("tab1") )
Dim tab2     : tab2      = IIF( request("tab2")="",0,request("tab2") )

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
		.Parameters("@rows").value = rows 
		.Parameters("@Key").value  = 3
		.Parameters("@tab").value  = tab1
		.Parameters("@tab2").value = tab2
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
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
		.Parameters("@Key").value  = 3
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
		
			<div class="dowunload_list">
				<%for iLoop = 0 to cntList%>
				<div class="block">
					<a href="#" class="link" data-idx="<%=arrList(FI_Idx,iLoop)%>"><%=arrList(FI_Title,iLoop)%> <span class="data"><%=arrList(FI_Indate,iLoop)%></span></a>
					<div class="sub">
						<%If arrList(FI_File_name,iLoop) <>  "" Then%>
						<div class="file">File ㅣ <a href="../common/download.asp?pach=/ocean/upload/Board/&file=<%=arrList(FI_File_name,iLoop)%>"><%=arrList(FI_File_name,iLoop)%></a></div>
						<%End If%>
						<%=arrList(FI_Contants,iLoop)%>
					</div>
				</div>
				<%Next%>

				<%If cntList < 0 Then %>
				<div class="block">
					<span style="margin-left:10px;">등록된 내용이 없습니다.</a>
				</div>
				<%End If%>
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
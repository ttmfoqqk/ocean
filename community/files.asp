<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList , arrListMenu 
Dim cntList : cntList  = -1
Dim cntListMenu : cntListMenu  = -1
Dim rows     : rows      = 1000
Dim idx      : idx       = request("idx")

Call Expires()
Call dbopen()
	Call GetListMenu()
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
		.Parameters("@rows").value     = rows 
		.Parameters("@Key").value      = 4
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
			
			<h3 class="title">자료실</h3>
			
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
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
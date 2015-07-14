<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList , arrList2
Dim cntList : cntList  = -1
Dim cntList2 : cntList2  = -1
Dim rows     : rows      = 1000
Dim idx      : idx       = request("idx")

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
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@Key").value      = 2
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
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Showcase OCEAN</h2>
		
		<!--p class="page_contants">
			<b class="color_green">사물인터넷 활용 사례</b><br>
			<div class="showcase_list">
				<div class="block">
					<img src="../img/icon_showcase_01.png"><br><br>
					TTEO
				</div><div class="block">
					<img src="../img/icon_showcase_02.png"><br><br>
					iThing
				</div><div class="block">
					<img src="../img/icon_showcase_03.png"><br><br>
					DRIoT
				</div><div class="block">
					<img src="../img/icon_showcase_04.png"><br><br>
					KINF
				</div><div class="block">
					<img src="../img/icon_showcase_05.png"><br><br>
					Smart Greenhouse
				</div>
			</div>
		</p-->

		<p class="page_contants">
			<b class="color_green">사물인터넷 관련 동영상</b><br>
			<div class="showcase_player">
				<img src="../img/player_sample.gif" style="margin-top:2px;">
			</div>

			<div class="showcase_player_text">
			The Social Web of Thing <br>
			LG HomeChat
			</div>
		</p>
		<br><br>

		<p class="page_contants">
			<b class="color_green">사물인터넷 활용 사례</b><br>
		</p>

		<div class="dowunload_list">
			<%for iLoop = 0 to cntList%>
			<div class="block">
				<a href="view.asp?idx=<%=arrList(FI_idx,iLoop)%>" class="link"><%=arrList(FI_Title,iLoop)%> <span class="data"><%=arrList(FI_Indate,iLoop)%></span></a>
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

<!-- #include file = "../inc/footer.asp" -->
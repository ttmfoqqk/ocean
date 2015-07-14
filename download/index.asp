<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList1 , arrList2  , arrListMenu
Dim cntList1    : cntList1     = -1
Dim cntList2    : cntList2     = -1
Dim cntListMenu : cntListMenu  = -1
Dim rows        : rows         = 1000
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )

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
	Call Check()
Call dbclose()

Sub GetList1()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value = rows 
		.Parameters("@Key").value  = 1
		.Parameters("@tab").value  = tab1
		.Parameters("@tab2").value = tab2
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI1")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList1 = objRs.GetRows()
		cntList1 = UBound(arrList1, 2)
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
			<h3 class="title">메뉴 타이틀 -> 페이지 작업 요망</h3>
			
			<!--div class="dowunload_tap">
				<div class="tap <%=IIF(tab1="1","on","")%>">
					<a href="../download/?tab1=1" class="m1"><span><b class="color_green">OpenMobius 다운로드</b><br><br>소스코드를 포함한 서버사이드 SW를<br>다운로드할 수 있습니다.</span></a>
				</div><div class="tap <%=IIF(tab1="2","on","")%>">
					<a href="../download/?tab1=2" class="m2"><span><b class="color_green">&Cube 다운로드</b><br><br>소스코드를 포함한 다양한 디바이스용 SW를<br>다운로드 할 수 있습니다.</span></a>
				</div>
			</div-->

			<div class="dowunload_tap2">
			<%for iLoop = 0 to cntListMenu
				%><button class="tap <%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"on","")%>" onclick="location.href='../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>';" style="<%=IIF( ((iLoop+1) Mod 3)=0,"margin-right:0px;","" )%>"><%=arrListMenu(MENU_name,iLoop)%></button><%
			Next%>
			</div>
			
			<div class="dowunload_list">
				<%for iLoop = 0 to cntList1
					onclick = ""
					If session("userIdx") = "" Then
						onclick = "if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')){location.href='../login/?goUrl="& g_host & g_url &"';};return false;"
					Else
						If CHECK_CNT = 0 Then
							onclick = "alert('관리자 승인 후 다운로드가 가능합니다.');return false;"
						Else
							onclick = ""
						End If
					End If 

					
				%>
				<div class="block">
					<a href="#" class="link"><%=arrList1(FI1_Title,iLoop)%> <span class="data"><%=arrList1(FI1_Indate,iLoop)%></span></a>
					<div class="sub">
						
						<table cellpadding="0" cellspacing="0" style="width:100%;">
							<tr>
								<td style="vertical-align:top;padding-bottom:10px;/*width:400px;*/"><%=arrList1(FI1_Contants,iLoop)%></td>
							</tr>
							<tr>
								<td style="vertical-align:top;border-top:1px solid #cdcccc;padding-top:10px;">
									<%If arrList1(FI1_File_name,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name2,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name2,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name2,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name3,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name3,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name3,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name4,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name4,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name4,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name5,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name5,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name5,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name6,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name6,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name6,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name7,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name7,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name7,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name8,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name8,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name8,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name9,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name9,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name9,iLoop),20 )%></a></div><%End If%>
									<%If arrList1(FI1_File_name10,iLoop) <>  "" Then%><div class="file">File ㅣ <a href="download.asp?file=<%=escape(arrList1(FI1_File_name10,iLoop))%>&idx=<%=arrList1(FI1_idx,iLoop)%>" onclick="<%=onclick%>"><%=HtmlTagRemover(arrList1(FI1_File_name10,iLoop),20 )%></a></div><%End If%>
								</td>
							</tr>
						</table>

					</div>
				</div>
				<%Next%>
				<%If cntList1 < 0 Then %>
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
	$dowunload_list = $('.dowunload_list');
	$dowunload_list.find('a.link').click(function(e){
		e.preventDefault();
		$(this).next().toggle();
		setLeftHeight();
	});
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" --><%=Request.ServerVariables("HTTP_USER_AGENT")%>
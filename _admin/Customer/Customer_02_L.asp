<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim UserId   : UserId   = request("UserId")
Dim UserName : UserName = request("UserName")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")

Dim Title    : Title    = request("Title")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )


Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&Title="    & Title

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&Title="    & Title





Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_DOWNLOAD_LOG_L"
		.Parameters("@rows").value    = rows 
		.Parameters("@pageNo").value  = pageNo
		.Parameters("@title").value   = Title
		.Parameters("@id").value      = UserId
		.Parameters("@name").value    = UserName
		.Parameters("@Indate").value  = Indate
		.Parameters("@Outdate").value = Outdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
End Sub
%>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 다운로드 로그 </td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">다운로드 일자</td>
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
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이름</td>
								<td class="line_box"><input type="text" class="input" name="UserName" value="<%=UserName%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">아이디</td>
								<td class="line_box" width="250"><input type="text" class="input" name="UserId" value="<%=UserId%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" class="input" name="Title" value="<%=Title%>"></td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140"><%=IIF( BoardKey="1" , "분류" , " " )%></td>
								<td class="line_box" width="250">
									<%If BoardKey="1" Then%>
									<select name="tab">
										<option value="">선택</option>
										<option value="1" <%=IIF(tab = "1","selected","")%>>Mobius</option>
										<option value="2" <%=IIF(tab = "2","selected","")%>>&CUBE</option>
									</select>
									<%End If%>
								</td>
							</tr>
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
						<form name="AdminForm" method="post" action="Customer_01_P.asp" enctype="multipart/form-data">
						<input type="hidden" name="actType" value="">
						<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50">번호</td>
								<td class="line_box">제목</td>
								<td class="line_box" width="10%">이름</td>
								<td class="line_box" width="10%">ID</td>
								<td class="line_box" width="20%">다운로드 일자</td>
							</tr>
							<%for iLoop = 0 to cntList%>
							<tr height="30" align=center>
								<td class="line_box"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" align=left><%=nbsp & HtmlTagRemover( arrList(FI_Title,iLoop) , 60 )%></td>
								<td class="line_box"><%=arrList(FI_userName,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_userId,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_date,iLoop)%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="5" align=center>등록된 내용이 없습니다.</td>
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
			</table>
		
		</td>
	</tr>

</table>
<!-- #include file = "../inc/bottom.asp" -->
<!-- #include file = "../inc/header.asp" -->
<%
'checkLogin( g_host & g_url )
Dim BoardKey    : BoardKey     = 3

Dim arrList
Dim cntList     : cntList  = -1

Dim arrListMenu
Dim cntListMenu : cntListMenu  = -1
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )
Dim tab3        : tab3         = IIF( request("tab3")="","all",request("tab3") )
dim sType       : sType        = request("sType")
dim word        : word         = request("word")
Dim Idx         : Idx          = IIF( request("Idx")="" , 0 , request("Idx") )
Dim pageNo      : pageNo       = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3 &_
		"&sType" & sType &_
		"&word=" & word

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
	call Check()
	Call GetListMenu()
	If cntListMenu >= 0 Then
		tab2 = IIF( tab2=0,arrListMenu(MENU_idx,0),tab2 )
	End If

	Call View()
Call dbclose()

if FI_Dellfg <> "0" then 
	With Response
		.Write "<script language='javascript' type='text/javascript'>"
		.Write "alert('삭제된 글 입니다.');"
		.Write "history.go(-1);"
		.Write "</script>"
		.End
	End With
end if


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
		.Parameters("@BoardKey").value = BoardKey
		
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")

	'상위글
	set objRs = objRs.NextRecordset
	CALL setFieldIndex(objRs, "PARENT")
	If Not(objRs.Eof or objRs.Bof) Then
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
			
			<div class="board_tap">
				<a href="../community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=all" class="<%=IIF(tab3="all","on","")%>">All</a>
				<a href="../community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=my" class="<%=IIF(tab3="my","on","")%>">My Contribution</a>
				<a href="../community/write.asp?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=<%=tab3%>">Contribution</a>
				<div class="underline"><!-- underline --></div>
			</div>
			
			<style type="text/css">
				#board_wrap{width:100%;overflow:hidden;}
				#board_wrap .cell_title{text-align:left;padding:0px 20px 0px 20px;}
				#board_wrap .cell_cont{text-align:left;padding:0px 20px 0px 20px;}
				#board_wrap .cell_cont .text_wrap{padding:20px 0px 100px 0px;line-height:160%;}
				#board_wrap .cell_cont .text_wrap img{max-width:100%;}
				#board_wrap .file{
					border:1px solid #bfbfbf;
					background-color:#ffffff;
					padding:5px 25px 5px 25px;
					line-height:130%;
				}
				.parent_contents_wrap{
					border-left:1px solid #bfbfbf;
					margin:10px 0px 10px 0px;
					padding:0px 0px 5px 20px;
				}
				.under_line{border-bottom:0px solid #bfbfbf;height:1px;overflow:hidden;}
			</style>
			<form id="mForm" name="mForm" method="POST" action="proc.asp" enctype="multipart/form-data">
				<input type="hidden" name="Idx" value="<%=FI_Idx%>">
				<input type="hidden" name="actType" value="DELETE">
				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
			</form>

			<div id="board_wrap">
				<table cellpadding=0 cellspacing=0 width="100%" class="table_wrap">
					<tr>
						<td class="cell_title"><%=FI_title%></td>
					</tr>
					<tr>
						<td class="cell_cont">
							<%=FI_ContName%> | 
							<%=FI_Indate%> | 
							Views <%=FI_Read_cnt%> | 
							<%
							If FI_status = "0" Then
								Response.Write("접수")
							elseif FI_status= "1" Then
								Response.Write("처리중")
							elseif FI_status= "2" Then
								Response.Write("완료")
							End if
							%>
						</td>
					</tr>
					<tr>
						<td class="cell_cont" style="border:0px;">
							<div class="text_wrap"><%=FI_Contants%></div>
						</td>
					</tr>
					<%
					login_url = g_host & g_url &  "?" & Request.ServerVariables("QUERY_STRING")

					file_html = ""
					For i=1 to 10
						fileName = ""
						execute("fileName =" & "FI_File_name" & IIF(i=1,"",i) )
						if fileName <> "" then 
							if session("UserIdx") = "" then
								file_html = file_html & IIF(file_html="","",", ") & "<a href=""javascript:if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')){go_Login('" & login_url & "');}"">"& fileName & "</a>"
							else
								
								If CHECK_CNT = 0 Then
									file_html = file_html & IIF(file_html="","",", ") & "<a href=""javascript:void(alert('관리자 승인 후 다운로드가 가능합니다.'));"">"& fileName & "</a>"
								else
									file_html = file_html & IIF(file_html="","",", ") & "<a href=""../Community/download.asp?file="& escape(fileName) &"&idx=" & FI_Idx &""">"& fileName & "</a>"
								end if

							end if
						end if
					Next
					if file_html <> "" then 
					%>
					<tr>
						<td class="file">
							File ㅣ <%=file_html%>
						</td>
					</tr>
					<%else%>
					<tr><td class="under_line"><!-- line --></td></tr>
					<%end if%>
					<tr>
						<td>
							 <%
							 ' 상위 글 내용
							for iLoop = 0 to cntList
								temp_file = ""

								For i=1 to 10
									fileName = ""
									execute("fileName =" & "arrList(PARENT_File_name" & IIF(i=1,"",i) &",iLoop)" )

									if fileName <> "" then 
										if session("UserIdx") = "" then
											temp_file = temp_file & IIF(temp_file="","",", ") & "<a href=""javascript:if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')){go_Login('" & login_url & "');}"">"& fileName & "</a>"
										else
											
											If CHECK_CNT = 0 Then
												temp_file = temp_file & IIF(temp_file="","",", ") & "<a href=""javascript:void(alert('관리자 승인 후 다운로드가 가능합니다.'));"">"& fileName & "</a>"
											else
												temp_file = temp_file & IIF(temp_file="","",", ") & "<a href=""../Community/download.asp?file="& escape(fileName) &"&idx=" & arrList(PARENT_Idx,iLoop) &""">"& fileName & "</a>"
											end if

										end if

									end if
								Next
							 
							 %>
							 <div class="parent_contents_wrap">
								<table cellpadding=0 cellspacing=0 width="100%">
									<td class="cell_cont" style="border:0px;">
										<div class="text_wrap"><%=arrList(PARENT_Title,iLoop)%></div>
									</td>
									<%if temp_file <> "" then %>
									<tr>
										<td class="file">
											File ㅣ <%=temp_file%>
										</td>
									</tr>
									<%else%>
									<tr><td class="under_line"><!-- line --></td></tr>
									<%end if%>
								</table>
							<%next
							for iLoop = 0 to cntList
								Response.Write("</div>")
							next 
							%>							
						</td>
					</tr>
				</table>
				<div class="btn_area">
					<input type="button" class="btn_m" value="List" onclick="location.href='../Community/?<%=PageParams%>'" style="float:left;">
					<input type="button" class="btn_m" value="Reply" onclick="location.href='../Community/write.asp?<%=PageParams%>&Idx=<%=FI_Idx%>&actType=ANS'">
					<%if session("UserIdx") = FI_UserIdx and FI_AdminIdx = "0" then %>
					<input type="button" class="btn_m" value="Edit" onclick="location.href='../Community/write.asp?<%=PageParams%>&Idx=<%=FI_Idx%>'">
					<input type="button" class="btn_m" value="Delete" onclick="go_Delete($(this),<%=FI_Idx%>)">
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

function go_Delete(obj,idx){
	obj.addClass('btn_visited');
	if( confirm('Are you sure ?') ){
		$('#mForm').submit();
	}else{
		obj.removeClass('btn_visited');
	}
}

function go_Login(url){
	location.href='../login/?goUrl='+encodeURIComponent(url);
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
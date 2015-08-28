<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = IIF( request("idx")="" , 0 , request("idx") )
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim Title    : Title    = request("Title")
dim position : position = request("position")
dim use      : use      = request("use")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&Title="    & Title &_
		"&position=" & position &_
		"&use="      & use


Call Expires()
Call dbopen()
	Call GetView()
Call dbclose()

Sub GetView()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BANNER_V"
		.Parameters("@idx").value = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%" style="line-height:22px;font-size:15px;">■ <b>팝업관리</b></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 팝업관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form id="AdminForm" name="AdminForm" method="POST" action="Admin_04_P.asp" enctype="multipart/form-data">
				<input type="hidden" id="actType" name="actType" value="<%=IIF( FI_idx="","INSERT" , "UPDATE" )%>">
				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
				<input type="hidden" name="oldFileName" value="<%=FI_image%>">
				<input type="hidden" name="idx" value="<%=FI_idx%>">
				

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">위치</td>
								<td class="line_box">
									<select id="position" name="position">
										<option value="">선택</option>
										<option value="1" <%=IIF(IIF(FI_position = "" ,position ,FI_position) = "1","selected","")%>>왼쪽</option>
										<option value="2" <%=IIF(IIF(FI_position = "" ,position ,FI_position) = "2","selected","")%>>오른쪽</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" id="Title" name="Title" class="input" value="<%=TagDecode( FI_name )%>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">링크 url</td>
								<td class="line_box">
									<input type="text" style="width:100%" id="link" name="link" class="input" value="<%=TagDecode( FI_link )%>">
									<div style="line-height:22px;">http:// 를 포함한 전체 url 주소를 입력해주세요.</div>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">링크 타겟</td>
								<td class="line_box">
									<select id="target" name="target">
										<option value="0" <%=IIF(FI_target = "0","selected","")%>>새창</option>
										<option value="1" <%=IIF(FI_target = "1","selected","")%>>현재창</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">이미지</td>
								<td class="line_box">
									<div>
										<input type="file" id="FileName" name="FileName" class="input">
										<%If FI_image <> "" Then%>
											<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_image%>"><%=FI_image%></a>
											<input type="checkbox" value="1" name="DellFileFg"> 기존파일 삭제
											
											<div style="margin:10px;">
												<%
												images = ""
												Set FSO = Server.CreateObject("DEXT.FileUpload")
													If (FSO.FileExists(BASE_PATH & "upload/Board/s_" & FI_image)) Then
														images = "<img src=""" & BASE_PATH & "upload/Board/s_" & FI_image & """ style=""max-width:300px;"">"
													else
														images = "<img src=""" & BASE_PATH & "upload/Board/" & FI_image & """ style=""max-width:300px;"">"
													End If
												set FSO = Nothing
												%>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_image%>"><%=images%></a>
											</div>

										<%End If%>
									</div>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">사용여부</td>
								<td class="line_box">
									<select id="is_use" name="is_use">
										<option value="0" <%=IIF(FI_is_use = "0","selected","")%>>사용</option>
										<option value="1" <%=IIF(FI_is_use = "1","selected","")%>>비사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">순서</td>
								<td class="line_box"><input type="text" id="order" name="order" class="input" value="<%=IIF(FI_order="","100",FI_order)%>" size="4" maxlength="10"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="submitContents()">
						<a href="Admin_04_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>
				</form>
			</table>

		</td>
	</tr>
</table>
<script type="text/javascript">


function submitContents() {
	if( !$('#position').val() ){
		alert("위치를 선택하세요.");
		return false;
	}
	if( !$('#Title').val() ){
		alert("제목을 입력하세요.");
		return false;
	}
	if( !$('#link').val() ){
		alert("링크 url을 입력하세요.");
		return false;
	}
	if( !$('#target').val() ){
		alert("링크 타겟을 선택하세요.");
		return false;
	}
	if( $('#actType').val()=='INSERT' && !$('#FileName').val() ){
		alert("이미지를 선택하세요.");
		return false;
	}
	if( !$('#is_use').val() ){
		alert("사용여부를 선택하세요.");
		return false;
	}
	$('#AdminForm').submit();	
}
</script>
<!-- #include file = "../inc/bottom.asp" -->
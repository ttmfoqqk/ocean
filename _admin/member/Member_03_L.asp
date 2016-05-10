<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList    , arrList2
Dim cntList    : cntList  = -1
Dim cntList2   : cntList2  = -1
Dim cntTotal   : cntTotal = 0
Dim rows       : rows     = 20
Dim pageNo     : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName   : UserName = request("UserName")
Dim UserId     : UserId   = request("UserId")
Dim Hphone3    : Hphone3  = request("Hphone3")
Dim delFg      : delFg    = request("delFg")
Dim State      : State    = request("State")
Dim ceoFg      : ceoFg    = request("ceoFg")
Dim companyIdx : companyIdx = request("companyIdx")
Dim Indate     : Indate   = request("Indate")
Dim Outdate    : Outdate  = request("Outdate")

Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&UserName="  & UserName &_
		"&UserId="    & UserId &_
		"&Hphone3="   & Hphone3 &_
		"&delFg="     & delFg &_
		"&State="     & State &_
		"&ceoFg="     & ceoFg &_
		"&companyIdx="& companyIdx &_
		"&Indate="    & Indate &_
		"&Outdate="   & Outdate

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&UserName="  & UserName &_
		"&UserId="    & UserId &_
		"&Hphone3="   & Hphone3 &_
		"&delFg="     & delFg &_
		"&State="     & State &_
		"&ceoFg="     & ceoFg &_
		"&companyIdx="& companyIdx &_
		"&Indate="    & Indate &_
		"&Outdate="   & Outdate

Call Expires()
Call dbopen()
	Call GetList()
	Call GetListCO()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@rows").value       = rows 
		.Parameters("@pageNo").value     = pageNo
		.Parameters("@UserName").value   = UserName
		.Parameters("@UserId").value     = UserId
		.Parameters("@Hphone3").value    = Hphone3
		.Parameters("@delFg").value      = delFg
		.Parameters("@State").value      = State
		.Parameters("@companyIdx").value = companyIdx
		.Parameters("@Indate").value     = Indate
		.Parameters("@Outdate").value    = Outdate
		.Parameters("@ceoFg").value      = ceoFg
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub

Sub GetListCO()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "CO")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList2 = objRs.GetRows()
		cntList2 = UBound(arrList2, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<script type="text/javascript">

$(function(){
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=Idx]').attr({"checked":"checked"}) : $('input[name=Idx]').attr({"checked":""});
	});
});


function MaileSend(mode){

	if(mode==0){
		if(!$(':input:checkbox[name=Idx]:checked').val()){
			alert("회원을 선택하세요.");
		}else{
			$('#SelectType').val('sell');
			$('#ListForm').submit();
		}
	}else if(mode==1){
		$('#SelectType').val('all');
		$('#ListForm').submit();
	}
}


</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_04_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 이메일 보내기 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_search.gif"></td>
				</tr>

				<form name="SearchForm" method="get">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">가입일자</td>
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
								<td class="line_box" width="170"><input type="text" class="input" name="UserId" value="<%=UserId%>"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">승인여부</td>
								<td class="line_box">
									<select name="State">
										<option value="">선택</option>
										<option value="0" <%=IIF(State="0","selected","")%>>관리자승인완료</option>
										<option value="2" <%=IIF(State="2","selected","")%>>대표자승인완료</option>
										<option value="1" <%=IIF(State="1","selected","")%>>승인요청</option>
										<option value="3" <%=IIF(State="3","selected","")%>>대표자 인증전</option>
									</select>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">탈퇴여부</td>
								<td class="line_box">
									<select name="delFg">
										<option value="">선택</option>
										<option value="0" <%=IIF(delFg="0","selected","")%>>사용중</option>
										<option value="1" <%=IIF(delFg="1","selected","")%>>탈퇴</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">회사</td>
								<td class="line_box">
									<select name="companyIdx">
										<option value="">선택</option>
										<%for iLoop = 0 to cntList2%>
										<option value="<%=arrList2(CO_idx,iLoop)%>" <%=IIF(companyIdx=CStr(arrList2(CO_idx,iLoop)),"selected","")%>><%=arrList2(CO_cName,iLoop)%></option>
										<%Next%>
									</select>

									<label><input type="checkbox" name="ceoFg" value="1" <%=IIF(ceoFg="1","checked","")%> style="vertical-align:top;"> 대표</label>
								</td>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">휴대폰</td>
								<td class="line_box"><input type="text" class="input" name="Hphone3" value="<%=Hphone3%>" maxlength="30"></td>
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
					<td colspan=2><img src="../img/center_sub_search_data.gif" valign="middle"> [total : <%=cntTotal%>]</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
						<input type="button" class="btn" value=" 선택발송 " onclick="MaileSend(0)" style="width:100px;height:30px;padding:0px;">
						<input type="button" class="btn" value=" 전체발송 " onclick="MaileSend(1)" style="width:100px;height:30px;padding:0px;">
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
					
					
					<form id="ListForm" name="ListForm" method="POST" action="Member_03_W.asp">
					<input type="hidden" id="SelectType" name="SelectType" value="">

					<input type="hidden" name="Indate" value="<%=Indate%>">
					<input type="hidden" name="Outdate" value="<%=Outdate%>">
					<input type="hidden" name="UserName" value="<%=UserName%>">
					<input type="hidden" name="UserId" value="<%=UserId%>">
					<input type="hidden" name="State" value="<%=State%>">
					<input type="hidden" name="delFg" value="<%=delFg%>">
					<input type="hidden" name="companyIdx" value="<%=companyIdx%>">
					<input type="hidden" name="ceoFg" value="<%=ceoFg%>">
					<input type="hidden" name="Hphone3" value="<%=delFg%>">

					<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
					<input type="hidden" name="cntTotal" value="<%=cntTotal%>">

						<table cellpadding=0 cellspacing=0 width="100%" id="memberList">
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="50">번호</td>
								<td class="line_box" width="30">대표</td>
								<td class="line_box" width="13%">가입일자</td>
								<td class="line_box" width="15%">이름</td>
								<td class="line_box">아이디</td>
								<td class="line_box" width="15%">승인여부</td>
								<td class="line_box" width="10%">탈퇴여부</td>
							</tr>
							<%
							Dim PageLink,UserHphone , stateTxt
							for iLoop = 0 to cntList
								PageLink = "openPop(" & arrList(FI_UserIdx, iLoop) & ")"
								

								If arrList(FI_state,iLoop) = "0" Then 
									stateTxt = "관리자승인완료"
								ElseIf arrList(FI_state,iLoop) = "1" Then
									stateTxt = "<font color=red>승인요청</font>"
								ElseIf arrList(FI_state,iLoop) = "2" Then
									stateTxt = "<font color=blue>대표자승인완료</font>"
								ElseIf arrList(FI_state,iLoop) = "3" Then
									stateTxt = "<font color=green>대표자 인증전</font>"
								Else
									stateTxt = ""
								End If
								
								tmp_UserId    = arrList(FI_UserId,iLoop)
								tmp_UserEmail = arrList(FI_UserEmail,iLoop)
								tmp_UserId    = IIF( isValidEmail(tmp_UserId),tmp_UserId, tmp_UserId &"<div style='color:#777777;'>[ "& tmp_UserEmail & " ]</div> " )
							%>
							<tr height="30" align=center>
								<td class="line_box" width="50"><input type="checkbox" name="Idx" value="<%=arrList(FI_UserIdx, iLoop)%>"></td>
								<td class="line_box"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box"><%=IIF( arrList(FI_ceo,iLoop)="1" , "v" , "" )%></td>
								<td class="line_box"><%=arrList(FI_UserIndate,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_UserName,iLoop) &" "& arrList(FI_UserNameLast,iLoop)%></td>
								<td class="line_box" style="text-align:left;padding-left:10px;"><%=tmp_UserId%></td>
								<td class="line_box"><%=stateTxt%></td>
								<td class="line_box"><%=IIF( arrList(FI_UserDelFg,iLoop)="0","사용중","<font color=red>탈퇴</font>" )%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>등록된 회원이 없습니다.</td>
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
				<tr><td height="20"></td></tr>
			</table>

		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->
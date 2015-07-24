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
function openPop(user_idx){
	if(!user_idx){
		alert("회원을 선택해주세요.");return false;
	}
	pop_loading()
	var html_btn_write = '<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick=chec_fm()>';
	var html_btn_dell = ' <img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick=del_fm()>';
	var html_btn_area = html_btn_write + html_btn_dell;

	var html_txt = '' +
		
		'<div class="admin_popup" id="admin_popup">' +
		'<form name="fm" method="POST" action="Member_01_P.asp">' +
		'<input type="hidden" name="actType" value="UPDATE">'+
		'<input type="hidden" name="user_idx" value="'+user_idx+'">'+
		
		'<input type="hidden" name="pageNo" value="<%=pageNo%>">' +
		'<input type="hidden" name="sUserName" value="<%=UserName%>">' +
		'<input type="hidden" name="sUserId" value="<%=UserId%>">' +
		'<input type="hidden" name="sHphone3" value="<%=Hphone3%>">' +
		'<input type="hidden" name="sIndate" value="<%=Indate%>">' +
		'<input type="hidden" name="sOutdate" value="<%=Outdate%>">' +
		'<input type="hidden" name="sState" value="<%=State%>">' +
		'<input type="hidden" name="sdelFg" value="<%=delFg%>">' +
		'<input type="hidden" name="scompanyIdx" value="<%=companyIdx%>">' +
		'<input type="hidden" name="sceoFg" value="<%=ceoFg%>">' +

		'<input type="hidden" id="user_id_hidden" name="user_id_hidden">' +

			'<div class="top_area">' +
				'<div class="title"><img src="../img/pop/title_member.gif"></div>' +
				'<div class="close"><a href="#">[닫기]</a></div>' +
			'</div>' +
			'<div class="cont">' +
				'<table cellpadding=0 cellspacing=0 width=100%>'+
					'<tr height=28>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">가입일자</td>'+
						'<td class="line_box" id="user_date"></td>'+
					'</tr>'+
					'<tr height=28>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">이름</td>'+
						'<td class="line_box" id="user_name" name="user_name"></td>'+
					'</tr>'+
					'<tr height=28>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">아이디</td>'+
						'<td class="line_box" id="user_id" name="user_id"></td>'+
					'</tr>'+
					'<tr height=28>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">새 비밀번호</td>'+
						'<td class="line_box"><input type="password" id="user_pass" name="user_pass" class="input"> ※변경시 작성</td>'+
					'</tr>'+
					'<tr height=28>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">새 비밀번호 확인</td>'+
						'<td class="line_box"><input type="password" id="user_pass_ch" name="user_pass_ch"  class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">회사명</td>'+
						'<td class="line_box">'+
							'<select id="user_companyIdx" name="user_companyIdx" style="width:300px;"></select>' +
							' <label><input type="checkbox" id="user_ceoFg" name="user_ceoFg" value="1" style="vertical-align:top;"> 대표</label>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">부서/직위</td>'+
						'<td class="line_box">'+
							'<input type="text" id="user_position" name="user_position" class="input" style="width:300px;ime-mode:active;" maxlength="100">' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">휴대폰</td>'+
						'<td class="line_box">'+
							'<input type="text" id="user_hphone" name="user_hphone" maxlength=50 class="input" size=50>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">전화</td>'+
						'<td class="line_box">'+
							'<input type="text" id="user_phone" name="user_phone" maxlength=50 class="input" size=50>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">비고</td>'+
						'<td class="line_box"><textarea id="user_bigo" name="user_bigo" style="width:100%;height:80px;"></textarea></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">승인여부</td>'+
						'<td class="line_box">'+
							'<input type="hidden" id="user_state_old" name="user_state_old">' +
							'<select id="user_state" name="user_state"><option value="0">관리자승인완료</option><option value="2">대표자승인완료</option><option value="1">승인요청</option><option value="3">대표자 인증전</option></select>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">탈퇴여부</td>'+
						'<td class="line_box">'+
							'<select id="user_delFg" name="user_delFg"><option value="0">사용중</option><option value="1">탈퇴</option></select>' +
						'</td>'+
					'</tr>'+
				'</table>'+
			'</div>' +
			'<div class="btn_area">' + html_btn_area + '</div>' +
		'</form>'+
		'</div>';
		

	$('body').append(html_txt);
	$('#admin_popup .close a').click(function(e){
		e.preventDefault();
		layerPopupClose('wall','admin_popup');
	});
		
	layerPopupOpen('wall',10,'admin_popup',20);

	$.ajax({
		type: "POST",
		dataType: "xml",
		url: "MEMBER_01_V.asp",
		data: {
			user_idx : user_idx
		} ,
		success: function(xml){
			var admin_login = $(xml).find("admin_login").text();
			if(admin_login=='login'){
				alert('로그인 세션 만료!');location.reload();return false;
			}
			
			var coHtml = '<option value="">선택</option>';
			$(xml).find("data").find("coCode").each(function(idx) {
				var coIdx  = $(this).find("idx").text();
				var coName = $(this).find("cName").text();

				coHtml += '<option value="'+coIdx+'">'+coName+'</option>';
			});
			$('#user_companyIdx').html(coHtml);


			if ($(xml).find("data").find("item").length > 0) {
				$(xml).find("data").find("item").each(function(idx) {

					var UserIdx         = $(this).find("UserIdx").text();
					var UserId          = $(this).find("UserId").text();
					var UserName        = $(this).find("UserName").text();
					var UserNameLast    = $(this).find("UserNameLast").text();
					var UserHPhone      = $(this).find("UserHPhone").text();
					var UserPhone       = $(this).find("UserPhone").text();
					var UserEmail       = $(this).find("UserEmail").text();
					var UserIndate_full = $(this).find("UserIndate_full").text();
					var UserOutdate     = $(this).find("UserOutdate").text();
					var UserDelFg       = $(this).find("UserDelFg").text();
					var UserBigo        = $(this).find("UserBigo").text();
					var UserState       = $(this).find("state").text();
					var companyIdx      = $(this).find("companyIdx").text();
					var ceoFg           = $(this).find("ceoFg").text();
					var UserPosition    = $(this).find("UserPosition").text();


					$('#user_date').text( UserIndate_full );
					$('#user_name').text( UserName + ' ' + UserNameLast );
					$('#user_id').text( UserId +' '+ ( UserEmail==''?'':' [ '+UserEmail+' ] ' ) );
					$('#user_id_hidden').val(UserId);
					$('#user_hphone').val( UserHPhone );
					$('#user_phone').val( UserPhone );
					$('#user_mail').val( UserEmail );

					$('#user_bigo').val( UserBigo );
					$("#user_delFg > option[value = " + UserDelFg + "]").attr("selected", "ture");
					$("#user_state > option[value = " + UserState + "]").attr("selected", "ture");
					$("#user_companyIdx > option[value = " + companyIdx + "]").attr("selected", "ture");

					
					$('#user_state_old').val(UserState);

					
					$('#user_position').val( UserPosition );
					
					if( ceoFg == '1' ){
						$('#user_ceoFg').attr("checked", "ture");
					}					
				});
			}
			layerPopupClose('wall_loading','pop_loading');
		},error:function(err){
			alert('ERR [502] : 고객센터에 문의하세요.' + err.responseText);
			layerPopupClose('wall_loading','pop_loading');
		}
	});
}

function chec_fm(){
	var fm = document.fm;
	
	if( trim( $('#user_pass').val() ) || trim( $('#user_pass_ch').val() ) ){
		if( trim( $('#user_pass').val() ) != trim( $('#user_pass_ch').val() ) ){
			alert("변경할 비밀번호를 확인해주세요.");return false;
		}
		if(confirm("새로운 비밀번호로 수정 하시겠습니까?")){
			fm.actType.value = "UPDATE";
			fm.submit();
			$('.btn_area').html("처리중입니다.");
		}
	}else{
		if(confirm("수정 하시겠습니까?")){
			fm.actType.value = "UPDATE";
			fm.submit();
			$('.btn_area').html("처리중입니다.");
		}
	}
}
function del_fm(){
	var fm = document.fm;
	if(confirm("탈퇴 처리 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
		$('.btn_area').html("처리중입니다.");
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
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 회원관리 </td>
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
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2>
					
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
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
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_rownum,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=IIF( arrList(FI_ceo,iLoop)="1" , "v" , "" )%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_UserIndate,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=arrList(FI_UserName,iLoop) &" "& arrList(FI_UserNameLast,iLoop)%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand;text-align:left;padding-left:10px;"><%=tmp_UserId%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=stateTxt%></td>
								<td class="line_box" onclick="<%=PageLink%>" style="cursor:hand"><%=IIF( arrList(FI_UserDelFg,iLoop)="0","사용중","<font color=red>탈퇴</font>" )%></td>
							</tr>
							<%next%>
							<%if cntList < 0 then%>
							<tr>
								<td height="30" class="line_box" colspan="8" align=center>등록된 회원이 없습니다.</td>
							</tr>
							<%end if%>
						</table>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2><%=printPageList(cntTotal, pageNo, rows, pageURL)%></td>
				</tr>
			</table>

		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->
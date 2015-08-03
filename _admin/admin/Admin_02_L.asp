<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList
Dim cntList   : cntList   = -1
Dim cntTotal  : cntTotal  = 0
Dim rows      : rows      = 20
Dim pageNo    : pageNo    = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim AdminId   : AdminId   = request("AdminId")
Dim AdminName : AdminName = request("AdminName")
Dim Indate    : Indate    = request("Indate")
Dim Outdate   : Outdate   = request("Outdate")
Dim pageURL
pageURL	= g_url & "?pageNo=__PAGE__" &_
		"&amp;AdminId="   & AdminId &_
		"&amp;AdminName=" & AdminName &_
		"&amp;Indate="    & Indate &_
		"&amp;Outdate="   & Outdate

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
		.CommandText      = "OCEAN_ADMIN_MEMBER_L"
		.Parameters("@rows").value      = rows 
		.Parameters("@pageNo").value    = pageNo
		.Parameters("@AdminId").value   = AdminId
		.Parameters("@AdminName").value = AdminName
		.Parameters("@Indate").value    = Indate
		.Parameters("@Outdate").value   = Outdate
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)	' 첫번째에서 행에서 전체 건수 설정.
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>

<script type="text/javascript">

function openPop(mode,admin_Idx){
	var html_btn_write = '<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick=chec_fm()>';
	var html_btn_dell = '<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick=del_fm()>';
	var html_btn_area = html_btn_write;
	var html_input_readonly='';
	if(mode == 'UPDATE'){
		html_btn_area += html_btn_dell;
		html_input_readonly = 'readonly';
	}
	var html_txt = '' +
		
		'<div class="admin_popup" id="admin_popup">' +
		'<form name="fm" method="POST" action="Admin_02_P.asp">' +
		'<input type="hidden" name="actType" value="'+mode+'"><input type="hidden" name="admin_idx" value="'+admin_Idx+'"><input type="hidden" name="pageNo" value="<%=pageNo%>">' +

			'<div class="top_area">' +
				'<div class="title"><img src="../img/pop/title_admin_member.gif"></div>' +
				'<div class="close"><a href="#">[닫기]</a></div>' +
			'</div>' +
			'<div class="cont">' +
				'<table cellpadding=0 cellspacing=0 width=100%>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0" width="115">ID</td>'+
						'<td class="line_box"><input type="text" id="admin_id" name="admin_id" class="input" '+html_input_readonly+'></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">비밀번호</td>'+
						'<td class="line_box"><input type="password" id="admin_pass" name="admin_pass" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">비밀번호 확인</td>'+
						'<td class="line_box"><input type="password" id="admin_pass_ch" name="admin_pass_ch" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">이름</td>'+
						'<td class="line_box"><input type="text" id="admin_name" name="admin_name" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">전화번호</td>'+
						'<td class="line_box">'+
							'<select id="admin_phone1" name="admin_phone1" style="width:70px;"></select> - ' +
							'<input type="text" id="admin_phone2" name="admin_phone2" maxlength=4 class="input" size=4> - ' +
							'<input type="text" id="admin_phone3" name="admin_phone3" maxlength=4 class="input" size=4>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">핸드폰</td>'+
						'<td class="line_box">'+
							'<select id="admin_hphone1" name="admin_hphone1" style="width:70px;"></select> - ' +
							'<input type="text" id="admin_hphone2" name="admin_hphone2" maxlength=4 class="input" size=4> - ' +
							'<input type="text" id="admin_hphone3" name="admin_hphone3" maxlength=4 class="input" size=4>' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">내선번호</td>'+
						'<td class="line_box"><input type="text" id="admin_ext" name="admin_ext" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">직통번호</td>'+
						'<td class="line_box"><input type="text" id="admin_dir" name="admin_dir" class="input"></td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">E-Mail</td>'+
						'<td class="line_box">'+
							'<input type="text" id="admin_mail1" name="admin_mail1" class="input" size=10>@'+
							'<input type="text" id="admin_mail3" name="admin_mail3" class="input" size=12 style="display:none"> '+
							'<select id="admin_mail2" name="admin_mail2" style="width:150px;"></select>' +
							'<input type="checkbox" name="email_write"> 직접입력' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">메신저</td>'+
						'<td class="line_box">'+
							'<input type="text" id="admin_msg1" name="admin_msg1" class="input" size=10>@'+
							'<input type="text" id="admin_msg3" name="admin_msg3" class="input" size=12 style="display:none"> '+
							'<select id="admin_msg2" name="admin_msg2" style="width:150px;"></select>' +
							'<input type="checkbox" name="msg_write"> 직접입력' +
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">커뮤니티</td>'+
						'<td class="line_box" style="line-height:180%;">'+
							'<span style="display:inline-block;width:50%;">'+
								'<input type="checkbox" name="cumunity_tab" id="cumunity_tab1" value="1" style="vertical-align:middle;"> <label for="cumunity_tab1">Device Dev</label>'+
							'</span>'+
							'<span style="display:inline-block;width:50%;">'+
								'<input type="checkbox" name="cumunity_tab" id="cumunity_tab2" value="2" style="vertical-align:middle;"> <label for="cumunity_tab2">Server Dev</label>'+
							'</span>'+
							'<span style="display:inline-block;width:50%;">'+
								'<input type="checkbox" name="cumunity_tab" id="cumunity_tab3" value="3" style="vertical-align:middle;"> <label for="cumunity_tab3">Application Dev</label>'+
							'</span>'+
						'</td>'+
					'</tr>'+
					'<tr>' +
						'<td class="line_box" align=right bgcolor="f0f0f0">비고</td>'+
						'<td class="line_box"><textarea id="admin_bigo" name="admin_bigo" style="width:100%;height:80px;"></textarea></td>'+
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
	$('#admin_mail2').change(function(e){
		$('#admin_mail3').val( $(this).val() );
	});
	$('#admin_msg2').change(function(e){
		$('#admin_msg3').val( $(this).val() );
	});
	$('input[name=email_write]').click(function(e){
		$(this).attr('checked') == true ? $('#admin_mail3').css({"display":""}) : $('#admin_mail3').css({"display":"none"});
	});
	$('input[name=msg_write]').click(function(e){
		$(this).attr('checked') == true ? $('#admin_msg3').css({"display":""}) : $('#admin_msg3').css({"display":"none"});
	});


	layerPopupOpen('wall',10,'admin_popup',20);

	getCodeAdd_combobox('#admin_phone1','<%=fc_code_list(9)%>','','','선택');
	getCodeAdd_combobox('#admin_hphone1','<%=fc_code_list(10)%>','','','선택');
	getCodeAdd_combobox('#admin_mail2','<%=fc_code_list(11)%>','','','선택');
	getCodeAdd_combobox('#admin_msg2','<%=fc_code_list(12)%>','','','선택');

	if(mode == 'UPDATE'){
		pop_loading()
		$.ajax({
			type: "POST",
			dataType: "xml",
			url: "ADMIN_02_V.asp",
			data: {
				Idx : admin_Idx
			} ,
			success: function(xml){
				var admin_login = $(xml).find("admin_login").text();
				if(admin_login=='login'){
					alert('로그인 세션 만료!');location.reload();return false;
				}
				if ($(xml).find("data").find("item").length > 0) {
					$(xml).find("data").find("item").each(function(idx) {

						$('#admin_id').val( $(this).find("admin_id").text() );
						$('#admin_pass').val( $(this).find("admin_pwd").text() );
						$('#admin_pass_ch').val( $(this).find("admin_pwd").text() );
						$('#admin_name').val( $(this).find("admin_name").text() );
						$("#admin_phone1 > option[value = " + $(this).find("admin_phone1").text() + "]").attr("selected", "ture");
						$('#admin_phone2').val( $(this).find("admin_phone2").text() );
						$('#admin_phone3').val( $(this).find("admin_phone3").text() );
						$("#admin_hphone1 > option[value = " + $(this).find("admin_hphone1").text() + "]").attr("selected", "ture");
						$('#admin_hphone2').val( $(this).find("admin_hphone2").text() );
						$('#admin_hphone3').val( $(this).find("admin_hphone3").text() );
						$('#admin_ext').val( $(this).find("admin_ext").text() );
						$('#admin_dir').val( $(this).find("admin_dir").text() );
						$('#admin_mail1').val( $(this).find("admin_mail1").text() );
						$("#admin_mail2 > option[value = " + $(this).find("admin_mail2").text() + "]").attr("selected", "ture");
						$('#admin_mail3').val( $(this).find("admin_mail2").text() );
						$('#admin_msg1').val( $(this).find("admin_msg1").text() );
						$("#admin_msg2 > option[value = " + $(this).find("admin_msg2").text() + "]").attr("selected", "ture");
						$('#admin_msg3').val( $(this).find("admin_msg2").text() );
						$('#admin_bigo').val( $(this).find("admin_bigo").text() );

						var permission = $(this).find("permission");
						permission.each(function(){
							$('input[name="cumunity_tab"][value="' + $(this).text() + '"]').attr({"checked":"checked"});
						});
						
						if( !$('#admin_mail2').val() ){
							$('input[name=email_write]').attr({"checked":"checked"});
							$('#admin_mail3').css({"display":""});
						}
						if( !$('#admin_msg2').val() ){
							$('input[name=msg_write]').attr({"checked":"checked"});
							$('#admin_msg3').css({"display":""});
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
}

function chec_fm(){
	var fm = document.fm;
	if( !trim( $('#admin_id').val() ) ){
		alert('아이디를 입력하세요.');return false;
	}
	if( !trim( $('#admin_pass').val() ) ){
		alert('비밀번호를 입력하세요.');return false;
	}
	if( !trim( $('#admin_pass_ch').val() ) ){
		alert('비밀번호 확인을 입력하세요.');return false;
	}
	if( trim( $('#admin_pass').val() ) != trim( $('#admin_pass_ch').val() ) ){
		alert('비밀번호를 확인해주세요.');return false;
	}
	if( !trim( $('#admin_phone1').val() ) || !trim( $('#admin_phone2').val() ) || !trim( $('#admin_phone3').val() ) ){
		alert('전화번호를 입력해주세요.');return false;
	}
	if( !trim( $('#admin_hphone1').val() ) || !trim( $('#admin_hphone2').val() ) || !trim( $('#admin_hphone3').val() ) ){
		alert('핸드폰 번호를 입력해주세요.');return false;
	}
	$('.btn_area').html("처리중입니다.");
	fm.submit();
}
function del_fm(){
	var fm = document.fm;
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
		$('.btn_area').html("처리중입니다.");
	}
}
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if( $(":checkbox[name='check_idx']:checked").length==0 ){
		alert("삭제할 항목을 하나이상 체크해주세요.");
		return;
	}
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
	}
}

$(document).ready( function() {
	
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=check_idx]').attr({"checked":"checked"}) : $('input[name=check_idx]').attr({"checked":""});
	});
} );
</script>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>

		<form name="AdminForm" method="post" action="Admin_02_P.asp">
		<input type="hidden" name="actType" value="">
		
			<table cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_01_02.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 사원관리</td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_01_02.gif"></td>
				</tr>
				<tr>
					<td colspan=2>
						<table cellpadding=0 cellspacing=0 width="100%" >
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="12%">ID</td>
								<td class="line_box" width="15%">이름</td>
								<td class="line_box" width="15%">연락처</td>
								<td class="line_box">이메일</td>
								<td class="line_box" width="15%">메신저</td>
								<td class="line_box" width="15%">내선번호</td>
								<td class="line_box" width="15%">정보수정</td>
							</tr>
							<%for iLoop = 0 to cntList%>
							<tr height="30" align=center>
								<td class="line_box"><input type="checkbox" name="check_idx" value="<%=arrList(FI_AdminIdx,iLoop)%>"></td>
								<td class="line_box"><%=arrList(FI_Id,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_AdminName,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_Hphone1,iLoop)&"-"&arrList(FI_Hphone2,iLoop)&"-"&arrList(FI_Hphone3,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_Email,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_MsgAddr,iLoop)%></td>
								<td class="line_box"><%=arrList(FI_ExtNum,iLoop)%></td>
								<td class="line_box"><img src="../img/center_btn_edite_Admin.gif" style="cursor:pointer;" onclick="openPop('UPDATE','<%=arrList(FI_AdminIdx, iLoop)%>')"></td>
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
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="openPop('INSERT','')"> &nbsp;&nbsp;
						<img src="../img/center_btn_delete.gif" style="cursor:pointer;" onclick="del_fm_checkbox()">
					</td>
				</tr>
			</table>
		
		</form>

		</td>
	</tr>
</table>
<!-- #include file = "../inc/bottom.asp" -->
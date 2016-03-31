<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim arrList2
Dim cntList2   : cntList2  = -1

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
pageURL	= "&UserName="  & UserName &_
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
	Call GetListCO()
Call dbclose()


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
	cllList(1);
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=Idx]').attr({"checked":"checked"}) : $('input[name=Idx]').attr({"checked":""});
	});
});


function cllList(pageNo){
	
	$('#memberListPage').html('<div style="width:100%;line-height:40px;text-align:center;color:#777777;font:bold;font-size:17px;border:2px solid #dddddd;">페이지 로딩중입니다</div>');

	$.ajax({
		type: "GET",
		dataType: "xml",
		url: "ajax.member.list.asp",
		data: {
			 pageNo     : pageNo
			,UserName   : '<%=UserName%>'
			,UserId     : '<%=UserId%>'
			,Hphone3    : '<%=Hphone3%>'
			,delFg      : '<%=delFg%>'
			,State      : '<%=State%>'
			,ceoFg      : '<%=ceoFg%>'
			,companyIdx : '<%=companyIdx%>'
			,Indate     : '<%=Indate%>'
			,Outdate    : '<%=Outdate%>'
		} ,
		success: function(xml){
			var admin_login = $(xml).find("admin_login").text();
			var PageListNum = $(xml).find("PageListNum").text();
			if(admin_login=='login'){
				alert('로그인 세션 만료!');location.reload();return false;
			}

			if ($(xml).find("data").find("item").length > 0) {
				var html = '';

				$(xml).find("data").find("item").each(function(idx) {
					var UserIdx    = $(this).find("UserIdx").text();
					var rownum     = $(this).find("rownum").text();
					var ceo        = $(this).find("ceo").text();
					var UserIndate = $(this).find("UserIndate").text();
					var UserName   = $(this).find("UserName").text();
					var UserId     = $(this).find("UserId").text();
					var stateTxt   = $(this).find("stateTxt").text();
					var UserDelFg  = $(this).find("UserDelFg").text();

					html += '' +
					'<tr height="30" align=center>'+
						'<td class="line_box" width="50"><input type="checkbox" name="Idx" value="'+UserIdx+'"></td>'+
						'<td class="line_box" width="30">'+ceo+'</td>'+
						'<td class="line_box" width="13%">'+UserIndate+'</td>'+
						'<td class="line_box" width="15%">'+UserName+'</td>'+
						'<td class="line_box">'+UserId+'</td>'+
						'<td class="line_box" width="15%">'+stateTxt+'</td>'+
						'<td class="line_box" width="10%">'+UserDelFg+'</td>'+
					'</tr>';
				});
				$('#memberList').append(html);
				
				if (PageListNum >0){
					$('#memberListPage').html('<div style="width:100%;line-height:40px;text-align:center;color:617bff;font:bold;font-size:17px;border:2px solid #dddddd;cursor:pointer" onclick="cllList('+PageListNum+')">더보기</div>');
				}else{
					$('#memberListPage').html('<div style="width:100%;line-height:40px;text-align:center;color:#777777;font:bold;font-size:17px;border:2px solid #dddddd;">내용이 없습니다.</div>');
				}
			}else{

				$('#memberListPage').html('<div style="width:100%;line-height:40px;text-align:center;color:#777777;font:bold;font-size:17px;border:2px solid #dddddd;">내용이 없습니다.</div>');
			}
		},error:function(err){
			alert('ERR [502] : 고객센터에 문의하세요.' + err.responseText);
			$('#memberListPage').html('<div style="width:100%;line-height:40px;text-align:center;color:#777777;font:bold;font-size:17px;border:2px solid #dddddd;">오류</div>');
		}
	});
}


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
					<td colspan=2><img src="../img/center_sub_search_data.gif"></td>
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

						<table cellpadding=0 cellspacing=0 width="100%" id="memberList">
							<tr height="30" align=center bgcolor="f0f0f0">
								<td class="line_box" width="50"><input type="checkbox" name="check_all"></td>
								<td class="line_box" width="30">대표</td>
								<td class="line_box" width="13%">가입일자</td>
								<td class="line_box" width="15%">이름</td>
								<td class="line_box">아이디</td>
								<td class="line_box" width="15%">승인여부</td>
								<td class="line_box" width="10%">탈퇴여부</td>
							</tr>
						</table>
					</form>


					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr><td id="memberListPage" colspan="2"></td></tr>
				<tr><td height="20"></td></tr>
			</table>

		</td>
	</tr>
</form>
</table>
<!-- #include file = "../inc/bottom.asp" -->
<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim SelectType   : SelectType   = request("SelectType")
Dim Idx        : Idx      = request("Idx")
Dim UserName   : UserName = request("UserName")
Dim UserId     : UserId   = request("UserId")
Dim Hphone3    : Hphone3  = request("Hphone3")
Dim delFg      : delFg    = request("delFg")
Dim State      : State    = request("State")
Dim ceoFg      : ceoFg    = request("ceoFg")
Dim companyIdx : companyIdx = request("companyIdx")
Dim Indate     : Indate   = request("Indate")
Dim Outdate    : Outdate  = request("Outdate")
Dim PageParams : PageParams = URLDecode(request("PageParams"))
Dim cntTotal   : cntTotal   = request("cntTotal")

dim cntIdx : cntIdx = split(Idx,",")

if SelectType = "all" then 
	cntIdx = cntTotal
elseif SelectType = "sell" then
	cntIdx = ubound(cntIdx)+1
end if

%>

<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form id="fm" name="fm" method="post" action="Member_03_P.asp">
				<input type="hidden" name="SelectType" value="<%=SelectType%>">
				<input type="hidden" name="Idx" value="<%=Idx%>">
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

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">선택 수신자</td>
								<td class="line_box"><%=cntIdx%>명</td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">발송자</td>
								<td class="line_box"><input type="text" style="width:100%" id="mailFrom" name="mailFrom" class="input" value="OCEAN<no-reply@iotocean.org>" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" id="Title" name="Title" class="input" value="" maxlength="200"></td>
							</tr>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box">
									<textarea name="Contants" id="Contants" style="width:100%;height:300px;display:none;"></textarea>
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2 id="btnDiv">
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="Send()">
						<a href="Member_03_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
</form>
</table>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contants",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});


function Send(){
	if( !$.trim($('#mailFrom').val()) ){
		alert("발송자를 입력하세요.");return false;
	}
	if( !$.trim($('#Title').val()) ){
		alert("제목을 입력하세요.");return false;
	}
	oEditors.getById["Contants"].exec("UPDATE_CONTENTS_FIELD", []);
	var html = "처리 중입니다.";
	$('#btnDiv').html(html);
	
	$('#fm').submit();
}

</script>
<!-- #include file = "../inc/bottom.asp" -->
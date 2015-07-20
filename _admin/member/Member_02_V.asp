<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)

Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim idx      : idx      = request("idx")
Dim cName    : cName    = request("cName")
Dim sano     : sano     = request("sano")
Dim ceo      : ceo      = request("ceo")
Dim State    : State    = request("State")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&cName="   & cName &_
		"&sano="    & sano &_
		"&ceo="     & ceo &_
		"&State="   & State &_
		"&Indate="  & Indate &_
		"&Outdate=" & Outdate


Call Expires()
Call dbopen()
	Dim optionCountry : optionCountry = setCodeOption( 13  , "select" , 0 , "" )
	Dim optionCStaff  : optionCStaff  = setCodeOption( 14  , "select" , 0 , "" )

	Call GetList()
Call dbclose()

addr = IIF( FI_addr="",FI_addr1 & " " & FI_addr2 , FI_addr )


Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_V"
		.Parameters("@idx").value      = idx
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>

<script type="text/javascript">
function del_fm_checkbox(){
	var fm = document.AdminForm;
	if(confirm("삭제 하시겠습니까?")){
		fm.actType.value = "DELETE";
		fm.submit();
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
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > 멤버사관리 </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				

				<form id="AdminForm" name="AdminForm" method="POST" action="Member_02_P.asp" enctype="multipart/form-data">
				<input type="hidden" name="idx" id="idx" value="<%=IIF( FI_idx="","0" , FI_idx )%>">
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , "UPDATE" )%>">
				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed">
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">업체명(상호)</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cName" name="cName" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_cName%>">
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">국가</td>
								<td class="line_box" style="word-break:break-all">
									<select class="input" id="Country" name="Country">
										<option value="">국가</option>
										<%=optionCountry%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140" style="height:40px;">주소</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="text" id="addr" name="addr" class="input" style="width:100%;ime-mode:active;" value="<%=addr%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">상시종업원수</td>
								<td class="line_box" style="word-break:break-all">
									<select class="input" id="cStaff" name="cStaff">
										<option value="">상시종업원수</option>
										<%=optionCStaff%>
									</select>
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">대표전화</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cPhone" name="cPhone" class="input" style="width:100%;ime-mode:active;" maxlength="50" value="<%=FI_cPhone%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">홈페이지</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="text" id="homepage" name="homepage" class="input" style="width:100%;ime-mode:disabled;" maxlength="200" value="<%=FI_homepage%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">사업분야</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<label><input type="checkbox" name="business1" value="1" class="business_check" <%=IIF(FI_business1="1","checked","")%>> LED</label>
									<label><input type="checkbox" name="business2" value="1" class="business_check" <%=IIF(FI_business2="1","checked","")%>> 전기·전자</label>
									<label><input type="checkbox" name="business3" value="1" class="business_check" <%=IIF(FI_business3="1","checked","")%>> 조선해양</label>
									<label><input type="checkbox" name="business4" value="1" class="business_check" <%=IIF(FI_business4="1","checked","")%>> 정보통신</label>
									
									<br>

									<label><input type="checkbox" name="business5" value="1" class="business_check" <%=IIF(FI_business5="1","checked","")%>> 나노·신소재</label>
									<label><input type="checkbox" name="business6" value="1" class="business_check" <%=IIF(FI_business6="1","checked","")%>> 기계·자동차 부품소재</label>
									<label><input type="checkbox" name="business7" value="1" class="business_check" <%=IIF(FI_business7="1","checked","")%>> 바이오·제약</label>
									<label><input type="checkbox" name="business8" value="1" class="business_check" <%=IIF(FI_business8="1","checked","")%>> 섬유·화학</label>
									<br>

									<label><input type="checkbox" name="business9" value="1" class="business_check" <%=IIF(FI_business9="1","checked","")%>> 식품생명</label>
									<label><input type="checkbox" name="business10" value="1" class="business_check" <%=IIF(FI_business10="1","checked","")%>> 건축·토목</label>
									<label><input type="checkbox" name="business11" value="1" class="business_check" <%=IIF(FI_business11="1","checked","")%>> 녹색에너지</label>
									<label><input type="checkbox" name="business12" value="1" class="business_check" <%=IIF(FI_business12="1","checked","")%>> 기타</label>
									<br><br>

									<input type="text" id="business" name="business" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_business%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">회사로고</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="file" id="files2" name="files2">
									<%If FI_files2<>"" Then %>
									<a href="../../common/download.asp?pach=/ocean/upload/Board/&file=<%=FI_files2%>"><%=FI_files2%></a>
									<input type="checkbox" value="1" name="DellFileFg2"> 기존파일 삭제
									<%End If%>
									<input type="hidden" name="oldFileName2" value="<%=FI_files2%>">
								</td>
							</tr>

							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">탈퇴여부</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<select id="State" name="State">
										<option value="">선택</option>
										<option value="0" <%=IIF(FI_State="0","selected","")%>>사용중</option>
										<option value="1" <%=IIF(FI_State="1","selected","")%>>탈퇴</option>
									</select>
								</td>
							</tr>

						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2 class="btn_area">
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="checkJoin()">
						<a href="Member_02_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
					</td>
				</tr>
				</form>
			</table>

		</td>
	</tr>

</table>
<SCRIPT type="text/javascript">
var $idx      = $('#idx');

function checkJoin(){
	if( !$.trim( $('#cName').val() ) ){
		alert('업체명을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#Country').val() ) ){
		alert('국가를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#addr').val() ) ){
		alert('주소를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cPhone').val() ) ){
		alert('대표전화를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#homepage').val() ) ){
		alert('홈페이지를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cStaff').val() ) ){
		alert('상시종업원수를 입력하세요.');
		return false;
	}
	if( $('.business_check:checked').length <= 0 ){
		alert('사업분야를 1개이상 선택해주세요.');
		return false;
	}
	if( $('input[name="business12"]:checked').length > 0 && !$.trim( $('#business').val() ) ){
		alert('사업분야 기타 내용을 입력해주세요.');
		return false;
	}
	$('.btn_area').html('처리 중입니다.');
	$('#AdminForm').submit();
}




function openDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
			//document.getElementById('post1').value = data.postcode1;
			//document.getElementById('post2').value = data.postcode2;
			//document.getElementById('addr').value = data.address;
			//전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
			//아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
			var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
			document.getElementById('addr1').value = addr;
			document.getElementById('addr2').focus();
		}
	}).open();
}
</SCRIPT>
<!-- #include file = "../inc/bottom.asp" -->
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
	Call GetList()
Call dbclose()


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
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">대표자</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="ceo" name="ceo" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_ceo%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">사업자등록번호</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="sano" name="sano" class="input" style="width:100%;ime-mode:disabled;" maxlength="10" value="<%=FI_sano%>">
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">설립일</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cDate" name="cDate" class="input" style="width:100%;" maxlength="10" readonly value="<%=FI_cDate%>" onclick="callCalendar(AdminForm.cDate);">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140" style="height:40px;">주소</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="text" id="addr1" name="addr1" class="input" style="width:100%;ime-mode:active;" maxlength="100" readonly onclick="openDaumPostcode()" value="<%=FI_addr1%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140" style="height:40px;">상세주소</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="text" id="addr2" name="addr2" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_addr2%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">기업 규모</td>
								<td class="line_box" style="word-break:break-all">
									<label><input type="radio" name="cScale" value="1" <%=IIF(FI_cScale="1","checked","")%> checked> 대기업</label>
									<label><input type="radio" name="cScale" value="2" <%=IIF(FI_cScale="2","checked","")%>> 중소기업</label>
									<label><input type="radio" name="cScale" value="3" <%=IIF(FI_cScale="3","checked","")%>> 기관</label>
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">대표전화</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cPhone" name="cPhone" class="input" style="width:100%;ime-mode:active;" maxlength="50" value="<%=FI_cPhone%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">업종</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cSectors" name="cSectors" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_cSectors%>">
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">홈페이지</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="homepage" name="homepage" class="input" style="width:100%;ime-mode:disabled;" maxlength="200" value="<%=FI_homepage%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">주생산품목</td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cItems" name="cItems" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_cItems%>">
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">전년도매출액<br><span style="font-size:12px;">(단위: 백만원)</span></td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cSales" name="cSales" class="input" style="width:100%;ime-mode:disabled;" maxlength="50" value="<%=FI_cSales%>">
								</td>
							</tr>
							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">상시종업원수<br><span style="font-size:12px;">(단위: 명)</span></td>
								<td class="line_box" style="word-break:break-all">
									<input type="text" id="cStaff" name="cStaff" class="input" style="width:100%;ime-mode:active;" maxlength="50" value="<%=FI_cStaff%>">
								</td>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">연구소</td>
								<td class="line_box" style="word-break:break-all">
									<label><input type="radio" name="cCenter" value="1" <%=IIF(FI_cCenter="1","checked","")%> checked> 유</label>
									<label><input type="radio" name="cCenter" value="2" <%=IIF(FI_cCenter="2","checked","")%>> 무</label>
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
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">사물인터넷 사업분야</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<label><input type="checkbox" name="iot_business1" value="1" class="iot_business_check" <%=IIF(FI_iot_business1="1","checked","")%>> 사물인터넷 플랫폼</label>
									<label><input type="checkbox" name="iot_business2" value="1" class="iot_business_check" <%=IIF(FI_iot_business2="1","checked","")%>> 연구 및 용역개발</label>
									<label><input type="checkbox" name="iot_business3" value="1" class="iot_business_check" <%=IIF(FI_iot_business3="1","checked","")%>> 사물인터넷 서비스</label>
									<label><input type="checkbox" name="iot_business4" value="1" class="iot_business_check" <%=IIF(FI_iot_business4="1","checked","")%>> 기술 및 경영자문</label>
									<br>
									<label><input type="checkbox" name="iot_business5" value="1" class="iot_business_check" <%=IIF(FI_iot_business5="1","checked","")%>> 사물인터넷 기기 및 제품</label>
									<label><input type="checkbox" name="iot_business6" value="1" class="iot_business_check" <%=IIF(FI_iot_business6="1","checked","")%>> 기타</label>
									<br><br>
									<input type="text" id="iot_business" name="iot_business" class="input" style="width:100%;ime-mode:active;" maxlength="100" value="<%=FI_iot_business%>">
								</td>
							</tr>

							<tr>
								<td class="line_box" align="left" bgcolor="f0f0f0" width="140">사업자등록증</td>
								<td class="line_box" style="word-break:break-all" colspan="3">
									<input type="file" id="files1" name="files1" >
									<%If FI_files1<>"" Then %>
									<a href="../../common/download.asp?pach=/ocean/upload/Board/&file=<%=FI_files1%>"><%=FI_files1%></a>
									<input type="checkbox" value="1" name="DellFileFg1"> 기존파일 삭제
									<%End If%>
									<input type="hidden" name="oldFileName1" value="<%=FI_files1%>">
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
var $userSaNo = $('#sano');
var $idx      = $('#idx');



var member_msg = {
	'userSaNo' : {
		'm0' : '사용 가능한 사업자 등록번호 입니다.',
		'm1' : '사업자 등록번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '숫자 10자 가능합니다.',
		'm4' : '현재 사용중인 사업자 등록번호 입니다.'
	},
	'err' : '일시적인 장애입니다. 잠시 후 다시 시도해 주세요.'
};


var checkFormUserSaNo = function( fg , remote ){
	var _alert = $userSaNo.next();
	var v      = $userSaNo.val();
	var c      = checkInputValue( v , 'sano' );

	_alert.show();

	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userSaNo.m'+c) );
		if(fg){
			alert( eval('member_msg.userSaNo.m'+c) );
		}
		return false;
	}
	if(remote){
		var idx  = $idx.val()
		var ajax = ajaxSanoCheck( v , _alert.find('div') , fg , idx );
	}else{
		_alert.hide();
		return true;
	}
}

var $ajaxSanoCheck = false;
var ajaxSanoCheck = function( value , obj , fg , idx ){
	$.ajax({
		type    : 'GET',
		url     : '../../inc/ajax.member.check.asp',
		data    : 'actType=sano&search='+value+'&idx='+idx ,
		dataType: 'text',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(text){
			if(text > 0){
				obj.attr('class','color_red').text( member_msg.userSaNo.m4 );
				if(fg){
					alert( member_msg.userSaNo.m4 );
				}
				$ajaxSanoCheck = false;
				return false;
			}else{
				obj.attr('class','color_blue').text( member_msg.userSaNo.m0 );
				$ajaxSanoCheck = true;
				return true;
			}
		},error:function(err){
			obj.attr('class','color_red').text( member_msg.err );
			alert( member_msg.err );
			$ajaxSanoCheck = false;
			//alert(err.responseText) 
			return false;
			//alert(err.responseText) 
			obj.text( member_msg.err );
		}
	});
}

var checkInputValue = function( value , reg ){
	var l = value.length;
	if( l == 0 ){
		return 1;
	}
	var t = CheckReg( 'space' , value );
	if( !t ){
		return 2;
	}
	t = CheckReg( reg , value );
	if( !t ){
		return 3;
	}
	return 0;
}

var _reg_space = /^([^\s])*$/;
var _reg_sano  = /^[0-9]{10}$/;

function CheckReg(m,str) {
	var reg = eval('_reg_'+m);
	return (reg.test(str));
}


$(function(){
	checkFormUserSaNo('',true);
	$userSaNo.focus(function(){
		$(this).next().show();
	}).blur(function(){
		checkFormUserSaNo('',true);
	}).keyup(function(){
		checkFormUserSaNo('',true);
	});
});


function checkJoin(){
	if( !$.trim( $('#cName').val() ) ){
		alert('업체명을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#ceo').val() ) ){
		alert('대표자를 입력하세요.');
		return false;
	}
	var userSaNo = checkFormUserSaNo(true,false);
	if( !userSaNo ){$userSaNo.focus();return false;}

	if(!$ajaxSanoCheck){
		alert(member_msg.userSaNo.m4);
		return false;
	}
	if( !$.trim( $('#cDate').val() ) ){
		alert('설립일을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#addr1').val() ) ){
		alert('주소를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#addr2').val() ) ){
		alert('상세주소를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#addr2').val() ) ){
		alert('상세주소를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cPhone').val() ) ){
		alert('대표전화를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cSectors').val() ) ){
		alert('업종을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#homepage').val() ) ){
		alert('홈페이지를 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cItems').val() ) ){
		alert('주생산품목을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#cSales').val() ) ){
		alert('전년도매출액을 입력하세요.');
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
	if( $('.iot_business_check:checked').length <= 0 ){
		alert('사물인터넷 사업분야를 1개이상 선택해주세요.');
		return false;
	}
	if( $('input[name="iot_business6"]:checked').length > 0 && !$.trim( $('#iot_business').val() ) ){
		alert('사물인터넷 사업분야 기타 내용을 입력해주세요.');
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
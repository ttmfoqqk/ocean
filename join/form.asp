<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )
Call Expires()
Call dbopen()
	Dim optionEmail : optionEmail = setCodeOption( 11  , "select" , 1 , "" )
	Dim optionPhone : optionPhone = setCodeOption( 10  , "select" , 1 , "" )
	Call Check()
Call dbclose()

If FI_CNT > 0 Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('맴버사 신청이 완료되었습니다.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Sub Check()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_CHECK"
		.Parameters("@sano").value = session("UserSano")
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap" style="border-bottom:2px solid #999a9d;padding-bottom:40px;">
			<h3 class="title"><span class="color_green">OCEAN</span> 멤버사 가입 신청서</h3>
			<p>
				간단한 정보만 입력하시면<br>
				OCEAN의 다양한 서비스를 바로 이용하실 수 있습니다.
			</p>
		</div>
		<STYLE type="text/css">
			td.label{width:127px;height:60px;font-size:14px;}
			td.cont{width:343px;}
			td.cont2{width:813px;}
			

			.form_wrap{width:100%;border-bottom:1px solid #999a9d;padding-bottom:10px;text-align:center;margin-top:10px;}
			.form_wrap .table{width:940px;margin:0px auto;text-align:left;}
			.form_wrap .row{margin:0px;}
		</STYLE>
		<form name="mForm" id="mForm" method="post" action="form_proc.asp" enctype="multipart/form-data" onsubmit="return checkJoin()">
		<input type="hidden" name="goUrl" value="<%=request("goUrl")%>">
		
		<div class="form_wrap">
			<table cellpadding="0" cellspacing="0" class="table" align="center">
				<tr>
					<td class="label">업체명(상호)<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cName" name="cName" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
					<td class="label">대표자<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="ceo" name="ceo" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">사업자등록번호<span class="color_red">*</span></td>
					<td class="cont" style="font-size:14px;"><%=session("UserSano")%></td>
					<td class="label">설립일<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cDate" name="cDate" class="input" style="width:300px;" maxlength="10" readonly>
						</div>
					</td>
				</tr>
				<tr>
					<td class="label" style="height:40px;">주소<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="addr1" name="addr1" class="input" style="width:300px;ime-mode:active;" maxlength="100" readonly onclick="openDaumPostcode()">
						</div>
					</td>
					<td class="label" style="height:40px;"> </td>
					<td class="cont">
						 
					</td>
				</tr>
				<tr>
					<td class="label" style="height:40px;">상세주소<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="addr2" name="addr2" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
					<td class="label" style="height:40px;"> </td>
					<td class="cont">
						 
					</td>
				</tr>
				<tr>
					<td class="label">기업 규모<span class="color_red">*</span></td>
					<td class="cont">
						<div class="radio_wrap">
							<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="1" checked></span></span>
							<label><b>대기업</b></label>
						</div>&nbsp;&nbsp;&nbsp;
						<div class="radio_wrap">
							<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="2"></span></span>
							<label><b>중소기업</b></label>
						</div>&nbsp;&nbsp;&nbsp;
						<div class="radio_wrap">
							<span name="_radio" class="off"><span class="blind"><input type="radio" name="cScale" value="3"></span></span>
							<label><b>기관</b></label>
						</div>
					</td>
					<td class="label">대표전화<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cPhone" name="cPhone" class="input" style="width:300px;ime-mode:active;" maxlength="50" >
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">업종<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cSectors" name="cSectors" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
					<td class="label">홈페이지<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="homepage" name="homepage" class="input" style="width:300px;ime-mode:disabled;" maxlength="200" >
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">주생산품목<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cItems" name="cItems" class="input" style="width:300px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
					<td class="label">전년도매출액<span class="color_red">*</span><br><span style="font-size:12px;">(단위: 백만원)</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cSales" name="cSales" class="input" style="width:300px;ime-mode:disabled;" maxlength="50" >
						</div>
					</td>
				</tr>
				<tr>
					<td class="label">상시종업원수<span class="color_red">*</span><br><span style="font-size:12px;">(단위: 명)</span></td>
					<td class="cont">
						<div class="row">
							<input type="text" id="cStaff" name="cStaff" class="input" style="width:300px;ime-mode:active;" maxlength="50" >
						</div>
					</td>
					<td class="label">연구소<span class="color_red">*</span></td>
					<td class="cont">
						<div class="radio_wrap">
							<span name="_radio" class="off"><span class="blind"><input type="radio" name="cCenter" value="1" checked></span></span>
							<label><b>유</b></label>
						</div>&nbsp;&nbsp;&nbsp;
						<div class="radio_wrap">
							<span name="_radio" class="off"><span class="blind"><input type="radio" name="cCenter" value="2"></span></span>
							<label><b>무</b></label>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="form_wrap">
			<table cellpadding="0" cellspacing="0" class="table" align="center">
				<tr>
					<td class="label">사업분야<span class="color_red">*</span></td>
					<td class="cont2">
						<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business1" class="business_check" value="1"></span></span>
							<label><b>LED</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business2" class="business_check" value="1"></span></span>
							<label><b>전기·전자</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business3" class="business_check" value="1"></span></span>
							<label><b>조선해양</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business4" class="business_check" value="1"></span></span>
							<label><b>정보통신</b></label>
						</div>
						<br><br>

						<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business5" class="business_check" value="1"></span></span>
							<label><b>나노·신소재</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business6" class="business_check" value="1"></span></span>
							<label><b>기계·자동차 부품소재</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business7" class="business_check" value="1"></span></span>
							<label><b>바이오·제약</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business8" class="business_check" value="1"></span></span>
							<label><b>섬유·화학</b></label>
						</div>
						<br><br>

						<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business9" class="business_check" value="1"></span></span>
							<label><b>식품생명</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business10" class="business_check" value="1"></span></span>
							<label><b>건축·토목</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business11" class="business_check" value="1"></span></span>
							<label><b>녹색에너지</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="business12" class="business_check" value="1"></span></span>
							<label><b>기타</b></label>
						</div>
						<br><br>

						<div class="row">
							<input type="text" id="business" name="business" class="input" style="width:770px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="form_wrap">
			<table cellpadding="0" cellspacing="0" class="table" align="center">
				<tr>
					<td class="label">사물인터넷<br>사업분야<span class="color_red">*</span></td>
					<td class="cont2">
						<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business1" class="iot_business_check" value="1"></span></span>
							<label><b>사물인터넷 플랫폼</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business2" class="iot_business_check" value="1"></span></span>
							<label><b>연구 및 용역개발</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business3" class="iot_business_check" value="1"></span></span>
							<label><b>사물인터넷 서비스</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business4" class="iot_business_check" value="1"></span></span>
							<label><b>기술 및 경영자문</b></label>
						</div>
						<br><br>

						<div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business5" class="iot_business_check" value="1"></span></span>
							<label><b>사물인터넷 기기 및 제품</b></label>
						</div><div class="checkbox_wrap" style="width:25%;display:inline-block;zoom:1;*display:inline;_display:inline;">
							<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="iot_business6" class="iot_business_check" value="1"></span></span>
							<label><b>기타</b></label>
						</div>
						<br><br>

						<div class="row">
							<input type="text" id="iot_business" name="iot_business" class="input" style="width:770px;ime-mode:active;" maxlength="100" >
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="form_wrap">
			<table cellpadding="0" cellspacing="0" class="table" align="center">
				<tr>
					<td class="label">사업자등록증<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="file" id="files1" name="files1" class="input" style="width:300px;">
						</div>
					</td>
					<td class="label">회사로고<span class="color_red">*</span></td>
					<td class="cont">
						<div class="row">
							<input type="file" id="files2" name="files2" class="input" style="width:300px;">
						</div>
					</td>
				</tr>
				<tr>
					<td> </td>
					<td colspan="3" style="font-size:11px;color:#000000;line-height:160%;">
						사용 가능한 첨부파일 확장자는 gif, jpg, jpeg, zip, egg, doc, docx, txt, alz, rar, png, bmp 입니다.<br>
						오류 문의시 브라우저명, 버전과 구체적 상황 또는 캡쳐화면을 첨부해주시면 신속하고 정확한 답변이 가능합니다.<br>
						파일의 크기가 3MB를 초과하거나 2개 이상의 파일을 첨부하실 경우 spweb@naver.com 으로 보내주시기 바랍니다. <br>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="margin:30px;line-height:40px;" class="btn_area">
			<button type="submit" class="btn">멤버신청 완료</button>
		</div>

		</form>



	</div>
</div>

<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
function checkJoin(){
	if( !$.trim( $('#cName').val() ) ){
		alert('업체명을 입력하세요.');
		return false;
	}
	if( !$.trim( $('#ceo').val() ) ){
		alert('대표자를 입력하세요.');
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
	if( !$.trim( $('#files1').val() ) ){
		alert('사업자등록증을 등록해주세요.');
		return false;
	}
	if( !$.trim( $('#files2').val() ) ){
		alert('회사로고를 등록해주세요.');
		return false;
	}
	$('.btn_area').html('처리 중입니다.');
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

$(function() {
  $( "#cDate" ).datepicker({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    dayNames: ['일','월','화','수','목','금','토'],
    dayNamesShort: ['일','월','화','수','목','금','토'],
    dayNamesMin: ['일','월','화','수','목','금','토'],
    showMonthAfterYear: true,
    yearSuffix: '년',
	changeMonth : true,
	changeYear : true,
	showOtherMonths:true,
	selectOtherMonths: true
  });
});
</SCRIPT>

<!-- #include file = "../inc/footer.asp" -->
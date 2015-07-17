<!-- #include file = "../inc/header.asp" -->
<%
Dim agree : agree = request("agree")
Dim length : length = Split(agree,",")
Dim agree1 : agree1 = 1
Dim agree2 : agree2 = 1

Dim arrList
Dim cntList : cntList  = -1

For i=0 To ubound(length)
	If Trim(length(i)) = "agree1" Then 
		agree1= 0
	End If
	If Trim(length(i)) = "agree2" Then 
		agree2= 0
	End If
Next

If agree1 <> 0 Or agree2 <> 0 Then
	Response.redirect "../join/"
End If

Call Expires()
Call dbopen()
	Dim optionCountry : optionCountry = setCodeOption( 13  , "select" , 1 , "" )
	Dim optionCStaff : optionCStaff   = setCodeOption( 14  , "select" , 1 , "" )

	Call GetList()

Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		.Parameters("@CHECK").value = 0
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap" style="border-bottom:2px solid #999a9d;padding-bottom:40px;">
			<h3 class="title"><span class="color_green">간단한 절차</span>로 가입하실 수 있습니다.</h3>
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
			.form_wrap .table{width:660px;margin:0px auto;text-align:left;}
			.form_wrap .row{width:660px;margin:0px auto;margin-bottom:15px;}
			.form_wrap h3{font-size:20px;font-family:ng,'NanumGothic';color:#777777;margin-bottom:20px;}
			.form_wrap h4{font-size:16px;font-family:ng,'NanumGothic';color:#777777;margin-bottom:20px;text-align:left;margin-left:10px;}
			
			.form_wrap .row label{
				float:none;
				width:auto;
				font-size:14px;
				color:#85868a;
				margin-left:5px;
			}
			input[type=checkbox]{
				vertical-align:middle;
			}
			
			
		</STYLE>
		
		
		<form name="mForm" id="mForm" method="post" action="join_proc.asp" enctype="multipart/form-data" onsubmit="return checkJoin()">
		<div class="form_wrap">
			<h3>Business account Information</h3>

			<div class="row">
				<input type="text" id="userId" name="userId" class="input" style="width:95%;ime-mode:disabled;" maxlength="255" placeholder="Company Email ( User Account )">
			</div>
			<div class="row">
				<input type="password" id="userPwd" name="userPwd" class="input" style="width:95%;" maxlength="20" placeholder="Create your password">
			</div>
			<div class="row">
				<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:95%;" maxlength="20" placeholder="Confirm password">
			</div>
			<div class="row">
				<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
					<input type="text" class="input" id="FirstName" name="FirstName" maxlength="30" style="width:90%;ime-mode:active;" placeholder="First Name">
				</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
					<input type="text" class="input" id="LastName" name="LastName" maxlength="30" style="width:90%;ime-mode:active;" placeholder="Last Name">
				</div>
			</div>

			<div class="row">
				<input type="text" id="userPosition" name="userPosition" class="input" style="width:95%;ime-mode:active;" maxlength="100" placeholder="Department/Position">
			</div>
			<div class="row">
				<input type="text" id="userhPhone" name="userhPhone" maxlength="4" class="input" style="width:95%;" placeholder="Mobile. No">
			</div>
			<div class="row">
				<input type="text" id="userPhone" name="userPhone" maxlength="4" class="input" style="width:95%;" placeholder="Tel. No">
			</div>
			<div class="row">
				<input type="hidden" id="companyName" name="companyName">
				<select class="input" id="companySelect" name="companySelect" style="width:80%;height:32px;padding:5px;">
					<option value="">Company</option>
					<%for iLoop = 0 to cntList%>
					<option value="<%=arrList(FI_idx,iLoop)%>"><%=arrList(FI_cName,iLoop)%></option>
					<%Next%>
					<option value="NEW">Other Company</option>
				</select>
				<input type="button" class="btn" id="companyCreate" style="width:15%;height:32px;margin-left:15px;" value="NEW">
			</div>
		</div>
		
		<div id="company_input" style="display:none;margin-top:20px;">
			<div class="form_wrap">
				<h3>Company Information</h3>

				<div class="row">
					<input type="text" id="cName" name="cName" class="input" style="width:95%;ime-mode:active;" maxlength="100" placeholder="Company Name">
				</div>
				<div class="row">
					<select class="input" id="Country" name="Country" style="width:98%;height:32px;padding:5px;">
						<option value="">Country</option>
						<%=optionCountry%>
					</select>
				</div>
				<div class="row">
					<input type="text" id="addr" name="addr" class="input" style="width:95%;ime-mode:active;" maxlength="100" placeholder="Office Address">
				</div>

				<div class="row">
					<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
						<input type="text" class="input" id="companyPhone" name="companyPhone" maxlength="30" style="width:90%;ime-mode:active;" placeholder="Tel. No">
					</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
						<input type="text" class="input" id="homepage" name="homepage" maxlength="30" style="width:90%;ime-mode:active;" placeholder="WebSite ( http:// )">
					</div>
				</div>

				<div class="row">
					<select class="input" id="cStaff" name="cStaff" style="width:98%;height:32px;padding:5px;">
						<option value="">Number of Company Employees</option>
						<%=optionCStaff%>
					</select>
				</div>

				<div class="row">
					<h4>Business Field</h4>
				</div>

				<div class="row round" style="width:645px;">
					<div class="row" style="text-align:left;width:100%;">
						
						<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
							<div style="margin:10px;">
								<div>
									<input type="checkbox" id="business1" name="business1" class="business_check" value="1" >
									<label for="business1">LED</label>
								</div>
								<div>
									<input type="checkbox" id="business5" name="business5" class="business_check" value="1">
									<label for="business5">Nano-Materials</label>
								</div>
								<div>
									<input type="checkbox" id="business7" name="business7" class="business_check" value="1">
									<label for="business7">Bio-Pharmaceutical</label>
								</div>
								<div>
									<input type="checkbox" id="business10" name="business10" class="business_check" value="1">
									<label for="business10">Construction-Civil Engineering</label>
								</div>
								<div>
									<input type="checkbox" id="business3" name="business3" class="business_check" value="1">
									<label for="business3">Ship Building</label>
								</div>
								<div>
									<input type="checkbox" id="business9" name="business9" class="business_check" value="1">
									<label for="business9">Food and Life</label>
								</div>
							</div>

						</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
							
							<div style="margin:10px;">
								<div>
									<input type="checkbox" id="business2" name="business2" class="business_check" value="1">
									<label for="business2">Electrical Electronics</label>
								</div>
								<div>
									<input type="checkbox" id="business4" name="business4" class="business_check" value="1">
									<label for="business4">Information and Communication</label>
								</div>
								<div>
									<input type="checkbox" id="business8" name="business8" class="business_check" value="1">
									<label for="business8">Textile-Chemical</label>
								</div>
								<div>
									<input type="checkbox" id="business11" name="business11" class="business_check" value="1">
									<label for="business11">Green Energy</label>
								</div>
								<div>
									<input type="checkbox" id="business6" name="business6" class="business_check" value="1">
									<label for="business6">Mechanical Car Parts and Material</label>
								</div>
								<div>
									<input type="checkbox" id="business12" name="business12" class="business_check" value="1" onclick="$('#business').focus();">
									<label for="business12" >etc.(
										<input type="text" id="business" name="business" style="width:180px;ime-mode:active;border:0px;vertical-align:middle;" maxlength="100" >
									)</label>
								</div>
							</div>

						</div>


					</div>

					
				</div>

				<!-- 파일 스크립트 추가 -->
				<div class="row">
					<input type="file" id="files2" name="files2" style="width:1px;height:1px;overflow:hidden;" onchange="$('#files2_text').val( $(this).val() );">
					<input type="text" id="files2_text" class="input" style="width:77%;" placeholder="Company Logo Image File ( jpg, bmp, gif, png )" readonly onclick="$('#files2').click();">
					<input type="button" class="btn" style="width:15%;height:32px;margin-left:15px;" value="SEARCH" onclick="$('#files2').click();">
				</div>


			</div>

			

			<div class="form_wrap">
				<div class="row" style="margin-top:20px;">
					<textarea name="other_information" class="input" style="width:95%;height:100px;" placeholder="Share additional Information"></textarea>
				</div>
			</div>






		</div>

		<div style="margin:30px;line-height:40px;" class="btn_area">
			<button type="submit" class="btn">REGISTER</button>
		</div>

		</form>



	</div>
</div>

<SCRIPT type="text/javascript">
$(function(){
	$('#companyCreate').click(function(){
		$('#companySelect').val('NEW').change();
	});
	$('#companySelect').change(function(){
		var v = $(this).val();
		var t = $('#companySelect option:selected').text();
		if(v == 'NEW'){
			$('#company_input').show();
			$('#companyName').val( '' );
		}else{
			$('#company_input').hide();
			$('#companyName').val( t );
		}
		setLeftHeight();
	});
});

var $ajaxIdCheck = false;
var ajaxIdCheck = function( value ){
	$.ajax({
		type    : 'GET',
		url     : '../inc/ajax.member.check.asp',
		data    : 'actType=id&search='+value ,
		dataType: 'text',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(text){
			if(text > 0){
				$ajaxIdCheck = false;
			}else{
				$ajaxIdCheck = true;
			}
		},error:function(err){
			//alert(err.responseText)
		}
	});
}

$userId = $('#userId');
$userId.blur(function(){
	ajaxIdCheck($(this).val());
}).keyup(function(){
	ajaxIdCheck($(this).val());
});

function checkJoin(){
	var data = [
		 ['userId','length','아이디를 입력해 주시기 바랍니다.']
		,['userId','mail','이메일 형식이 틀렸습니다.']
		,['userPwd','length','비밀번호를 입력해 주시기 바랍니다.']
		,['userPwd','pwd','비밀번호는 6~20자까지 가능합니다.']
		,['userPwdConfirm','length','비밀번호 확인을 입력해 주시기 바랍니다.']
		,['userPwdConfirm','confirm','비밀번호와 동일하게 입력해 주시기 바랍니다.','userPwd']
		,['FirstName','length','First Name 을 입력해 주시기 바랍니다.']
		,['LastName','length','Last Name 을 입력해 주시기 바랍니다.']
		,['userPosition','length','부서/직위를 입력해 주시기 바랍니다.']
		,['userhPhone','length','휴대전화 번호를 입력해 주시기 바랍니다.']
		,['userPhone','length','전화 번호를 입력해 주시기 바랍니다.']
		,['companySelect','length','회사명을 선택해주세요.']
	];
	var dataCo = [
		 ['cName','length','업체명을 입력해 주시기 바랍니다.']
		,['Country','length','Country를 선택해주세요.']
		,['addr','length','Office Address를 입력해 주시기 바랍니다.']
		,['companyPhone','length','Tel. No를 입력해 주시기 바랍니다.']
		,['homepage','length','homepage를 입력해 주시기 바랍니다.']
		,['cStaff','length','상시종업원수를 입력하세요.']
		,['files2','length','회사로고를 등록해주세요.']
	];


	var checkform = checkInputValue(data);
	if(!checkform){return false;}

	if( $('#companySelect').val() == 'NEW' ){
		
		var checkformCo = checkInputValue(dataCo);
		if(!checkformCo){return false;}

		if( $('.business_check:checked').length <= 0 ){
			alert('사업분야를 1개이상 선택해주세요.');
			return false;
		}
		if( $('input[name="business12"]:checked').length > 0 && !$.trim( $('#business').val() ) ){
			alert('사업분야 기타 내용을 입력해주세요.');
			return false;
		}
	}
	alert('폼 작업중');
	return false;
	$('.btn_area').html('처리 중입니다.');
}

</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
<!-- #include file = "../inc/header.asp" -->
<%
if Session("UserIdx") <> "" then 
	Response.Redirect("../mypage/")
end if

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
	Dim optionCountry : optionCountry = setCodeOption( 13  , "select" , 0 , "" )
	Dim optionCStaff  : optionCStaff  = setCodeOption( 14  , "select" , 0 , "" )

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
			<h3 class="title">Joining process and entry requirements</h3>
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
				<input type="text" id="userId" name="userId" class="input" style="width:95%;ime-mode:disabled;" maxlength="320" placeholder="Company Email ( User Account )">
			</div>
			<div class="row">
				<input type="password" id="userPwd" name="userPwd" class="input" style="width:95%;" maxlength="20" placeholder="Create your password">
			</div>
			<div class="row">
				<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:95%;" maxlength="20" placeholder="Confirm password">
			</div>
			<div class="row">
				<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;position:relative">
					<input type="text" class="input" id="FirstName" name="FirstName" maxlength="30" style="width:90%;" placeholder="First Name">
				</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;position:relative">
					<input type="text" class="input" id="LastName" name="LastName" maxlength="30" style="width:90%;" placeholder="Last Name">
				</div>
			</div>

			<div class="row">
				<input type="text" id="userPosition" name="userPosition" class="input" style="width:95%;" maxlength="100" placeholder="Department/Position">
			</div>
			<div class="row">
				<input type="text" id="userhPhone" name="userhPhone" maxlength="30" class="input" style="width:95%;" placeholder="Mobile. No">
			</div>
			<div class="row">
				<input type="text" id="userPhone" name="userPhone" maxlength="30" class="input" style="width:95%;" placeholder="Tel. No">
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
					<input type="text" id="cName" name="cName" class="input" style="width:95%;" maxlength="100" placeholder="Company Name">
				</div>
				<div class="row">
					<select class="input" id="Country" name="Country" style="width:98%;height:32px;padding:5px;">
						<option value="">Country</option>
						<%=optionCountry%>
					</select>
				</div>
				<div class="row">
					<input type="text" id="addr" name="addr" class="input" style="width:95%;" maxlength="200" placeholder="Office Address">
				</div>

				<div class="row">
					<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;position:relative">
						<input type="text" class="input" id="cPhone" name="cPhone" maxlength="30" style="width:90%;" placeholder="Tel. No">
					</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;position:relative;">
						<input type="text" class="input" id="homepage" name="homepage" maxlength="200" style="width:90%;" placeholder="WebSite ( http:// )">
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
						
						<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;position:relative">
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
										<input type="text" id="business" name="business" style="width:180px;border:0px;vertical-align:middle;" maxlength="100" >
									)</label>
								</div>
							</div>

						</div>


					</div>

					
				</div>

				<!-- 파일 스크립트 추가 -->
				<div class="row">
					<input type="file" id="files2" name="files2" style="width:1px;height:1px;overflow:hidden;">
					<input type="text" id="files2_input" class="input" style="width:78%;" placeholder="Company Logo Image File ( jpg, bmp, gif, png )" readonly>
					<input type="button" id="files2_btn" class="btn" style="width:15%;height:32px;margin-left:15px;" value="SEARCH">
				</div>


			</div>

			


			<div class="form_wrap">
				<div class="row" style="margin-top:20px;">
					<textarea name="other_infor" class="input" style="width:95%;height:100px;line-height:160%;" placeholder="Share additional Information"></textarea>
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
	$('#files2_input').click(function(){
		$('#files2').click();
	})
	$('#files2_btn').click(function(){
		$('#files2').click();
	});
	$('#files2').change(function(){
		$('#files2_input').val( $(this).val() );
	});

});

$ajaxIdCheck = false;
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

ajaxIdCheck($userId.val());
$userId.blur(function(){
	ajaxIdCheck($(this).val());
}).keyup(function(){
	ajaxIdCheck($(this).val());
});

function checkJoin(){
	var data = [
		 ['userId','length','Please enter id']
		,['userId','mail','E-mail format is incorrect']
		,['userPwd','length','Please enter password']
		,['userPwd','pwd','The password can be up to 6-20 characters']
		,['userPwdConfirm','length','Please enter confirm password']
		,['userPwdConfirm','confirm','Please enter the same password','userPwd']
		,['FirstName','length','Please enter First Name']
		,['LastName','length','Please enter Last Name']
		,['userPosition','length','Please enter Department/Position']
		,['userhPhone','length','Please enter Mobile. No']
		,['userPhone','length','Please enter Tel. No']
		,['companySelect','length','Please choose company name']
	];
	var dataCo = [
		 ['cName','length','Please enter company name']
		,['Country','length','Please choose Country']
		,['addr','length','Please enter Office Address']
		,['cPhone','length','Please enter Tel. No']
		,['homepage','length','Please enter homepage']
		,['cStaff','length','Please choose Number of Company Employees']
		,['files2','length','Please enter company Logo image file']
	];

	var checkform = checkInputValue(data);
	if(!checkform){return false;}

	if( $('#companySelect').val() == 'NEW' ){
		
		var checkformCo = checkInputValue(dataCo);
		if(!checkformCo){return false;}

		var check_file = checkTitleFileType( $('#files2').val() );
		if( !check_file ){
			alert("you can register [jpg, bmp, gif, png]" ); 
			return false;
		}

		if( $('.business_check:checked').length <= 0 ){
			alert('Please select one or more businesses');
			return false;
		}
		if( $('input[name="business12"]:checked').length > 0 && !$.trim( $('#business').val() ) ){
			alert('Please enter etc');
			$('#business').focus();
			return false;
		}
	}

	if(!$ajaxIdCheck){alert('The ID is currently in use');return false;}

	$('.btn_area').html('Loading.');
}

function checkTitleFileType(obj){ 
	pathpoint = obj.lastIndexOf('.'); 
	filepoint = obj.substring(pathpoint+1,obj.length); 
	filetype = filepoint.toLowerCase(); 
	if (filetype == 'gif'|| filetype == 'jpg' || filetype == 'jpeg' || filetype == 'bmp' || filetype == 'png'){
		return true;
	}else{
		return false;
	}
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
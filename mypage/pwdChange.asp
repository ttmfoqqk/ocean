<!-- #include file = "../inc/header.asp" -->
<%checkLogin( g_host & g_url )%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">비밀번호 변경</h3>

			<form name="mForm" id="mForm" method="post" action="pwdChange_proc.asp" onsubmit="return check();">
			<div class="form_wrap" style="width:490px;">
				<div class="row">
					<label style="width:170px;">현재 비밀번호 <span class="color_red">*</span></label>
					<input type="password" id="oldUserPwd" name="oldUserPwd" class="input" style="width:300px;">
				</div>
				<div class="row">
					<label style="width:170px;">새로운 비밀번호 <span class="color_red">*</span></label>
					<input type="password" id="userPwd" name="userPwd" class="input" style="width:300px;">
				</div>
				<div class="row">
					<label style="width:170px;">새로운 비밀번호 확인 <span class="color_red">*</span></label>
					<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:300px;">
				</div>
			</div>
			
			<div style="margin:30px;text-align:center;">
				<button type="submit" class="btn">변경하기</button>
			</div>
			</form>

			<div style="padding:25px;border:1px solid #bfbfbf;background-color:#fafafa;line-height:160%;">
				비밀번호는 주기적으로 변경하는 것이 안전합니다.<br>
				다른 사이트와 같은 아이디, 비밀번호를 사용하는 것은 비밀번호 도용의 위험이 매우 높습니다.<br>
				아이디, 주민등록번호, 전화번호등 개인정보와 관련된 비밀번호는 안전하지 않습니다.<br>
			</div>

		</div>
		
	</div>
</div>
<script type="text/JavaScript" src="../inc/js/member.js"></script>
<SCRIPT type="text/javascript">
$oldUserPwd = $('#oldUserPwd');
$(function(){
	$oldUserPwd.focus();
});
function check(){
	
	if( !$.trim( $oldUserPwd.val() ) ){
		alert( '현재 비밀번호를 입력해주세요.' );
		$oldUserPwd.focus();
		return false;
	}
	var userPwd = checkFormUserPwd(true);
	if( !userPwd ){$userPwd.focus();return false;}

	var userPwdConfirm = checkFormUserPwdConfirm(true);
	if( !userPwdConfirm ){$userPwdConfirm.focus();return false;}
	
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
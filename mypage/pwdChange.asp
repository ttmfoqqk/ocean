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
			<div class="form_wrap" style="width:450px;">
				<div class="row">
					<input type="password" id="oldUserPwd" name="oldUserPwd" class="input" style="width:95%;" placeholder="Your password">
				</div>
				<div class="row">
					<input type="password" id="userPwd" name="userPwd" class="input" style="width:95%;" placeholder="New password">
				</div>
				<div class="row">
					<input type="password" id="userPwdConfirm" name="userPwdConfirm" class="input" style="width:95%;" placeholder="Confirm New password">
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
<SCRIPT type="text/javascript">
function check(){
	var data = [
		 ['oldUserPwd','length','현재 비밀번호를 입력해주세요.']
		,['userPwd','length','비밀번호를 입력해 주시기 바랍니다.']
		,['userPwd','pwd','비밀번호는 6~20자까지 가능합니다.']
		,['userPwdConfirm','length','비밀번호 확인을 입력해 주시기 바랍니다.']
	];
	var checkform = checkInputValue(data);
	if(!checkform){return false;}
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
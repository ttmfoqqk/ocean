<!-- #include file = "../inc/header.asp" -->
<%checkLogin( g_host & g_url )%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">Password Changes</h3>

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
				<button type="submit" class="btn">Submit</button>
			</div>
			</form>

			

		</div>
		
	</div>
</div>
<SCRIPT type="text/javascript">
function check(){
	var data = [
		 ['oldUserPwd','length','Please enter your current password']
		,['userPwd','length','Please enter new password']
		,['userPwd','pwd','The password can be up to 6-20 characters']
		,['userPwdConfirm','length','Please enter confirm password']
	];
	var checkform = checkInputValue(data);
	if(!checkform){return false;}
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
	if Session("UserIdx") <> "" then 
		Response.Redirect("../mypage/")
	end if

	Dim save_id    : save_id    = request.cookies("UserIdSave")("id")
	Dim save_check : save_check = IIF( save_id <> "","checked","" )
%>
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap">
			<h2 class="title">Welcome to OCEAN</h2>
			<p>Please log in to use many more services of OCEAN</p>
		</div>
	</div>

	<div class="login_wrap">
		<div class="wrap">
			<div class="login_box">
				
				<form method="post" name="mForm" id="mForm" action="login.asp" onsubmit="return check()">
				<input type="hidden" name="goUrl" value="<%=request("goUrl")%>">

				<br><br><br><br>
				<table cellpadding="0" cellspacing="0" class="table" align="center">
					<tr>
						<td style="width:255px;height:37px;vertical-align:top;">
							<input id="userId" name="userId" type="text" class="input" maxlength="320" placeholder="id" style="width:235px;padding:5px;ime-mode:disabled;" tabindex="1" value="<%=save_id%>">
						</td>
						<td rowspan="2" style="vertical-align:top;">
							<button class="btn" style="width:100%;height:65px;" tabindex="3">Login</button>
						</td>
					</tr>
					<tr>
						<td>
							<input id="userPwd" name="userPwd" type="password" class="input" maxlength="20" placeholder="password" style="width:235px;padding:5px" tabindex="2">
						</td>
					</tr>
					<tr>
						<td colspan="2" style="height:33px;color:#000000;">
							<label><input type="checkbox" class="checkbox" name="SaveLog" value="Y" checked tabindex="4" style="vertical-align:top;"> Save ID</label>
							<span style="float:right;">
								<a href="../find/find_id.asp" tabindex="5">Find ID</a> · <a href="../find/find_pwd.asp" tabindex="6">Password</a> ㅣ <a href="../join/" tabindex="7"><b>Join</b></a>
							</span>
						</td>
					</tr>
				</table>

				</form>
			</div>
		</div>
	</div>
</div>

<SCRIPT type="text/javascript">
$userId  = $('#userId');
$userPwd = $('#userPwd');

function check(){
	if( !$.trim($userId.val()) ){
		alert('아이디를 입력하세요');
		$userId.focus();
		return false;
	}
	if( !$.trim($userPwd.val()) ){
		alert('비밀번호를 입력하세요');
		$userPwd.focus();
		return false;
	}
}

$(function(){
	<%if save_id <> "" then%>
	$userPwd.focus();
	<%else%>
	$userId.focus();
	<%end if%>
});
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
Call Expires()
Call dbopen()
	Dim optionEmail : optionEmail = setCodeOption( 11  , "select" , 1 , "" )
Call dbclose()
%>
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">비밀번호 재발급</h2>
		
		<form name="mForm" id="mForm" method="post" action="find_pwd_proc.asp" onsubmit="return check();">
		<div class="form_wrap" style="width:565px;">
			<div class="row">
				<label style="width:85px;">아이디 <span class="color_red">*</span></label>
				<input type="text" id="userId" name="userId" class="input" style="width:316px;ime-mode:disabled;" maxlength="16" tabindex="1">
			</div>
			<div class="row">
				<label style="width:85px;">이름 <span class="color_red">*</span></label>
				<input type="text" id="userName" name="userName" class="input" style="width:316px;ime-mode:active;" maxlength="16" tabindex="1">
			</div>
			<div class="row">
				<label style="width:85px;">이메일 <span class="color_red">*</span></label>
				<div style="display:inline-block;">
					<input type="text" id="userEmail1" name="userEmail1" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="1"> @ <input type="text" id="userEmail2" name="userEmail2" class="input" style="width:139px;ime-mode:disabled;" maxlength="100" tabindex="3">
					<select id="userEmail3" name="userEmail3" class="input" style="width:139px;height:32px;padding:5px;" tabindex="2">
						<option value="">직접입력</option>
						<%=optionEmail%>
					</select>
					<div class="color_blue" style="font-size:11px;line-height:100%;margin-top:10px;">가입 시 기재한 이메일을 입력해 주세요.</div>
				</div>
			</div>
		</div>
		
		<div style="margin:30px;text-align:center;">
			<button class="btn" type="submit">비밀번호 재발급</button>
		</div>
		</form>


	</div>
</div>

<script type="text/JavaScript" src="../inc/js/member.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	$userId.focus();
});
function check(){
	var userId = checkFormUserId(true,false);
	if( userId == false ){$userId.focus();return false;}

	var userName = checkFormUserName(true);
	if( !userName ){$userName.focus();return false;}

	var userEmail = checkFormUserEmail(true);	
	if( !userEmail ){$userEmail1.focus();return false;}
}
</SCRIPT>

<!-- #include file = "../inc/footer.asp" -->
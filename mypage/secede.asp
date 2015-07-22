<!-- #include file = "../inc/header.asp" -->
<%checkLogin( g_host & g_url )%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">Membership Withdrawal</h3>

			<div class="secede" style="padding-top:0px;">
				<h4>1. Immediate deactivation of member services</h4>
				<p>- If you withdraw your membership, you cannot access all services offered under the OCEAN partnership anymore.</p>
			</div>

			<div class="secede">
				<h4>2. Not allowed to sign up again with the same ID</h4>
				<p>
					- If you request to withdraw your OCEAN membership, the withdrawal request will be processed immediately.<br>
					- If your membership is cancelled completely, you will not be allowed to sign up again with the same ID. <br>
					(hope you understand our policy to prevent from repeating sign-up/withdrawal with the same ID)<br>
				</p>
			</div>

			<div class="secede">
				<h4>3. Removal of membership information and subscribed services </h4>
				<p>
					- Your registered information will be permanently deleted with your membership withdrawal. <br>
					- ‘If you want’, you need to delete resources you have contributed to the OCEAN (e.g., bulletin posts) before requesting withdrawal. <br>
					Otherwise, they will remain in the OCEAN even after your membership withdrawal.<br>
				</p>
			</div>
			
			<form id="mForm" name="mForm" method="post" action="secede_proc.asp" onsubmit="return check()">
			<div style="padding:20px 20px 0px 20px;text-align:left;">
				<div class="checkbox_wrap">
					<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree" name="agree"></span></span>
					<label><b>Please make sure you read and understand all items stated above before move to next step.</b></label>
				</div>
			</div>
			
			<div style="margin:30px;text-align:center;">
				<button type="submit" class="btn" style="width:auto;padding:0px 20px 0px 20px;">Request to Withdraw Membership </button>
			</div>
			</form>


		</div>
		
	</div>
</div>

<SCRIPT type="text/javascript">
function check(){
	if( !$('#agree').attr('checked') ){
		alert('탈퇴 확인 내용에 동의해 주세요.');
		return false;
	};	
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
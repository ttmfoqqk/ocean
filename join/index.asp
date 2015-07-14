<!-- #include file = "../inc/header.asp" -->
<%
Call Expires()
Call dbopen()
	Call AgreeView()
Call dbclose()

Sub AgreeView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_AGREE_V"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle" style="overflow:hidden;">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap" style="border-bottom:2px solid #999a9d;padding-bottom:40px;">
			<h3 class="title">회원가입을 위해 <span class="color_green">이용약관</span>과 <span class="color_green">개인정보 수집 및 이용</span>에 동의해 주세요.</h3>
			<p>
				회원이 되시면 OCEAN에서 제공하는 다양한 서비스를 이용하실 수 있습니다.<br>
				아래의 서비스 약관 및 개인정보 수집 이용에 대한 안내를 반드시 읽고 동의해 주세요.
			</p>
			<br><br>
			<div class="checkbox_wrap">
				<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" name="agree" value="all"></span></span>
				<label><b>이용약관, 개인정보 수집 및 이용약관(선택)에 모두 동의합니다.</b></label>
			</div>
		</div>
		
		<form id="mForm" name="mForm" method="post" action="info.asp" onsubmit="return check();">
		
			<div style="text-align:left;">
				<p class="page_contants">
					<b class="color_green">이용약관</b><br>
					<div class="textarea" style="width:100%;height:150px;overflow-x:hidden;overflow-y:scroll;line-height:160%;"><%=FI_agree1%></div>

					<div class="checkbox_wrap" style="margin:0px;">
						<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree1" name="agree" value="agree1"></span></span>
						<label><b>이용약관에 동의합니다.</b></label>
					</div>
				</p>
				<br><br>

				<p class="page_contants">
					<b class="color_green">개인정보 수집 및 이용</b><br>
					<div class="textarea" style="width:100%;height:150px;overflow-x:hidden;overflow-y:scroll;line-height:160%;"><%=FI_agree2%></div>

					<div class="checkbox_wrap">
						<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree2" name="agree" value="agree2"></span></span>
						<label><b>개인정보 수집 및 이용에 동의합니다.</b> </label>
					</div>
				</p>
			</div>
			<div style="margin:30px;">
				<button type="submit" class="btn">다음단계</button>
			</div>


		</form>



	</div>
</div>

<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
function check(){
	if( !$('#agree1').attr('checked') || !$('#agree2').attr('checked') ){
		alert('OCEAN의 이용약관, 개인정보 수집 및 이용에 동의해 주세요');
		return false;
	}
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
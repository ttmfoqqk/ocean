<!-- #include file = "../inc/header.asp" -->
<%checkLogin( g_host & g_url )%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">회원탈퇴</h3>

			<div class="secede" style="padding-top:0px;">
				<h4>1. 회원 서비스 이용 불가능</h4>
				<p>회원 탈퇴를 하시면 서비스를 더 이상 이용하실 수 없습니다.</p>
			</div>

			<div class="secede">
				<h4>2. 해당 아이디로 재가입 불가</h4>
				<p>
					회원탈퇴를 신청하시면 해당 아이디는 <span class="color_red">즉시 탈퇴 처리</span> 됩니다.<br>
					<span class="color_red">해당 아이디는 영구적으로 사용이 중지</span>되므로 해당 아이디로는 회원가입이 불가능 합니다.<br>
					이는 가입과 탈퇴의 반복을 막고, 선량한 이용자들에게 피해를 끼치는 행위를 방지하기 위한 조치이오니 양해 바랍니다.<br>
				</p>
			</div>

			<div class="secede">
				<h4>3. 회원정보 및 회원제 서비스의 정보 삭제</h4>
				<p>
					회원 탈퇴 시 회원 계정에 속한 <span class="color_red">개인정보는 즉시 삭제</span>됩니다.<br>
					게시물 등의 삭제를 원하시는 경우에는 반드시 삭제하신 후, 탈퇴를 신청하시기 바랍니다.
				</p>
			</div>

			<div class="secede">
				<h4>4. 불량이용 및 이용제한에 관한 기록 1년 동안 보관</h4>
				<p>개인정보취급방침에 따라 불량회원 및 이용제한에 관한 기록은 1년 동안 삭제되지 않고 보관됩니다.</p>
			</div>
			
			<form id="mForm" name="mForm" method="post" action="secede_proc.asp" onsubmit="return check()">
			<div style="padding:20px 20px 0px 20px;text-align:left;">
				<div class="checkbox_wrap">
					<span name="_checkbox" class="off"><span class="blind"><input type="checkbox" id="agree" name="agree"></span></span>
					<label><b>위의 내용을 확인하였습니다.</b></label>
				</div>
			</div>
			
			<div style="margin:30px;text-align:center;">
				<button type="submit" class="btn">탈퇴신청</button>
			</div>
			</form>


		</div>
		
	</div>
</div>
<script type="text/JavaScript" src="../inc/js/checked.js"></script>
<SCRIPT type="text/javascript">
function check(){
	if( !$('#agree').attr('checked') ){
		alert('탈퇴 확인 내용에 동의해 주세요.');
		return false;
	};	
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
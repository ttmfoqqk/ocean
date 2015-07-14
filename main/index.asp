<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList
Dim cntList : cntList = -1
Dim rows    : rows    = 10

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_L"
		.Parameters("@rows").value     = rows 
		.Parameters("@Key").value      = 0
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
<STYLE type="text/css">
#middle{background:#ffffff;}
</STYLE>
<div id="middle">
	<div class="visual" id="main_backgroundImages">
		<div class="visual_wrap">
			<div class="item" style="background:url(../img/visual/main/01.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>표준 기반 사물인터넷 오픈소스 연합체</h4>
					<p>IoT 글로벌 표준을 기반으로 개발된 오픈소스를 공유합니다.<br>다양한 사물 인터넷 서비스의 조기 개발 및 상용화를 촉진하기 위한 연합체 입니다.</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>
			<div class="item" style="background:url(../img/visual/main/02.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>openMobius®  &CUBE®  공개</h4>
					<p>openMobius® 는 IoT 글로벌 표준을 기반으로 개발된 사물인터넷 서버 플랫폼입니다.<br>&CUBE® 사물인터넷 디바이스 플랫폼입니다.<br>지금 다운로드 받아 사용하실 수 있습니다.</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>
			<div class="item" style="background:url(../img/visual/main/03.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>3-clause BSD-style 라이센스</h4>
					<p>개발된 코드는 여러분의 것입니다. <br>라이센스 규정을 확인하세요.</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>

		<div class="visual_page" id="main_rolling_icon"></div>
		<div class="visual_page_left"  id="main_rolling_icon_left"><a href="javascript:;"><span class="blind">이전</span></a></div>
		<div class="visual_page_right" id="main_rolling_icon_right"><a href="javascript:;"><span class="blind">다음</span></a></div>
		</div>
	</div>
	

	<div class="wrap">
		

		<div class="main_notice">
			<div class="title">공지사항 <a href="../customer/" class="more">+ 더보기</a></div>
			<div class="contants">
				<table cellpadding="0" cellspacing="0" class="table">
					<%for iLoop = 0 to cntList%>
					<tr>
						<td><a href="../customer/?idx=<%=arrList(FI_idx,iLoop)%>"><%=arrList(FI_Title,iLoop)%></a></td>
						<td class="data"><%=arrList(FI_Indate,iLoop)%></td>
					</tr>
					<%Next%>
				</table>
			</div>
		</div>

		<div class="main_description">
			<div class="rap">
				<a href="../join/"><h4 class="color_green icon1">회원가입</h4></a>
				<p>
				OCEAN의 회원가입 및 모든 정보이용은 무료로<br>
				제공되며 IoT 플랫폼 소스코드 다운로드는 회원<br>
				가입을 원칙으로 하고 있습니다.<br>
				회원가입유형은 기업회원만 가입할 수 있으며<br>
				개인회원은 OCEAN 정책상 기업/기관 회원에<br>
				소속된 개인만 가입할 수 있음을 양지해 주시기 바랍니다.
				</p>
			</div>
		</div>
		<div class="main_description">
			<div class="rap">
				<a href="../download/"><h4 class="color_green icon2">다운로드</h4></a>
				<p>
				표준기반 IoT 서버 플랫폼인 openMobius® 와<br>
				IoT 디바이스 플랫폼인 &CUBE ® 의 이미지와<br>
				소스코드를 다운로드 할 수 있습니다. 

				</p>
			</div>
		</div>
		<div class="main_description">
			<div class="rap">
				<a href="../showcase/"><h4 class="color_green icon3">Showcase</h4></a>
				<p>
				참여하고 있는 멤버사가 OCEAN 오픈소스를<br>
				기반으로 개발한 기술개발 결과물을 게시하고 <br>
				공유할 수 있습니다. 기업간 협력의 장이 될 것입니다.
				</p>
			</div>
		</div>


		<div class="main_banner">
			<h4 class="color_green">MEMBERS</h4>
			<div style="margin:20px 0px 0px 0px;"><img src="../img/main_icon_4.gif"></div>
		</div>

	</div>


</div>

<SCRIPT type="text/javascript">
$(function(){
	$backgroundImages   = $('#main_backgroundImages');
	$rolling_icon       = $('#main_rolling_icon');
	$rolling_icon_left  = $('#main_rolling_icon_left');
	$rolling_icon_right = $('#main_rolling_icon_right');

	
	var rolling_icon_html = '';
	var rolling_cnt       = 0;
	var rolling_length    = $backgroundImages.find('div.item').length;
	var rolling_setTime;

	$backgroundImages.find('div.item').hide()

	for(var i=0;i<rolling_length;i++ ){
		rolling_icon_html += '<a href="javascript:;" value="'+i+'"><span class="blind">'+(i+1)+'번째 이미지</span></a> ';
	}
	$rolling_icon.html(rolling_icon_html);

	rolling_img(rolling_cnt);

	function rolling_img( t ){
		clearTimeout(rolling_setTime);
		t = t >= rolling_length ? 0 : t;
		t = t < 0 ? (rolling_length-1) : t;
		
		$rolling_icon.find('a').removeClass().unbind().filter(':eq('+t+')').addClass('on');
		$rolling_icon_left.find('a').unbind();
		$rolling_icon_right.find('a').unbind();

		$backgroundImages.find('div.item:eq('+rolling_cnt+')').stop().fadeOut(1000,function(){
			
			$backgroundImages.find('div.item:eq('+t+')').stop().fadeIn(1000,function(){
				rolling_cnt=t;
				$rolling_icon.find('a').bind('click',function(){
					rolling_img( $(this).attr('value') );
				});
				$rolling_icon_left.find('a').bind('click',function(e){
					e.preventDefault();
					rolling_img( parseInt(rolling_cnt)-1 );
				});
				$rolling_icon_right.find('a').bind('click',function(e){
					e.preventDefault();
					rolling_img( parseInt(rolling_cnt)+1 );
				});

				rolling_setTime = setTimeout(function(){rolling_img( parseInt(rolling_cnt)+1 )},3000);
			});
		});
	}
});
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
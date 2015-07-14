
<div id="footer">
	<div class="block1">
		<div class="wrap">
			<div class="share">
				<a href="#" onclick="snsShare('facebook');return false;" class="facebook"><span class="blind">페이스북 알리기</span></a>
				<a href="#" onclick="snsShare('twitter');return false;" class="twitter"><span class="blind">트위터 알리기</span></a>
			</div>
			<a href="#" onclick="$(window).scrollTop(0);return false;" class="btn_goTop"><span class="blind">위로</span></a>
		</div>
	</div>
	<div class="block2">
		<div class="wrap">
			<h1 class="logo"><span class="blind">CRZ.TECHNOLOGY</span></h1>
			<div class="menu">
				<a href="../agree/agree1.asp">이용약관</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../agree/agree2.asp">개인정보취급방침</a>
			</div>
			<p class="copy">
				463-816 경기도 성남시 분당구 새나리로 25 (야탑동)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tel : 031-789-7586<br>
				Copyright ⓒ2014 OCEAN.All Right Reserved.
			</p>
		</div>
	</div>
</div>

</body>

<SCRIPT type="text/javascript">
function setLeftHeight(){
	$('#middle').css({'height' : 'auto'});

	var windowH = $(window).height();
	var topH    = $('#header').height();
	var footerH = $('#footer').height();
	var middleH = $('#middle').height();
	var height  = windowH - topH - footerH - 51;

	if(height > middleH){
		$('#middle').height(height);
	}
}
$(function(){
	setLeftHeight();
});
$(window).load(function(){
	setLeftHeight();
});
$( window ).resize(function() {
	setLeftHeight();
});


</SCRIPT>
</html>
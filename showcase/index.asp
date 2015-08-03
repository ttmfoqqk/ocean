<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<style type="text/css">
	#middle .dowunload_list .block .sub{display:block;}
</style>
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Showcase OCEAN</h2>

		<p class="page_contants">
			<b class="color_green">Your demo video is always wekowe Contact us! (araha@keti.re.kr)</b><br>
		</p>
		
		<div class="dowunload_list">
			<div id="board_list"></div>
			<input type="button" class="btn more_button" id="btn_board_more" value="+ MORE">
		</div>

	</div>
</div>

<script src="../inc/js/board.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	ajax_board_list([2,'<%=tab1%>','<%=tab2%>','<%=tab3%>'],1,5,'board_list','btn_board_more');
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
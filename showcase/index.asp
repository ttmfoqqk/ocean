<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Showcase OCEAN</h2>

		<p class="page_contants">
			<b class="color_green">Internet of Things Related Videos</b><br>
		</p>
		
		<div class="dowunload_list">
			<div id="board_list"></div>
			<input type="button" class="btn" id="btn_board_more" value="+ MORE">
		</div>

	</div>
</div>

<script src="../inc/js/board.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	ajax_board_list([2,'<%=tab1%>','<%=tab2%>','<%=tab3%>'],1,10,'board_list','btn_board_more');
})
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
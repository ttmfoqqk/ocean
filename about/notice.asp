<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			
			<h3 class="title">NOTICE</h3>
			
			<div class="dowunload_list">
				<div id="board_list"></div>
				<input type="button" class="btn more_button" id="btn_board_more" value="+ MORE">
			</div>

		</div>
	</div>
</div>

<script src="../inc/js/board.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	ajax_board_list([0,'','',''],1,10,'board_list','btn_board_more','<%=request("idx")%>');
});
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
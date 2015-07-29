<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap">
			<%if Session("temp_join_result") = "CEO" then %>
			<h2 class="title">Please check your e-mail !!</h2>
			
			<p style="margin-top:50px;">
				<b>Verification email for the OCEAN membership application</b><br><br>
				The first person who has joined the OCEAN becomes<br>
				the representative member of his/her company.<br>
				Email verification will be required for the OCEAN membership application.<br>
			</p>
			<%else%>
			<h2 class="title">
				The OCEAN membership joining request is <br>
				successfully processed.
			</h2>
			
			<p style="margin-top:50px;">
				Your request to join the OCEAN is waiting for administrator approval.<br>
				The joining process will be completed after getting the approval from the representative<br>
				member of your company.<br>
			</p>
			<%end if%>
		</div>
		<div style="margin:30px;">
			<img src="../img/logo_footer.png">
		</div>
		
	</div>
</div>

<!-- #include file = "../inc/footer.asp" -->
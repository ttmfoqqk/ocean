<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
If session("search_pwd_email") = "" Then 
	Response.redirect "find_pwd.asp"
End If 
%>
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Password reissue</h2>
		
		<div style="font-size:14px;line-height:180%;">
				<h3 style="font-size:18px;">The temporary password has already sent to <span style="color:#bc9a14;"><%=session("search_pwd_email")%></span> email address.</h3>
				<p>
					Please change your password after logging with the temporary password.
					<br>Thank you.
				</p>
			</div>

		<div style="margin:30px;text-align:center;">
			<button class="btn" onclick="location.href='../login/'">Login</button>
		</div>
		

	</div>
</div>
<%
session("search_pwd_email") = ""
%>
<!-- #include file = "../inc/footer.asp" -->
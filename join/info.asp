<!-- #include file = "../inc/header.asp" -->
<%
if Session("UserIdx") <> "" then 
	Response.Redirect("../mypage/")
end if

Dim agree : agree = request("agree")
Dim length : length = Split(agree,",")
Dim agree1 : agree1 = 1
Dim agree2 : agree2 = 1

For i=0 To ubound(length)
	If Trim(length(i)) = "agree1" Then 
		agree1= 0
	End If
	If Trim(length(i)) = "agree2" Then 
		agree2= 0
	End If
Next

If agree1 <> 0 Or agree2 <> 0 Then
	Response.redirect "../join/"
End If

%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<div class="member_title_wrap">
			<h3 class="title">Joining process and entry requirements</h3>
		</div>
		
		<form id="mForm" name="mForm" method="post" action="data.asp">
			<input type="hidden" name="agree" id="agree" value="agree1,agree2">
		
			<div><img src="../img/joinInfo.gif"></div>
			<div style="margin:30px;">
				<button type="submit" class="btn">Next</button>
			</div>
		</form>
	</div>
</div>
<!-- #include file = "../inc/footer.asp" -->
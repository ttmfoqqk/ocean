<!-- #include file = "../inc/header.asp" -->
<%
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
			<h3 class="title"><span class="color_green">회원가입 절차</span></h3>
			<p>
				아래의 절차를 통하여 OCEAN의 다양한 서비스를 이용하실 수 있습니다.
			</p>
		</div>
		
		<form id="mForm" name="mForm" method="post" action="data.asp">
			<input type="hidden" name="agree" id="agree" value="agree1,agree2">
		
			<div><img src="../img/joinInfo.gif"></div>
			<div style="margin:30px;">
				<button type="submit" class="btn">다음단계</button>
			</div>
		</form>
	</div>
</div>
<!-- #include file = "../inc/footer.asp" -->
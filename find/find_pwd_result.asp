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
		<h2 class="page_title">비밀번호 재발급</h2>
		
		<div style="font-size:14px;line-height:180%;">
				<h3 style="font-size:18px;"><span style="color:#bc9a14;"><%=session("search_pwd_email")%> </span>이메일 주소로 임시 비밀번호가 재발급 되었습니다.</h3>
				<p>로그인 하신 후 비밀번호를 변경해 주시기 바랍니다.</p>
			</div>

		<div style="margin:30px;text-align:center;">
			<button class="btn" onclick="location.href='../login/'">로그인</button>
		</div>
		

	</div>
</div>
<%
session("search_pwd_email") = ""
%>
<!-- #include file = "../inc/footer.asp" -->
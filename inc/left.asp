	<% If INSTR(LCase(g_url),"/mypage/")>0 Then %>
	<div id="left_menu">
		<h2>마이페이지</h2>
		<ul>
			<li><a href="pwdChange.asp" class="<%=IIF( INSTR(LCase(g_url),"pwdchange") > 0 ,"over" , "" )%>"><span>비밀번호 변경</span></a></li>
			<li><a href="info.asp" class="<%=IIF( INSTR(LCase(g_url),"info") > 0 ,"over" , "" )%>"><span>회원정보 변경</span></a></li>
			<li><a href="secede.asp" class="<%=IIF( INSTR(LCase(g_url),"secede") > 0 ,"over" , "" )%>"><span>회원탈퇴</span></a></li>
			<%If Session("UserCeoFg") = "1" Then %>
			<li><a href="staff.asp" class="<%=IIF( INSTR(LCase(g_url),"staff") > 0 ,"over" , "" )%>"><span>승인요청</span></a></li>
			<%End If%>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/about/")>0 Then %>
	<div id="left_menu">
		<h2>About</h2>
		<ul>
			<li><a href="../about/" class="<%=IIF( INSTR(LCase(g_url),"index") > 0 ,"over" , "" )%>"><span>Ocean이란?</span></a></li>
			<li><a href="../about/notice.asp" class="<%=IIF( INSTR(LCase(g_url),"notice") > 0 ,"over" , "" )%>"><span>공지사항</span></a></li>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/download/")>0 Then %>
	<div id="left_menu">
		<h2>Download</h2>
		<ul>
			<li><a href="../download/?tab1=1" class="<%=IIF( tab1 = 1 ,"over" , "" )%>"><span>OpenMobius</span></a></li>
			<li><a href="../download/?tab1=2" class="<%=IIF( tab1 = 2 ,"over" , "" )%>"><span>&Cube</span></a></li>
		</ul>
	</div>
	<% End If %>
<%If INSTR(LCase(g_url),"/about/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>About</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/01.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/license/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>License</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/02.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/download/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Download</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/03.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/showcase/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Showcase</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/04.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/contact/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Contact</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/05.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/mypage/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Mypage</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/06.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/find/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Members</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/07.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/agree/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<%if INSTR(LCase(g_url),"/agree1.asp")>0 then %>
			<h4>Terms of use</h4>
			<%else%>
			<h4>Privacy policy</h4>
			<%end if%>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/08.jpg) no-repeat center;"></div>
	</div>
<%ElseIf INSTR(LCase(g_url),"/community/")>0 Then%>
	<div class="sub_visual">
		<div class="text">
			<h4>Community</h4>
			Open allianCE for iot stANDard
		</div>
		<div class="mask"></div>
		<div class="item" style="background:url(../img/visual/sub/09.jpg) no-repeat center;"></div>
	</div>
<%End If%>
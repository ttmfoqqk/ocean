	<% If INSTR(LCase(g_url),"/mypage/")>0 Then %>
	<div id="left_menu">
		<h2>마이페이지</h2>
		<ul>
			<li><a href="pwdChange.asp" class="<%=IIF( INSTR(LCase(g_url),"pwdchange") > 0 ,"over" , "" )%>"><div>비밀번호 변경</div></a></li>
			<li><a href="info.asp" class="<%=IIF( INSTR(LCase(g_url),"info") > 0 ,"over" , "" )%>"><div>회원정보 변경</div></a></li>
			<li><a href="secede.asp" class="<%=IIF( INSTR(LCase(g_url),"secede") > 0 ,"over" , "" )%>"><div>회원탈퇴</div></a></li>
			<%If Session("UserCeoFg") = "1" Then %>
			<li><a href="staff.asp" class="<%=IIF( INSTR(LCase(g_url),"staff") > 0 ,"over" , "" )%>"><div>승인요청</div></a></li>
			<%End If%>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/about/")>0 Then %>
	<div id="left_menu">
		<h2>About</h2>
		<ul>
			<li><a href="../about/" class="<%=IIF( INSTR(LCase(g_url),"index") > 0 ,"over" , "" )%>"><div>Ocean이란?</div></a></li>
			<li><a href="../about/notice.asp" class="<%=IIF( INSTR(LCase(g_url),"notice") > 0 ,"over" , "" )%>"><div>공지사항</div></a></li>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/download/")>0 Then %>
	<div id="left_menu">
		<h2>Download</h2>
		<ul>
			<li><a href="../download/?tab1=1" class="<%=IIF( tab1 = 1 ,"over" , "" )%>"><div>OpenMobius</div></a>
				<%
				If tab1=1 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../download/?tab1=2" class="<%=IIF( tab1 = 2 ,"over" , "" )%>"><div>&Cube</div></a>
				<%
				If tab1=2 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../download/?tab1=3" class="<%=IIF( tab1 = 3 ,"over" , "" )%>"><div>Open Contribution</div></a>
				<%
				If tab1=3 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/community/")>0 Then %>
	<div id="left_menu">
		<h2>Community</h2>
		<ul>
			<li><a href="../Community/?tab1=2" class="<%=IIF( tab1 = 2 ,"over" , "" )%>"><div>게시판 1</div></a>
				<%
				If tab1=2 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../Community/?tab1=3" class="<%=IIF( tab1 = 3 ,"over" , "" )%>"><div>게시판 2</div></a>
				<%
				If tab1=3 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../Community/?tab1=4" class="<%=IIF( tab1 = 4 ,"over" , "" )%>"><div>게시판 3</div></a>
				<%
				If tab1=4 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../Community/?tab1=1" class="<%=IIF( tab1 = 1 ,"over" , "" )%>"><div>자료실</div></a>
				<%
				If tab1=1 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../download/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
		</ul>
	</div>
	<% End If %>
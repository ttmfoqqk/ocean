	<% If INSTR(LCase(g_url),"/mypage/")>0 Then %>
	<div id="left_menu">
		<h2>Mypage</h2>
		<ul>
			<li><a href="pwdChange.asp" class="<%=IIF( INSTR(LCase(g_url),"pwdchange") > 0 ,"over" , "" )%>"><div>Password Changes</div></a></li>
			<li><a href="info.asp" class="<%=IIF( INSTR(LCase(g_url),"info") > 0 ,"over" , "" )%>"><div>Account Changes</div></a></li>
			<li><a href="secede.asp" class="<%=IIF( INSTR(LCase(g_url),"secede") > 0 ,"over" , "" )%>"><div>Secession</div></a></li>
			<%If Session("UserCeoFg") = "1" Then %>
			<li><a href="staff.asp" class="<%=IIF( INSTR(LCase(g_url),"staff") > 0 ,"over" , "" )%>"><div>Request</div></a></li>
			<%End If%>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/about/")>0 Then %>
	<div id="left_menu">
		<h2>About</h2>
		<ul>
			<li><a href="../about/" class="<%=IIF( INSTR(LCase(g_url),"index") > 0 ,"over" , "" )%>"><div>What is OCEAN?</div></a></li>
			<li><a href="../about/notice.asp" class="<%=IIF( INSTR(LCase(g_url),"notice") > 0 ,"over" , "" )%>"><div>NOTICE</div></a></li>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/download/")>0 Then %>
	<div id="left_menu">
		<h2>Download</h2>
		<ul>
			<li><a href="../download/?tab1=1" class="<%=IIF( tab1 = 1 ,"over" , "" )%>"><div>Mobius</div></a>
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
			<li><a href="../Community/?tab1=1" class="<%=IIF( tab1 = 1 ,"over" , "" )%>"><div>Device Dev</div></a>
				<%
				If tab1=1 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../Community/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../Community/?tab1=2" class="<%=IIF( tab1 = 2 ,"over" , "" )%>"><div>Server Dev</div></a>
				<%
				If tab1=2 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../Community/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<li><a href="../Community/?tab1=3" class="<%=IIF( tab1 = 3 ,"over" , "" )%>"><div>Application Dev</div></a>
				<%
				If tab1=3 Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../Community/?tab1=<%=tab1%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
		</ul>
	</div>
	<% End If %>
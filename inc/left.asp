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
			<%for kLoop = 0 to cntTab1List%>
			<li><a href="../download/?tab1=<%=arrTab1List(FI2_idx,kLoop)%>" class="<%=IIF( CStr(tab1) = CStr(arrTab1List(FI2_idx,kLoop)) ,"over" , "" )%>"><div><%=arrTab1List(FI2_name,kLoop)%></div></a>
				<%
				If CStr(tab1) = CStr(arrTab1List(FI2_idx,kLoop)) Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu

						if trim(arrListMenu(MENU_link,iLoop))="" or isnull(arrListMenu(MENU_link,iLoop)) then 
							%>
							<li><a href="../download/?tab1=<%=arrTab1List(FI2_idx,kLoop)%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
							<%
						else
							%>
							<li><a href="<%=arrListMenu(MENU_link,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>" target="_blank"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
							<%
						end if

					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<%next%>
		</ul>
	</div>
	<% elseif INSTR(LCase(g_url),"/community/")>0 Then %>
	<div id="left_menu">
		<h2>Community</h2>
		<ul>
			<%for kLoop = 0 to cntTab1List%>
			<li><a href="../Community/?tab1=<%=arrTab1List(FI2_idx,kLoop)%>" class="<%=IIF( CStr(tab1) = CStr(arrTab1List(FI2_idx,kLoop)) ,"over" , "" )%>"><div><%=arrTab1List(FI2_name,kLoop)%></div></a>
				<%
				If CStr(tab1) = CStr(arrTab1List(FI2_idx,kLoop)) Then
					response.Write("<ul class=""sub"">")
					for iLoop = 0 to cntListMenu
				%>
					<li><a href="../Community/?tab1=<%=arrTab1List(FI2_idx,kLoop)%>&tab2=<%=arrListMenu(MENU_idx,iLoop)%>" class="<%=IIF(CStr(tab2)=CStr(arrListMenu(MENU_idx,iLoop)),"over","")%>"><div><%=arrListMenu(MENU_name,iLoop)%></div></a></li>
				<%
					next
					response.Write("</ul>")
				end if
				%>
			</li>
			<%next%>
		</ul>
	</div>
	<% End If %>
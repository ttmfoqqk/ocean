<script type="text/javascript">
function submenu_open(obj){
	$obj = $(obj);
	if( $obj.is(':hidden') ){
		$obj.show();
	}else{
		$obj.hide();
	}
}
</script>
<div class="Admin_left">
<div><img src="../img/left_title_0<%=AdminTopmode%>.gif"></div>
<%If AdminTopmode = 1 Then%>
<ul>
	<li style="<%=IIF(INSTR(LCase(g_url),"admin_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_01_L.asp">약관관리</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"admin_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_02_L.asp">사원관리</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"admin_03")>0,"background-color:#f4f4f4;","")%>"><a href="../Admin/Admin_03_L.asp">기초코드</a></li>
</ul>
<%elseIf AdminTopmode = 2 Then%>
<ul>
	<li style="<%=IIF(INSTR(LCase(g_url),"info_01")>0,"background-color:#f4f4f4;","")%>"><a href="../info/info_01_L.asp">메뉴관리</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"info_02")>0,"background-color:#f4f4f4;","")%>"><a href="../info/info_02_L.asp">시설관리</a></li>
</ul>

<%elseIf AdminTopmode = 3 Then%>
<ul>
	<li style="<%=IIF(INSTR(LCase(g_url),"golfer_01")>0,"background-color:#f4f4f4;","")%>"><a href="../golfer/golfer_01_L.asp">프로골퍼관리</a></li>
</ul>
<%elseIf AdminTopmode = 4 Then%>
<ul>
	<li style="<%=IIF(INSTR(LCase(g_url),"member_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Member/Member_01_L.asp">회원관리</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"member_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Member/Member_02_L.asp">멤버사관리</a></li>
</ul>
<%elseIf AdminTopmode = 5 Then%>
<ul>
	<li style="<%=IIF(BoardKey=0 And INSTR(LCase(g_url),"customer_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=0">공지사항</a></li>
	<li style="<%=IIF(BoardKey=1 And INSTR(LCase(g_url),"customer_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=1">다운로드</a></li>
	<li style="<%=IIF(BoardKey=2 And INSTR(LCase(g_url),"customer_01")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_01_L.asp?BoardKey=2">쇼케이스</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"customer_03")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_03_L.asp">다운로드 분류관리</a></li>
	<li style="<%=IIF(INSTR(LCase(g_url),"customer_02")>0,"background-color:#f4f4f4;","")%>"><a href="../Customer/Customer_02_L.asp">다운로드 로그</a></li>
</ul>
<%End If%>

</div>
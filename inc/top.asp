<%
if ( Session("change_id") = "false" and INSTR(LCase(Request.ServerVariables("PATH_INFO")),"/mypage/info")<=0) then 
	response.redirect "../mypage/info.asp"
end if
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> OCEAN </title>
<meta name="Generator" content="EditPlus">
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1000">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>

<script type="text/javascript" src="../common/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/JavaScript" src="../inc/js/default.js"></script>
<script type="text/JavaScript" src="../inc/js/placeholders.js"></script>
<link rel="stylesheet" type="text/css" href="../inc/css/default.css?<%=Timestamp()%>">
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>

<meta name="description" content="표준 기반 IoT 산업 활성화를 위한 OCEAN(Open allianCE for iot stANdard)" />
<meta property="og:image" content="http://keti.ithelp.gethompy.com/ocean/img/fb.jpg" />

<STYLE type="text/css">
.ui-datepicker {width:24em; padding:.2em .2em 0;}
.ui-datepicker select.ui-datepicker-month, 
.ui-datepicker select.ui-datepicker-year {width:30%;}
</STYLE>
</head>

<body>

<div id="header">
	<div class="wrap">
		<div class="block1"><a href="../"><h1 class="logo"><span class="blind">OCEAN</span></h1></a></div>
		<div class="block2">
			<a href="../about/" class="menu <%=IIF(INSTR(LCase(g_url),"/about/")>0,"color_green on","")%>">About</a>
			<a href="../license/" class="menu <%=IIF(INSTR(LCase(g_url),"/license/")>0,"color_green on","")%>">License</a>
			<a href="../download/" class="menu <%=IIF(INSTR(LCase(g_url),"/download/")>0,"color_green on","")%>">Download</a>
			<a href="../community/" class="menu <%=IIF(INSTR(LCase(g_url),"/community/")>0,"color_green on","")%>">Community</a>			
			<a href="../showcase/" class="menu <%=IIF(INSTR(LCase(g_url),"/showcase/")>0,"color_green on","")%>">Showcase</a>
			<a href="../contact/" class="menu <%=IIF(INSTR(LCase(g_url),"/contact/")>0,"color_green on","")%>">Contact</a>
		</div>
		<%If session("UserIdx") = "" Then %>
		<div class="block3"><a href="../login/">LOGIN</a> ㅣ <a href="../join/">JOIN</a></div>
		<%Else%>
		<div class="block3"><a href="../login/logout.asp">LOGOUT</a> ㅣ <a href="../mypage/">MYPAGE</a></div>
		<%End If%>
	</div>
</div>
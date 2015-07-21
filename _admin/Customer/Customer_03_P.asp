<!-- #include file = "../inc/header.asp" -->
<%
Dim alertMsg
Dim actType    : actType    = request("actType")
Dim Idx        : Idx        = IIF( request("Idx")="" , "0" , request("Idx") )
Dim Title      : Title      = TagEncode( Trim( request("Title") ) )
Dim BoardKey   : BoardKey   = request("BoardKey")
Dim tab        : tab        = IIF( request("tab")="" , 0 , request("tab") )
Dim Order      : Order      = IIF( request("order")="" , 0 , request("order") )
Dim PageParams : PageParams = URLDecode(request("PageParams"))


Call Expires()
Call dbopen()
	if (alertMsg <> "")	then
		actType	= ""
	Elseif (actType = "INSERT") Then	'글작성
		Call insert()
		alertMsg = "입력 되었습니다."
	ElseIf (actType = "UPDATE") Then	'글수정
		Call insert()
		alertMsg = "수정 되었습니다."
	ElseIf (actType = "DELETE") Then	'글삭제
		Call insert()
		alertMsg = "삭제 되었습니다."
	else
		alertMsg = "actType[" & actType & "]이 정의되지 않았습니다."
	end If

Call dbclose()

Sub insert()
	SET objCmd	= Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection	= objConn
		.prepared				= true
		.CommandType		= adCmdStoredProc
		.CommandText		= "OCEAN_BOARD_TAP_P"
		.Parameters("@actType").value = actType
		.Parameters("@Idx").value     = Idx
		.Parameters("@Key").value     = BoardKey
		.Parameters("@Title").value   = Title
		.Parameters("@tab").value     = tab
		.Parameters("@order").value   = order
		.Execute
	End with
	set objCmd = nothing
End Sub
%>
<html>
<head>
	<META HTTP-EQUIV="Contents-Type" Contents="text/html; charset=euc-kr">
	<script language=javascript>
	<!--
		if ("<%=alertMsg%>" != "") alert('<%=alertMsg%>');
		//if("<%=actType%>" == "UPDATE"){
		//	top.location.href = "Customer_03_V.asp?<%=pageParams%>&Idx=<%=Idx%>";
		//}else{
			top.location.href = "Customer_03_L.asp?<%=pageParams%>";
		//}
	//-->
	</script>
</head>
<body></body>
</html>
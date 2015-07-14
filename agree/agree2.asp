<!-- #include file = "../inc/header.asp" -->
<%
Call Expires()
Call dbopen()
	Call AgreeView()
Call dbclose()

Sub AgreeView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_COMM_AGREE_V"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">개인정보취급방침</h2>
		<p class="page_contants"><%=FI_agree2%></p>
	</div>
</div>
<!-- #include file = "../inc/footer.asp" -->
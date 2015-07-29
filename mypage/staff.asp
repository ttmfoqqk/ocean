<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )

If Session("UserCeoFg") <> "1" Or Session("UserCIdx") = "" Then 
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The wrong path.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 10
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))

Dim pageURL    : pageURL    = g_url & "?pageNo=__PAGE__"
Dim PageParams : PageParams = "pageNo=" & pageNo

Call Expires()
Call dbopen()
	Call getView()
Call dbclose()

Sub getView()
	Set objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_USER_MEMBER_L"
		.Parameters("@rows").value       = rows 
		.Parameters("@pageNo").value     = pageNo
		.Parameters("@delFg").value      = 0
		.Parameters("@State").value      = 1
		.Parameters("@companyIdx").value = Session("UserCIdx")
		.Parameters("@ceoFg").value      = 0
		Set objRs = .Execute
	End with
	set objCmd = Nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList		= objRs.GetRows()
		cntList		= UBound(arrList, 2)
		cntTotal	= arrList(FI_tcount, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<!-- #include file = "../inc/left.asp" -->
		<div id="contant">
			<h3 class="title">Membership Request</h3>

			<STYLE type="text/css">
			.table{width:100%;border-top:2px solid #333333;}
			.table td{height:30px;border-bottom:1px solid #333333;padding:5px;text-align:center;}
			</STYLE>
			
			<form name="mForm" method="POST" action="staff_proc.asp" onsubmit="return check()">
			<table cellpadding="0" cellspacing="0" class="table">
				<tr>
					<td style="width:20px;"><input type="checkbox" name="check_all"></td>
					<td><b>아이디</b></td>
					<td style="width:150px;"><b>Name</b></td>
					<td style="width:140px;"><b>Department/Position</b></td>
					<td style="width:140px;"><b>Date</b></td>
				</tr>
				<%for iLoop = 0 to cntList%>
				<tr>
					<td><input type="checkbox" name="Idx" value="<%=arrList(FI_UserIdx,iLoop)%>"></td>
					<td><%=arrList(FI_UserId,iLoop)%></td>
					<td><%=arrList(FI_UserName,iLoop) & "  " & arrList(FI_UserNameLast,iLoop) %></td>
					<td><%=arrList(FI_UserPosition,iLoop)%></td>
					<td><%=arrList(FI_UserIndate_full,iLoop)%></td>
				</tr>
				<%Next%>
				<%if cntList < 0 then%>
				<tr>
					<td colspan="8" align="center">No Data</td>
				</tr>
				<%end if%>
			</table>

			<div style="text-align:center;margin-top:20px;">
				<div class="page_wrap"><%=printPageList(cntTotal, pageNo, rows, pageURL)%></div>
			</div>
			
			<%if cntList > -1 then%>
			<div style="text-align:center;">
				<button type="submit" class="btn">Submit</button>
			</div>
			<%end if%>
			</form>


		</div>
		
	</div>
</div>
<SCRIPT type="text/javascript">
$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).is(":checked") == true ? $('input[name=Idx]').attr({"checked":true}) : $('input[name=Idx]').attr({"checked":false});
	});
});

function check(){
	if( $('input[name=Idx]:checked').length <= 0 ){
		alert('Please select the members to be approved');
		return false;
	}
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
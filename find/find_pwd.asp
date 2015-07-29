<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
Dim arrList
Dim cntList : cntList  = -1

Call Expires()
Call dbopen()
	Call GetList()
Call dbclose()

Sub GetList()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_MEMBERSHIP_MINI_L"
		.Parameters("@CHECK").value = 0
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList = objRs.GetRows()
		cntList = UBound(arrList, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<div id="middle">
	<!-- #include file = "../inc/sub_visual.asp" -->
	<div class="wrap">
		<h2 class="page_title">Password reissue</h2>
		
		<form name="mForm" id="mForm" method="post" action="find_pwd_proc.asp" onsubmit="return check();">
		<div class="form_wrap">
			<div class="row">
				<input type="text" id="userId" name="userId" class="input" style="width:95%;ime-mode:disabled;" maxlength="255" placeholder="Company Email ( User Account )">
			</div>
			<div class="row">
				<div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
					<input type="text" class="input" id="FirstName" name="FirstName" maxlength="30" style="width:90%;" placeholder="First Name">
				</div><div style="display:inline-block;zoom:1;*display:inline;_display:inline;width:50%;">
					<input type="text" class="input" id="LastName" name="LastName" maxlength="30" style="width:90%;" placeholder="Last Name">
				</div>
			</div>
			<div class="row">
				<select class="input" id="companySelect" name="companySelect" style="width:98%;height:32px;padding:5px;">
					<option value="">Company</option>
					<%for iLoop = 0 to cntList%>
					<option value="<%=arrList(FI_idx,iLoop)%>"><%=arrList(FI_cName,iLoop)%></option>
					<%Next%>
				</select>
			</div>
		</div>
		
		<div style="margin:30px;text-align:center;">
			<button class="btn" type="submit">submit</button>
		</div>
		</form>


	</div>
</div>

<SCRIPT type="text/javascript">
function check(){
	var data = [
		 ['userId','length','Please enter id.']
		,['userId','mail','E-mail format is incorrect']
		,['FirstName','length','Please enter First Name']
		,['LastName','length','Please enter Last Name']
		,['companySelect','length','Please choose company name']
	];

	var checkform = checkInputValue(data);
	if(!checkform){return false;}
}
</SCRIPT>

<!-- #include file = "../inc/footer.asp" -->
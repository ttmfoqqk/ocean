﻿<!-- #include file = "../inc/header.asp" -->
<%
checkLogin( g_host & g_url )
dim BoardKey    : BoardKey  = 3
Dim arrListMenu
Dim cntListMenu : cntListMenu  = -1
Dim tab1        : tab1         = IIF( request("tab1")="",1,request("tab1") )
Dim tab2        : tab2         = IIF( request("tab2")="",0,request("tab2") )
Dim tab3        : tab3         = IIF( request("tab3")="","all",request("tab3") )
Dim Idx         : Idx          = IIF( request("Idx")="" , 0 , request("Idx") )
dim sType       : sType        = request("sType")
dim word        : word         = request("word")
Dim pageNo      : pageNo       = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim actType     : actType      = request("actType")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&tab1=" & tab1 &_
		"&tab2=" & tab2 &_
		"&tab3=" & tab3 &_
		"&sType" & sType &_
		"&word=" & word

If tab1 <> "" And IsNumeric( tab1 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The wrong path.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

If tab2 <> "" And IsNumeric( tab2 ) = False Then
	With Response
	 .Write "<script language='javascript' type='text/javascript'>"
	 .Write "alert('The wrong path.');"
	 .Write "history.go(-1);"
	 .Write "</script>"
	 .End
	End With
End If

Call Expires()
Call dbopen()
	Call GetListMenu()
	If cntListMenu >= 0 Then
		tab2 = IIF( tab2=0,arrListMenu(MENU_idx,0),tab2 )
	End If

	Call View()
Call dbclose()

' 게시완료 -> 읽기 가능

' 게시요청 -> 수정/삭제 가능

Sub View()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_V"
		.Parameters("@Idx").value      = Idx
		.Parameters("@BoardKey").value = BoardKey
		
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "FI")
	objRs.close	: Set objRs = Nothing
End Sub

Sub GetListMenu()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_TAP_S"
		.Parameters("@Key").value  = BoardKey
		.Parameters("@tab").value  = tab1
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "MENU")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrListMenu = objRs.GetRows()
		cntListMenu = UBound(arrListMenu, 2)
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
			<h3 class="title" id="page_title"><!-- script 에서 작성 --></h3>
			
			<div class="board_tap">
				<a href="../Community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=all">All</a>
				<a href="../Community/?tab1=<%=tab1%>&tab2=<%=tab2%>&tab3=my">My question</a>
				<a class="on">New question</a>
				<div class="underline"><!-- underline --></div>
			</div>

			<form name="mForm" method="POST" action="proc.asp" enctype="multipart/form-data" onsubmit="return check();">
			<input type="hidden" name="oldFileName" value="<%=FI_File_name%>">
			<input type="hidden" name="oldFileName2" value="<%=FI_File_name2%>">
			<input type="hidden" name="oldFileName3" value="<%=FI_File_name3%>">
			<input type="hidden" name="oldFileName4" value="<%=FI_File_name4%>">
			<input type="hidden" name="oldFileName5" value="<%=FI_File_name5%>">
			<input type="hidden" name="oldFileName6" value="<%=FI_File_name6%>">
			<input type="hidden" name="oldFileName7" value="<%=FI_File_name7%>">
			<input type="hidden" name="oldFileName8" value="<%=FI_File_name8%>">
			<input type="hidden" name="oldFileName9" value="<%=FI_File_name9%>">
			<input type="hidden" name="oldFileName10" value="<%=FI_File_name10%>">
			<input type="hidden" name="Idx" value="<%=FI_Idx%>">
			<input type="hidden" name="actType" value="<%=IIF( FI_Idx="" ,"INSERT" , IIF(actType="ANS","INSERT","UPDATE") )%>">
			<input type="hidden" name="actType2" value="<%=actType%>">
			<input type="hidden" name="tab1" value="<%=tab1%>">
			<input type="hidden" name="tab2" value="<%=tab2%>">
			<input type="hidden" name="category" id="category" value="">


			<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">
			
			<style type="text/css">
				#board_wrap .cell_title{text-align:left;padding:0px 20px 0px 20px;}
				#board_wrap .cell_cont{text-align:left;padding:0px 20px 0px 20px;}
				#board_wrap a{display:inline-block;width:165px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;vertical-align:top;}
			</style>
			<div id="board_wrap">
				<table cellpadding=0 cellspacing=0 width="100%" class="table_wrap">
					<tr>
						<td class="cell_title" style="width:80px;">Title</td>
						<td class="cell_title"><input type="text" style="width:100%" id="title" name="title" class="input" value="<%= TagDecode( FI_Title )%>" maxlength="200"></td>
					</tr>
					<tr>
						<td class="cell_cont">Contents</td>
						<td class="cell_cont" style="padding:10px 10px 10px 20px;">
							<textarea name="contants" id="contants" style="width:100%;height:300px;display:none;"><%=IIF(actType="ANS","",FI_Contants)%></textarea>
						</td>
					</tr>
					<tr>
						<td class="cell_cont">File</td>
						<td class="cell_cont">
							<input type="file" name="FileName" class="input" style="vertical-align:middle;">
							<%If FI_File_name<>"" and actType <> "ANS" Then %>
							<a href="../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name%>" style="vertical-align:middle;"><%=FI_File_name%></a>
							<input type="checkbox" value="1" name="DellFileFg" style="vertical-align:middle;"> delete
							<%End If%>
						</td>
					</tr>
				</table>
				<div class="btn_area" style="text-align:center;">
					<input type="button" class="btn_m" value="Cancel" onclick="location.href='../Community/?<%=PageParams%>'">
					&nbsp;
					<input type="submit" class="btn_m" value="Submit">
				</div>
				
			</div>

			</form>

		</div>


	</div>
</div>
<SCRIPT type="text/javascript">
$(function(){
	$page_title = $('#page_title');
	$left_menu  = $('#left_menu');
	var left_title = '';
	if( $left_menu.find('ul.sub').find('a.over').length > 0 ){
		left_title = $left_menu.find('ul.sub').find('a.over').text();
	}else{
		left_title = $left_menu.find('a.over').text();
	}
	$page_title.text(left_title);

	var category = '';
	$left_menu.find('a.over').each(function(n){
		category += $(this).text()+ (n < $left_menu.find('a.over').length-1 ? ' > ':'') ;
	});
	$('#category').val( category );
});


var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contants",
	sSkinURI: "../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor"
});

function check(){
	if( !$.trim( $('#title').val() ) ){
		alert('Please enter title.');
		return false;
	}
	oEditors.getById["contants"].exec("UPDATE_CONTENTS_FIELD", []);
}
</SCRIPT>
<!-- #include file = "../inc/footer.asp" --> 
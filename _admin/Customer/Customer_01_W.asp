<!-- #include file = "../inc/header.asp" -->
<!-- #include file = "../inc/top.asp" -->
<%
checkAdminLogin(g_host & g_url)
Dim BC_ARRY_LIST
Dim BC_CNT_LIST  : BC_CNT_LIST  = -1
Dim BC_FIRST_KEY : BC_FIRST_KEY = 0

Dim arrList
Dim cntList  : cntList  = -1
Dim cntTotal : cntTotal = 0
Dim rows     : rows     = 20
Dim pageNo   : pageNo   = CInt(IIF(request("pageNo")="","1",request("pageNo")))
Dim UserName : UserName = request("UserName")
Dim UserId   : UserId   = request("UserId")
Dim Indate   : Indate   = request("Indate")
Dim Outdate  : Outdate  = request("Outdate")
Dim BoardKey : BoardKey = request("BoardKey")
Dim Title    : Title    = request("Title")
Dim tab      : tab      = IIF( request("tab")="",0,request("tab") )
Dim tab2     : tab2     = IIF( request("tab2")="",0,request("tab2") )
dim sstatus  : sstatus  = request("status")
Dim Idx      : Idx      = IIF( request("Idx")="" , 0 , request("Idx") )

Dim actType  : actType  = request("actType")

Dim PageParams
PageParams = "pageNo=" & pageNo &_
		"&BoardKey=" & BoardKey &_
		"&UserName=" & UserName &_
		"&UserId="   & UserId &_
		"&Indate="   & Indate &_
		"&Outdate="  & Outdate &_
		"&tab="      & tab &_
		"&tab2="     & tab2 &_
		"&Title="    & Title &_
		"&sstatus="  & sstatus


Call Expires()
Call dbopen()
	Call BoardCodeList()
	Call BoardCodeView()
	Call GetList()
Call dbclose()

Sub BoardCodeList()
'왼쪽메뉴용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CODE_L"
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "BoardCode")
	If NOT(objRs.BOF or objRs.EOF) Then
		BC_ARRY_LIST = objRs.GetRows()
		BC_CNT_LIST  = UBound(BC_ARRY_LIST, 2)
		BC_FIRST_KEY = BC_ARRY_LIST(BoardCode_Idx, 0)
	End If
	objRs.close	: Set objRs = Nothing
End Sub


Sub BoardCodeView()
'관련설정용
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CODE_V"
		.Parameters("@Idx").value = BoardKey 
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldValue(objRs, "BoardCodeView")
	objRs.close	: Set objRs = Nothing
End Sub


Sub GetList()
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
%>
<script type="text/javascript">
$(document).ready( function() {
	$('input[name=check_all]').click(function(e){
		$(this).attr('checked') == true ? $('input[name=check_idx]').attr({"checked":"checked"}) : $('input[name=check_idx]').attr({"checked":""});
	});
} );
</script>
<table cellpadding=0 cellspacing=0 width="990" align=center border=0>
	<tr>
		<td class=center_left_area valign=top><!-- #include file = "../inc/left.asp" --></td>
		<td class=center_cont_area valign=top>
		<%
		If BoardCodeView_Idx = "" Or BoardCodeView_State = "1" Then 
			Response.write "잘못된 게시판 코드 입니다."
		Else
		%>
			<table cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td width="50%"><img src="../img/center_title_05_01.gif"></td>
					<td width="50%" align=right><img src="../img/navi_icon.gif"> <%=AdminLeftName%> > <%=BoardCodeView_Name%> </td>
				</tr>
				<tr><td class=center_cont_title_bg colspan=2></td></tr>
				<tr>
					<td colspan=2 style="padding:10px 0px 10px 0px"><img src="../img/center_sub_board_write.gif"></td>
				</tr>

				<form name="AdminForm" method="POST" action="Customer_01<%=IIF(BoardKey="1","_D","")%>_P.asp" enctype="multipart/form-data">
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
				<input type="hidden" name="actType" value="<%=IIF( FI_Idx="","INSERT" , IIF(actType="ANS","INSERT","UPDATE") )%>">
				<input type="hidden" name="UserIdx" value="<%=FI_UserIdx%>">
				<input type="hidden" name="BoardKey" value="<%=BoardKey%>">
				<input type="hidden" name="userEmail" value="<%=FI_email%>">

				<input type="hidden" name="PageParams" value="<%=Server.urlencode(PageParams)%>">

				<tr><td height="10"></td></tr>
				<tr>
					<td colspan=2 >

						<table cellpadding=0 cellspacing=0 width="100%">
							<%If BoardKey = "1" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<select id="tab" name="tab">
										<option value="">대분류 선택</option>
										<option value="1" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "1","selected","")%>>Mobius</option>
										<option value="2" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "2","selected","")%>>&CUBE</option>
										<option value="3" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "3","selected","")%>>Open Contribution</option>
									</select>

									<select id="tab2" name="tab2">
										<option value="">중분류 선택</option>
									</select>
								</td>
							</tr>
							<%elseIf BoardKey = "3" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">분류</td>
								<td class="line_box">
									<select id="tab" name="tab">
										<option value="">대분류 선택</option>
										<option value="1" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "1","selected","")%>>community 1</option>
										<option value="2" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "2","selected","")%>>community 2</option>
										<option value="3" <%=IIF(IIF(FI_tab="" ,tab ,FI_tab) = "3","selected","")%>>community 3</option>
									</select>

									<select id="tab2" name="tab2">
										<option value="">중분류 선택</option>
									</select>
								</td>
							</tr>
							<%End If%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">제목</td>
								<td class="line_box"><input type="text" style="width:100%" name="Title" class="input" value="<%= TagDecode( FI_Title )%>" maxlength="200"></td>
							</tr>
							
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">내용</td>
								<td class="line_box">
									<textarea name="Contants" id="Contants" style="width:100%;height:300px;display:none;"><%=FI_Contants%></textarea>
								</td>
							</tr>
							
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">첨부파일</td>
								<td class="line_box">
									<div>
										<input type="file" name="FileName" class="input">
										<%If FI_File_name<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name%>"><%=FI_File_name%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg"> 기존파일 삭제
										<%End If%>
									</div>
									<%If BoardKey="1" Then %>
									<div style="margin-top:10px;">
										<input type="file" name="FileName2" class="input">
										<%If FI_File_name2<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name2%>"><%=FI_File_name2%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name2%>"><%=FI_File_name2%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg2"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName3" class="input">
										<%If FI_File_name3<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name3%>"><%=FI_File_name3%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name3%>"><%=FI_File_name3%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg3"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName4" class="input">
										<%If FI_File_name4<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name4%>"><%=FI_File_name4%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name4%>"><%=FI_File_name4%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg4"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName5" class="input">
										<%If FI_File_name5<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name5%>"><%=FI_File_name5%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name5%>"><%=FI_File_name5%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg5"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName6" class="input">
										<%If FI_File_name6<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name6%>"><%=FI_File_name6%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name6%>"><%=FI_File_name6%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg6"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName7" class="input">
										<%If FI_File_name7<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name7%>"><%=FI_File_name7%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name7%>"><%=FI_File_name7%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg7"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName8" class="input">
										<%If FI_File_name8<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name8%>"><%=FI_File_name8%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name8%>"><%=FI_File_name8%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg8"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName9" class="input">
										<%If FI_File_name9<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name9%>"><%=FI_File_name9%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name9%>"><%=FI_File_name9%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg9"> 기존파일 삭제
										<%End If%>
									</div>

									<div style="margin-top:10px;">
										<input type="file" name="FileName10" class="input">
										<%If FI_File_name10<>"" And actType<>"ANS" Then %>
											<%If BoardKey = "1" Then %>
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/keti.ocean.download/&file=<%=FI_File_name10%>"><%=FI_File_name10%></a>
											<%Else%>											
												<a href="../../common/download.asp?pach=<%=BASE_PATH%>upload/Board/&file=<%=FI_File_name10%>"><%=FI_File_name10%></a>
											<%End If%>
										<input type="checkbox" value="1" name="DellFileFg10"> 기존파일 삭제
										<%End If%>
									</div>
									<%End If%>

								</td>
							</tr>
							<%If (BoardKey = "1" and FI_tab = "3") or BoardKey = "3" Then 
								if FI_Depth_no <= "0" and actType<>"ANS" then 
							%>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">진행상황</td>
								<td class="line_box" style="word-break:break-all">
									<%If BoardKey="1" Then%>
									<select id="status" name="status">
										<option value="">선택</option>
										<option value="0" <%=IIF(FI_status="0","selected","")%>>게시요청</option>
										<option value="1" <%=IIF(FI_status="1","selected","")%>>검토중</option>
										<option value="2" <%=IIF(FI_status="2","selected","")%>>완료</option>
									</select>
									<%elseIf BoardKey="3" Then%>
									<select id="status" name="status">
										<option value="">선택</option>
										<option value="0" <%=IIF(FI_status="0","selected","")%>>접수</option>
										<option value="1" <%=IIF(FI_status="1","selected","")%>>처리중</option>
										<option value="2" <%=IIF(FI_status="2","selected","")%>>완료</option>
									</select>
									<%End If%>
								</td>
							</tr>	
							<%
								end if
							end if
							%>
							<%If BoardKey = "0" Then %>
							<tr>
								<td class="line_box" align=center bgcolor="f0f0f0" width="140">공지</td>
								<td class="line_box"><input type="checkbox" value="1" name="Notice" <%=IIF( FI_Notice="1","checked","" )%>></td>
							</tr>
							<%End If%>
							
						</table>

					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr>
					<td align=center colspan=2>
						<img src="../img/center_btn_write_ok.gif" style="cursor:pointer;" onclick="submitContents()">
						<a href="Customer_01_L.asp?<%=PageParams%>"><img src="../img/center_btn_list.gif"></a>
						
					</td>
				</tr>
			</table>
		<%End If%>
		</td>
	</tr>
</form>
</table>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contants",
	sSkinURI: "../../common/smarteditor/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//
		}
	}, //boolean
	fOnAppLoad : function(){
		//oEditors.getById["Agree1"].exec("PASTE_HTML", [""]);
	},
	fCreator: "createSEditor2"
});

function submitContents() {
	var form=document.AdminForm;
	
	if( $('#tab').length>0 && !$('#tab').val() ){
		alert("대분류를 선택하세요.");return false;
	}
	if( $('#tab2').length>0 && !$('#tab2').val() ){
		alert("중분류를 선택하세요.");return false;
	}

	if( !trim( form.Title.value ) ){
		alert("제목을 입력하세요.");return false;
	}
	$('.btnArea').html("처리중입니다.");
	oEditors.getById["Contants"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	//document.getElementById("content").value
	try {
		form.submit();
	} catch(e) {}
}


$tab = $('#tab');
$tab2 = $('#tab2');

var temp1 = '<%=IIF(FI_tab="",tab,FI_tab)%>';
var temp2 = '<%=IIF(FI_tab2="",tab2,FI_tab2)%>';

$tab.change(function(){
	call_depth( $tab2 , $(this).val() , temp2 );
});

call_depth( $tab2 , temp1 , temp2 );

function call_depth(obj,parent,value){
	if(!parent){return false;}
	var param  = 'parent='+parent+'&boardKey=<%=BoardKey%>';

	obj.html( '<option value="">로딩 중입니다.</option>' );
	$.ajax({
		type    : 'GET',
		url     : '../../inc/ajax.download.m.asp',
		data    : param,
		dataType: 'xml',
		cache: false,
		scriptCharset:'utf-8',
		success: function(xml){
			var $xml  = $(xml);
			var $item = $xml.find('item');
			var html  = '<option value="">중분류 선택</option>';

			$item.each(function(index){
				var idx  = $(this).find('idx').text();
				var name = $(this).find('name').text();
				
				html += '<option value="'+idx+'">'+name+'</option>';
			});
			obj.html( html );
			obj.find('option[value="'+value+'"]').attr('selected',true);
		},error:function(err){
			alert(err.responseText)
			obj.html( '<option value="">에러: 잠시 후에 다시 시도해주세요.</option>' );
		}
	});
}

</script>
<!-- #include file = "../inc/bottom.asp" -->
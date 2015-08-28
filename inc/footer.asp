
<div id="footer">
	<div class="block1">
		<div class="wrap">
			<div class="share">
				<a href="#" onclick="snsShare('facebook','<%=g_host & BASE_PATH %>');return false;" class="facebook"><span class="blind">facebook</span></a>
				<a href="#" onclick="snsShare('twitter','<%=g_host & BASE_PATH %>');return false;" class="twitter"><span class="blind">twitter</span></a>
			</div>
			<a href="#" onclick="$(window).scrollTop(0);return false;" class="btn_goTop"><span class="blind">위로</span></a>
		</div>
	</div>
	<div class="block2">
		<div class="wrap">
			<h1 class="logo"><span class="blind">KETI</span></h1>
			<div class="menu">
				<a href="../agree/agree1.asp">Terms of use</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../agree/agree2.asp">Privacy policy</a>
			</div>
			<p class="copy">
				25, Saenari-ro, Bundang-gu, Seongnam-si, Gyeonggi-do, 463-816 Korea<br>
				Copyright(C) 2010 KETI. All Rights Reserved.
			</p>
		</div>
	</div>
</div>


<%
'노출 메뉴 설정
menu_filter = "/main/,/about/,/license/,/download/,/community/,/showcase/,/contact/,/join/,/login/,/mypage/"
quic_fg = false
f_menu_filter()

Function f_menu_filter()
	filter_arr = split(menu_filter, ",")
	filter_cnt = Ubound(filter_arr)

	for i=0 to filter_cnt
		if InStr( LCase(g_url),filter_arr(i) ) > 0 then
			quic_fg = true
			exit for
		end if	
	next
End Function

if quic_fg = true then 

	Dim arrList_L
	Dim cntList_L  : cntList_L  = -1
	Dim cntTotal_L : cntTotal_L = 0

	dim arrList_R
	Dim cntList_R  : cntList_R  = -1
	Dim cntTotal_R : cntTotal_R = 0

	Call Expires()
	Call dbopen()
		Call GetListQuicMenu(1 , arrList_L , cntList_L , cntTotal_L)
		Call GetListQuicMenu(2 , arrList_R , cntList_R , cntTotal_R)
	Call dbclose()


	Sub GetListQuicMenu( position , arrList , cntList , cntTotal )
		SET objRs  = Server.CreateObject("ADODB.RecordSet")
		SET objCmd = Server.CreateObject("adodb.command")
		with objCmd
			.ActiveConnection = objConn
			.prepared         = true
			.CommandType      = adCmdStoredProc
			.CommandText      = "OCEAN_BANNER_L"
			.Parameters("@rows").value     = 1000
			.Parameters("@position").value = position
			.Parameters("@is_use").value   = 0
			Set objRs = .Execute
		End with
		set objCmd = nothing
		CALL setFieldIndex(objRs, "FI")
		If NOT(objRs.BOF or objRs.EOF) Then
			arrList  = objRs.GetRows()
			cntList  = UBound(arrList, 2)
			cntTotal = arrList(FI_tcount, 0)
		End If	
		objRs.close	: Set objRs = Nothing
	End Sub


	%>
	<!-- 퀵메뉴 -->
	<style type="text/css">
		.quick_menu{clear:both;position:absolute;top:-1000px;left:-1000px;width:150px;z-index:100;text-align:left;}
		.quick_menu .item{margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid #c2c2c2;}
		.quick_menu .item img{width:150px;}
	</style>

	<%if cntList_L >= 0 then %>
	<div id="quick_left_menu" class="quick_menu">
		<%
		for iLoop = 0 to cntList_L

			Set FSO = Server.CreateObject("DEXT.FileUpload")
				If (FSO.FileExists(BASE_PATH & "upload/Board/s_" & arrList_L(FI_image,iLoop))) Then
					images = "<img src=""" & BASE_PATH & "upload/Board/s_" & arrList_L(FI_image,iLoop) & """>"
				elseif (FSO.FileExists(BASE_PATH & "upload/Board/" & arrList_L(FI_image,iLoop))) Then
					images = "<img src=""" & BASE_PATH & "upload/Board/" & arrList_L(FI_image,iLoop) & """>"
				else
					images = ""
				End If
			set FSO = Nothing

			if arrList_L(FI_target,iLoop)="0" then 
				target="_blank"
			elseif arrList_L(FI_target,iLoop)="1" then 
				target="_self"
			else
				target="_blank"
			end if
			
			if images <> "" then 
		%>
		<div class="item">
			<a href="<%=TagDecode(arrList_L(FI_link,iLoop))%>" target="<%=target%>" title="<%=arrList_L(FI_name,iLoop)%>"><%=images%></a>
		</div>
		<%
			end if
		next%>
	</div>
	<%end if%>



	<%if cntList_R >= 0 then %>
	<div id="quick_right_menu" class="quick_menu">
		<%
		for iLoop = 0 to cntList_R

			Set FSO = Server.CreateObject("DEXT.FileUpload")
				If (FSO.FileExists(BASE_PATH & "upload/Board/s_" & arrList_R(FI_image,iLoop))) Then
					images = "<img src=""" & BASE_PATH & "upload/Board/s_" & arrList_R(FI_image,iLoop) & """>"
				elseif (FSO.FileExists(BASE_PATH & "upload/Board/" & arrList_R(FI_image,iLoop))) Then
					images = "<img src=""" & BASE_PATH & "upload/Board/" & arrList_R(FI_image,iLoop) & """>"
				else
					images = ""
				End If
			set FSO = Nothing

			if arrList_R(FI_target,iLoop)="0" then 
				target="_blank"
			elseif arrList_R(FI_target,iLoop)="1" then 
				target="_self"
			else
				target="_blank"
			end if
			
			if images <> "" then 
		%>
		<div class="item">
			<a href="<%=TagDecode(arrList_R(FI_link,iLoop))%>" target="<%=target%>" title="<%=arrList_R(FI_name,iLoop)%>"><%=images%></a>
		</div>
		<%
			end if
		next%>
	</div>
	<%end if%>



	<script type="text/javascript">
	$(function(){
		var obj_header   = $('#header');
		var obj_visual_m = $('#main_backgroundImages');
		var obj_visual_s = $('.sub_visual');
		var tops         = 20;
		
		if(obj_header.length > 0){
			tops += obj_header.height();
		}
		if(obj_visual_m.length > 0){
			tops += obj_visual_m.height();
		}
		if(obj_visual_s.length > 0){
			tops += obj_visual_s.height()+50;
		}
		
		quick_position('quick_left_menu'  ,tops ,-580);
		quick_position('quick_right_menu' ,tops ,+580);
	});


	function quick_position(obj,tops,lefts){
		$(window).load(function(){
			var quick_menu = $('#'+obj);
			if( quick_menu.length <= 0 ){
				return false;
			}
			var quick_top  = tops;
			var left       = ( ($(window).width() - quick_menu.width()) / 2 ) + lefts;
			var topH       = quick_top - 20;

			quick_menu.css( {'top': quick_top ,'left': left + 'px' } );
			
			if( topH < $(document).scrollTop() ){
				quick_menu.css( { 'top': '20px','position':'fixed' } );
			}else{
				quick_menu.css( { 'top': quick_top +'px','position':'absolute' } );
			}

			$(window).scroll(function(){
				if( topH < $(document).scrollTop() ){
					quick_menu.css( { 'top': '20px','position':'fixed' } );
				}else{
					quick_menu.css( { 'top': quick_top +'px','position':'absolute' } );
				}
			});
			$( window ).resize(function() {
				var left = ( ($(window).width() - quick_menu.width()) / 2 ) + lefts;
				quick_menu.css( { 'left': left + 'px' } );
			});
		});
	}

	</SCRIPT>

<%end if%>
</body>
</html>
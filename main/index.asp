﻿<!-- #include file = "../inc/header.asp" -->
<%
Dim arrList
Dim cntList : cntList = -1

Dim arrList2
Dim cntList2 : cntList2 = -1

Call Expires()
Call dbopen()
	Call GetNotice()
	call GetFiles()
Call dbclose()

Sub GetNotice()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_MINI_L"
		.Parameters("@Key").value = 0
		.Parameters("@CNT").value = 5
		.Parameters("@notice").value = 1
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

Sub GetFiles()
	SET objRs  = Server.CreateObject("ADODB.RecordSet")
	SET objCmd = Server.CreateObject("adodb.command")
	with objCmd
		.ActiveConnection = objConn
		.prepared         = true
		.CommandType      = adCmdStoredProc
		.CommandText      = "OCEAN_BOARD_CONT_MINI_L"
		.Parameters("@Key").value = 1
		.Parameters("@CNT").value = 5
		.Parameters("@notice").value = 1
		Set objRs = .Execute
	End with
	set objCmd = nothing
	CALL setFieldIndex(objRs, "FI2")
	If NOT(objRs.BOF or objRs.EOF) Then
		arrList2 = objRs.GetRows()
		cntList2 = UBound(arrList2, 2)
	End If
	objRs.close	: Set objRs = Nothing
End Sub
%>
<!-- #include file = "../inc/top.asp" -->
<STYLE type="text/css">
#middle{background:#ffffff;}
</STYLE>
<div id="middle">
	<div class="visual" id="main_backgroundImages">
		<div class="visual_wrap">
			<div class="item" style="background:url(../img/visual/main/01.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>A global alliance based on open source and IoT standards</h4>
					<p>
						OCEAN's aim is to share the open source developed based on IoT standards  and to promote the development and <br>
						commercialization of diverse IoT services.
					</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>
			<div class="item" style="background:url(../img/visual/main/02.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>openMobius® &CUBE® Release</h4>
					<p>
						openMobius® is an IoT service platform complying with globally-accepted, <br>
						widely-used IoT standards, i.e., oneM2M specifications. <br>
						&CUBE® is a device software platform, i.e., a middleware and designed to <br>
						serve as the oneM2M specs-defined platforms for IoT gateways and devices.<br>
						The source code for the openMobius® and &CUBE® is now available. <br>
					</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>
			<div class="item" style="background:url(../img/visual/main/03.jpg) no-repeat center;">
				<div class="visual_text">
					<h4>3-claus BSD-style license</h4>
					<p>Free to use and modify the source code provided.<br>Read the license terms and conditions for more details.</p>
				</div>
				<div class="mask_left"></div>
				<div class="mask_right"></div>
				<div class="mask"></div>
			</div>

		<div class="visual_page" id="main_rolling_icon"></div>
		<div class="visual_page_left"  id="main_rolling_icon_left"><a href="javascript:;"><span class="blind">prev</span></a></div>
		<div class="visual_page_right" id="main_rolling_icon_right"><a href="javascript:;"><span class="blind">next</span></a></div>
		</div>
	</div>
	

	<div class="wrap">
		
		<!-- 게시판 -->
		<div class="main_notice" style="margin-right:15px;">
			<div class="title">NOTICE <a href="../about/notice.asp" class="more">+ MORE</a></div>
			<div class="contants">
				<table cellpadding="0" cellspacing="0" class="table">
					<%for iLoop = 0 to cntList%>
					<tr>
						<td>
							<div class="ellipsis">
								<a href="../about/notice.asp?idx=<%=arrList(FI_idx,iLoop)%>" title="<%=arrList(FI_Title,iLoop)%>"><%=arrList(FI_Title,iLoop)%></a>
							</div>
						</td>
						<td class="data"><%=arrList(FI_Indate,iLoop)%></td>
					</tr>
					<%Next%>
					<%if cntList < 0 then %>
					<tr>
						<td>등록된 내용이 없습니다.</td>
					</tr>
					<%end if%>
				</table>
			</div>
		</div>

		<div class="main_notice">
			<div class="title">DOWNLOAD <a href="../download/" class="more">+ MORE</a></div>
			<div class="contants">
				<table cellpadding="0" cellspacing="0" class="table">
					<%for iLoop = 0 to cntList2%>
					<tr>
						<td>
							<div class="ellipsis">
								<a href="../download/?tab1=<%=arrList2(FI2_tab,iLoop)%>&tab2=<%=arrList2(FI2_tab2,iLoop)%>&idx=<%=arrList2(FI2_idx,iLoop)%>" title="<%=arrList2(FI2_Title,iLoop)%>"><%=arrList2(FI2_Title,iLoop)%></a>
							</div>
						</td>
						<td class="data"><%=arrList2(FI2_Indate,iLoop)%></td>
					</tr>
					<%Next%>
					<%if cntList2 < 0 then %>
					<tr>
						<td>등록된 내용이 없습니다.</td>
					</tr>
					<%end if%>
				</table>
			</div>
		</div>
		<!-- 게시판 -->

		<div class="main_description">
			<div class="rap">
				<a href="../join/"><h4 class="color_green icon1">Membership application</h4></a>
				<p>
				The OCEAN services including downloading<br>
				source codes are provided for free under <br>
				the OCEAN membership.<br>
				In principle, the OCEAN membership is <br>
				permitted only to a person affiliated to a <br>
				company or organization.<br>

				</p>
			</div>
		</div>
		<div class="main_description">
			<div class="rap">
				<a href="../download/"><h4 class="color_green icon2">Download</h4></a>
				<p>
				You can download the source code and <br>
				documents of the standard IoT server <br>
				platform, openMobius® and IoT device <br>
				platform, &Cube®.<br>
				</p>
			</div>
		</div>
		<div class="main_description">
			<div class="rap">
				<a href="../showcase/"><h4 class="color_green icon3">Showcase</h4></a>
				<p>
				All OCEAN members are encouraged to <br>
				publish and share their developments <br>
				based on the OCEAN's open sources for <br>
				further collaboration.<br>
				</p>
			</div>
		</div>


		<div class="main_banner">
			<h4 class="color_green">MEMBERS</h4>
			<div style="margin:auto 0px;margin:20px 0px 0px 0px;position:relative;float:left;width:100%;">
				<ul class="movie">
					<li id='p_click3'><span class="blind">이전</span></li>
					<li><div id="srolling_members" style="position: relative;overflow:hidden;width:900px;height:565px;margin-left:40px;"></div></li>
					<li id='n_click3'><span class="blind">다음</span></li>
				</ul>
			</div>
		</div>

	</div>


</div>


<style type="text/css">
#srolling_members{
	position:relative;
	overflow:hidden;
	width:900px;
	height:565px;
	margin-left:40px;
}
#srolling_members .item_wrap{
	width:900px;height:565px;overflow:hidden;
}
#srolling_members .item_wrap .item{
	width:135px;height:83px;float:left;margin:15px 0px 15px 18px;overflow:hidden;text-align:center;
}
#srolling_members .item_wrap .item img{
	max-width:100%;max-height:100%;vertical-align:middle;
	_width:100%;_height:100%;
}
</style>


<SCRIPT type="text/javascript">
$(function(){
	$backgroundImages   = $('#main_backgroundImages');
	$rolling_icon       = $('#main_rolling_icon');
	$rolling_icon_left  = $('#main_rolling_icon_left');
	$rolling_icon_right = $('#main_rolling_icon_right');

	
	var rolling_icon_html = '';
	var rolling_cnt       = 0;
	var rolling_length    = $backgroundImages.find('div.item').length;
	var rolling_setTime;

	$backgroundImages.find('div.item').hide()

	for(var i=0;i<rolling_length;i++ ){
		rolling_icon_html += '<a href="javascript:;" value="'+i+'"><span class="blind">'+(i+1)+'번째 이미지</span></a> ';
	}
	$rolling_icon.html(rolling_icon_html);

	rolling_img(rolling_cnt);

	function rolling_img( t ){
		clearTimeout(rolling_setTime);
		t = t >= rolling_length ? 0 : t;
		t = t < 0 ? (rolling_length-1) : t;
		
		$rolling_icon.find('a').removeClass().unbind().filter(':eq('+t+')').addClass('on');
		$rolling_icon_left.find('a').unbind();
		$rolling_icon_right.find('a').unbind();

		$backgroundImages.find('div.item:eq('+rolling_cnt+')').stop().fadeOut(1000,function(){
			
			$backgroundImages.find('div.item:eq('+t+')').stop().fadeIn(1000,function(){
				rolling_cnt=t;
				$rolling_icon.find('a').bind('click',function(){
					rolling_img( $(this).attr('value') );
				});
				$rolling_icon_left.find('a').bind('click',function(e){
					e.preventDefault();
					rolling_img( parseInt(rolling_cnt)-1 );
				});
				$rolling_icon_right.find('a').bind('click',function(e){
					e.preventDefault();
					rolling_img( parseInt(rolling_cnt)+1 );
				});

				rolling_setTime = setTimeout(function(){rolling_img( parseInt(rolling_cnt)+1 )},10000);
			});
		});
	}




	$.ajax({
		type    : 'GET',
		url     : '../inc/ajax.members.logo.asp',
		dataType: 'xml',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(xml){
			$xml  = $(xml);
			$item = $xml.find('item');
			
			var X = 6;
			var Y = 5;
			var data = [];
			var total = $item.length;
			var items = '';
			
			if(total>0){
				$item.each(function(i){
					var name = $(this).find('name').text();
					var image = $(this).find('image').text();

					margin = (i % X) == 0? 'margin-left:0px;':'';
					clear  = (i % X) == 0? 'clear:both;':'';
					items += '<div class="item" style="'+margin+clear+'" title="'+name+'"><img style="width:0px;height:100%;overflow:hidden;"><img src="'+image+'"></div>';

					if( ( (i + 1) % (X * Y) ) == 0 ){
						data.push('<div class="item_wrap">'+items+'</div>');
						items = '';
					}else if( (i + 1) == total ){
						data.push('<div class="item_wrap">'+items+'</div>');
						items = '';
					}
				});

				$("#srolling_members").srolling({
					 data        : data
					,auto        : true
					,item_count  : 1
					,cache_count : Math.ceil( total / (X*Y) ) * 2
					,width       : 900
					,height      : 565
					,delay       : 11000
					,delay_frame : 1000
					,move        : 'left'
					,prev        : '#p_click3'
					,next        : '#n_click3'
					,is_bullet   : false
				});
			}

		},error:function(err){
			//alert(err.responseText) 
		}
	});

});
</SCRIPT>
<!-- #include file = "../inc/footer.asp" -->
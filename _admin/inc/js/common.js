function bluring(){if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();}
document.onfocusin=bluring;

var ROOT_DIR = '/'

//파라미터 리퀘스트
var Request = function(){
	this.getParameter = function( name ){
	var rtnval = '';
	var nowAddress = unescape(location.href);
	var parameters = (nowAddress.slice(nowAddress.indexOf('#')+1,nowAddress.length)).split('&');
		for(var i = 0 ; i < parameters.length ; i++){
			var varName = parameters[i].split('=')[0];
			if(varName.toUpperCase() == name.toUpperCase()){
				rtnval = parameters[i].split('=')[1];break;
			}
		}
	return rtnval;
	}
}
var request = new Request();

/*=====================================================================
 * 달력.
 *=====================================================================*/
var calendarDivId    = "__DIV_CALENDAR__";
var calendarIframeId = "__IFRAME_CALENDAR__";
//달력 보여줄 위치 찾기:Top
function getRealOffsetTop(o) {
	return o ? o.offsetTop + getRealOffsetTop(o.offsetParent) : 3;
}
//달력 보여줄 위치 찾기:Left
function getRealOffsetLeft(o) {
	return o ? o.offsetLeft + getRealOffsetLeft(o.offsetParent) : 2;
}
function hideCalendar()	{
	var cal = document.getElementById(calendarDivId);
		if(cal) cal.style.display = "none";
}
function callCalendar(obj)	{
	var top  = getRealOffsetTop(obj)+17;
	var left = getRealOffsetLeft(obj)-6;
	
	var param = '';
	if(obj) {
		var tokens = obj.value.split("-");
		if(tokens.length==3)
		{
			param   = "&year="+tokens[0];
			param  += "&month="+tokens[1];
			param  += "&day="+tokens[2];
		}
	}
	url = "../../common/calender.asp?obj="+obj.form.name+"."+obj.name;	
	if(param!="") url += param;
	var width = 215;
	var height = 180;
	var ifrm = document.getElementById(calendarIframeId);
	var div = document.getElementById(calendarDivId);
	if(!div)
	{
		div = document.createElement("DIV");
		div.id = calendarDivId;
		div.style.display = "none";
		div.style.position = "absolute";
		div.style.left = left+'px';
		div.style.top = top+'px';
		div.style.zIndex = 100;
		//obj.parentNode.appendChild(div);
		document.body.appendChild(div);
	}else{
		div.style.left = left+'px';
		div.style.top = top+'px';
	}
	if(!ifrm)
	{
		ifrm = document.createElement("IFRAME");
		ifrm.id = calendarIframeId;
		ifrm.width = width;
		ifrm.height = height;
		ifrm.frameBorder = 0;
		ifrm.scrolling = "no";
		ifrm.style.border = '1px solid #aaaaaa';
		div.appendChild(ifrm);
	}
	div.style.display = "inline";
	ifrm.src = url;
}

//-------------------------------------------------------
// 오늘 , 7일 , 30일후
//-------------------------------------------------------
function date_input(Indate,Outdate,value1,value2){
	Indate = document.getElementById(Indate);
	Outdate = document.getElementById(Outdate);
	Indate.value=value1;
	Outdate.value=value2;
}


/*===========================================================================
 * DIV 팝업창 열기
 *===========================================================================*/
function layerPopupOpen(wall_id,wall_zindex,pop_id,pop_zindex,top_px){
	var $tmp_wall = '<div class="wall" id="'+wall_id+'"></div>';
	var $layerPopupObj = $('#'+pop_id);
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 ); 
	var top_center = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 ); 
	var top_pix = ( $(window).scrollTop() + top_px ); 
	var top = top_px ? top_pix : top_center;

	$('body').append($tmp_wall);
	$('#'+wall_id).css({"z-index":wall_zindex,"height":$(document).height(),"opacity":0.5});

	$layerPopupObj.css({'left':left,'top':top,"z-index":pop_zindex});
}
/*===========================================================================
 * DIV 팝업창 삭제
 *===========================================================================*/
function layerPopupClose(wall_id,pop_id){
	var $tmp_wall = $('#'+wall_id);
	var $layerPopupObj = $('#'+pop_id);
	$tmp_wall.remove();
	$layerPopupObj.remove();
}

/*===========================================================================
 * 기초코드 콤보박스 옵션 추가하기 fc_lib.asp [fc_code_list]
 *===========================================================================*/
function getCodeAdd_combobox(objId,txt,mode,val,title){
	$(objId + ' option').remove();
	title = !title ? '선택' : title;
	var tmp_arry = txt.split('|_ARRY_|');
	var paramLi = '<option value="">'+title+'</option>';

	if(tmp_arry.length > 0){
		for(var i=0 ; i < tmp_arry.length ; i++) {
			var o = tmp_arry[i].split('|_KEY_|');
			var k = mode == 'idx' ? o[0] : o[1] ;
			var s = k == val ? 'selected' : '';
			
			paramLi += '<option value="' + k + '" '+s+'>';
			paramLi += o[1];
			paramLi += '</option>';
		}
		$(objId).html(paramLi);
	}
}

/*===========================================================================
 * TRIM 화이트스페이스 제거
 *===========================================================================*/
function trim(str){ 		
	str = str.replace(/^\s*/,'').replace(/\s*$/, '');
	return str; //변환한 스트링을 리턴.
}

/*===========================================================================
 * TagDecode script
 *===========================================================================*/
function TagDecode(str){
	var temp;
	temp = str.replace(/&quot;/gi,"\"")
	temp = temp.replace(/&#39;/gi,"\'")
	temp = temp.replace(/&lt;/gi,"<")
	temp = temp.replace(/&gt;/gi,">")
	temp = temp.replace(/<br>/gi,"\n")
	temp = temp.replace(/&amp;/gi,"&")
	return temp;
}

 //로딩
function pop_loading(){
	var html = '<div class="pop_box" id="pop_loading" style="text-align:center;width:200px;line-height:100px;"><b>LOADING..</b></div>';
	$('body').append(html);
	layerPopupOpen('wall_loading',1000,'pop_loading',1200);
}
var device = (function(){
	var deviceName = "pc";
	var userAgent = navigator.userAgent.toLocaleLowerCase();
	if(userAgent.indexOf("android") != -1){
		deviceName = "android";
	}else if(userAgent.indexOf("iphone") != -1){
		deviceName = "iphone";
	}else if(userAgent.indexOf("ipad") != -1){
		deviceName = "ipad";
	}else if(userAgent.indexOf("ipod") != -1){
		deviceName = "ipod";
	}
	return deviceName;    
})();
var snsShare = function(sns) {
    var snsUrl = "";
    var popupWidth = 0;
    var popupHeight = 0;

	var url = 'http://keti.ithelp.gethompy.com/ocean/';
	var msg = '[OCEAN]';
    
	switch (sns) {
	case "facebook":
		snsUrl = (device == "pc" ? "http://www.facebook.com/sharer.php?" : "http://m.facebook.com/sharer.php?") + "t=" + encodeURIComponent(msg) + "&u=" + encodeURIComponent(url);
		popupWidth = 520;
		popupHeight = 400;
		if (device == "pc") {
			window.open(snsUrl, sns, 'width=' + popupWidth + ', height=' + popupHeight + ',resizable=yes,scrollbars=yes');
		}
		else {
			top.location.href = snsUrl;
		}
		break;

	case "twitter":
		snsUrl = (device == "pc" ? "http://twitter.com/share?" : "https://twitter.com/intent/tweet?") + "url=" + encodeURIComponent(url) + "&text=" + encodeURIComponent(msg);
		popupWidth = 550;
		popupHeight = 430;
		if (device == "pc") {
			window.open(snsUrl, sns, 'width=' + popupWidth + ', height=' + popupHeight + ',resizable=yes,scrollbars=yes');
		}
		else {
			top.location.href = snsUrl;
		}
		break;
	}
}



var _reg_space   = /^([^\s])*$/;
var _reg_id      = /^[a-z0-9]{6,12}$/;
var _reg_pwd     = /^([a-zA-Z0-9_~!-\/:-@\[-`{-]){6,20}$/;
var _reg_name    = /^([a-zA-Z]{2,30}|[가-힣]{1,16})$/;
var _reg_company = /^([a-zA-Z0-9가-힣_~!-\/:-@\[-`{-]){2,100}$/;
var _reg_sano    = /^[0-9]{10}$/;
var _reg_mail    = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;
var _reg_phone   = /^[0-9]{1,4}$/;
var _reg_auth    = /^[0-9]{6}$/;

function CheckReg(m,str) {
	var reg = eval('_reg_'+m);
	return (reg.test(str));
}

function checkInputValue( data ){
	var obj,reg;
	for(i=0;i<data.length;i++){
		obj = document.getElementById(data[i][0]);
		reg = data[i][1];
		msg = data[i][2];
		if(reg == 'length'){
			t = obj.value.length<=0 ? false : true;
		}else if(reg == 'confirm'){
			obj2 = document.getElementById(data[i][3]);
			t = obj.value!=obj2.value ? false : true;
		}else{
			t = CheckReg( reg , obj.value );
		}
		if( !t ){
			alert(msg);
			obj.focus();
			return false;
			break;			
		}
	}
	return true;
}
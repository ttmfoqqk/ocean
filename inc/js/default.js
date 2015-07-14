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

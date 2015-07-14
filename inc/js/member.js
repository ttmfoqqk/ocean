var member_msg = {
	'userId' : {
		'm0' : '사용 가능한 아이디 입니다.',
		'm1' : '아이디를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '영소문자, 숫자 또는 혼용하여 6~12자 가능합니다.',
		'm4' : '현재 사용중인 아이디 입니다.'
	},
	'userPwd' : {
		'm0' : '보안등급 : ',
		'm1' : '비밀번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '영문 대·소, 숫자, 특수문자 혼합 6~20자 가능합니다.'
	},
	'userPwdConfirm' : {
		'm1' : '비밀번호 확인을 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '영문 대·소, 숫자, 특수문자 혼합 6~20자 가능합니다.',
		'm4' : '비밀번호와 동일하게 입력하세요.'
	},
	'userName' : {
		'm1' : '이름을 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '한글 1~16자, 영문 대·소문자 2~30자 가능합니다.'
	},
	'userCompany' : {
		'm1' : '회사명을 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '한글, 영문 대·소, 숫자, 특수문자 혼합 2~100자 가능합니다.'
	},
	'userSaNo' : {
		'm0' : '사용 가능한 사업자 등록번호 입니다.',
		'm1' : '사업자 등록번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '숫자 10자 가능합니다.',
		'm4' : '현재 사용중인 사업자 등록번호 입니다.'
	},
	'userEmail' : {
		'm0' : '사용 가능한 이메일입니다.',
		'm1' : '이메일을 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '이메일 형식이 틀렸습니다.'		
	},
	'userPhone' : {
		'm0' : '인증완료',
		'm1' : '휴대전화 번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '숫자만 입력 가능합니다.'
	},
	'userPhone2' : {
		'm0' : '인증완료',
		'm1' : '전화 번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '숫자만 입력 가능합니다.'
	},
	'userFax' : {
		'm0' : '인증완료',
		'm1' : '팩스 번호를 입력해 주시기 바랍니다.',
		'm2' : '공백문자는 입력할 수 없습니다.',
		'm3' : '숫자만 입력 가능합니다.'
	},
	'err' : '일시적인 장애입니다. 잠시 후 다시 시도해 주세요.'
	
};
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

var getPasswordLevel = function( value ) {
	var level = 0;
	var text  = '';
	var password = value;
	if(password.length > 8) {
		level++;
	}
	if(/[0-9]/.test(password)) {
		level++;
	}
	if(/[a-zA-Z]/.test(password)) {
		level++;
	}
	if(/\W/.test(password)) {
		level++;
	}
	
	return level;
};

var setPasswordLevel = function( value ) {
	var text = '';
	switch(value){
	case 0:
	case 1:
		text =  '위험';
		break;
	case 2:
		text =  '낮음';
		break;
	case 3:
		text =  '보통';
		break;
	default:
		text =  '높음';
		break;
	}
	return text;
};
var checkInputValue = function( value , reg ){
	var l = value.length;
	if( l == 0 ){
		return 1;
	}
	var t = CheckReg( 'space' , value );
	if( !t ){
		return 2;
	}
	t = CheckReg( reg , value );
	if( !t ){
		return 3;
	}
	return 0;
}

var $ajaxIdCheck = false;
var ajaxIdCheck = function( value , obj , fg ){
	$.ajax({
		type    : 'GET',
		url     : '../inc/ajax.member.check.asp',
		data    : 'actType=id&search='+value ,
		dataType: 'text',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(text){
			if(text > 0){
				obj.attr('class','color_red').text( member_msg.userId.m4 );
				if(fg){
					alert( member_msg.userId.m4 );
				}
				$ajaxIdCheck = false;
				return false;				
			}else{
				obj.attr('class','color_blue').text( member_msg.userId.m0 );
				$ajaxIdCheck = true;
				return true;
			}
		},error:function(err){
			obj.attr('class','color_red').text( member_msg.err );
			alert( member_msg.err );
			$ajaxIdCheck = false;
			return false;
			//alert(err.responseText) 
			obj.text( member_msg.err );
		}
	});
}

var $ajaxSanoCheck = false;
var ajaxSanoCheck = function( value , obj , fg ){
	$.ajax({
		type    : 'GET',
		url     : '../inc/ajax.member.check.asp',
		data    : 'actType=sano&search='+value ,
		dataType: 'text',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(text){
			if(text > 0){
				obj.attr('class','color_red').text( member_msg.userSaNo.m4 );
				if(fg){
					alert( member_msg.userSaNo.m4 );
				}
				$ajaxSanoCheck = false;
				return false;
			}else{
				obj.attr('class','color_blue').text( member_msg.userSaNo.m0 );
				$ajaxSanoCheck = true;
				return true;
			}
		},error:function(err){
			obj.attr('class','color_red').text( member_msg.err );
			alert( member_msg.err );
			$ajaxSanoCheck = false;
			return false;
			//alert(err.responseText) 
			obj.text( member_msg.err );
		}
	});
}




var checkFormUserId = function( fg , remote ){
	var _alert = $userId.next();
	var v      = $userId.val();
	var c      = checkInputValue( v , 'id' );
	
	_alert.show();

	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userId.m'+c) );
		if(fg){
			alert( eval('member_msg.userId.m'+c) );
		}
		return false;
	}
	if(remote){
		var ajax = ajaxIdCheck( v , _alert.find('div') , fg );
	}else{
		_alert.hide();
		return true;
	}
}
var checkFormUserName = function( fg ){
	var _alert = $userName.next();
	var v      = $userName.val();
	var c      = checkInputValue( v , 'name' );

	_alert.show();

	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userName.m'+c) );
		if(fg){
			alert( eval('member_msg.userName.m'+c) );
		}
		return false;
	}
	_alert.hide();
	return true;
}
var checkFormUserCompany = function( fg ){
	var _alert = $userCompany.next();
	var v      = $userCompany.val();
	var c      = checkInputValue( v , 'company' );

	_alert.show();

	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userCompany.m'+c) );
		if(fg){
			alert( eval('member_msg.userCompany.m'+c) );
		}
		return false;
	}
	_alert.hide();
	return true;
}
var checkFormUserSaNo = function( fg , remote ){
	var _alert = $userSaNo.next();
	var v      = $userSaNo.val();
	var c      = checkInputValue( v , 'sano' );

	_alert.show();

	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userSaNo.m'+c) );
		if(fg){
			alert( eval('member_msg.userSaNo.m'+c) );
		}
		return false;
	}
	if(remote){
		var ajax = ajaxSanoCheck( v , _alert.find('div') , fg );
	}else{
		_alert.hide();
		return true;
	}
}
var checkFormUserPwd = function( fg ){
	var _alert = $userPwd.next();
	_alert.show();
	var v      = $userPwd.val();
	var c      = checkInputValue( v , 'pwd' );
	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPwd.m'+c) );
		if(fg){
			alert( eval('member_msg.userPwd.m'+c) );
		}
		return false;
	}
	var level = getPasswordLevel(v);
	var text  = setPasswordLevel(level);
	_alert.find('div').attr('class', (level<3?'color_red':'color_blue') ).text( member_msg.userPwd.m0 + text );
	return true;
}
var checkFormUserPwdConfirm = function( fg ){
	var _alert = $userPwdConfirm.next();
	_alert.show();
	var v      = $userPwdConfirm.val();
	var c      = checkInputValue( v , 'pwd' );
	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPwdConfirm.m'+c) );
		if(fg){
			alert( eval('member_msg.userPwdConfirm.m'+c) );
		}
		return false;
	}
	if( v != $userPwd.val() ){
		_alert.find('div').attr('class','color_red').text( member_msg.userPwdConfirm.m4 );
		if(fg){
			alert( member_msg.userPwdConfirm.m4 );
		}
		return false;
	}
	_alert.hide()
	return true;
}
var checkFormUserEmail = function( fg ){
	var _alert = $userEmail3.next();
	_alert.show();
	var c = checkInputValue( $userEmail1.val() +'@'+$userEmail2.val() , 'mail' );
	if( c > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userEmail.m'+c) );
		if(fg){
			alert( eval('member_msg.userEmail.m'+c) );
		}
		return false;
	}
	_alert.find('div').attr('class','color_blue').text( member_msg.userEmail.m0 );
	return true;
}

var checkFormUserphoen = function( fg ){
	var _alert = $userhPhone3.next();
	_alert.show();
	var c1 = checkInputValue( $userhPhone1.val()  , 'phone' );
	if( c1 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone.m'+c1) );
		if(fg){
			alert( eval('member_msg.userPhone.m'+c1) );
		}
		return false;
	}
	var c2 = checkInputValue( $userhPhone2.val()  , 'phone' );
	if( c2 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone.m'+c2) );
		if(fg){
			alert( eval('member_msg.userPhone.m'+c2) );
		}
		return false;
	}
	var c3 = checkInputValue( $userhPhone3.val()  , 'phone' );
	if( c3 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone.m'+c3) );
		if(fg){
			alert( eval('member_msg.userPhone.m'+c3) );
		}
		return false;
	}
	_alert.hide();
	return true;
}

var checkFormUserphoen2 = function( fg ){
	var _alert = $userPhone3.next();
	_alert.show();
	var c1 = checkInputValue( $userPhone1.val()  , 'phone' );
	if( c1 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone2.m'+c1) );
		if(fg){
			alert( eval('member_msg.userPhone2.m'+c1) );
		}
		return false;
	}
	var c2 = checkInputValue( $userPhone2.val()  , 'phone' );
	if( c2 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone2.m'+c2) );
		if(fg){
			alert( eval('member_msg.userPhone2.m'+c2) );
		}
		return false;
	}
	var c3 = checkInputValue( $userPhone3.val()  , 'phone' );
	if( c3 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userPhone2.m'+c3) );
		if(fg){
			alert( eval('member_msg.userPhone2.m'+c3) );
		}
		return false;
	}
	_alert.hide();
	return true;
}

var checkFormUserFax = function( fg ){
	var _alert = $userfax3.next();
	_alert.show();
	var c1 = checkInputValue( $userfax1.val()  , 'phone' );
	if( c1 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userFax.m'+c1) );
		if(fg){
			alert( eval('member_msg.userFax.m'+c1) );
		}
		return false;
	}
	var c2 = checkInputValue( $userfax2.val()  , 'phone' );
	if( c2 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userFax.m'+c2) );
		if(fg){
			alert( eval('member_msg.userFax.m'+c2) );
		}
		return false;
	}
	var c3 = checkInputValue( $userfax3.val()  , 'phone' );
	if( c3 > 0 ){
		_alert.find('div').attr('class','color_red').text( eval('member_msg.userFax.m'+c3) );
		if(fg){
			alert( eval('member_msg.userFax.m'+c3) );
		}
		return false;
	}
	_alert.hide();
	return true;
}


var $mForm          = $('#mForm');
var $userId         = $('#userId');
var $userPwd        = $('#userPwd');
var $userPwdConfirm = $('#userPwdConfirm');
var $userName       = $('#userName');
var $userCompany    = $('#userCompany');
var $userSaNo       = $('#userSaNo');

var $userEmail1     = $('#userEmail1');
var $userEmail2     = $('#userEmail2');
var $userEmail3     = $('#userEmail3');

var $userhPhone1    = $('#userhPhone1');
var $userhPhone2    = $('#userhPhone2');
var $userhPhone3    = $('#userhPhone3');

var $userPhone1     = $('#userPhone1');
var $userPhone2     = $('#userPhone2');
var $userPhone3     = $('#userPhone3');

var $userfax1       = $('#userfax1');
var $userfax2       = $('#userfax2');
var $userfax3       = $('#userfax3');

$userId.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserId('',true);
}).keyup(function(){
	checkFormUserId('',true);
});
$userName.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserName();
});

$userCompany.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserCompany();
});

$userSaNo.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserSaNo('',true);
}).keyup(function(){
	checkFormUserSaNo('',true);
});

$userPwd.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserPwd();
});
$userPwdConfirm.focus(function(){
	$(this).next().show();
}).blur(function(){
	checkFormUserPwdConfirm();
});

$userEmail1.focus(function(){
	$userEmail3.next().show();
}).blur(function(){
	checkFormUserEmail();
});
$userEmail2.focus(function(){
	$userEmail3.next().show();
}).blur(function(){
	checkFormUserEmail();
});
$userEmail3.change(function(){
	if( $(this).val() ){
		$userEmail2.val( $(this).val() );
		checkFormUserEmail();
	}
});


$userhPhone1.change(function(){
	checkFormUserphoen();
});
$userhPhone2.focus(function(){
	$userhPhone3.next().show();
}).blur(function(){
	checkFormUserphoen();
});
$userhPhone3.focus(function(){
	$userhPhone3.next().show();
}).blur(function(){
	checkFormUserphoen();
});
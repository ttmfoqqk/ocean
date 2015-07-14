var $checkbox  = $('.checkbox_wrap');
var _input_all = $checkbox.find('input[value="all"]');
var _check_all = _input_all.parent().parent();
$checkbox.click(function(){
	var _input = $(this).find('input[type="checkbox"]');
	var _check = $(this).find('span[name="_checkbox"]');
	var _value = _input.val();

	if( _input.attr('checked') ){
		_input.attr('checked',false);
		_check.attr('class','off');
		
		_input_all.attr('checked',false);
		_check_all.attr('class','off');
	}else{
		_input.attr('checked',true);
		_check.attr('class','on');
	}

	if( _value == 'all' ){
		checkbox_all( _input.attr('name') , _input.attr('checked') );
	}
});

function checkbox_all( name , check ){
	var _input = $checkbox.find('input[name="'+name+'"]');
	var _check = _input.parent().parent();

	if( check ){
		_input.attr('checked',true);
		_check.attr('class','on');
	}else{
		_input.attr('checked',false);
		_check.attr('class','off');
	}
}


var $radio  = $('.radio_wrap');
$radio.click(function(){
	var _input = $(this).find('input[type="radio"]');
	var _check = $(this).find('span[name="_radio"]');
	var _array = $radio.find('input[name="'+_input.attr('name')+'"]');
	
	_array.attr('checked',false);
	_array.parent().parent().attr('class','off');
	_input.attr('checked',true);
	_check.attr('class','on');
});

$(function(){
	$checkbox.each(function(){
		var _input = $(this).find('input[type="checkbox"]');
		var _check = $(this).find('span[name="_checkbox"]');
		if(_input.is(':checked')){
			_check.attr('class','on');
		}
	});


	$radio.each(function(){
		var _input = $(this).find('input[type="radio"]');
		if(_input.is(':checked')){
			$(this).click();
		}
	});
});
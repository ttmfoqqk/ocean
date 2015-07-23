function ajax_board_list(params,pageNo,rows,obj,btn){
	$obj  = $('#'+obj);
	$btn  = $('#'+btn);
	$btn.unbind().val('LOADING');

	$.ajax({
		type    : 'GET',
		url     : '../inc/ajax.board.list.asp',
		data    : {
			 'pageNo'    : pageNo
			,'rows'      : rows
			,'board_key' : params[0]
			,'tab1'      : params[1]
			,'tab2'      : params[2]
			,'tab3'      : params[3]
		} ,
		dataType: 'xml',
		cache   : false,
		scriptCharset:'utf-8',
		success: function(xml){
			$cnt  = $(xml).find('cnt').text();
			$item = $(xml).find('item');
			
			var html = '';
			$item.each(function( index ){
				var tmp_html = '';
				
				var no       = $(this).find('no').text();
				var title    = $(this).find('title').text();
				var contents = $(this).find('contants').text();
				var wName    = $(this).find('wName').text();
				var created  = $(this).find('created').text();
				var tab1     = $(this).find('tab1').text();
				var tab2     = $(this).find('tab2').text();
				var file     = $(this).find('file');

				file.each(function( f_index ){
					var link = $(this).find('link').text();
					var name = $(this).find('name').text();
					tmp_html += '<a href="' +link+ '">' +name+ '</a>' + ( f_index < (file.length-1) ? ' ㅣ':'' );
				});
				
				if(file.length>0){
					tmp_html = '<div class="file"> <label>File : </label><div>' +tmp_html+ '</div> </div>';
				}				

				html += '' +
				'<div class="block">'+
					'<a href="#" onclick="$(this).next().toggle();return false;" class="link" data-idx="' +no+ '">' +title+ ' <span class="data">' +created+ '</span></a>'+
					'<div class="sub">'+
						'<div class="contents">' +contents+ '</div>'+
						tmp_html +
					'</div>'+
				'</div>';
			});

			if( $item.length<=0 ){
				html = '<div class="block"><span style="margin-left:10px;">NO DATA</a></div>';
			}

			$obj.append(html);
			
			if( (pageNo*rows)<$cnt ){
				$btn.bind('click',function(){
					ajax_board_list(params,(pageNo+1),rows,obj,btn)
				}).val('+ MORE');
			}else{
				$btn.unbind().val('LAST PAGE');
			}
			setLeftHeight();
		},error:function(err){
			alert(err.responseText);
		}
	});
}
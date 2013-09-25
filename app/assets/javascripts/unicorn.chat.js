/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function(){
	
	var msg_template = '<p><span class="msg-block"><strong></strong><span class="time"></span><span class="msg"></span></span></p>';

	$('.chat-message input').keypress(function(e){
		if(e.which == 13) {	
			if($(this).val() != ''){
				add_message('You','/assets/demo/av1.jpg',$(this).val(),true);
			}		
		}
	});
	
	var i = 0;
	function add_message(name,img,msg,clear) {
		var  inner = $('#chat-messages-inner');
		var time = new Date();
		var hours = time.getHours();
		var minutes = time.getMinutes();
		if(hours < 10) hours = '0' + hours;
		if(minutes < 10) minutes = '0' + minutes;
  var idname = name.replace(' ','-').toLowerCase();
  var chat_block = '<p><img src="'+img+'" alt="" />'
										+'<span class="msg-block"><strong>'+name+'</strong> <span class="time">- '+hours+':'+minutes+'</span>'
										+'<span class="msg">'+msg+'</span></span></p>';
		inner.append(chat_block);
		chat_block.find("p").hide().fadeIn(800);
		if(clear) {
			$('.chat-message input').val('').focus();
		}
		$('#chat-messages').animate({ scrollTop: inner.height() },1000);
	}
    function remove_user(userid,name) {
        i = i + 1;
        $('.contact-list li#user-'+userid).addClass('offline').delay(1000).slideUp(800,function(){
            $(this).remove();
        });
        var  inner = $('#chat-messages-inner');
        var id = 'msg-'+i;
        inner.append('<p class="offline" id="'+id+'"><span>User '+name+' left the chat</span></p>');
        $('#'+id).hide().fadeIn(800);
    }
});


/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function(){
	
	var msg_template = '<p><span class="msg-block"><strong></strong><span class="time"></span><span class="msg"></span></span></p>';

	$('.chat-message button').click(function(){
		var input = $(this).siblings('span').children('input[type=text]');
		if(input.val() != ''){
      data = { auth_token: "VIkbc9LEATR7vZXLx9TF", author_key: "9792efdb", content: input.val(), parent_id: '', restrict_comment_length: 'false', site_key:	'de6njq4oqblvxil4zfxdyonjdfniqq2', topic_key: '5255', topic_title: 'RDFNET-COMMENTS', topic_url: 'RDFNET-COMMENTS' }
      $.post('http://localhost:3001/api/comments/add_comment.json', data, function(response) {
        var response = $.parseJSON(response);
        add_message('You','/assets/demo/av1.jpg',response.comment_option.comment_text,true);
      });      
		}		
	});
	
	$('.chat-message input').keypress(function(e){
		if(e.which == 13) {	
			if($(this).val() != ''){
				add_message('You','/assets/demo/av1.jpg',$(this).val(),true);
			}		
		}
	});
	
	setTimeout(function(){
			add_message('Neytiri','/assets/demo/av2.jpg','I have a problem. My computer not work!')
		},'6000');
	setTimeout(function(){
			add_message('Cartoon Man','/assets/demo/av3.jpg','Turn off and turn on your computer then see result.')
		},'11000');
	setTimeout(function(){
            remove_user('neytiri','Neytiri')
        },'13500');
   	var i = 0;
	function add_message(name,img,msg,clear) {
		i = i + 1;
		var  inner = $('#chat-messages-inner');
		var time = new Date();
		var hours = time.getHours();
		var minutes = time.getMinutes();
		if(hours < 10) hours = '0' + hours;
		if(minutes < 10) minutes = '0' + minutes;
		var id = 'msg-'+i;
        var idname = name.replace(' ','-').toLowerCase();
		inner.append('<p id="'+id+'" class="user-'+idname+'"><img src="'+img+'" alt="" />'
										+'<span class="msg-block"><strong>'+name+'</strong> <span class="time">- '+hours+':'+minutes+'</span>'
										+'<span class="msg">'+msg+'</span></span></p>');
		$('#'+id).hide().fadeIn(800);
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
/*
auth_token	VIkbc9LEATR7vZXLx9TFryk2gOLooe5quZRf3dHeAd5H7hib01P7DLb8rj4cTHWMLPkSG5FxXdl187C6S6lwmH6/j5mjQA==
author_key	9792efdb
content	eJwrSS0uAQAEXQHB
parent_id	
restrict_comment_length	false
site_key	ipv96qqxc0w2gn0l9vduwicbzrlbg2r
topic_key	5255
topic_title	RDFRS: Book TV 2013 Book Expo America: Richard Dawkins, "An Appetite for Wonder"
topic_url	http://staging.richarddawkins.net/news_articles/2013/7/25/book-tv-2013-book-expo-america-richard-dawkins-an-appetite-for-wonder

url: http://rdfnet-comments-staging.herokuapp.com/api/comments/add_comment.json
*/

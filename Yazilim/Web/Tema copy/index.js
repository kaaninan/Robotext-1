$(function(){

	var a = $.cookie("session");

	if(a != null){
		if(a != 'true'){
			$('#scr_index').css('display','none');
			window.location.href="login.html";
		}else{
			$('#scr_index').css('display','block');
		}
	}else{
		$('#scr_index').css('display','none');
		window.location.href="login.html";
	}


	

});


$('a#logout').click(function(e){
    e.preventDefault();
    $.cookie("session", "false");
    $.cookie("user", null);
    $.cookie("pass", null);
    window.location.href="login.html";
});
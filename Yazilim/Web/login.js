$(function(){

	var a = $.cookie("session");

	if(a != null){
		if(a == 'true'){
			window.location.href="index.html";
		}
	}


	$('#login').click(function(){

		var index = $('#sc_inx');
		var login = $('#sc_log');

		var a = $('#email').val();
		var b = $('#sifre').val();


		if(a == "robotext" && b == "afl"){
			$('#uyari').html('');
			$.cookie("session", "true");
			$.cookie("user", "robotext");
			$.cookie("pass", "afl");
			window.location.href="index.html";

		}else{
			$.cookie("session", "false");
			$.cookie("user", null);
			$.cookie("pass", null);
			$('#uyari').html('Hatalı giriş yaptınız!');
			$('#email').val('');
			$('#sifre').val('');

		}
	});
})
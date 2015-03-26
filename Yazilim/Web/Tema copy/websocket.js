var ws = null;
var host = "localhost"
var port = 7070
var socket = ""


// Degerler

var k_ileri = "git";
var k_geri = "dur";
var k_sol = "dur";
var k_sag = "dur";


var etkin_guvenlik = "kapali";


// Bildirimler

var not_baglaniyor = $('#notification_baglaniyor');
var not_baglandi = $('#notification_baglandi');
var not_hata = $('#notification_hata');
var not_hata_websocket = $('#notification_hata_websocket');



// İstatistikler

var guvenlik_kapali_text = $('#guvenlik_kapali_text');
var guvenlik_acik_text = $('#guvenlik_acik_text');

var motor_auto_text = $('#motor_auto_text');
var motor_manual_text = $('#motor_manual_text');


var sensor_isik = $('#sensor_isik');
var sensor_sicaklik = $('span#sicaklik_deger');
var sensor_gaz = $('#sensor_gaz');
var sensor_hareket = $('#sensor_hareket');
var sensor_ses = $('#sensor_ses');



var hareket_var_icon = $('#hareket_var');
var hareket_yok_icon = $('#hareket_yok');

var ses_var_icon = $('#ses_var');
var ses_yok_icon = $('#ses_yok');



var alarm_ac_button = $('#alarm_ac_button');
var alarm_kapat_button = $('#alarm_kapat_button');

var motor_manual_button = $('#motor_manual_button');
var motor_auto_button = $('#motor_auto_button');

var guvenlik_ac_button = $('#guvenlik_ac_button');
var guvenlik_kapat_button = $('#guvenlik_kapat_button');



// BUTTON
$(function(){
    guvenlik_ac_button.click(function(){
        guvenlik_ac_button.css('display','none');
        guvenlik_kapat_button.css('display','inline');

        guvenlik_kapali_text.css('display','none');
        guvenlik_acik_text.css('display','inline');

        etkin_guvenlik = "acik";

        gonder_hareket();
    });

    guvenlik_kapat_button.click(function(){
        guvenlik_ac_button.css('display','inline');
        guvenlik_kapat_button.css('display','none');

        guvenlik_kapali_text.css('display','inline');
        guvenlik_acik_text.css('display','none');

        etkin_guvenlik = "kapali";

        gonder_hareket();
    });

});



var a = 0;
function otomatik(){
    /*
    ws.send(JSON.stringify({
            ileri: k_ileri,
            geri: k_geri,
            sag: k_sag,
            sol: k_sol
    }));
*/
}


function gonder_hareket(){
    ws.send(JSON.stringify({
            etkin_guvenlik: etkin_guvenlik
    }));
}


$(function(){
    $("#notification_baglaniyor").show();
    setTimeout(function(){
        not_baglaniyor.hide();
        baglan();
    }, 2000);
});




function baglan(){;
    var interval = null;

    var _socket = (undefined==socket)?"":"/"+socket

    _url = "ws://"+host+":"+port+_socket

    if ('MozWebSocket' in window) ws = new MozWebSocket (_url);
    else ws = new WebSocket (_url);



    ws.onclose = function(){
        $("#notification_hata_websocket").slideDown(100);
        clearInterval(interval);

    };

    ws.onopen = function () {
        interval = setInterval(otomatik, 10);    
        $("#notification_baglandi").slideDown('slow');
        setTimeout(function(){
            $("#notification_baglandi").slideUp();
        }, 4000);
    };

    ws.onerror = function (error) {
        clearInterval(interval);
        $("#notification_hata_websocket").slideDown(100);
    };

    ws.onmessage = function (e) {
        var json = $.parseJSON(e.data);
        $(json).each(function(i,val){
            $.each(val,function(k,v){
                console.log(k+" : "+ v);
                if(k == "isik"){
                    $('#sensor_isik').html(v);
                }
            });
        });
    };

}

//document.addEventListener("DOMContentLoaded", ready, false);
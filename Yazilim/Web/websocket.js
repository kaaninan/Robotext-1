var ws = null;
var host = "192.168.43.111"
var port = 7070
var socket = ""


// Degerler

var etkin_guvenlik = "kapali";
var etkin_otomatik = "kapali";
var etkin_alarm = "kapali";
var etkin_motor = "dur";


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

var motor_ileri_button = $('#motor_ileri_button');
var motor_geri_button = $('#motor_geri_button');
var motor_sag_button = $('#motor_sag_button');
var motor_sol_button = $('#motor_sol_button');
var motor_dur_button = $('#motor_dur_button');



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





    motor_manual_button.click(function(){
        motor_manual_button.css('display','none');
        motor_auto_button.css('display','inline');

        motor_manual_text.css('display','inline');
        motor_auto_text.css('display','none');

        etkin_otomatik = "kapali"

        gonder_otomatik();
    });

    motor_auto_button.click(function(){
        motor_manual_button.css('display','inline');
        motor_auto_button.css('display','none');

        motor_manual_text.css('display','none');
        motor_auto_text.css('display','inline');

        etkin_otomatik = "acik"

        gonder_otomatik();
    });




    alarm_ac_button.click(function(){
        alarm_ac_button.css('display','none');
        alarm_kapat_button.css('display','inline');

        etkin_alarm = "acik"

        gonder_alarm();
    });

    alarm_kapat_button.click(function(){
        alarm_ac_button.css('display','inline');
        alarm_kapat_button.css('display','none');

        etkin_alarm = "kapali"

        gonder_alarm();
    });




    motor_ileri_button.click(function(){
        motor_ileri_button.addClass("btn-primary");
        
        motor_geri_button.removeClass("btn-primary");
        motor_sag_button.removeClass("btn-primary");
        motor_sol_button.removeClass("btn-primary");

        motor_geri_button.addClass("btn-default");
        motor_sag_button.addClass("btn-default");
        motor_sol_button.addClass("btn-default");

        etkin_motor = 'ileri';

        gonder_motor();
    });

    motor_geri_button.click(function(){
        motor_geri_button.addClass("btn-primary");
        
        motor_ileri_button.removeClass("btn-primary");
        motor_sag_button.removeClass("btn-primary");
        motor_sol_button.removeClass("btn-primary");

        motor_ileri_button.addClass("btn-default");
        motor_sag_button.addClass("btn-default");
        motor_sol_button.addClass("btn-default");

        etkin_motor = 'geri';

        gonder_motor();
    });

    motor_sag_button.click(function(){
        motor_sag_button.addClass("btn-primary");
        
        motor_ileri_button.removeClass("btn-primary");
        motor_geri_button.removeClass("btn-primary");
        motor_sol_button.removeClass("btn-primary");

        motor_ileri_button.addClass("btn-default");
        motor_geri_button.addClass("btn-default");
        motor_sol_button.addClass("btn-default");

        etkin_motor = 'sag';

        gonder_motor();
    });

    motor_sol_button.click(function(){
        motor_sol_button.addClass("btn-primary");
        
        motor_ileri_button.removeClass("btn-primary");
        motor_sag_button.removeClass("btn-primary");
        motor_geri_button.removeClass("btn-primary");

        motor_ileri_button.addClass("btn-default");
        motor_sag_button.addClass("btn-default");
        motor_geri_button.addClass("btn-default");

        etkin_motor = 'sol';

        gonder_motor();
    });

    motor_dur_button.click(function(){
        motor_ileri_button.removeClass("btn-primary");
        motor_sag_button.removeClass("btn-primary");
        motor_sol_button.removeClass("btn-primary");
        motor_geri_button.removeClass("btn-primary");

        etkin_motor = 'dur';

        gonder_motor();
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

function gonder_otomatik(){
    ws.send(JSON.stringify({
            etkin_otomatik: etkin_otomatik
    }));
}

function gonder_alarm(){
    ws.send(JSON.stringify({
            etkin_alarm: etkin_alarm
    }));
}

function gonder_motor(){
    ws.send(JSON.stringify({
            etkin_motor: etkin_motor
    }));
}



$(function(){
    $("#notification_baglaniyor").show();
    setTimeout(function(){
        not_baglaniyor.hide();
        baglan();
    }, 1000);
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
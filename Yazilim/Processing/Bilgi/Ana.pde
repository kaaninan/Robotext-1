String IP = "192.168.1.23";
int port = 7000;

String s_arduino_uno = "/dev/ttyACM0";
String s_arduino_mega = "/dev/ttyUSB0";

boolean arduino_uno_bagli = false;
boolean arduino_mega_bagli = false;

boolean osc_gonder = false;
boolean giris_etkin = false;

String cozunurluk = "800x480";
int wait = 6000;

//String s_arduino_uno = "/dev/tty.usbmodem1421";
//String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";


void setup() {

  println(Arduino.list());

  if (arduino_uno_bagli)
    arduino_uno = new Arduino(this, s_arduino_uno, 57600);

  if (arduino_mega_bagli)
    arduino_mega = new Arduino(this, s_arduino_mega, 57600);


  remoteLocation = new NetAddress(IP, 9000);
  oscP5 = new OscP5(this, port);


  if(osc_gonder)
    gonder_durum("Pin Mode");


  // ARDUINO UNO PIN MODE
  if (arduino_uno_bagli == true) {
    arduino_uno.pinMode(a_motor_sol_on, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sag_on, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sag_arka, Arduino.OUTPUT);

    arduino_uno.pinMode(a_motor_sol_on_d, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sol_arka_d, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sag_on_d, Arduino.OUTPUT);
    arduino_uno.pinMode(a_motor_sag_arka_d, Arduino.OUTPUT);

    arduino_uno.pinMode(a_led_k_1, Arduino.OUTPUT);
    arduino_uno.pinMode(a_led_k_2, Arduino.OUTPUT);
    arduino_uno.pinMode(a_led_y_1, Arduino.OUTPUT);
    arduino_uno.pinMode(a_led_y_2, Arduino.OUTPUT);
  }


  // ARDUINO MEGA PIN MODE
  if (arduino_mega_bagli) {
    arduino_mega.pinMode(a_ses, Arduino.INPUT);
    arduino_mega.pinMode(a_hareket_1, Arduino.INPUT);
    arduino_mega.pinMode(a_hareket_2, Arduino.INPUT);

    arduino_mega.pinMode(a_buzzer, Arduino.OUTPUT);

    arduino_mega.pinMode(a_servo_1, Arduino.SERVO);
    arduino_mega.pinMode(a_servo_2, Arduino.SERVO);

    gonder_motor_sifirla(true);
    gonder_uzaklik_sifirla();
    gonder_isik_sifirla();
    gonder_hareket_sifirla();
    gonder_yakinlik_sifirla();
    gonder_voltaj_sifirla();
    
  }
  
  if(arduino_mega_bagli)
    arduino_mega.servoWrite(a_servo_1, 90);
    
  if(osc_gonder)
    gonder_durum("Mail Atiliyor");
  
  sendMailBasla();
  
  ses("merhaba");
  
  time = millis();
  
  if(osc_gonder)
    gonder_durum("Setup Finish");
}







void draw() {

  // GIRIS
  
  if(giris_etkin)
    gonder_giris();
    
  else
    giris = 1;

  if (giris == 0) { // Giriş yapılmadıysa

    if(osc_gonder){
      gonder_motor_sifirla(true);
      gonder_uzaklik_sifirla();
      gonder_isik_sifirla();
      gonder_hareket_sifirla();
      gonder_yakinlik_sifirla();
      gonder_voltaj_sifirla();
      
      if(osc_gonder)
        gonder_durum("Giris Yapilmadi");
    }
      
  } else {

    if (arduino_uno_bagli){
      uno_motor_kontrol_manual();
    }

    if(hareket_etkin == 1){
      
      if(hareket_first == true){
                                  // ###### SIFIRLAMA YAPILABİLİR ######## ///
        if(osc_gonder)
          gonder_durum("Hareket Algilama Etkinlestirildi");
        println("Hareket Algılama Etkinleştirildi");
        ses("hareket_basla");
        hareket_first = false;
      }
      
      if (arduino_mega_bagli){
        oku_hareket_sag();
        oku_hareket_sol();
        //oku_ses();
      }
    }else{
      hareket_first = true;
    }
      
  }
  
  //arduino_mega.servoWrite(a_servo_1, int(servo_1));
  
  if(millis() - time >= wait){
    time = millis();
    
    if(olcmeye_basla)
      hareket_olc();
  }
  
}

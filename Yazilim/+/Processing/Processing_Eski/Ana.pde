void setup() {

  println(Arduino.list());

  if (arduino_mega_bagli)
    arduino_mega = new Arduino(this, s_arduino_mega, 57600);


  remoteLocation = new NetAddress(IP, 9000);
  oscP5 = new OscP5(this, port);


  if(osc_gonder)
    gonder_durum("Pin Mode");


  // ARDUINO MEGA PIN MODE
  if (arduino_mega_bagli) {
    
  // PWM
  arduino_mega.pinMode(a_motor_sol_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_servo_x, Arduino.SERVO);
  arduino_mega.pinMode(a_servo_y, Arduino.SERVO);

  // DIGITAL
  arduino_mega.pinMode(a_motor_sol_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_1, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_2, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sag_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sol_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_hareket_on_sag, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_on_sol, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_arka_sag, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_arka_sol, Arduino.INPUT);
  arduino_mega.pinMode(a_ses_sensoru, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_alt_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_alt_2, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_ust_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_ust_2, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_arka_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_arka_2, Arduino.INPUT);


    gonder_motor_sifirla(true);
    gonder_uzaklik_sifirla();
    gonder_isik_sifirla();
    gonder_hareket_sifirla();
    gonder_yakinlik_sifirla();
    gonder_voltaj_sifirla();
    
  }
  
    
  if(osc_gonder)
    gonder_durum("Mail Atiliyor");
  
  //sendMailBasla();
  
  ses("merhaba");
  
  time = millis();
  
  if(osc_gonder)
    gonder_durum("Setup Finished");
    
    
}






void draw() {
  
  
  //println(arduino_mega.analogRead(a_uzaklik_sag_1)+","+arduino_mega.analogRead(a_uzaklik_sag_2)+","+arduino_mega.analogRead(a_uzaklik_sol_1)+","+arduino_mega.analogRead(a_uzaklik_sol_2));

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

    if (arduino_mega_bagli){
      mega_motor_kontrol_manual();
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
  
  if(millis() - time >= wait){
    time = millis();
    
    if(olcmeye_basla)
      hareket_olc();
  }
  
}

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
    
    arduino_mega.pinMode(a_motor_sol_on, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sag_on, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sag_arka, Arduino.OUTPUT);

    arduino_mega.pinMode(a_motor_sol_on_d, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sol_arka_d, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sag_on_d, Arduino.OUTPUT);
    arduino_mega.pinMode(a_motor_sag_arka_d, Arduino.OUTPUT);

    arduino_mega.pinMode(a_led_k_1, Arduino.OUTPUT);
    arduino_mega.pinMode(a_led_k_2, Arduino.OUTPUT);
    arduino_mega.pinMode(a_led_y_1, Arduino.OUTPUT);
    arduino_mega.pinMode(a_led_y_2, Arduino.OUTPUT);
    
    arduino_mega.pinMode(a_ses, Arduino.INPUT);
    arduino_mega.pinMode(a_hareket_1, Arduino.INPUT);
    arduino_mega.pinMode(a_hareket_2, Arduino.INPUT);

    arduino_mega.pinMode(a_hoparlor, Arduino.OUTPUT);
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
    arduino_mega.servoWrite(a_servo_2, 90);
    
  if(osc_gonder)
    gonder_durum("Mail Atiliyor");
  
  //sendMailBasla();
  
  ses("merhaba");
  
  time = millis();
  
  if(osc_gonder)
    gonder_durum("Setup Finished");
    
    
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}


void captureEvent(Capture c) {
  c.read();
}







void draw() {
  
  
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  //println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    
    arduino_mega.servoWrite(a_servo_2, faces[i].x);
    arduino_mega.servoWrite(a_servo_1, faces[i].y);
    
    //arduino_mega.servoWrite(a_servo_1, 90);
    //arduino_mega.servoWrite(a_servo_2, 90);
    
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  
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

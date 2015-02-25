import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Map; 
import processing.serial.*; 
import cc.arduino.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Robot extends PApplet {





String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";
boolean arduino_mega_bagli = true;



public void setup(){
  
  arduino_connect();
  delay(100);
  arduino_pinmode();

}


public void draw(){

  oku_hareket_sag();
  
  //println(arduino_mega.digitalRead(30));
}
Arduino arduino_mega;

public void arduino_connect(){
    
  println();
  println(Arduino.list());
  println();

  if(arduino_mega_bagli){
    arduino_mega = new Arduino(this, s_arduino_mega, 57600);
    log("Arduino -> arduino_connect", "Arduino Mega -> Baglanildi");
  }else{
    log("Arduino -> arduino_connect", "Arduino Mega -> Bagli Degil");
  }

}




public void arduino_pinmode(){
  if (arduino_mega_bagli) {
    pinMode();
  }
}


boolean hareket_oldu_sag = false;
int basla = 0;
int hareket_sayisi_sag = 0;

public void oku_hareket_sag() {
  int hareket_durum = arduino_mega.digitalRead(a_hareket_on_sag);

  if (hareket_durum == Arduino.HIGH) {

      //println("Hareket Var (SAG)");
      hareket_oldu_sag = true;
      
      if(basla == 0){
        hareket("sag");
        basla = 1;
      }
    
  } else if(hareket_durum == Arduino.LOW) {
  
      if (hareket_oldu_sag == true) {
        hareket_sayisi_sag++;
        hareket_oldu_sag = false;
        basla = 0;
        //println("Toplam Hareket (SAG): "+hareket_sayisi_sag);
      }
  }
  
}
boolean running = false;
boolean first = true;
boolean the_first = false;
boolean olcmeye_basla = false;

public void hareket(String yon){

  if(running == false){
    
    // \u0130lk Hareket Alg\u0131land\u0131\u011f\u0131nda Grafik Verilerini Ba\u015flat
    if(the_first)
      olcmeye_basla = true;
    
    running = true;
    
    println("Hareket Ba\u015flad\u0131");
    
    /*ses("hareket");
    
    if(yon == "sag"){
      servo_dondur("sag");
    }else{
      servo_dondur("sol");
    }
    
    resim_cek();
    resim_no++;
    
    if(first == true){
      println("Birinci Mail G\u00f6nderiliyor..");
      thread("sendMailBirinci");
    }
    
    */
    
    running = false;
  
  }else{
    
    // \u00dcst \u00fcste hareket alg\u0131land\u0131\u011f\u0131nda
    println("test; cakisma");
    
  }
}
public void log (String nerde, String mesaj){

  println(nerde + "  =>  " + mesaj);
  println();

}

// PWM
int a_motor_sol_on = 2;
int a_motor_sol_arka = 3;
int a_motor_sag_on = 4;
int a_motor_sag_arka = 5;
int a_servo_x = 6;
int a_servo_y = 7;

// DIGITAL
int a_motor_sol_on_yon = 22;
int a_motor_sol_arka_yon = 23;
int a_motor_sag_on_yon = 24;
int a_motor_sag_arka_yon = 25;
int a_buzzer_1 = 26;
int a_buzzer_2 = 27;
int a_ekran_sag_isik = 28;
int a_ekran_sol_isik = 29;
int a_hareket_on_sag = 30;
int a_hareket_on_sol = 31;
int a_hareket_arka_sag = 32;
int a_hareket_arka_sol = 33;
int a_ses_sensoru = 34;
int a_uzaklik_on_alt_1 = 35;
int a_uzaklik_on_alt_2 = 36;
int a_uzaklik_on_ust_1 = 37;
int a_uzaklik_on_ust_2 = 38;
int a_uzaklik_arka_1 = 39;
int a_uzaklik_arka_2 = 40;

// ANALOG
int a_motor_sol_on_hiz = 0;
int a_motor_sol_arka_hiz = 1;
int a_motor_sag_on_hiz = 2;
int a_motor_sag_arka_hiz = 3;
int a_uzaklik_sag_on = 4;
int a_uzaklik_sag_arka = 5;
int a_uzaklik_sol_on = 6;
int a_uzaklik_sol_arka = 7;
int a_sicaklik = 8;
int a_gaz = 9;
int a_ldr_on_sag = 10;
int a_ldr_on_sol = 11;
int a_ldr_arka = 12;

public void pinMode(){
  
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

  log("Pin -> pinMode","Arduino Mega -> Pin Mode -> OK");

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Robot" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

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

public void setup(){
  
  Pin pin = new Pin();
  
  arduino_connect();
  arduino_pinmode();

}
public void draw(){}
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
	Pin pin = new Pin();

	if (arduino_mega_bagli) {
		pin.pinMode(arduino_mega);
	}
}




public void log(String nerde, String mesaj){

	println(nerde + "  =>  " + mesaj);

}
class Pin {

  public void pinMode(Arduino self_arduino_mega){

    // PWM
    self_arduino_mega.pinMode(a_motor_sol_on, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sag_on, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sag_arka, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_servo_x, Arduino.SERVO);
    self_arduino_mega.pinMode(a_servo_y, Arduino.SERVO);

    // DIGITAL
    self_arduino_mega.pinMode(a_motor_sol_on_yon, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sol_arka_yon, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sag_on_yon, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_motor_sag_arka_yon, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_buzzer_1, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_buzzer_2, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_ekran_sag_isik, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_ekran_sol_isik, Arduino.OUTPUT);
    self_arduino_mega.pinMode(a_hareket_on_sag, Arduino.INPUT);
    self_arduino_mega.pinMode(a_hareket_on_sol, Arduino.INPUT);
    self_arduino_mega.pinMode(a_hareket_arka_sag, Arduino.INPUT);
    self_arduino_mega.pinMode(a_hareket_arka_sol, Arduino.INPUT);
    self_arduino_mega.pinMode(a_ses_sensoru, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_on_alt_1, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_on_alt_2, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_on_ust_1, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_on_ust_2, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_arka_1, Arduino.INPUT);
    self_arduino_mega.pinMode(a_uzaklik_arka_2, Arduino.INPUT);

    log("Pin -> pinMode","Arduino Mega -> Pin Mode -> OK");

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

}
String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";

boolean arduino_mega_bagli = true;
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Robot" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

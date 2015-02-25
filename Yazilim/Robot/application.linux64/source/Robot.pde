import java.util.Map;
import processing.serial.*;
import cc.arduino.*;

String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";
boolean arduino_mega_bagli = true;



void setup(){
  
  arduino_connect();
  delay(100);
  arduino_pinmode();

}


void draw(){

  oku_hareket_sag();
  
  //println(arduino_mega.digitalRead(30));
}

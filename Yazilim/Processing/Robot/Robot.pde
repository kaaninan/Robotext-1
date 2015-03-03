import java.util.Map;
import processing.serial.*;
import cc.arduino.*;
import muthesius.net.*;
import org.webbitserver.*;
import java.io.*;

String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";
String s_arduino_uno = "/dev/tty.usbmodem1411";

//String s_arduino_mega = "/dev/ttyUSB0";
//String s_arduino_uno = "/dev/ttyACM0";

void setup(){
  
  arduino_connect();
  
  // WebSocket
  socket = new WebSocketP5( this, 7070, "" );
  delay(100);
  //thread("json_gonder");
  
  //sensor_dinle();
}


void draw(){
  
  while(arduino_uno.available() > 0){
      
      String gelen = arduino_uno.readStringUntil('\n');
      
      gelen = trim(gelen);
      
      String[] parcala = split(gelen, ",");
      
      println(parcala.length);
      //print(parcala[4]);
      //println(parcala[5]);
      
  }
  
  //oku_hareket_sag();
  //println(arduino_mega.digitalRead(30));
  //servo();  
  //oku_hareket_sag();  
  //println(arduino_mega.analogRead(a_uzaklik_sag_on));
  //motor_web();
  //motor_manual(155,155,1,1);
  
  //println(sensor_uzaklik);
}



void stop(){
  socket.stop();
}

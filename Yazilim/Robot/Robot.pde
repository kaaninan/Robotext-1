import java.util.Map;
import processing.serial.*;
import cc.arduino.*;
import muthesius.net.*;
import org.webbitserver.*;
import java.io.*;

String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";
boolean arduino_mega_bagli = true;



void setup(){
  
  //arduino_connect();
  delay(100);
  //arduino_pinmode();
  
  // WebSocket
  socket = new WebSocketP5( this, 8080, "" );

}


void draw(){

  //oku_hareket_sag();
  
  //println(arduino_mega.digitalRead(30));
}


void stop(){
  socket.stop();
}
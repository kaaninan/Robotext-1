import java.util.Map;
import processing.serial.*;
import cc.arduino.*;
import muthesius.net.*;
import org.webbitserver.*;
import java.io.*;

String s_arduino_mega = "/dev/tty.usbserial-A603JL3X";
String s_arduino_uno = "/dev/tty.usbmodem14231";

//String s_arduino_mega = "/dev/ttyUSB0";
//String s_arduino_uno = "/dev/ttyACM0";

void setup(){
  
  //arduino_connect();
  
  // WebSocket
  socket = new WebSocketP5( this, 7070, "" );
  delay(100);
  //thread("json_gonder");
  
  //sensor_dinle();
  
  //ekran(1);
}


void draw(){
  
  //motor_web();
  //motor_manual(255,255,1,1);
  
  //ekran_isik(1,1);
  
}

void mousePressed(){
  ekran(2);
  ir(0);
}
  
void keyPressed(){
  ekran(1);
  ir(1);
}



void serialEvent(Serial myPort){
  String myString = myPort.readStringUntil('\n');
  myString = trim(myString);

  int sensors[] = int(split(myString, ','));

  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    // KALDIR
    //print("Sensor " + sensorNum + ": " +  + "\t");
    sensor_uzaklik[sensorNum] = int(sensors[sensorNum]);
  }
  // KALDIR
  //println();
  
  
  // KALDIR
  //myPort.write('A');
}



void stop(){
  socket.stop();
}

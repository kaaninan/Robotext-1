import java.util.Map;
import processing.serial.*;
import cc.arduino.*;
import muthesius.net.*;
import org.webbitserver.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Flags.Flag;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.*;
import java.awt.*;
import java.io.*;
import java.util.Properties;
import java.util.*;

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
  
}


void draw(){
  
  // ### TEST BASLANGICI ### //
  
  // MOTORLAR
    //motor_web();
    //motor_manual(255,255,1,1);
    
  // UZAKLIK
    //println(sensor_uzaklik);
      
  // LDR
    //println(sensor_ldr);
    
  /* BUZZER
    buzzer("sag", 1, null);
    delay(100);
    buzzer("sag", 0, null);
    delay(100);
    
    buzzer("sol", 1, null);
    delay(100);
    buzzer("sol", 0, null);
    delay(100);
    
    buzzer("hepsi", 1, null);
    delay(100);
    buzzer("hepsi", 0, null);
    delay(100);
  
    buzzer("sol", 3, 10);
    delay(100);
    buzzer("sag", 3, 10);
    delay(100);
  */
  
  // SICAKLIK
    //println(sensor_sicaklik);
    
  /* EKRAN ISIK
    ekran_isik(1,1);
    delay(500);
    ekran_isik(0,0);
    delay(500);
    ekran_isik(1,1);
    delay(500);
    ekran_isik(0,0);
    delay(500);
    ekran_isik(1,1);
    delay(500);
    ekran_isik(0,0);
    delay(500);
  */
  
  // EKRAN
    //ekran(1);
    //ekran(2);
    
  // HAREKET
    //println(sensor_hareket);
    
  /* SERVO
    servo("sag");
    delay(1000);
    servo("sol");
    delay(1000);
  */
  
  // SES
    //println(sensor_ses);
    
  /* KIZILOTESI
    ir(1);
    delay(2000);
    ir(0);
    delay(2000);
  */
  
  // ### TEST SONU ### //
  
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

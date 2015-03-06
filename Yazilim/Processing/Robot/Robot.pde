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
String s_arduino_uno = "/dev/tty.usbmodem14131";

//String s_arduino_mega = "/dev/ttyUSB0";
//String s_arduino_uno = "/dev/ttyACM0";

void setup(){
  
  arduino_connect();
  
  // WebSocket
  socket = new WebSocketP5( this, 7070, "" );
  delay(100);
  //thread("json_gonder");
  
  sensor_dinle();
  
  delay(1000);
  
  //thread("resim_bul");
  //thread("sendMailBirinci");
  //thread("sendMailIkinci");

  //thread("servo_test");
  //servo_test();
  /*
  
  arduino_mega.pinMode(2, Arduino.OUTPUT);
  arduino_mega.pinMode(3, Arduino.OUTPUT);
  arduino_mega.pinMode(4, Arduino.OUTPUT);
  arduino_mega.pinMode(5, Arduino.OUTPUT);
  
  arduino_mega.pinMode(22, Arduino.OUTPUT);
  arduino_mega.pinMode(23, Arduino.OUTPUT);
  arduino_mega.pinMode(24, Arduino.OUTPUT);
  arduino_mega.pinMode(25, Arduino.OUTPUT);
  
  */
}


void draw(){
  
  
  
  // ### TEST BASLANGICI ### //
  
  //motor_manual(255,255,0,0);
  
  //motor_test(255,255);
  
  // MOTORLAR
    motor_web();
    
  // UZAKLIK
    //println(sensor_uzaklik);
      
  // LDR
    //println(sensor_ldr);
    
  /* BUZZER
   buzzer("sag", 1, 1);
    delay(100);
    buzzer("sag", 0, 1);
    delay(10000);
    
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
    ekran_isik(1,1);
    //ekran(2);
    
  // HAREKET
    println(sensor_hareket);
    
  // SERVO
  //
  
  // SES
    //println(sensor_ses);
  
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

void servo_test(){
  while(true){
    /*
    arduino_mega.servoWrite(6, 10);
    arduino_mega.servoWrite(7, 10);
    delay(3000);
    arduino_mega.servoWrite(6, 170);
    arduino_mega.servoWrite(7, 170);
    delay(3000);
    */
    servo("sag");
    delay(3000);
    servo("sol");
    delay(3000);
  }
}



void serialEvent(Serial myPort){
  String myString = myPort.readStringUntil('\n');
  myString = trim(myString);

  int sensors[] = int(split(myString, ','));

  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    // KALDIR
    //print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    sensor_uzaklik[sensorNum] = int(sensors[sensorNum]);
  }
  // KALDIR
  //println();
  
  
  // KALDIR
  myPort.write('A');
}



void stop(){
  socket.stop();
  arduino_uno.stop();
}

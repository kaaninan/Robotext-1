import oscP5.*;
import netP5.*;
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
Arduino arduino_mega;

OscP5 oscP5;
Serial arduinoPort;
NetAddress remoteLocation;

// Motor
float motor_sag = 0;
float motor_sol = 0;

float motor_sag_ters = 0;
float motor_sol_ters = 0;

float servo_x = 0;
float servo_y = 0;

// ## OSC ## //

void oscEvent(OscMessage theOscMessage) {

  String addr = theOscMessage.addrPattern();
  float  val  = theOscMessage.get(0).floatValue();
  
  // Motor
  if(addr.equals("/Main/sol")){ motor_sol  = val; }
  if(addr.equals("/Main/sag")){ motor_sag  = val; }
  if(addr.equals("/Main/sag_ters")){ motor_sag_ters  = val; }
  if(addr.equals("/Main/sol_ters")){ motor_sol_ters  = val; }
  if(addr.equals("/Main/servo_x")){ servo_x  = val; }
  if(addr.equals("/Main/servo_y")){ servo_y  = val; }
}


void motor(){
  
  if(motor_sol_ters == 0){
    arduino.digitalWrite(2, Arduino.LOW);
    arduino.digitalWrite(4, Arduino.HIGH);
  }else{
    arduino.digitalWrite(2, Arduino.HIGH);
    arduino.digitalWrite(4, Arduino.LOW);
  }
  
  if(motor_sag_ters == 0){
    arduino.digitalWrite(7, Arduino.LOW);
    arduino.digitalWrite(8, Arduino.HIGH);
  }else{
    arduino.digitalWrite(7, Arduino.HIGH);
    arduino.digitalWrite(8, Arduino.LOW);
  }  
  
  arduino.analogWrite(3, int(motor_sol));
  arduino.analogWrite(5, int(motor_sol));
  arduino.analogWrite(6, int(motor_sag));
  arduino.analogWrite(9, int(motor_sag));
}


void setup() {
  printArray(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino_mega = new Arduino(this, Arduino.list()[1], 57600);
  
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.OUTPUT);
    arduino_mega.pinMode(i, Arduino.SERVO);
  
  oscP5 = new OscP5(this,7000);
}
  



void draw() {
  arduino_mega.servoWrite(2, servo_x);
  arduino_mega.servoWrite(3, servo_y);
  motor();
}

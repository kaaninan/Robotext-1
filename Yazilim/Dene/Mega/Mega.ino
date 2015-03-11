#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX

void setup(){
  
  Serial.begin(57600);
  Serial.println("Goodnight moon!");

  mySerial.begin(4800);
  mySerial.write('A');
  delay(1000);
  mySerial.write('B');
}

void loop(){
  if (mySerial.available())
    Serial.write(mySerial.read());
  if (Serial.available())
    mySerial.write(Serial.read());
}


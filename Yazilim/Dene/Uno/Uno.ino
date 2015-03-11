#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX

void setup(){
  mySerial.begin(4800);
  pinMode(13, OUTPUT);
}

void loop(){
  if (mySerial.available()){
    char gelen = mySerial.read(); 
    if(gelen == 'A'){ digitalWrite(13, HIGH); }
    else if(gelen == 'B'){ digitalWrite(13, LOW); }
  }
}


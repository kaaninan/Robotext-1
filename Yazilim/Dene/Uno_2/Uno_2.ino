#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11);

String command;


void setup(){
  
  pinMode(13, OUTPUT);
  
  int bekle = 150;
  
  Serial.begin(9600);
  Serial.println("Goodnight moon!");

  mySerial.begin(9600);
  
  delay(1000);
  mySerial.println();

  mySerial.println("on 13");
  delay(bekle);
  mySerial.println("off 13");
  delay(bekle);
  mySerial.println("on 13");
  delay(bekle);
  mySerial.println("off 13");
  delay(bekle);
  mySerial.println("on 13");
  delay(500);
  mySerial.println("off 13");
  delay(bekle);
  mySerial.println();
 
}

void loop(){
 while (mySerial.available()) {
    
    char gelen = mySerial.read();
    Serial.println(gelen);
    
    if(gelen == '\n'){
      parseCommand(command);
      command = "";
    }else{
      command+= gelen;
    }
  } 
}



void parseCommand(String com){
  String part1;
  String part2;
  
  part1 = com.substring(0, com.indexOf(" "));
  part2 = com.substring(com.indexOf(" ") + 1);
  
  if(part1.equalsIgnoreCase("pinon")){
    int pin = part2.toInt();    
    digitalWrite(pin, HIGH);
  }
  else if(part1.equalsIgnoreCase("pinoff")){
    int pin = part2.toInt();
    digitalWrite(pin, LOW);
  }
}

void establishContact() {
  while (mySerial.available() <= 0) {
    mySerial.println("connect");
    delay(300);
  }
}

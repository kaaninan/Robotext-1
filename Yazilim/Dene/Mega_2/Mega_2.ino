#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11);

void setup(){
  mySerial.begin(9600);
  pinMode(13, OUTPUT);
}

String command = "";

void loop(){
  while (mySerial.available()) {
    
    char gelen = mySerial.read();
    
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
  
  if(part1.equalsIgnoreCase("on")){
    int pin = part2.toInt();    
    digitalWrite(pin, HIGH);
  }
  else if(part1.equalsIgnoreCase("off")){
    int pin = part2.toInt();
    digitalWrite(pin, LOW);
    
    mySerial.println();
    mySerial.println("pinon 13");
  }
}

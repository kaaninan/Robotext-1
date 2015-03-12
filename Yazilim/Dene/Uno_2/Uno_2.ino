#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11);

String command;
String command2;

int sayi = 0; // sil

void setup(){
  
  pinMode(13, OUTPUT);
  
  int bekle = 150;
  //Serial.println("Starting..");

  mySerial.begin(9600);
  
  delay(500);
  mySerial.println();
  
  Serial.begin(115200);
  establishContact();
}

int a = 0;
char gelen;
char gelen2;

void loop(){
  
  if (Serial.available() > 0){
    gelen2 = Serial.read();
    if(gelen2 == '\n'){
      parseCommand(command2);
      command2 = "";
    }else{
      command2+= gelen2;
    }
  }
  
  if(mySerial.available() > 0){
    gelen = mySerial.read();
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
  
  if(part1.equalsIgnoreCase("gelen")){
    int pin = part2.toInt();
    digitalWrite(pin, HIGH);
  }
  else if(part1.equalsIgnoreCase("gelen2")){
    int pin = part2.toInt();
    digitalWrite(pin, LOW);
  }
  else if(part1.equalsIgnoreCase("test")){
    int pin = part2.toInt();
    mySerial.println("test 13");
  }
  else if(part1.equalsIgnoreCase("yak")){
    int pin = part2.toInt();
    mySerial.println("on 13");
  }
  else if(part1.equalsIgnoreCase("sondur")){
    int pin = part2.toInt();
    mySerial.println("off 13");
  }
  else if(part1.equalsIgnoreCase("deger")){
    int pin = part2.toInt();
    digitalWrite(13, HIGH);
    Serial.println(pin);
    sayi++;
  }
}



void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("Loading..");
    delay(300);
  }
}

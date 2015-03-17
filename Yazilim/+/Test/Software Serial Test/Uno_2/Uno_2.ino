#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11);

String command;
String command2;


void setup(){
  
  pinMode(13, OUTPUT);
  
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
  
  
  
  
  // MEGA'YA YOLLA (CEVAPSIZ)
  
  // BUZZER
  else if(part1.equalsIgnoreCase("+1")){
    int pin = part2.toInt();
    mySerial.print("+1 ");
    mySerial.println(pin);
  }
  
  // EKRAN ISIK
  else if(part1.equalsIgnoreCase("+2")){
    int pin = part2.toInt();
    mySerial.print("+2 ");
    mySerial.println(pin);
  }
  
  // BUZZER
  else if(part1.equalsIgnoreCase("+3")){
    int pin = part2.toInt();
    mySerial.print("+3 ");
    mySerial.println(pin);
  }
  
  // SERVO SAG
  else if(part1.equalsIgnoreCase("+4")){
    int pin = part2.toInt();
    mySerial.print("+4 ");
    mySerial.println(pin);
  }
  
  // SERVO SOL
  else if(part1.equalsIgnoreCase("+5")){
    int pin = part2.toInt();
    mySerial.print("+5 ");
    mySerial.println(pin);
  }
  
  
  
  
  
  // MEGA'YA YOLLA (CEVAPLI)
  
  // UZAKLIK
  else if(part1.equalsIgnoreCase("-11")){
    mySerial.println("-11 0");
  }
  else if(part1.equalsIgnoreCase("-12")){
    mySerial.println("-12 0");
  }
  else if(part1.equalsIgnoreCase("-13")){
    mySerial.println("-13 0");
  }
  else if(part1.equalsIgnoreCase("-14")){
    mySerial.println("-14 0");
  }
  else if(part1.equalsIgnoreCase("-15")){
    mySerial.println("-15 0");
  }
  else if(part1.equalsIgnoreCase("-16")){
    mySerial.println("-16 0");
  }
  
  // HAREKET
  else if(part1.equalsIgnoreCase("-21")){
    mySerial.println("-21 0");
  }
  else if(part1.equalsIgnoreCase("-22")){
    mySerial.println("-22 0");
  }
  
  // SES
  else if(part1.equalsIgnoreCase("-3")){
    mySerial.println("-3 0");
  }
  
  // ISIK
  else if(part1.equalsIgnoreCase("-4")){
    mySerial.println("-4 0");
  }
  
  // YAKINLIK
  else if(part1.equalsIgnoreCase("-51")){
    mySerial.println("-51 0");
  }
  else if(part1.equalsIgnoreCase("-52")){
    mySerial.println("-52 0");
  }
  
  
  
  // MEGA'DAN GELEN
  
  
  // UZAKLIK
  else if(part1.equalsIgnoreCase("-111")){
    int pin = part2.toInt();
    Serial.print("-111 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-121")){
    int pin = part2.toInt();
    Serial.print("-121 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-131")){
    int pin = part2.toInt();
    Serial.print("-131 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-141")){
    int pin = part2.toInt();
    Serial.print("-141 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-151")){
    int pin = part2.toInt();
    Serial.print("-151 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-161")){
    int pin = part2.toInt();
    Serial.print("-161 ");
    Serial.println(pin);
  }
  
  
  // HAREKET
  else if(part1.equalsIgnoreCase("-211")){
    int pin = part2.toInt();
    Serial.print("-211 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-221")){
    int pin = part2.toInt();
    Serial.print("-221 ");
    Serial.println(pin);
  }
  
  // SES
  else if(part1.equalsIgnoreCase("-31")){
    int pin = part2.toInt();
    Serial.print("-31 ");
    Serial.println(pin);
  }
  
  // ISIK
  else if(part1.equalsIgnoreCase("-41")){
    int pin = part2.toInt();
    Serial.print("-41 ");
    Serial.println(pin);
  }
  
  // YAKINLIK
  else if(part1.equalsIgnoreCase("-511")){
    int pin = part2.toInt();
    Serial.print("-511 ");
    Serial.println(pin);
  }
  else if(part1.equalsIgnoreCase("-521")){
    int pin = part2.toInt();
    Serial.print("-521 ");
    Serial.println(pin);
  }
}



void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("Loading..");
    delay(300);
  }
}

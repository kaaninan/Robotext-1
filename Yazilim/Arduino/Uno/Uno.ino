#include <SoftwareSerial.h>


// VALUES
int hiz = 9600; // mySerial

String command;
String command2;
char gelen;
char gelen2;


// SENSOR VALUES
int deger_motor_sag_on_enkoder = 0;
int deger_motor_sag_arka_enkoder = 0;
int deger_motor_sol_on_enkoder = 0;
int deger_motor_sol_arka_enkoder = 0;
int deger_sicaklik = 0;
int deger_yakinlik = 0;



// ### IO ###

// DIGITAL
int motor_sag_on_hiz = 3;
int motor_sag_arka_hiz = 5;
int motor_sol_on_hiz = 6;
int motor_sol_arka_hiz = 9;

int motor_sag_on_yon = 2;
int motor_sag_arka_yon = 4;
int motor_sol_on_yon = 7;
int motor_sol_arka_yon = 8;

SoftwareSerial mySerial(10, 11);

int transistor_1 = 12;
int transistor_2 = 13;


// ANALOG
int motor_sag_on_enkoder = 0;
int motor_sag_arka_enkoder = 1;
int motor_sol_on_enkoder = 2;
int motor_sol_arka_enkoder = 3;

int sicaklik = 4;
int yakinlik = 5;



void setup(){
  
  pinMode(motor_sag_on_hiz, OUTPUT);
  pinMode(motor_sag_arka_hiz, OUTPUT);
  pinMode(motor_sol_on_hiz, OUTPUT);
  pinMode(motor_sol_arka_hiz, OUTPUT);
  pinMode(motor_sag_on_yon, OUTPUT);
  pinMode(motor_sag_arka_yon, OUTPUT);
  pinMode(motor_sol_on_yon, OUTPUT);
  pinMode(motor_sol_arka_yon, OUTPUT);
  
  pinMode(transistor_1, OUTPUT);
  pinMode(transistor_2, OUTPUT);
  
  /*
  mySerial.begin(hiz);
  delay(500);
  mySerial.println();
  */
  
  Serial.begin(115200);
  establishContact();
}



void loop(){
  
  oku_sensor();
  
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



// ### MOTOR ###

void motor_ileri(){}
void motor_geri(){}
void motor_sag(){}
void motor_sol(){}
void motor_dur(){}
void motor_ileri_sag(){}
void motor_ileri_sol(){}




// ### SENSOR ###

void oku_sensor(){
  oku_sicaklik();
  oku_yakinlik();
  oku_enkoder();
}


void oku_sicaklik(){
  deger_sicaklik = (5.0 * analogRead(sicaklik) * 100.0) / 1024;
}

void oku_yakinlik(){
  deger_yakinlik = analogRead(yakinlik);
}

void oku_enkoder(){
  deger_motor_sag_on_enkoder = analogRead(motor_sag_on_enkoder);
  deger_motor_sag_arka_enkoder = analogRead(motor_sag_arka_enkoder);
  deger_motor_sol_on_enkoder = analogRead(motor_sol_on_enkoder);
  deger_motor_sol_arka_enkoder = analogRead(motor_sol_arka_enkoder);
}




// ### CIKIS ###

void cikis_transistor_1(int a){
  digitalWrite(transistor_1, a);
}

void cikis_transistor_2(int a){
  digitalWrite(transistor_2, a);
}





// ### SERIAL ###

void parseCommand(String com){
  String part1;
  String part2;
  
  part1 = com.substring(0, com.indexOf(" "));
  part2 = com.substring(com.indexOf(" ") + 1);
  
  
  // TEST
  if(part1.equalsIgnoreCase("gelen")){
    int pin = part2.toInt();
    digitalWrite(pin, HIGH);
  }
  else if(part1.equalsIgnoreCase("gelen2")){
    int pin = part2.toInt();
    digitalWrite(pin, LOW);
  }
  
  
  
  // UNO'YA GELEN (CEVAPSIZ)
  
  // MOTOR
  else if(part1.equalsIgnoreCase("+01")){ motor_ileri(); }
  else if(part1.equalsIgnoreCase("+02")){ motor_geri(); }
  else if(part1.equalsIgnoreCase("+03")){ motor_sag(); }
  else if(part1.equalsIgnoreCase("+04")){ motor_sol(); }
  else if(part1.equalsIgnoreCase("+05")){ motor_ileri_sag(); }
  else if(part1.equalsIgnoreCase("+06")){ motor_ileri_sol(); }
  else if(part1.equalsIgnoreCase("+07")){ motor_dur(); }
  
  
  // TRANSISTOR
  else if(part1.equalsIgnoreCase("+08")){
    int pin = part2.toInt();
    cikis_transistor_1(pin);
  }
  else if(part1.equalsIgnoreCase("+09")){
    int pin = part2.toInt();
    cikis_transistor_1(pin);
  }
  
  
  
  
  // UNO'YA GELEN (CEVAPLI)
  
  // SICAKLIK
  else if(part1.equalsIgnoreCase("-01")){
    Serial.print("-01 ");
    Serial.println(deger_sicaklik);
  }
  
  // YAKINLIK
  else if(part1.equalsIgnoreCase("-02")){
    Serial.print("-02 ");
    Serial.println(deger_yakinlik);
  }
  
  // ENKODER
  else if(part1.equalsIgnoreCase("-03")){
    Serial.print("-03 ");
    Serial.println(deger_motor_sag_on_enkoder);
  }
  else if(part1.equalsIgnoreCase("-04")){
    Serial.print("-04 ");
    Serial.println(deger_motor_sag_arka_enkoder);
  }
  else if(part1.equalsIgnoreCase("-05")){
    Serial.print("-05 ");
    Serial.println(deger_motor_sol_on_enkoder);
  }
  else if(part1.equalsIgnoreCase("-06")){
    Serial.print("-06 ");
    Serial.println(deger_motor_sol_arka_enkoder);
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

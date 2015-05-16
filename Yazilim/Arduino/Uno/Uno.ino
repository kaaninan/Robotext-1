#include <SoftwareSerial.h>
SoftwareSerial SIM900(10, 11);
String textForSMS;
String textForSMS2;
                
String command = "";
boolean oku = true;

// PINS
int sag_on_yon = 2;
int sag_on_hiz = 3;
int sag_arka_yon = 4;
int sag_arka_hiz = 5;
int sol_on_hiz = 6;
int sol_on_yon = 7;
int sol_arka_yon = 8;
int sol_arka_hiz = 9;

void setup(){
  pinMode(sag_on_yon, OUTPUT);
  pinMode(sag_on_hiz, OUTPUT);
  pinMode(sag_arka_yon, OUTPUT);
  pinMode(sag_arka_hiz, OUTPUT);
  pinMode(sol_on_hiz, OUTPUT);
  pinMode(sol_on_yon, OUTPUT);
  pinMode(sol_arka_yon, OUTPUT);
  pinMode(sol_arka_hiz, OUTPUT);
  pinMode(13, OUTPUT);

  digitalWrite(13, LOW);
  
  Serial.begin(115200);
  SIM900.begin(9600);
  
  delay(5000);
  digitalWrite(13, HIGH);
  establishContact();
}

void sendSMS(String message){
  SIM900.print("AT+CMGF=1\r");
  delay(50);
  SIM900.println("AT + CMGS = \"+905414955742\"");
  delay(50);
  SIM900.println(message);
  delay(50);
  SIM900.println((char)26);
  delay(50);
  SIM900.println();
}

void loop(){
  textForSMS = "ROBOTEXT Guvenlik Sistemi - Sistem Baslatildi";
  textForSMS2 = "ROBOTEXT Guvenlik Sistemi - Hareket Algilandi!";
 
}




void serialEvent(){
  while(Serial.available()) {
    
    char gelen = Serial.read();
    if (gelen == '&') {
      parseCommand(command);
      command = "";
    } else {
      command += gelen;
    }
  }
}



// ### Serial ###

void parseCommand(String com) {

  String part1;
  String part2;

  part1 = com.substring(0, com.indexOf(" "));
  part2 = com.substring(com.indexOf(" ") + 1);


  // ### GELEN ###
  
  
  // Ileri
  if (part1.equalsIgnoreCase("+1")) {
    int pin = part2.toInt();
    digitalWrite(2, LOW);
    digitalWrite(4, HIGH);
    digitalWrite(7, LOW);
    digitalWrite(8, HIGH);
  }
  
  // Geri
  else if (part1.equalsIgnoreCase("+2")) {
    int pin = part2.toInt();
    digitalWrite(2, HIGH);
    digitalWrite(4, LOW);
    digitalWrite(7, HIGH);
    digitalWrite(8, LOW);
  }
  
  
  // Sag
  else if (part1.equalsIgnoreCase("+3")) {
    int pin = part2.toInt();
    digitalWrite(2, LOW);
    digitalWrite(4, HIGH);
    digitalWrite(7, HIGH);
    digitalWrite(8, LOW);
  }
  
  // Sol
  else if (part1.equalsIgnoreCase("+4")) {
    int pin = part2.toInt();
    digitalWrite(2, HIGH);
    digitalWrite(4, LOW);
    digitalWrite(7, LOW);
    digitalWrite(8, HIGH);
  }
  
  // Git
  else if (part1.equalsIgnoreCase("+5")) {
    int pin = part2.toInt();
    digitalWrite(3, HIGH);
    digitalWrite(5, HIGH);
    digitalWrite(6, HIGH);
    digitalWrite(9, HIGH);
  }
  
  // Dur
  else if (part1.equalsIgnoreCase("+6")) {
    int pin = part2.toInt();
    digitalWrite(3, LOW);
    digitalWrite(5, LOW);
    digitalWrite(6, LOW);
    digitalWrite(9, LOW);
  }
  
  // Baslangic SMS
  else if (part1.equalsIgnoreCase("+7")) {
    int pin = part2.toInt();
    sendSMS(textForSMS);
    Serial.println("Mesaj Gonderildi");
  }
  
  // Hareket SMS
  else if (part1.equalsIgnoreCase("+8")) {
    int pin = part2.toInt();
    sendSMS(textForSMS2);
    Serial.println("Mesaj Gonderildi");
  }
  
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("Loading..");
    delay(300);
  }
}

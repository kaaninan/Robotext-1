#include <SharpIR.h>
#include <IRremote.h>
#include <IRremoteInt.h>

int trig = 4;
int echo = 5;
long deger;
long cm;

int trig2 = 6;
int echo2 = 7;
long deger2;
long cm2;

int ir_komut = 13;

IRsend irsend;

SharpIR sharp_sag_on(A0, 25, 93, 1080);
SharpIR sharp_sag_arka(A1, 25, 93, 1080);
SharpIR sharp_sol_on(A2, 25, 93, 1080);
SharpIR sharp_sol_arka(A3, 25, 93, 1080);

void setup(){
  
  Serial.begin(57600);
  
  // KALDIR
//  pinMode (A0, INPUT);
//  pinMode (A1, INPUT);
//  pinMode (A2, INPUT);
//  pinMode (A3, INPUT);
  // KALDIR
  
  
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(trig2, OUTPUT);
  pinMode(echo2, INPUT);
  
  pinMode(ir_komut, INPUT);

  // KALDIR
//  pinMode(3, OUTPUT);  
  establishContact();
  // KALDIR

}


void loop(){
  
  int a = digitalRead(ir_komut);
  
  if(a == HIGH){
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      delay(10);
  }else{
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      delay(10);
  }
  
  if (Serial.available() > 0) {
    delay(100);
    
    digitalWrite(trig, LOW);
    digitalWrite(trig, HIGH);
    digitalWrite(trig, LOW);
    
    deger = pulseIn(echo, HIGH, 15000);
    cm = deger/29/2;
    
    delay(50);
    
    digitalWrite(trig2, LOW);
    digitalWrite(trig2, HIGH);
    digitalWrite(trig2, LOW);
    
    deger2 = pulseIn(echo2, HIGH, 15000);
    cm2 = deger2/29/2;
    
    delay(50);
    
  
    unsigned long pepe1 = millis();
    int dis_sag_on = sharp_sag_on.distance();
    int dis_sag_arka = sharp_sag_arka.distance();
    int dis_sol_on = sharp_sol_on.distance();
    int dis_sol_arka = sharp_sol_arka.distance();
    
    Serial.print(dis_sag_on);
    Serial.print(",");
    Serial.print(dis_sag_arka);
    Serial.print(",");
    Serial.print(dis_sol_on);
    Serial.print(",");
    Serial.print(dis_sol_arka);
    Serial.print(",");
    Serial.print(cm);
    Serial.print(",");
    Serial.println(cm2);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0,0,0");   // send an initial string
    delay(300);
  }
}

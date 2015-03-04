#include <Servo.h>
#include <IRremote.h>

int kirmizi = 3;
int yesil = 4;

Servo servo;
int ir_alici = 7;

IRrecv irrecv(ir_alici);
decode_results results;

#define CH1 0xFFA25D 
#define CH 0xFF629D
#define CH2 0xFFE21D 
#define PREV 0xFF22DD 
#define NEXT 0xFF02FD 
#define PLAYPAUSE 0xFFC23D 
#define VOL1 0xFFE01F 
#define VOL2 0xFFA857 
#define EQ 0xFF906F
#define BUTON0 0xFF6897 
#define BUTON100 0xFF9867 
#define BUTON200 0xFFB04F 
#define BUTON1 0xFF30CF 
#define BUTON2 0xFF18E7 
#define BUTON3 0xFF7A85 
#define BUTON4 0xFF10EF 
#define BUTON5 0xFF38C7
#define BUTON6 0xFF5AA5 
#define BUTON7 0xFF42BD 
#define BUTON8 0xFF4AB5 
#define BUTON9 0xFF52AD


void setup() {
  pinMode(kirmizi, OUTPUT);
  pinMode(yesil, OUTPUT);
  irrecv.enableIRIn();
  servo.attach(2);
}

void loop() {

  if (irrecv.decode(&results)) {
    
    if (results.value == CH1) {
      servo.write(180);
      digitalWrite(kirmizi, HIGH);
      digitalWrite(yesil, LOW);
    }
    if (results.value == CH){
      servo.write(0);
      digitalWrite(kirmizi, LOW);
      digitalWrite(yesil, HIGH);
    }
    if (results.value == CH2){}
    if (results.value == PREV){}
    if (results.value == NEXT){}
    if (results.value == PLAYPAUSE){}
    if (results.value == VOL1){}
    if (results.value == VOL2){}
    if (results.value == EQ){}
    if (results.value == BUTON0){}
    if (results.value == BUTON100){}
    if (results.value == BUTON200){}
    if (results.value == BUTON1){}
    if (results.value == BUTON2){}
    if (results.value == BUTON3){}
    if (results.value == BUTON4){}
    if (results.value == BUTON5){}
    if (results.value == BUTON6){}
    if (results.value == BUTON7){}
    if (results.value == BUTON8){}
    if (results.value == BUTON9){}

    irrecv.resume();
  }
  
}

 

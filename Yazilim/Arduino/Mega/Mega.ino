#include <LiquidCrystal.h>
#include <SoftwareSerial.h>
#include <Servo.h>
#include <SharpIR.h>


// VALUES
String command = "";
boolean oku = false;


// LOG
int log_uzaklik_sonic = 1;
int log_uzaklik_ir = 1;
int log_hareket = 1;
int log_ses = 1;
int log_isik = 1;
int log_yakinlik = 1;



// SENSOR VALUES
int deger_uzaklik_on_sag = 0;
int deger_uzaklik_on_sol = 0;
int deger_uzaklik_sag_on = 0;
int deger_uzaklik_sag_arka = 0;
int deger_uzaklik_sol_on = 0;
int deger_uzaklik_sol_arka = 0;
int deger_hareket_sag = 0;
int deger_hareket_sol = 0;
int deger_ses = 0;
int deger_isik = 0;
int deger_yakinlik_sag = 0;
int deger_yakinlik_sol = 0;



// ### IO ###


// PWM
int servo_x_pin = 2;
int servo_y_pin = 3;
Servo servo_x;
Servo servo_y;
int led_1 = 4;
int led_2 = 5;


// DIGITAL
const int uzaklik_on_sag_t = 22;
const int uzaklik_on_sag_e = 23;
const int uzaklik_on_sol_t = 24;
const int uzaklik_on_sol_e = 25;
const int hareket_sag = 26;
const int hareket_sol = 27;
const int buzzer_1 = 28;
const int buzzer_2 = 29;
const int ses = 30;
const int ekran_isik = 31;
LiquidCrystal lcd(32, 33, 34, 35, 36, 37);


// ANALOG
SharpIR uzaklik_sag_on(A0, 25, 93, 1080);
SharpIR uzaklik_sag_arka(A1, 25, 93, 1080);
SharpIR uzaklik_sol_on(A2, 25, 93, 1080);
SharpIR uzaklik_sol_arka(A3, 25, 93, 1080);
const int ldr_1 = 4;
const int ldr_2 = 5;
const int yakinlik_sag = 6;
const int yakinlik_sol = 7;



void setup() {

  Serial.begin(115200);

  // DIGITAL
  pinMode(uzaklik_on_sag_t, OUTPUT);
  pinMode(uzaklik_on_sag_e, INPUT);
  pinMode(uzaklik_on_sol_t, OUTPUT);
  pinMode(uzaklik_on_sol_e, INPUT);
  pinMode(buzzer_1, OUTPUT);
  pinMode(buzzer_2, OUTPUT);
  pinMode(ekran_isik, OUTPUT);
  pinMode(hareket_sag, INPUT);
  pinMode(hareket_sol, INPUT);
  pinMode(ses, INPUT);

  // PWM
  servo_x.attach(servo_x_pin);
  servo_y.attach(servo_y_pin);
  pinMode(led_1, OUTPUT);
  pinMode(led_2, OUTPUT);

  // Ekran
  lcd.begin(16, 2);

  lcd.setCursor(0, 0);
  lcd.print("SERI BAGLANTI");
  lcd.setCursor(0, 1);
  lcd.print("BEKLENIYOR");
  
  establishContact();
}



void loop() {
  
  // Sensoleri oku ve baglanti varsa iletişim kur
  
  if(oku){
    oku_sensor();
  }
  
}


void serialEvent(){
  while(Serial.available()) {
    char gelen = Serial.read();
    if (gelen == '\n') {
      parseCommand(command);
      if(command == "A"){
        oku = true;
      }
      command = "";
    } else {
      command += gelen;
    }
  }
}







// ### SENSOR OKUMA ###


void oku_sensor() {
  oku_uzaklik_ultrasonic();
  oku_uzaklik_kizilotesi();
  oku_hareket();
  oku_ses();
  oku_isik();
  oku_yakinlik();
}


void oku_uzaklik_ultrasonic() {

  digitalWrite(uzaklik_on_sag_t, LOW);
  digitalWrite(uzaklik_on_sag_t, HIGH);
  digitalWrite(uzaklik_on_sag_t, LOW);

  int deger = pulseIn(uzaklik_on_sag_e, HIGH, 100);
  deger_uzaklik_on_sag = deger / 29 / 2;

  //delay(50);

  digitalWrite(uzaklik_on_sol_t, LOW);
  digitalWrite(uzaklik_on_sol_t, HIGH);
  digitalWrite(uzaklik_on_sol_t, LOW);

  int deger2 = pulseIn(uzaklik_on_sol_e, HIGH, 100);
  deger_uzaklik_on_sol = deger2 / 29 / 2;

  if (log_uzaklik_sonic == 1) {
    Serial.print("Sensor 1 - ");
    Serial.print(deger_uzaklik_on_sag);
    Serial.print("    ");
    Serial.print("Sensor 2 - ");
    Serial.println(deger_uzaklik_on_sol);
  }

  //delay(50);
}




void oku_uzaklik_kizilotesi() {
  int deger_uzaklik_sag_on = uzaklik_sag_on.distance();
  int deger_uzaklik_sag_arka = uzaklik_sag_arka.distance();
  int deger_uzaklik_sol_on = uzaklik_sol_on.distance();
  int deger_uzaklik_sol_arka = uzaklik_sol_arka.distance();

  if (log_uzaklik_ir == 1) {
    Serial.print("Kızılötesi Uzaklık: Sağ Ön: ");
    Serial.print(deger_uzaklik_sag_on);
    Serial.print(" - Sağ Arka");
    Serial.print(deger_uzaklik_sag_arka);
    Serial.print(" - Sol Ön");
    Serial.print(deger_uzaklik_sol_on);
    Serial.print(" - Sol Arka");
    Serial.println(deger_uzaklik_sol_arka);
  }
}





void oku_hareket() {
  deger_hareket_sag = digitalRead(hareket_sag);
  deger_hareket_sol = digitalRead(hareket_sol);

  if (log_hareket == 1) {
    Serial.print("Sag: ");
    Serial.print(deger_hareket_sag);
    Serial.print("Sol: ");
    Serial.print(deger_hareket_sol);
  }
}




void oku_ses() {
  deger_ses = digitalRead(ses);

  if (log_ses == 1) {
    Serial.print("Ses: ");
    Serial.println(deger_ses);
  }
}



void oku_isik() {
  deger_isik = (analogRead(ldr_1) + analogRead(ldr_2)) / 2;

  if (log_isik == 1) {
    Serial.print("Işık: ");
    Serial.println(deger_isik);
  }
}

void oku_yakinlik() {
  deger_yakinlik_sag = analogRead(yakinlik_sag);
  deger_yakinlik_sol = analogRead(yakinlik_sol);

  if (log_yakinlik == 1) {
    Serial.print("Yakinlik-> Sağ Ön: ");
    Serial.print(deger_yakinlik_sag);
    Serial.print("  Sol Ön: ");
    Serial.print(deger_yakinlik_sol);
  }
}










// ### ÇIKIŞ ###

void cikis_buzzer(int cal) {
  if (cal == 1) {
    digitalWrite(buzzer_1, HIGH);
    digitalWrite(buzzer_2, HIGH);
  } else {
    digitalWrite(buzzer_1, LOW);
    digitalWrite(buzzer_2, LOW);
  }
}


void cikis_ekran_isik(int deger) {
  digitalWrite(ekran_isik, deger);
}



void cikis_ekran(int deger) {

  if (deger == 0) {
    lcd.setCursor(0, 0);
    lcd.print("ROBOTEXT");
    lcd.setCursor(0, 1);
    lcd.print("POWERED BY AFL");
  }
}


void cikis_servo_x(int x) {
  servo_x.write(x);
}

void cikis_servo_y(int x) {
  servo_y.write(x);
}


void cikis_led_1(int a){
  digitalWrite(led_1, a);
}

void cikis_led_2(int a){
  digitalWrite(led_2, a);
}




// ### Serial ###

void parseCommand(String com) {

  String part1;
  String part2;

  part1 = com.substring(0, com.indexOf(" "));
  part2 = com.substring(com.indexOf(" ") + 1);


  // ### CEVAP VERILECEK ###

  // UZAKLIK
  if (part1.equalsIgnoreCase("-11")) {
    Serial.print("-111 ");
    Serial.println(deger_uzaklik_on_sag);
  }
  else if (part1.equalsIgnoreCase("-12")) {
    Serial.print("-121 ");
    Serial.println(deger_uzaklik_on_sol);
  }
  else if (part1.equalsIgnoreCase("-13")) {
    Serial.print("-131 ");
    Serial.println(deger_uzaklik_sag_on);
  }
  else if (part1.equalsIgnoreCase("-14")) {
    Serial.print("-141 ");
    Serial.println(deger_uzaklik_sag_arka);
  }
  else if (part1.equalsIgnoreCase("-15")) {
    Serial.print("-151 ");
    Serial.println(deger_uzaklik_sol_on);
  }
  else if (part1.equalsIgnoreCase("-16")) {
    Serial.print("-161 ");
    Serial.println(deger_uzaklik_sol_arka);
  }
  
  
  
  // HAREKET
  else if (part1.equalsIgnoreCase("-21")) {
    Serial.print("-211 ");
    Serial.println(deger_hareket_sag);
  }
  else if (part1.equalsIgnoreCase("-22")) {
    Serial.print("-221 ");
    Serial.println(deger_hareket_sol);
  }
  
  
  
  // SES
  else if (part1.equalsIgnoreCase("-3")) {
    Serial.print("-31 ");
    Serial.println(deger_ses);
  }
  
  // ISIK
  else if (part1.equalsIgnoreCase("-4")) {
    Serial.print("-41 ");
    Serial.println(deger_isik);
  }
  
  // YAKINLIK
  else if (part1.equalsIgnoreCase("-51")) {
    Serial.print("-511 ");
    Serial.println(deger_yakinlik_sag);
  }
  else if (part1.equalsIgnoreCase("-52")) {
    Serial.print("-521 ");
    Serial.println(deger_yakinlik_sol);
  }
  
  
  
  // ### GELEN ###
  
  
  // BUZZER
  else if (part1.equalsIgnoreCase("+1")) {
    int pin = part2.toInt();
    cikis_buzzer(pin);
  }
  
  // EKRAN ISIK
  else if (part1.equalsIgnoreCase("+2")) {
    int pin = part2.toInt();
    if(pin == 0)
      cikis_ekran_isik(0);
    else if(pin == 1)
      cikis_ekran_isik(1);
  }
  
  
  // EKRAN
  else if (part1.equalsIgnoreCase("+3")) {
    int pin = part2.toInt();
    cikis_ekran(pin);
  }
  
  // SERVO X
  else if (part1.equalsIgnoreCase("+4")) {
    int pin = part2.toInt();
    cikis_servo_x(pin);
  }
  
  // SERVO Y
  else if (part1.equalsIgnoreCase("+5")) {
    int pin = part2.toInt();
    cikis_servo_y(pin);
  }
  
  // LED 1
  else if (part1.equalsIgnoreCase("+6")) {
    int pin = part2.toInt();
    cikis_led_1(pin);
  }
  
  // LED 2
  else if (part1.equalsIgnoreCase("+7")) {
    int pin = part2.toInt();
    cikis_led_2(pin);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("Loading..");
    delay(300);
  }
}

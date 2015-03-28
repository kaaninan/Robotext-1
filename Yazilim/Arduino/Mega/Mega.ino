#include <LiquidCrystal.h>
#include <Servo.h>
#include <SharpIR.h>


// VALUES
String command = "";
boolean oku = true;


// LOG
int log_uzaklik = 0;
int log_hareket = 0;
int log_ses = 0;
int log_isik = 0;
int log_sicaklik = 0;
int log_gaz = 0;



// SENSOR VALUES
int deger_uzaklik_on = 0;
int deger_uzaklik_arka = 0;
int deger_uzaklik_sag = 0;
int deger_uzaklik_sol = 0;
int deger_hareket_sag = 0;
int deger_hareket_sol = 0;
int deger_ses = 0;
int deger_isik = 0;
int deger_sicaklik = 0;
int deger_gaz = 0;
 

// ### IO ###


// PWM
int servo_x_pin = 2;
int servo_y_pin = 3;
Servo servo_x;
Servo servo_y;


// DIGITAL
const int hareket_sag = 22;
const int hareket_sol = 23;
const int buzzer_1 = 24;
const int buzzer_2 = 25;
const int ses = 26;
const int ekran_isik = 27;
LiquidCrystal lcd(28, 29, 30, 31, 32, 33);
int led_1 = 34;
int led_2 = 35;


// ANALOG
SharpIR uzaklik_on(A0, 25, 93, 1080);
SharpIR uzaklik_arka(A1, 25, 93, 1080);
SharpIR uzaklik_sag(A2, 25, 93, 1080);
SharpIR uzaklik_sol(A3, 25, 93, 1080);
const int ldr = 4;
const int sicaklik = 5;
const int gaz = 6;



void setup() {

  Serial.begin(115200);

  // DIGITAL
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
    if (gelen == '&') {
      parseCommand(command);
      command = "";
    } else {
      command += gelen;
    }
  }
}







// ### SENSOR OKUMA ###


void oku_sensor() {
  oku_uzaklik();
  oku_hareket();
  oku_ses();
  oku_isik();
  oku_sicaklik();
  oku_gaz();
}



void oku_uzaklik() {
  deger_uzaklik_on = uzaklik_on.distance();
  deger_uzaklik_arka = uzaklik_arka.distance();
  deger_uzaklik_sag = uzaklik_sag.distance();
  deger_uzaklik_sol = uzaklik_sol.distance();

  if (log_uzaklik == 1) {
    Serial.print("On: ");
    Serial.print(deger_uzaklik_on);
    Serial.print(" - Arka: ");
    Serial.print(deger_uzaklik_arka);
    Serial.print(" - Sag: ");
    Serial.print(deger_uzaklik_sag);
    Serial.print(" - Sol: ");
    Serial.println(deger_uzaklik_sol);
  }
}



void oku_hareket() {
  deger_hareket_sag = digitalRead(hareket_sag);
  deger_hareket_sol = digitalRead(hareket_sol);

  if (log_hareket == 1) {
    Serial.print("Sag: ");
    Serial.print(deger_hareket_sag);
    Serial.print("  Sol: ");
    Serial.println(deger_hareket_sol);
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
  deger_isik = analogRead(ldr);

  if (log_isik == 1) {
    Serial.print("Işık: ");
    Serial.println(deger_isik);
  }
}



void oku_sicaklik(){
  deger_sicaklik = (5.0 * analogRead(sicaklik) * 100.0) / 1024;
  
  if(log_sicaklik == 1){
    Serial.print("Sicaklik: ");
    Serial.println(deger_sicaklik);
  }
}

void oku_gaz(){
  deger_gaz = analogRead(gaz);
  
  if(log_gaz == 1){
    Serial.print("Gaz: ");
    Serial.println(deger_gaz);
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
    lcd.print("    ROBOTEXT    ");
    lcd.setCursor(0, 1);
    lcd.print(" POWERED BY AFL ");
  }
  
  else if (deger == 1) {
    lcd.setCursor(0, 0);
    lcd.print("     HAREKET    ");
    lcd.setCursor(0, 1);
    lcd.print("   ALGILANDI    ");
  }
  
  else if (deger == 3) {
    lcd.setCursor(0, 0);
    lcd.print("  OTOMATIK MOD  ");
  }
  
  else if (deger == 4) {
    lcd.setCursor(0, 0);
    lcd.print("   MANUEL MOD   ");
  }
  
  else if (deger == 4) {
    lcd.setCursor(0, 1);
    lcd.print("GUVENLIK: ACIK  ");
  }
  
  else if (deger == 5) {
    lcd.setCursor(0, 1);
    lcd.print("GUVENLIK: KAPALI");
  }
  
  else if (deger == 6) {
    lcd.clear();
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
    Serial.println(deger_uzaklik_on);
  }
  else if (part1.equalsIgnoreCase("-12")) {
    Serial.print("-121 ");
    Serial.println(deger_uzaklik_arka);
  }
  else if (part1.equalsIgnoreCase("-13")) {
    Serial.print("-131 ");
    Serial.println(deger_uzaklik_sag);
  }
  else if (part1.equalsIgnoreCase("-14")) {
    Serial.print("-141 ");
    Serial.println(deger_uzaklik_sol);
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
  
  
  // SICAKLIK
  else if (part1.equalsIgnoreCase("-5")) {
    Serial.print("-51 ");
    Serial.println(deger_sicaklik);
  }
  
  
  // GAZ
  else if (part1.equalsIgnoreCase("-6")) {
    Serial.print("-61 ");
    Serial.println(deger_gaz);
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

#include <SharpIR.h>
#include <LiquidCrystal.h>
#include <Servo.h>


// VALUES
boolean run_loop = false;


// LOG
int log_uzaklik_sonic = 0;
int log_uzaklik_ir = 0;
int log_hareket = 0;
int log_sicaklik = 0;
int log_ses = 0;
int log_isik = 0;
int log_yakinlik = 0;



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
int deger_sicaklik = 0;
int deger_isik = 0;
int deger_yakinlik_sag = 0;
int deger_yakinlik_sol = 0;
int deger_yakinlik_alt = 0;



// ### IO ###


// PWM
int servo_x_pin = 2;
int servo_y_pin = 3;
Servo servo_x;
Servo servo_y;

// DIGITAL
const int uzaklik_on_sag_t = 22;
const int uzaklik_on_sag_e = 23;
const int uzaklik_on_sol_t = 24;
const int uzaklik_on_sol_e = 25;
const int ses = 26;
const int hareket_sag = 28;
const int hareket_sol = 29;
const int buzzer_1 = 30;
const int buzzer_2 = 31;
const int ekran_isik_sag = 38;
const int ekran_isik_sol = 39;

LiquidCrystal lcd_sag(32,33, 34, 35, 36, 37);
LiquidCrystal lcd_sol(39, 40, 41, 42, 43, 44);


// ANALOG
SharpIR uzaklik_sag_on(A0, 25, 93, 1080);
SharpIR uzaklik_sag_arka(A1, 25, 93, 1080);
SharpIR uzaklik_sol_on(A2, 25, 93, 1080);
SharpIR uzaklik_sol_arka(A3, 25, 93, 1080);
const int sicaklik = 4;
const int ldr_1 = 5;
const int ldr_2 = 6;
const int yakinlik_sag = 7;
const int yakinlik_sol = 8;
const int yakinlik_alt_1 = 9;
const int yakinlik_alt_2 = 10;



void setup() {
  
  Serial.begin(115200);
  
  // DIGITAL
  pinMode(uzaklik_on_sag_t, OUTPUT);
  pinMode(uzaklik_on_sag_e, INPUT);
  pinMode(uzaklik_on_sol_t, OUTPUT);
  pinMode(uzaklik_on_sol_e, INPUT);
  pinMode(buzzer_1, OUTPUT);
  pinMode(buzzer_2, OUTPUT);
  pinMode(ekran_isik_sag, OUTPUT);
  pinMode(ekran_isik_sol, OUTPUT);
  pinMode(hareket_sag, INPUT);
  pinMode(hareket_sol, INPUT);
  pinMode(ses, INPUT);
  
  // PWM
  servo_x.attach(servo_x_pin);
  servo_y.attach(servo_y_pin);
  
  // Ekran
  lcd_sag.begin(16,2);
  lcd_sol.begin(16,2);
  
  lcd_sag.setCursor(0, 0);
  lcd_sag.print("SERI BAGLANTI");
  lcd_sag.setCursor(0, 1);
  lcd_sag.print("BEKLENIYOR");
  
  lcd_sol.setCursor(0, 0);
  lcd_sol.print("SERI BAGLANTI");
  lcd_sol.setCursor(0, 1);
  lcd_sol.print("BEKLENIYOR");
  
  // Serial
  establishContact();
  
}



void loop() {
  if(run_loop == true){
    
    run_loop = false;
  }
}






// ### SENSOR OKUMA ###


void oku_uzaklik_ultrasonic(){
  
  digitalWrite(uzaklik_on_sag_t, LOW);
  digitalWrite(uzaklik_on_sag_t, HIGH);
  digitalWrite(uzaklik_on_sag_t, LOW);
  
  int deger = pulseIn(uzaklik_on_sag_e, HIGH, 10000);
  deger_uzaklik_on_sag = deger/29/2;
  
  //delay(50);

  digitalWrite(uzaklik_on_sol_t, LOW);
  digitalWrite(uzaklik_on_sol_t, HIGH);
  digitalWrite(uzaklik_on_sol_t, LOW);
  
  int deger2 = pulseIn(uzaklik_on_sol_e, HIGH, 10000);
  deger_uzaklik_on_sol = deger2/29/2;
  
  if(log_uzaklik_sonic == 1){
    Serial.print("Sensor 1 - ");
    Serial.print(deger_uzaklik_on_sag);
    Serial.print("    ");
    Serial.print("Sensor 2 - ");
    Serial.println(deger_uzaklik_on_sol);
  }
  
  //delay(50);
}




void oku_uzaklik_kizilotesi(){
  int deger_uzaklik_sag_on = uzaklik_sag_on.distance();
  int deger_uzaklik_sag_arka = uzaklik_sag_arka.distance();
  int deger_uzaklik_sol_on = uzaklik_sol_on.distance();
  int deger_uzaklik_sol_arka = uzaklik_sol_arka.distance();
  
  if(log_uzaklik_ir == 1){
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





void oku_hareket(){
  deger_hareket_sag = digitalRead(hareket_sag);
  deger_hareket_sol = digitalRead(hareket_sol);
  
  if(log_hareket == 1){
    Serial.print("Sag: ");
    Serial.print(deger_hareket_sag);
    Serial.print("Sol: ");
    Serial.print(deger_hareket_sol);
  }
}




void oku_ses(){
  deger_ses = digitalRead(ses);
  
  if(log_ses == 1){
    Serial.print("Ses: ");
    Serial.println(deger_ses);
  }
}


void oku_sicaklik(){
  deger_sicaklik = (5.0 * analogRead(sicaklik) * 100.0) / 1024;
  
  if(log_sicaklik == 1){
    Serial.print("Sıcaklık: ");
    Serial.print(deger_sicaklik);
    Serial.println("C ");
  }

}


void oku_isik(){
  deger_isik = (analogRead(ldr_1) + analogRead(ldr_2))/2;
  
  if(log_isik == 1){
    Serial.print("Işık: ");
    Serial.println(deger_isik);
  }
}

void oku_yakinlik(){
  deger_yakinlik_sag = analogRead(yakinlik_sag);
  deger_yakinlik_sol = analogRead(yakinlik_sol);
  deger_yakinlik_alt = (analogRead(yakinlik_alt_1)+analogRead(yakinlik_alt_2))/2;
  
  if(log_yakinlik == 1){
    Serial.print("Yakinlik-> Sağ Ön: ");
    Serial.print(deger_yakinlik_sag);
    Serial.print("  Sol Ön: ");
    Serial.print(deger_yakinlik_sol);
    Serial.print("  Alt: ");
    Serial.println(deger_yakinlik_alt);
  }
}










// ### ÇIKIŞ ###

void cikis_buzzer(int cal){
  if(cal == 1){
    digitalWrite(buzzer_1, HIGH);
    digitalWrite(buzzer_2, HIGH);  
  }else{
    digitalWrite(buzzer_1, LOW);
    digitalWrite(buzzer_2, LOW);
  }
}


void cikis_ekran_isik(int sag, int sol){
  digitalWrite(ekran_isik_sag, sag);
  digitalWrite(ekran_isik_sol, sol);
}



void cikis_ekran(int sag, int sol){
  
  if(sag == 0){
    lcd_sag.setCursor(0, 0);
    lcd_sag.print("ROBOTEXT");
    lcd_sag.setCursor(0, 1);
    lcd_sag.print("POWERED BY AFL");
  }
  
  if(sol == 0){
    lcd_sol.setCursor(0, 0);
    lcd_sol.print("ROBOTEXT");
    lcd_sol.setCursor(0, 1);
    lcd_sol.print("POWERED BY AFL");
  }
}


void cikis_servo(int x, int y){
  servo_x.write(x);
  servo_y.write(y);
}






// ### Serial ###

String command = "";

void serialEvent() {
  
  while (Serial.available()) {
    
    int serialRead = Serial.read();
    
    if(serialRead == '\n'){
      parseCommand(command);
      command = "";
    }else{
      command+= serialRead;
    }
    
    int firstSensor = analogRead(A0);
    int secondSensor = analogRead(A1);

    int deger1 = map(firstSensor, 0, 1023, 0, 255);
    int deger2 = map(secondSensor, 0, 1023, 0, 255);
    
    Serial.print(firstSensor);
    Serial.print(",");
    Serial.println(secondSensor);
    
    if(serialRead == '1'){
      run_loop = true;
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
  while (Serial.available() <= 0) {
    Serial.println("0,0,0");
    delay(300);
  }
}


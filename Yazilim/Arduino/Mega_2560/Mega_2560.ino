#include <LiquidCrystal.h>

// PINs
const int lcd_sag_isik = 34;
const int lcd_sol_isik = 35;

LiquidCrystal lcd_sag(22, 23, 24, 25, 26, 27);
LiquidCrystal lcd_sol(28, 29, 30, 31, 32, 33);

const int a_sicaklik = 0;
const int a_gaz = 1;
const int a_voltaj = 2;

// Komutlar
String komut_no_s = "";
int komut_no = 0;
String komut_mesaj = "";

boolean stringComplete = false;

void setup() {
  
  Serial.begin(115200);
  
  komut_mesaj.reserve(200);
  
  lcd_sag.begin(16,2);
  lcd_sol.begin(16,2);
  
  pinMode(13, OUTPUT);
  
  establishContact();
}

void loop() {
  if (stringComplete) {
    stringComplete = false;
  }
}

void serialEvent() {
  while (Serial.available()) {
    komut_no_s = Serial.readStringUntil('&');
    komut_no = komut_no_s.toInt();
    komut_mesaj = Serial.readStringUntil(':');
    
    if(komut_no == 1){
      lcd_sag.setCursor(0,0);
      lcd_sag.print(komut_mesaj);
    }
    
    else if(komut_no == 2){
      lcd_sag.setCursor(0, 1);
      lcd_sag.print(komut_mesaj);
    }
    
    else if(komut_no == 3){
      lcd_sol.setCursor(0,0);
      lcd_sol.print(komut_mesaj);
    }
    
    else if(komut_no == 4){
      lcd_sol.setCursor(0,1);
      lcd_sol.print(komut_mesaj);
    }
    
    else if(komut_no == 5){
      digitalWrite(lcd_sag_isik, LOW);
    }
    
    else if(komut_no == 6){
      digitalWrite(lcd_sag_isik, HIGH);
    }
    
    else if(komut_no == 7){
      digitalWrite(lcd_sol_isik, LOW);
    }
    
    else if(komut_no == 8){
      digitalWrite(lcd_sol_isik, HIGH);
    }
    
    else if(komut_no == 9){
      Serial.print("9. KOMUT ");
      Serial.println(analogRead(0));
    }
    
    else if(komut_no == 10){
      Serial.print("10&");
      Serial.print(analogRead(a_sicaklik));
      Serial.println(":");
    }
    
    else if(komut_no == 11){
      Serial.print("10&");
      Serial.print(analogRead(a_gaz));
      Serial.println(":");
    }
    
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("Arduino Mega Bekliyor...");
    delay(300);
  }
}

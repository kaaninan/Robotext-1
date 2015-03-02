// OKUNAN DEGERLERI KAYDETME
int[] sensor_hareket = new int[1];
int[] sensor_uzaklik = new int[5];
int sensor_ses = 0;
int sensor_ldr = 0;
float sensor_sicaklik = 0;


int bekle = 10; // Islemci gucune gore degisir


void sensor_dinle(){
  thread("oku_hareket");
  thread("oku_ses");
  thread("oku_isik");
  thread("oku_uzaklik_on");
  thread("oku_uzaklik");
  thread("oku_sicaklik");
}


// HAREKET  ==>  (Sağ, Sol)
void oku_hareket() {
  while(true){
    int sag = arduino_mega.digitalRead(a_hareket_sag);
    int sol = arduino_mega.digitalRead(a_hareket_sol);
    sensor_hareket[0] = sag;
    sensor_hareket[1] = sol;
    delay(bekle);
  }
}



// SES
void oku_ses(){
  while(true){
    sensor_ses = arduino_mega.digitalRead(a_ses);
    delay(bekle);
  }
}



// IŞIK
void oku_isik(){
  while(true){
    int sag = arduino_mega.analogRead(9);
    int sol = arduino_mega.analogRead(10);
    sensor_ldr = (sag+sol)/2;
    delay(bekle);
  }
}





// UZAKLIK  ==>  (Sağ Ön, Sağ Arka, Sol Ön, Sol Arka, On Alt, On Ust)
void oku_uzaklik(){
  while(arduino_uno.available() > 0){
    
    String gelen = arduino_uno.readStringUntil('\n');
    gelen = trim(gelen);
    
    String[] parcala = split(gelen, ",");
    
    sensor_uzaklik[0] = int(parcala[0]);
    sensor_uzaklik[1] = int(parcala[1]);
    sensor_uzaklik[2] = int(parcala[2]);
    sensor_uzaklik[3] = int(parcala[3]);
    sensor_uzaklik[4] = int(parcala[4]);
    sensor_uzaklik[5] = int(parcala[5]);
    
    delay(bekle);
  }
}



// SICAKLIK
void oku_sicaklik(){
  while(true){
    float readValue = arduino_mega.analogRead(a_sicaklik);
    sensor_sicaklik = (5.0 * readValue * 100.0) / 1024;
    delay(bekle);
  }
}

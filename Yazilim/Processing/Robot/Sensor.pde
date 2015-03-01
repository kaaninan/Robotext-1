// OKUNAN DEGERLERI KAYDETME
int[] sensor_hareket = new int[2];
int[] sensor_uzaklik_on = new int[2];
int[] sensor_uzaklik = new int[4];
int sensor_ses = 0;
int sensor_ldr = 3;
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



// UZAKLIK ULTRASONİK  ==>  (Ön Alt, Ön Üst)
void oku_uzaklik_on(){
  while(true){
    int[] degerler = new int[2];
    
    int alt = 0;
    int ust = 0;
    
    // Ön Alt
    int alt_1 = arduino_mega.digitalRead(a_uzaklik_on_alt_1);
    int alt_2 = arduino_mega.digitalRead(a_uzaklik_on_alt_2);
    
    int ust_1 = arduino_mega.digitalRead(a_uzaklik_on_ust_1);
    int ust_2 = arduino_mega.digitalRead(a_uzaklik_on_ust_2);
    
    if(alt_1 == Arduino.LOW && alt_2 == Arduino.LOW){ alt = 1; }
    if(alt_1 == Arduino.HIGH && alt_2 == Arduino.LOW){ alt = 2; }
    if(alt_1 == Arduino.LOW && alt_2 == Arduino.HIGH){ alt = 3; }
    if(alt_1 == Arduino.HIGH && alt_2 == Arduino.HIGH){ alt = 4; }
    
    if(ust_1 == Arduino.LOW && ust_2 == Arduino.LOW){ ust = 1; }
    if(ust_1 == Arduino.HIGH && ust_2 == Arduino.LOW){ ust = 2; }
    if(ust_1 == Arduino.LOW && ust_2 == Arduino.HIGH){ ust = 3; }
    if(ust_1 == Arduino.HIGH && ust_2 == Arduino.HIGH){ ust = 4; }
    
    sensor_uzaklik_on[0] = alt;
    sensor_uzaklik_on[1] = ust;
    
    delay(bekle);
  }
}



// UZAKLIK  ==>  (Sağ Ön, Sağ Arka, Sol Ön, Sol Arka)
void oku_uzaklik(){
  while(true){
    sensor_uzaklik[0] = sensor_uzaklik(a_uzaklik_sag_on);
    sensor_uzaklik[1] = sensor_uzaklik(a_uzaklik_sag_arka);
    sensor_uzaklik[2] = sensor_uzaklik(a_uzaklik_sol_on);
    sensor_uzaklik[3] = sensor_uzaklik(a_uzaklik_sol_arka);
    delay(bekle);
  }
}
int sensor_uzaklik(int pin){
  char GP2D12= (char) read_gp2d12_range(pin);
  int a = GP2D12/10;
  int b = GP2D12%10;
  int val=a*10+b;
  int i_uzaklik;
 
  if(val>10&&val<80){
    String s_uzaklik = a+""+b;
    i_uzaklik = int(s_uzaklik);
  }else
    i_uzaklik = 0;
  return i_uzaklik;
}
float read_gp2d12_range(int pin){
  int tmp;
  tmp = arduino_mega.analogRead(a_uzaklik_sol_arka);
  if (tmp < 3)return -1;
  return (6787.0 /((float)tmp - 3.0)) - 4.0;
}



// SICAKLIK
void oku_sicaklik(){
  while(true){
    float readValue = arduino_mega.analogRead(a_sicaklik);
    sensor_sicaklik = (5.0 * readValue * 100.0) / 1024;
    delay(bekle);
  }
}

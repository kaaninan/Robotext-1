int on_alt_deger = 0;
int on_ust_deger = 0;
int arka_deger = 0;

float sicaklik = 29;

int a = 0;
int bekle = 50;

// Giriş Çıkış

const int on_alt_t = 0;
const int on_alt_e = 1;

const int on_ust_t = 2;
const int on_ust_e = 3;

const int arka_t = 4;
const int arka_e = 5;

const int on_alt_c_1 = 6;
const int on_alt_c_2 = 7;
const int on_alt_c_3 = 8;

const int on_ust_c_1 = 9;
const int on_ust_c_2 = 10;
const int on_ust_c_3 = 11;

const int arka_c_1 = 12;
const int arka_c_2 = 13;

void setup(){
  
  pinMode(on_alt_t, OUTPUT);
  pinMode(on_alt_e, INPUT);

  pinMode(on_ust_t, OUTPUT);
  pinMode(on_ust_e, INPUT);
  
  pinMode(arka_t, OUTPUT);
  pinMode(arka_e, INPUT);
  
  pinMode(on_alt_c_1, OUTPUT);
  pinMode(on_alt_c_2, OUTPUT);
  pinMode(on_alt_c_3, OUTPUT);
  
  pinMode(on_ust_c_1, OUTPUT);
  pinMode(on_ust_c_2, OUTPUT);
  pinMode(on_ust_c_3, OUTPUT);
  
  pinMode(arka_c_1, OUTPUT);
  pinMode(arka_c_2, OUTPUT);
}




void loop() {
  
  if(a == 0){
    
    digitalWrite(on_alt_t, LOW);
    digitalWrite(on_alt_t, HIGH);
    digitalWrite(on_alt_t, LOW);
    
    on_alt_deger = (pulseIn(on_alt_e, HIGH, 10000))/sicaklik/2;
    delay(bekle);
    a = 1;
    
  }else if(a == 1){
    
    digitalWrite(on_ust_t, LOW);
    digitalWrite(on_ust_t, HIGH);
    digitalWrite(on_ust_t, LOW);
    
    on_ust_deger = (pulseIn(on_ust_e, HIGH, 10000))/sicaklik/2;
    delay(bekle);
    a = 2;
    
  }else{
    digitalWrite(arka_t, LOW);
    digitalWrite(arka_t, HIGH);
    digitalWrite(arka_t, LOW);
    
    arka_deger = (pulseIn(arka_e, HIGH, 10000))/sicaklik/2;
    delay(bekle);
    a = 0;
  }
  
  // Sıcaklık
  //float sicaklik = (5.0 * analogRead(0) * 100.0) / 1024;
  
  // Kontrol
  if(on_alt_deger > 30)
    on_alt(1);
  if(31 < on_alt_deger < 25)
    on_alt(2);
  if(26 < on_alt_deger < 22)
    on_alt(3);
  if(23 < on_alt_deger < 18)
    on_alt(4);
  if(19 < on_alt_deger < 14)
    on_alt(5);
  if(15 < on_alt_deger < 10)
    on_alt(6);
  if(11 < on_alt_deger < 7)
    on_alt(7);
  if(8 < on_alt_deger < -1)
    on_alt(8);
  

  if(on_ust_deger > 30)
    on_ust(1);
  if(31 < on_ust_deger < 25)
    on_ust(2);
  if(26 < on_ust_deger < 22)
    on_ust(3);
  if(23 < on_ust_deger < 18)
    on_ust(4);
  if(19 < on_ust_deger < 14)
    on_ust(5);
  if(15 < on_ust_deger < 10)
    on_ust(6);
  if(11 < on_ust_deger < 7)
    on_ust(7);
  if(8 < on_ust_deger < -1)
    on_ust(8);

	
  if(arka_deger > 30)
    arka(1);
  if(31 < arka_deger < 20)
    arka(2);
  if(21 < arka_deger < 10)
    arka(3);
  if(11 < arka_deger < -1)
    arka(4);
}


void on_alt(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, LOW);
      digitalWrite(on_alt_c_3, LOW);
    case 2:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, LOW);
      digitalWrite(on_alt_c_3, LOW);
    case 3:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, HIGH);
      digitalWrite(on_alt_c_3, LOW);
    case 4:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, LOW);
      digitalWrite(on_alt_c_3, HIGH);
    case 5:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, HIGH);
      digitalWrite(on_alt_c_3, LOW);
    case 6:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, HIGH);
      digitalWrite(on_alt_c_3, HIGH);
    case 7:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, LOW);
      digitalWrite(on_alt_c_3, HIGH);
    case 8:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, HIGH);
      digitalWrite(on_alt_c_3, HIGH);
  }
}


void on_ust(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, LOW);
      digitalWrite(on_ust_c_3, LOW);
    case 2:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, LOW);
      digitalWrite(on_ust_c_3, LOW);
    case 3:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, HIGH);
      digitalWrite(on_ust_c_3, LOW);
    case 4:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, LOW);
      digitalWrite(on_ust_c_3, HIGH);
    case 5:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, HIGH);
      digitalWrite(on_ust_c_3, LOW);
    case 6:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, HIGH);
      digitalWrite(on_ust_c_3, HIGH);
    case 7:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, LOW);
      digitalWrite(on_ust_c_3, HIGH);
    case 8:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, HIGH);
      digitalWrite(on_ust_c_3, HIGH);
  }
}


void arka(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(arka_c_1, LOW);
      digitalWrite(arka_c_2, LOW);
    case 2:
      digitalWrite(arka_c_1, HIGH);
      digitalWrite(arka_c_2, LOW);
    case 3:
      digitalWrite(arka_c_1, LOW);
      digitalWrite(arka_c_2, HIGH);
    case 4:
      digitalWrite(arka_c_1, HIGH);
      digitalWrite(arka_c_2, HIGH);
  }
}

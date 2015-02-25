int on_alt_deger = 0;
int on_ust_deger = 0;
int arka_deger = 0;

float sicaklik = 29;

int a = 0;
int bekle = 50;

// Giriş Çıkış

const int on_alt_t = 2;
const int on_alt_e = 3;

const int on_ust_t = 4;
const int on_ust_e = 5;

const int arka_t = 6;
const int arka_e = 7;

const int on_alt_c_1 = 8;
const int on_alt_c_2 = 9;

const int on_ust_c_1 = 10;
const int on_ust_c_2 = 11;

const int arka_c_1 = 12;
const int arka_c_2 = 13;

void setup(){
  Serial.begin(9600);
  
  pinMode(on_alt_t, OUTPUT);
  pinMode(on_alt_e, INPUT);

  pinMode(on_ust_t, OUTPUT);
  pinMode(on_ust_e, INPUT);
  
  pinMode(arka_t, OUTPUT);
  pinMode(arka_e, INPUT);
  
  pinMode(on_alt_c_1, OUTPUT);
  pinMode(on_alt_c_2, OUTPUT);
  
  pinMode(on_ust_c_1, OUTPUT);
  pinMode(on_ust_c_2, OUTPUT);
  
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
  if(on_ust_deger < 30){
    if(on_ust_deger < 20){
      if(on_ust_deger < 10){
        on_ust(4);
      }else{
        on_ust(3);
      }
    }else{
      on_ust(2);
    }
  }else{
    on_ust(1);
  }
  
  
  if(on_alt_deger < 30){
    if(on_alt_deger < 20){
      if(on_alt_deger < 10){
        on_alt(4);
      }else{
        on_alt(3);
      }
    }else{
      on_alt(2);
    }
  }else{
    on_alt(1);
  }

	
  if(arka_deger < 30){
    if(arka_deger < 20){
      if(arka_deger < 10){
        arka(4);
      }else{
        arka(3);
      }
    }else{
      arka(2);
    }
  }else{
    arka(1);
  }
}


void on_ust(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, LOW);
      break;
    case 2:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, LOW);
      break;
    case 3:
      digitalWrite(on_ust_c_1, LOW);
      digitalWrite(on_ust_c_2, HIGH);
      break;
    case 4:
      digitalWrite(on_ust_c_1, HIGH);
      digitalWrite(on_ust_c_2, HIGH);
      break;
  }
}


void on_alt(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, LOW);
      break;
    case 2:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, LOW);
      break;
    case 3:
      digitalWrite(on_alt_c_1, LOW);
      digitalWrite(on_alt_c_2, HIGH);
      break;
    case 4:
      digitalWrite(on_alt_c_1, HIGH);
      digitalWrite(on_alt_c_2, HIGH);
      break;
  }
}


void arka(int seviye){
  switch(seviye){
    case 1:
      digitalWrite(arka_c_1, LOW);
      digitalWrite(arka_c_2, LOW);
      break;
    case 2:
      digitalWrite(arka_c_1, HIGH);
      digitalWrite(arka_c_2, LOW);
      break;
    case 3:
      digitalWrite(arka_c_1, LOW);
      digitalWrite(arka_c_2, HIGH);
      break;
    case 4:
      digitalWrite(arka_c_1, HIGH);
      digitalWrite(arka_c_2, HIGH);
      break;
  }
  
  /*
  Serial.print(on_alt_deger);
  Serial.print(" - ");
  Serial.print(on_ust_deger);
  Serial.println(" - ");
  */
}

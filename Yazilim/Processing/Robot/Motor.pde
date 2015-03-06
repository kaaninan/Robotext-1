void motor_test(int sag, int sol){
  arduino_mega.analogWrite(a_motor_sol_on, sol);
  arduino_mega.analogWrite(a_motor_sol_arka, sol);
  arduino_mega.analogWrite(a_motor_sag_on, sag);
  arduino_mega.analogWrite(a_motor_sag_arka, sag);
  
  /*
  arduino_mega.digitalWrite(a_motor_sol_on_yon, 0);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, 1);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, 0);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, 1);
  */
  
  arduino_mega.digitalWrite(a_motor_sol_on_yon, 1);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, 0);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, 1);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, 0);
}

// MANUAL
void motor_manual(int motor_sol, int motor_sag, int motor_sol_ters, int motor_sag_ters){
  arduino_mega.analogWrite(a_motor_sol_on, motor_sol);
  arduino_mega.analogWrite(a_motor_sol_arka, motor_sol);
  arduino_mega.analogWrite(a_motor_sag_on, motor_sag);
  arduino_mega.analogWrite(a_motor_sag_arka, motor_sag);

  if (motor_sol_ters == 1) {
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
  } else {
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
  }

  if (motor_sag_ters == 1) {
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
  } else {
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
  }
}


// AUTO

void motor_web(){
  
  // Ileri
  if(j_ileri == 1 && j_sag == 0 && j_sol == 0 && j_geri == 0){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Geri
  else if(j_ileri == 0 && j_sag == 0 && j_sol == 0 && j_geri == 1){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Sag
  else if(j_ileri == 0 && j_sag == 1 && j_sol == 0 && j_geri == 0){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Sol
  else if(j_ileri == 0 && j_sag == 0 && j_sol == 1 && j_geri == 0){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Ileri Sag
  else if(j_ileri == 1 && j_sag == 1 && j_sol == 0 && j_geri == 0){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 0);
    arduino_mega.analogWrite(a_motor_sag_arka, 0);
  }
  
  // Ileri Sol
  else if(j_ileri == 1 && j_sag == 0 && j_sol == 1 && j_geri == 0){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 0);
    arduino_mega.analogWrite(a_motor_sol_arka, 0);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Geri Sag
  else if(j_ileri == 0 && j_sag == 1 && j_sol == 0 && j_geri == 1){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 150);
    arduino_mega.analogWrite(a_motor_sag_arka, 150);
  }
  
  // Geri Sol
  else if(j_ileri == 0 && j_sag == 0 && j_sol == 1 && j_geri == 1){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 150);
    arduino_mega.analogWrite(a_motor_sol_arka, 150);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  
  // Dur
  else{
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 0);
    arduino_mega.analogWrite(a_motor_sol_arka, 0);
    arduino_mega.analogWrite(a_motor_sag_on, 0);
    arduino_mega.analogWrite(a_motor_sag_arka, 0);
  }
}

// #KOMUTLAR
// ileri(hizli, yavas)
// geri(hizli, yavas)
// dur
// ileri_sag(tam, yarim)
// ileri_sol(tam, yarim)
// geri_sag()
// geri_sol()

void motor_auto_ileri(String secim){
  
  arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
  
  if(secim == "hizli"){
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  else if(secim == "yavas"){
    arduino_mega.analogWrite(a_motor_sol_on, 150);
    arduino_mega.analogWrite(a_motor_sol_arka, 150);
    arduino_mega.analogWrite(a_motor_sag_on, 150);
    arduino_mega.analogWrite(a_motor_sag_arka, 150);
  }
}

void motor_auto_geri(String secim){
  
  arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
  
  if(secim == "hizli"){
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  else if(secim == "yavas"){
    arduino_mega.analogWrite(a_motor_sol_on, 150);
    arduino_mega.analogWrite(a_motor_sol_arka, 150);
    arduino_mega.analogWrite(a_motor_sag_on, 150);
    arduino_mega.analogWrite(a_motor_sag_arka, 150);
  }
}

void motor_auto_ileri_sag(String secim){
  
  if(secim == "tam"){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  else if(secim == "yarim"){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 0);
    arduino_mega.analogWrite(a_motor_sag_arka, 0);
  }
}

void motor_auto_ileri_sol(String secim){
  
  if(secim == "tam"){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 255);
    arduino_mega.analogWrite(a_motor_sag_arka, 255);
  }
  else if(secim == "yarim"){
    arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
    arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.LOW);
    arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.HIGH);
    
    arduino_mega.analogWrite(a_motor_sol_on, 255);
    arduino_mega.analogWrite(a_motor_sol_arka, 255);
    arduino_mega.analogWrite(a_motor_sag_on, 0);
    arduino_mega.analogWrite(a_motor_sag_arka, 0);
  }
}


void motor_auto_geri_sag(){
  arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
  
  arduino_mega.analogWrite(a_motor_sol_on, 255);
  arduino_mega.analogWrite(a_motor_sol_arka, 255);
  arduino_mega.analogWrite(a_motor_sag_on, 150);
  arduino_mega.analogWrite(a_motor_sag_arka, 150);
}

void motor_auto_geri_sol(){
  arduino_mega.digitalWrite(a_motor_sol_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sol_arka_yon, Arduino.LOW);
  arduino_mega.digitalWrite(a_motor_sag_on_yon, Arduino.HIGH);
  arduino_mega.digitalWrite(a_motor_sag_arka_yon, Arduino.LOW);
  
  arduino_mega.analogWrite(a_motor_sol_on, 150);
  arduino_mega.analogWrite(a_motor_sol_arka, 150);
  arduino_mega.analogWrite(a_motor_sag_on, 255);
  arduino_mega.analogWrite(a_motor_sag_arka, 255);
}


void motor_auto_dur(){
  arduino_mega.analogWrite(a_motor_sol_on, 0);
  arduino_mega.analogWrite(a_motor_sol_arka, 0);
  arduino_mega.analogWrite(a_motor_sag_on, 0);
  arduino_mega.analogWrite(a_motor_sag_arka, 0);
}

// ENKODER

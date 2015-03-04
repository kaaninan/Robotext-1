// SERVO
void servo(String servo_yon){
  
  arduino_mega.servoWrite(a_servo_y, 50); //normal
  
  if(servo_yon == "sag"){
    arduino_mega.servoWrite(a_servo_x, 10);
  }else{
    arduino_mega.servoWrite(a_servo_x, 160);
  }
  
  //arduino_mega.servoWrite(a_servo_y, 00); //yüksek
  //arduino_mega.servoWrite(a_servo_y, 50); //normal
  //arduino_mega.servoWrite(a_servo_y, 120); //yer
  
}



// EKRAN
void ekran(int deger){
  if(deger == 1){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.HIGH);
  }else if(deger == 2){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.LOW);
  }else if(deger == 3){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.HIGH);
  }else if(deger == 4){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.HIGH);
  }else if(deger == 5){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.LOW);
  }else if(deger == 6){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.LOW);
  }else if(deger == 7){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.HIGH);
  }else if(deger == 8){
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_1, Arduino.HIGH);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_2, Arduino.LOW);
    arduino_mega.digitalWrite(a_ekran_yazi_cikis_3, Arduino.LOW);
  }
}






// EKRAN ISIK (Sag, Sol)
void ekran_isik(int sag, int sol){
  arduino_mega.digitalWrite(a_ekran_sag_isik, sag);
  arduino_mega.digitalWrite(a_ekran_sol_isik, sol);
}





// BUZZER
void buzzer(String yon, int secim, int tekrar){

  // yon -> sag,sol,hepsi
  // secim -> 1,2 / 1-> surekli calma , 2-> durdur, 3-> bip bip
  
  if(yon == "sag"){
    if(secim == 1)
      arduino_mega.digitalWrite(a_buzzer_sag, Arduino.HIGH);
      
    else if(secim == 2)
      arduino_mega.digitalWrite(a_buzzer_sag, Arduino.LOW);
      
    else if(secim == 3){
      for(int i = 0; i < tekrar; i++){
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.HIGH);
        delay(300);
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.LOW);
        delay(300);
      }
    }
  }
  
  
  if(yon == "sol"){
    if(secim == 1)
      arduino_mega.digitalWrite(a_buzzer_sol, Arduino.HIGH);
      
    else if(secim == 2)
      arduino_mega.digitalWrite(a_buzzer_sol, Arduino.LOW);
      
    else if(secim == 3){
      for(int i = 0; i < tekrar; i++){
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.HIGH);
        delay(300);
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.LOW);
        delay(300);
      }
    }
  }
  
  
  
  if(yon == "hepsi"){
    if(secim == 1){
      arduino_mega.digitalWrite(a_buzzer_sag, Arduino.HIGH);
      arduino_mega.digitalWrite(a_buzzer_sol, Arduino.HIGH);
    } 
     
    else if(secim == 2){
      arduino_mega.digitalWrite(a_buzzer_sag, Arduino.LOW);
      arduino_mega.digitalWrite(a_buzzer_sol, Arduino.LOW);
    }
      
    else if(secim == 3){
      for(int i = 0; i < tekrar; i++){
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.HIGH);
        arduino_mega.digitalWrite(a_buzzer_sol, Arduino.HIGH);
        delay(300);
        arduino_mega.digitalWrite(a_buzzer_sag, Arduino.LOW);
        arduino_mega.digitalWrite(a_buzzer_sol, Arduino.LOW);
        delay(300);
      }
    }
  }
}



void ir(int ac){
  if(ac == 1){
    arduino_mega.digitalWrite(a_ir_cikis, Arduino.HIGH);
  }else{
    arduino_mega.digitalWrite(a_ir_cikis, Arduino.LOW);
  }
}

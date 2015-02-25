Arduino arduino_mega;

void arduino_connect(){
    
  println();
  println(Arduino.list());
  println();

  if(arduino_mega_bagli){
    arduino_mega = new Arduino(this, s_arduino_mega, 57600);
    log("Arduino -> arduino_connect", "Arduino Mega -> Baglanildi");
  }else{
    log("Arduino -> arduino_connect", "Arduino Mega -> Bagli Degil");
  }

}



void arduino_pinmode(){
  if (arduino_mega_bagli) {
    pinMode();
  }
}







boolean hareket_oldu_sag = false;
int basla = 0;
int hareket_sayisi_sag = 0;

void oku_hareket_sag() {
  int hareket_durum = arduino_mega.digitalRead(a_hareket_on_sag);

  if (hareket_durum == Arduino.HIGH) {

      //println("Hareket Var (SAG)");
      hareket_oldu_sag = true;
      
      if(basla == 0){
        hareket("sag");
        basla = 1;
      }
    
  } else if(hareket_durum == Arduino.LOW) {
  
      if (hareket_oldu_sag == true) {
        hareket_sayisi_sag++;
        hareket_oldu_sag = false;
        basla = 0;
        //println("Toplam Hareket (SAG): "+hareket_sayisi_sag);
      }
  }
  
}

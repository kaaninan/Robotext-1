// ## ARDUINO'DAN GELEN ## //

int basla = 0;
int basla2 = 0;


int[] oku_uzaklik() {
  int[] degerler = new int[3];
  
  degerler[0] = arduino_uno.digitalRead(a_uzaklik_sag_1);
  degerler[1] = arduino_uno.digitalRead(a_uzaklik_sag_2);
  
  degerler[2] = arduino_uno.digitalRead(a_uzaklik_sol_1);
  degerler[3] = arduino_uno.digitalRead(a_uzaklik_sol_2);
  
  if(osc_gonder){
    gonder_uzaklik(degerler[0], degerler[1], degerler[2], degerler[3]);
  }
  
  return degerler;
}



void oku_hareket_sag() {
  int hareket_durum = arduino_mega.digitalRead(a_hareket_1);

  if (hareket_durum == Arduino.HIGH) {

      if(osc_gonder)
        gonder_hareket(hareket_sayisi_sag, true);
  
      println("Hareket Var (SAG)");
      hareket_oldu_sag = true;
      
      if(basla == 0){
        hareket("sag");
        basla = 1;
      }
    
  } else if(hareket_durum == Arduino.LOW) {

      if(osc_gonder)
        gonder_hareket(hareket_sayisi_sag, false);
  
      if (hareket_oldu_sag == true) {
        hareket_sayisi_sag++;
        hareket_oldu_sag = false;
        basla = 0;
        println("Toplam Hareket (SAG): "+hareket_sayisi_sag);
      }
  }
  
}



void oku_hareket_sol() {
  int hareket_durum = arduino_mega.digitalRead(a_hareket_2);

  if (hareket_durum == Arduino.HIGH) {
    println("Hareket Var (SOL)");
    hareket_oldu_sol = true;
    
    if(basla2 == 0){
      hareket("sol");
      basla2 = 1;
    }
    
  } else {
    
    if (hareket_oldu_sol == true) {
      println("Toplam Hareket (SOL): "+hareket_sayisi_sol);
      hareket_sayisi_sol++;
      hareket_oldu_sol = false;
      basla2 = 0;
    }
  }
}



void oku_ses() {
  int ses_durum = arduino_mega.digitalRead(a_ses);

  if (ses_durum == Arduino.LOW) {
    println("Ses Algilandi");
  }
}

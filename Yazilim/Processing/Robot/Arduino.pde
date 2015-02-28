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
  
  delay(100);
}

void arduino_pinmode(){
  if (arduino_mega_bagli) {
    pinMode();
  }
}

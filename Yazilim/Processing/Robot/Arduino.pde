Arduino arduino_mega;
Serial arduino_uno;

void arduino_connect(){
    
  println();
  println(Arduino.list());
  println();

  arduino_mega = new Arduino(this, s_arduino_mega, 57600);
  arduino_uno = new Serial(this, s_arduino_uno, 115200);
  log("Arduino -> arduino_connect", "Arduino Mega -> Baglanildi");
  
  delay(100);
  pinMode(); 
}

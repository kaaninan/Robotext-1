Arduino arduino_mega;
Serial arduino_uno;

void arduino_connect(){
    
  println();
  println(Arduino.list());
  println();

  arduino_mega = new Arduino(this, s_arduino_mega, 57600);
  arduino_uno = new Serial(this, s_arduino_uno, 57600);
  
  log("Arduino -> arduino_connect", "Arduino Mega -> Baglanildi");
  log("Arduino -> arduino_connect", "Arduino Uno -> Baglanildi");

  delay(500);
  
  arduino_uno.bufferUntil('\n');
  
  delay(1000);
  pinMode();
  delay(1000); 
}

String servo_yon = "";

void servo(){
  
  // Servo yüksekliğini ayarla ve gereken tarafa dön
  // İşlem bitince kamera'ya istek yolla
  
  arduino_mega.servoWrite(a_servo_y, 80);
  
  if(servo_yon == "sag"){
    arduino_mega.servoWrite(a_servo_x, 0);
  }else{
    arduino_mega.servoWrite(a_servo_x, 180);
  }
  
  delay(100);
  
}

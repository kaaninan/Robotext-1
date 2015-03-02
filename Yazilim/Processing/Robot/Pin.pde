// PWM
int a_motor_sol_on = 2;
int a_motor_sol_arka = 3;
int a_motor_sag_on = 4;
int a_motor_sag_arka = 5;
int a_servo_x = 6;
int a_servo_y = 7;
int a_ekran_yazi_cikis_1 = 8;
int a_ekran_yazi_cikis_2 = 9;
int a_ekran_yazi_cikis_3 = 10;


// DIGITAL
int a_motor_sol_on_yon = 22;
int a_motor_sol_arka_yon = 23;
int a_motor_sag_on_yon = 24;
int a_motor_sag_arka_yon = 25;
int a_buzzer_sag = 26;
int a_buzzer_sol = 27;
int a_ekran_sag_isik = 28;
int a_ekran_sol_isik = 29;
int a_hareket_sag = 30;
int a_hareket_sol = 31;
int a_ses = 32;

// ANALOG
int a_motor_sol_on_hiz = 0;
int a_motor_sol_arka_hiz = 1;
int a_motor_sag_on_hiz = 2;
int a_motor_sag_arka_hiz = 3;
int a_uzaklik_sag_on = 4;
int a_uzaklik_sag_arka = 5;
int a_uzaklik_sol_on = 6;
int a_uzaklik_sol_arka = 7;
int a_sicaklik = 8;
int a_ldr_sag = 9;
int a_ldr_sol = 10;

void pinMode(){
  
  // PWM
  arduino_mega.pinMode(a_motor_sol_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_servo_x, Arduino.SERVO);
  arduino_mega.pinMode(a_servo_y, Arduino.SERVO);
  arduino_mega.pinMode(a_ekran_yazi_cikis_1, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_yazi_cikis_2, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_yazi_cikis_3, Arduino.OUTPUT);

  // DIGITAL
  arduino_mega.pinMode(a_motor_sol_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_sag, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_sol, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sag_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sol_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_hareket_sag, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_sol, Arduino.INPUT);
  arduino_mega.pinMode(a_ses, Arduino.INPUT);

  log("Pin -> pinMode","Arduino Mega -> Pin Mode -> OK");

}

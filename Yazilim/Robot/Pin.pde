// PWM
int a_motor_sol_on = 2;
int a_motor_sol_arka = 3;
int a_motor_sag_on = 4;
int a_motor_sag_arka = 5;
int a_servo_x = 6;
int a_servo_y = 7;

// DIGITAL
int a_motor_sol_on_yon = 22;
int a_motor_sol_arka_yon = 23;
int a_motor_sag_on_yon = 24;
int a_motor_sag_arka_yon = 25;
int a_buzzer_1 = 26;
int a_buzzer_2 = 27;
int a_ekran_sag_isik = 28;
int a_ekran_sol_isik = 29;
int a_hareket_on_sag = 30;
int a_hareket_on_sol = 31;
int a_hareket_arka_sag = 32;
int a_hareket_arka_sol = 33;
int a_ses_sensoru = 34;
int a_uzaklik_on_alt_1 = 35;
int a_uzaklik_on_alt_2 = 36;
int a_uzaklik_on_ust_1 = 37;
int a_uzaklik_on_ust_2 = 38;
int a_uzaklik_arka_1 = 39;
int a_uzaklik_arka_2 = 40;

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
int a_gaz = 9;
int a_ldr_on_sag = 10;
int a_ldr_on_sol = 11;
int a_ldr_arka = 12;

void pinMode(){
  
  // PWM
  arduino_mega.pinMode(a_motor_sol_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka, Arduino.OUTPUT);
  arduino_mega.pinMode(a_servo_x, Arduino.SERVO);
  arduino_mega.pinMode(a_servo_y, Arduino.SERVO);

  // DIGITAL
  arduino_mega.pinMode(a_motor_sol_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sol_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_on_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_motor_sag_arka_yon, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_1, Arduino.OUTPUT);
  arduino_mega.pinMode(a_buzzer_2, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sag_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_ekran_sol_isik, Arduino.OUTPUT);
  arduino_mega.pinMode(a_hareket_on_sag, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_on_sol, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_arka_sag, Arduino.INPUT);
  arduino_mega.pinMode(a_hareket_arka_sol, Arduino.INPUT);
  arduino_mega.pinMode(a_ses_sensoru, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_alt_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_alt_2, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_ust_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_on_ust_2, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_arka_1, Arduino.INPUT);
  arduino_mega.pinMode(a_uzaklik_arka_2, Arduino.INPUT);

  log("Pin -> pinMode","Arduino Mega -> Pin Mode -> OK");

}

OscP5 oscP5;
NetAddress remoteLocation;
Capture video;
Capture cam;

Arduino arduino_mega; // Arduino Mega 1280
Arduino arduino_mega_2; // Arduino Mega 2560

// ### ARDUINO PIN ### //
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


// ### OPEN SOUND CONTROL ### //

  // 2. SAYFA
  
  String ikinci_sayfa = "/Motor/";
  
  String s_motor_sol = ikinci_sayfa+"sol";
  String s_motor_sag = ikinci_sayfa+"sag";
  
  String s_motor_sol_ters = ikinci_sayfa+"sol_ters";
  String s_motor_sag_ters = ikinci_sayfa+"sag_ters";
  
  String s_motor_sol_on = ikinci_sayfa+"etkin_multitoggle/2/1";
  String s_motor_sol_arka = ikinci_sayfa+"etkin_multitoggle/1/1";
  String s_motor_sag_on = ikinci_sayfa+"etkin_multitoggle/2/2";
  String s_motor_sag_arka = ikinci_sayfa+"etkin_multitoggle/1/2";
  
  String s_buzzer = ikinci_sayfa+"buzzer";
  
  String s_led_1 = ikinci_sayfa+"multi_led/1/1";
  String s_led_2 = ikinci_sayfa+"multi_led/1/2";
  String s_led_3 = ikinci_sayfa+"multi_led/1/3";
  String s_led_4 = ikinci_sayfa+"multi_led/1/4";
  
  String s_servo_1 = ikinci_sayfa+"servo_1";
  String s_servo_2 = ikinci_sayfa+"servo_2";
  
  String s_uzaklik_sag_1 = ikinci_sayfa+"sag_1";
  String s_uzaklik_sag_2 = ikinci_sayfa+"sag_2";
  String s_uzaklik_sol_1 = ikinci_sayfa+"sol_1";
  String s_uzaklik_sol_2 = ikinci_sayfa+"sol_2";
  
  String s_durum = ikinci_sayfa+"durum";





// ### PROCESSING ### //

  // GİRİŞ EKRANI
  
  int giris = 0;
  
  int devam = 0;
  int devam1 = 0;
  int devam2 = 0;
  int devam3 = 0;
  int devam4 = 0;
  
  
  // MOTOR
  
  float motor_sol = 0.0f;
  float motor_sag = 0.0f;
  
  float motor_sol_ters = 0.0f;
  float motor_sag_ters = 0.0f;
  
  float motor_etkin_sol_on = 0.0f;
  float motor_etkin_sol_arka = 0.0f;
  float motor_etkin_sag_on = 0.0f;
  float motor_etkin_sag_arka = 0.0f;
  
  float buzzer = 0.0f;
  
  float servo_1 = 0.0f;
  float servo_2 = 0.0f;
  
  float led_1 = 0.0f;
  float led_2 = 0.0f;
  float led_3 = 0.0f;
  float led_4 = 0.0f;
  
  
  // Hareket
  float hareket_etkin = 0;
  float hareket_seviye_1 = 0;
  float hareket_seviye_2 = 0;
  float hareket_alarm = 0;
  float hareket_sifirla = 0;
  
  
  // Sensor
  float sensor_uzaklik = 0;
  float sensor_isik = 0;
  float sensor_yakinlik = 0;
  float sensor_hareket = 0;
  float sensor_kizilotesi = 0;



// ### MAIL ### //



// ### GENEL TANIMLAMALAR ### //

int time;

boolean hareket_first = false;

boolean hareket_oldu_sag = false;
int hareket_sayisi_sag = 0;

boolean hareket_oldu_sol = false;
int hareket_sayisi_sol = 0;

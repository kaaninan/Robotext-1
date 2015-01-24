import oscP5.*;
import netP5.*;

import processing.serial.*;
import processing.video.*;

import cc.arduino.*;

import java.awt.*;
import java.io.*;
import java.util.Properties;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Flags.Flag;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.*;

OscP5 oscP5;
NetAddress remoteLocation;
Capture video;
Capture cam;

Arduino arduino_mega; // Arduino Mega 1280
Arduino arduino_mega_2; // Arduino Mega 2560

// ### ARDUINO PIN ### //

  // ## MEGA 1 ## //
  
  // PWM
  int a_motor_sol_on = 2;
  int a_motor_sol_arka = 3;
  int a_motor_sag_on = 4;
  int a_motor_sag_arka = 5;
  
  int a_servo_1 = 6;
  int a_servo_2 = 7;
  
  // DIGITAL
  int a_motor_sol_on_d = 22;
  int a_motor_sol_arka_d = 23;
  int a_motor_sag_on_d = 24;
  int a_motor_sag_arka_d = 25;
  
  int a_led_k_1 = 26;
  int a_led_k_2 = 27;
  
  int a_led_y_1 = 28;
  int a_led_y_2 = 29;
  
  int a_hareket_1 = 30;
  int a_hareket_2 = 31;
  int a_ses = 32;
  int a_hoparlor = 33;
  int a_buzzer = 34;
  
  // ANALOG
  int a_motor_sol_on_e = 0;
  int a_motor_sol_arka_e = 1;
  int a_motor_sag_on_e = 2;
  int a_motor_sag_arka_e = 3;
  
  int a_uzaklik_sag_1 = 4;
  int a_uzaklik_sag_2 = 5;
  
  int a_uzaklik_sol_1 = 6;
  int a_uzaklik_sol_2 = 7;


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

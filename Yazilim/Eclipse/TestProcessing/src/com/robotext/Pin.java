package com.robotext;

import cc.arduino.Arduino;

public class Pin {
	
	// PWM
	public int a_motor_sol_on = 2;
	public int a_motor_sol_arka = 3;
	public int a_motor_sag_on = 4;
	public int a_motor_sag_arka = 5;
	public int a_servo_x = 6;
	public int a_servo_y = 7;

	// DIGITAL
	public int a_motor_sol_on_yon = 22;
	public int a_motor_sol_arka_yon = 23;
	public int a_motor_sag_on_yon = 24;
	public int a_motor_sag_arka_yon = 25;
	public int a_buzzer_1 = 26;
	public int a_buzzer_2 = 27;
	public int a_ekran_sag_isik = 28;
	public int a_ekran_sol_isik = 29;
	public int a_hareket_on_sag = 30;
	public int a_hareket_on_sol = 31;
	public int a_hareket_arka_sag = 32;
	public int a_hareket_arka_sol = 33;
	public int a_ses_sensoru = 34;
	public int a_uzaklik_on_alt_1 = 35;
	public int a_uzaklik_on_alt_2 = 36;
	public int a_uzaklik_on_ust_1 = 37;
	public int a_uzaklik_on_ust_2 = 38;
	public int a_uzaklik_arka_1 = 39;
	public int a_uzaklik_arka_2 = 40;

	// ANALOG
	public int a_motor_sol_on_hiz = 0;
	public int a_motor_sol_arka_hiz = 1;
	public int a_motor_sag_on_hiz = 2;
	public int a_motor_sag_arka_hiz = 3;
	public int a_uzaklik_sag_on = 4;
	public int a_uzaklik_sag_arka = 5;
	public int a_uzaklik_sol_on = 6;
	public int a_uzaklik_sol_arka = 7;
	public int a_sicaklik = 8;
	public int a_gaz = 9;
	public int a_ldr_on_sag = 10;
	public int a_ldr_on_sol = 11;
	public int a_ldr_arka = 12;

	public void pinMode(Arduino arduino_mega){
	  
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

	  System.out.println("Pin -> pinMode ==> Arduino Mega -> Pin Mode -> OK");

	}

}

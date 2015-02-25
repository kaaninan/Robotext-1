package com.robotext;

import cc.arduino.Arduino;

public class ArduinoMotor extends Thread {
	
	Arduino arduino;
	Pin pin;
	
	public ArduinoMotor(ArduinoConnect arduino_mega){
		this.arduino = arduino_mega.arduino_mega1280;
		pin = new Pin();
	}
	
	public void run(){
		
	}

	
	private void manual(int y_sag, int y_sol, int sag_on, int sag_arka, int sol_on, int sol_arka){
		
		if(y_sol == 0){
			arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.LOW);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.HIGH);
		}else{
			arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.HIGH);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.LOW);
		}		
		
		if(y_sag == 0){
			arduino.digitalWrite(pin.a_motor_sag_on_yon, Arduino.LOW);
		    arduino.digitalWrite(pin.a_motor_sag_arka_yon, Arduino.HIGH);
		}else{
			arduino.digitalWrite(pin.a_motor_sag_on_yon, Arduino.HIGH);
		    arduino.digitalWrite(pin.a_motor_sag_arka_yon, Arduino.LOW);
		}
		
		arduino.analogWrite(pin.a_motor_sag_on, sag_on);
		arduino.analogWrite(pin.a_motor_sag_arka, sag_arka);
		arduino.analogWrite(pin.a_motor_sol_on, sol_on);
		arduino.analogWrite(pin.a_motor_sol_arka, sol_arka);
		
	}
	
	
	private void git(String yon){
		
		if(yon == "ileri"){
			arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.LOW);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.HIGH);
		    arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.HIGH);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.LOW);
		}else{
			arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.HIGH);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.LOW);
		    arduino.digitalWrite(pin.a_motor_sol_on_yon, Arduino.LOW);
		    arduino.digitalWrite(pin.a_motor_sol_arka_yon, Arduino.HIGH);
		}
	    
	    arduino.analogWrite(pin.a_motor_sag_on, 255);
		arduino.analogWrite(pin.a_motor_sag_arka, 255);
		arduino.analogWrite(pin.a_motor_sol_on, 255);
		arduino.analogWrite(pin.a_motor_sol_arka, 255);
	}
	
	private void dur(){		
	    arduino.analogWrite(pin.a_motor_sag_on, 0);
		arduino.analogWrite(pin.a_motor_sag_arka, 0);
		arduino.analogWrite(pin.a_motor_sol_on, 0);
		arduino.analogWrite(pin.a_motor_sol_arka, 0);
	}
	
}
